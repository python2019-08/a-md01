# 1. 简易的命令行入门教程(from gitee):
## 1.1 Git 全局设置:

git config --global user.name "python191"
git config --global user.email "python191@163.com"

## 1.2 创建 git 仓库:

mkdir sss
cd sss
git init
touch README.md
git add README.md
git commit -m "first commit"
git remote add origin https://gitee.com/sgit2020/abner9qt9mis.git
git push -u origin master


## 1.2 已有仓库?

cd existing_git_repo

git remote add origin https://gitee.com/sgit2020/abner9qt9mis.git
git push -u origin master


477480ab5f3c61042f1f9064e4bf503b
===============================================================
# 2. github 
Quick setup — if you’ve done this kind of thing before

Get started by creating a new file or uploading an existing file. We recommend every repository include a README, LICENSE, and .gitignore.
…or create a new repository on the command line
```sh
echo "# pytest" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/python2019-08/pytest.git
git push -u origin main
```

…or push an existing repository from the command line
```sh
git remote add origin https://github.com/python2019-08/pytest.git
git branch -M main
git push -u origin main
```

==============================================================
# 2. git config --global

要查看 Git 的全局配置，可以使用以下命令：

```bash
git config --global --list
```

或者更简洁地：

```bash
git config --global -l
```

### 命令说明：
- `git config`：Git 的配置命令
- `--global`：指定查看全局配置文件（通常位于 `~/.gitconfig`）
- `--list` 或 `-l`：列出所有配置项

### 示例输出：
```bash
user.name=Your Name
user.email=you@example.com
core.editor=vim
color.ui=auto
```

## 2.1 查看特定配置项：
如果只想查看某个特定配置项（例如 `user.name`），可以使用：
```bash
git config --global user.name
```

## 2.2 修改全局配置：
若需要修改配置，可以直接编辑配置文件：
```bash
vim ~/.gitconfig
```

或者使用 `git config` 命令：
```bash
git config --global user.name "New Name"
git config --global user.email "new.email@example.com"
```

## 2.3 关闭git对文件换行符的修改,如自动把CRLF换成LF等
```sh
git config --global core.autocrlf false
```

## 2.4 git config pull.rebase true  

`git config pull.rebase true` 是一个用于配置 Git 行为的命令，它设置了在执行 `git pull` 时的默认合并策略为 **rebase**（变基）而非默认的 **merge**（合并）。以下是对该命令的详细解释：


### 2.4.1 **作用**
当你执行 `git pull` 时，Git 会从远程仓库获取最新提交并尝试将其整合到本地分支。默认情况下，Git 使用 **merge** 策略，这会创建一个新的合并提交（merge commit）。而设置 `pull.rebase true` 后，Git 会使用 **rebase** 策略，将本地提交移至远程提交的末尾，使提交历史保持线性。

```bash
# 启用 pull.rebase 配置（全局设置）
git config --global pull.rebase true
```


### 2.4.2 **区别示例**
假设远程仓库有提交 `A → B`，而你的本地仓库基于 `B` 提交了 `C → D`：

#### 2.4.2.1 **默认 merge 行为**
```bash
# 远程：A → B
# 本地：A → B → C → D
git pull  # 执行合并
# 结果：A → B → C → D → E（合并提交）
```

#### 2.4.2.2 **rebase 行为**
```bash
# 远程：A → B → E
# 本地：A → B → C → D
git pull  # 执行变基
# 结果：A → B → E → C' → D'（线性历史）
```


### 2.4.3 **优缺点**
| **Merge**                | **Rebase**               |
|--------------------------|--------------------------|
| 保留提交历史完整性        | 创建更清晰的线性历史      |
| 适合团队协作复杂场景      | 适合个人开发或小型团队    |
| 可能产生冗余合并提交      | 避免合并提交，历史更简洁  |


### 2.4.4 **其他配置选项**
(1). **仅对当前仓库生效**：
   ```bash
   git config pull.rebase true  # 不加 --global
   ```

(2). **使用 `rebase.autoStash`**（自动暂存工作区）：
   ```bash
   git config --global rebase.autoStash true
   ```

(3). **恢复默认 merge 行为**：
   ```bash
   git config --global --unset pull.rebase
   ```


### 2.4.5 **适用场景**
- **推荐使用 rebase**：如果你追求线性提交历史，便于代码审查和回溯。
- **推荐使用 merge**：如果你需要保留所有提交的时间顺序和原始上下文。

通过 `git config pull.rebase true`，你可以让 Git 在每次 `pull` 时自动执行 `git pull --rebase`，简化工作流程。


## 2.5 注意事项：
- 全局配置会应用于当前用户的所有 Git 仓库
- 每个仓库也可以有自己独立的配置（使用 `--local` 参数）
- 系统级配置（对所有用户生效）存储在 `/etc/gitconfig`，可以使用 `--system` 参数查看

如果需要进一步操作或有其他问题，请随时告诉我！

===========================================================
# 3.git rebase 的常见冲突及解决办法
1. git cherry-pick与git rebase
        进行两个独立分支的代码合并时有两个比较常用的命令，分别是git cherry-pick <commit-id>和git rebase。
        cherry-pick主要可以用于拷贝某个单独的patch，它的灵活性更大，而rebase主要用于整个分支的一次性合并。git rebase的使用语法为：
git rebase <upstream-branch-name> <to-branch-name>
        执行上述命令的过程为：
切换到to-branch分支；
(使用git reset --hard 命令)将to-branch中比upstream-branch多的commit先撤销掉，并将这些commit放在一块临时存储区（.git/rebase）；
(使用git rebase upstream-branch)将upstream-branch中比to-branch多的commit应用到to-branch上，此刻to-branch和upstream-branch的代码状态一致；
将存放的临时存储区的commit重新应用到to-branch上；
结束。
        执行完上述第3步后，to-branch的代码状态已经改变，接着执行第4步时则可能会产生合并冲突。
 
 
1.1 git reset
git reset：回滚到某次提交。
git reset --soft ：此次提交之后的修改会被退回到暂存区。
git reset --hard ：此次提交之后的修改不做任何保留， 查看工作区是没有记录的。 
 
2. 合并冲突的解决办法
        解决合并冲突几个常见的办法是：
手动编辑冲突文件，手动删除或者保留冲突的代码；
对于“both added”、“both deleted”、“both modified”等类型的冲突，若想完整地保留某一方的修改可以执行git checkout --ours(或者--theirs) <文件名>来选择想要保留的版本。需要注意的是由于git rebase 是先撤销再应用commit，所以这里的ours指的是upstream-branch，theirs指的是我们将要应用的临时commit。
对于“added by us/them”、“deleted by us/them”等类型的冲突需要使用git rm <file-name>和git add <file-name>来删除/添加file。在此过程中需要特别注意谁是us，谁是them。
        冲突解决完之后，使用git add <file-name>来标记冲突已解决，最后执行git rebase --continue继续。如果中间遇到某个补丁不需要应用，可以用下面命令忽略：
git rebase --skip
        如果想回到rebase执行之前的状态，可以执行：  
git rebase --abort

========================================================
========================================================
# 4. git clone 例子
git config pull.rebase true     

git clone https:// gitlab.com/xxx/cnnavi-i3.git

git clone https://abner:8DMd4wyNLt44wfcNWDZn@gitlab.com/xxx/cnnavi-i3.git
 
========================================================
# 5. How to rebase dev 
 
## 5.1.	保存本地变更 :  git stash save 
git status
 
git checkout dev
git pull
 
git checkout 原分支 :   git checkout  dev-5066-CT-IF-service-Traffic
git rebase dev
git push
git push -f  origin HEAD:dev-5066-CT-IF-service-Traffic
 

 $ git branch
      dev
    * ut_maoqigu_202218                             
 $ git checkout dev
 $ git pull 
 $ git checkout dev-5066-CT-IF-service-Traffic
 $ git rebase dev
 $ git stash  pop

 
######
 ~/work$ git diff origin/clang-duanzy
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789^C
 ~/work$ git push -f
 ~/work$ git reset --soft origin/dev^C
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789^C
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789
 ~/work$ git status
On branch clang-duanzy

##### 
git log --pretty=oneline  nv3\src\overlay\map_stylereader.cpp
git show 7a29f358387edb22daa2a2d2df150121ddf92840:nv3\src\overlay\map_stylereader.cpp

#####
git add 
 
git commit -m"----msg" 
git commit --amend

git push -f
git push -f  origin HEAD:cppcoreguidelines-owning-mem4-1--03-i2sop

#####
git commit --amend
insert
esc    
ctrl+X

git pull
git push

===================================================
# 6.Git如何永久删除文件(包括历史记录)

有些时候不小心上传了一些敏感文件(例如密码), 或者不想上传的文件(没及时或忘了加到.gitignore里的),而且上传的文件又特别大的时候, 这将导致别人clone你的代码或下载zip包的时候也必须更新或下载这些无用的文件,因此, 我们需要一个方法, 永久的删除这些文件(包括该文件的历史记录).

首先, 可以参考 github 的帮助:
https://help.github.com/articles/remove-sensitive-data

## 步骤一: 从你的资料库中清除文件
以Windows下为例(Linux类似), 打开项目的Git Bash,使用命令:
```sh
$ git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch path-to-your-remove-file' --prune-empty --tag-name-filter cat -- --all
```
其中, path-to-your-remove-file 就是你要删除的文件的相对路径(相对于git仓库的跟目录), 替换成你要删除的文件即可. 注意一点，这里的文件或文件夹，都不能以 '/' 开头，否则文件或文件夹会被认为是从 git 的安装目录开始。

如果你要删除的目标不是文件，而是文件夹，那么请在 `git rm --cached' 命令后面添加 -r 命令，表示递归的删除（子）文件夹和文件夹下的文件，类似于 `rm -rf` 命令。

此外，如果你要删除的文件很多, 可以写进一个.sh文件批量执行, 如果文件或路径里有中文, 由于MinGW或CygWin对中文路径设置比较麻烦, 你可以使用通配符*号, 例如: sound/music_*.mp3, 这样就把sound目录下以music_开头的mp3文件都删除了.

例如这样, 新建一个 bash 脚本文件，del-music-mp3.sh:
```shell
#!/bin/bash

git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch projects/Moon.mp3' --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch sound/Music_*.mp3' --prune-empty --tag-name-filter cat -- --all
```
 如果你看到类似下面这样的, 就说明删除成功了:
```sh
Rewrite 48dc599c80e20527ed902928085e7861e6b3cbe6 (266/266)
# Ref 'refs/heads/master' was rewritten
```
如果显示 xxxxx unchanged, 说明repo里没有找到该文件, 请检查路径和文件名是否正确.

注意: 补充一点, 如果你想以后也不会再上传这个文件或文件夹, 请把这个文件或文件夹添加到.gitignore文件里, 然后再push你的repo.

## 步骤二: 推送我们修改后的repo
以强制覆盖的方式推送你的repo, 命令如下:
```sh
$ git push origin master --force --all
```
这个过程其实是重新上传我们的repo, 比较耗时, 虽然跟删掉重新建一个repo有些类似, 但是好处是保留了原有的更新记录, 所以还是有些不同的. 如果你实在不在意这些更新记录, 也可以删掉重建, 两者也差不太多, 也许后者还更直观些.

执行结果类似下面:

```sh
Counting objects: 4669, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (4352/4352), done.
Writing objects: 100% (4666/4666), 35.16 MiB | 51 KiB/s, done.
Total 4666 (delta 1361), reused 0 (delta 0)
To https://github.com/defunkt/github-gem.git
 + beb839d...81f21f3 master -> master (forced update)
```
为了能从打了 tag 的版本中也删除你所指定的文件或文件夹，您可以使用这样的命令来强制推送您的 Git tags：
```sh
$ git push origin master --force --tags
 ```
## 步骤三: 清理和回收空间
虽然上面我们已经删除了文件, 但是我们的repo里面仍然保留了这些objects, 等待垃圾回收(GC), 所以我们要用命令彻底清除它, 并收回空间.

命令如下:
```sh
$ rm -rf .git/refs/original/

$ git reflog expire --expire=now --all

$ git gc --prune=now

Counting objects: 2437, done.
# Delta compression using up to 4 threads.
# Compressing objects: 100% (1378/1378), done.
# Writing objects: 100% (2437/2437), done.
# Total 2437 (delta 1461), reused 1802 (delta 1048)

$ git gc --aggressive --prune=now

Counting objects: 2437, done.
# Delta compression using up to 4 threads.
# Compressing objects: 100% (2426/2426), done.
# Writing objects: 100% (2437/2437), done.
# Total 2437 (delta 1483), reused 0 (delta 0)
```
注: 绿色字部分是命令执行后的结果.
 
现在你再看看你的.git目录文件大小是不是变小了.
 
参考自:
http://whoop.sinaapp.com/blog/article/21
http://blog.csdn.net/meteor1113/article/details/4407209

=================================================================
# 7.git submodule update --init --recursive

在 Git 里，`--recurse` 一般和 `--recurse-submodules` 选项搭配使用，它在处理包含子模块的仓库时极为有用。下面为你详细介绍该选项的作用和使用场景。

### 选项作用
`--recurse-submodules` 选项可以让 Git 在操作仓库时递归地处理所有子模块。子模块是指向另一个 Git 仓库的引用，借助这个选项，你能够在父仓库操作时同时对所有子模块进行相同操作。

### 常见使用场景

#### 1. 克隆包含子模块的仓库
当你克隆一个包含子模块的仓库时，默认情况下子模块不会被自动克隆。你可以使用 `--recurse-submodules` 选项来同时克隆父仓库和所有子模块：
```bash
git clone --recurse-submodules <repository-url>
```
这里的 `<repository-url>` 是你要克隆的仓库的 URL。

#### 2. 更新子模块
若你已经克隆了一个包含子模块的仓库，并且想要更新所有子模块到最新状态，可以使用 `git submodule update` 命令结合 `--recurse-submodules` 选项：
```bash
git submodule update --init --recursive
```
- `--init` 选项的作用是初始化本地配置文件。
- `--recursive` 选项会递归地更新所有子模块。

#### 3. 拉取包含子模块的仓库的最新更改
当你要拉取父仓库和所有子模块的最新更改时，可以使用 `git pull` 命令结合 `--recurse-submodules` 选项：
```bash
git pull --recurse-submodules
```

### 示例
假设你有一个包含子模块的仓库，你可以使用以下命令来克隆它并更新子模块：
```bash
# 克隆包含子模块的仓库
git clone --recurse-submodules https://github.com/your-repo.git

# 进入克隆的仓库目录
cd your-repo

# 拉取父仓库和子模块的最新更改
git pull --recurse-submodules
```

通过使用 `--recurse-submodules` 选项，你能够更方便地管理包含子模块的 Git 仓库。 

===========================================================
# 8.git 如何查看 某个commit 的修改

### Git查看特定commit修改的方法

在Git中，查看特定commit的修改是一项常见操作，这对于理解代码变更历史、排查问题或进行代码审查非常有用。以下是几种常用的方法：

### 1. 使用`git show`命令

这是最常用的查看commit修改的方法：

```bash
git show <commit哈希值>
```

例如：

```bash
git show abc1234
```

这个命令会显示：
- commit的基本信息（作者、日期、提交信息）
- 该commit引入的所有文件修改
- 每个文件的具体变更（使用统一差异格式）

### 2. 查看特定文件在某个commit的修改

如果你只想查看某个特定文件在特定commit中的修改：

```bash
git show <commit哈希值> <文件路径>
```

例如：

```bash
git show abc1234 src/main.go
```

### 3. 使用`git diff`命令

你可以使用`git diff`来比较两个commit之间的差异：

```bash
git diff <commit1> <commit2>
```

或者查看某个commit相对于其父commit的差异：

```bash
git diff <commit>^ <commit>
```

### 4. 只查看文件列表，不显示具体内容

如果你只关心哪些文件被修改了，而不关心具体修改内容：

```bash
git show --name-only <commit哈希值>
```

### 5. 使用`git log -p`查看最近几次修改

这个命令可以查看最近几次commit的详细修改：

```bash
git log -p -n 3  # 查看最近3次commit的详细修改
```

### 6. 图形化查看修改

对于更喜欢图形界面的用户，可以使用：

```bash
gitk <commit哈希值>
```

或者使用现代的Git GUI工具，如GitKraken、SourceTree等。

### 7. 查看某个文件的修改历史

如果你想查看某个文件的完整修改历史：

```bash
git log -p <文件路径>
```

### 8. 查看某个文件在特定时间范围内的修改

```bash
git log --since="2 weeks ago" --until="yesterday" -p <文件路径>
```

### 9. 查看二进制文件的修改

对于二进制文件（如图像、文档），可以使用：

```bash
git show --pretty=oneline --name-only <commit哈希值>
```

或者使用专门的二进制文件比较工具。

### 实用技巧

- 使用`git log --oneline`先获取commit哈希值的简短列表
- 使用`HEAD~1`、`HEAD~2`等表示最近的第几个commit
- 可以结合`--stat`参数查看修改的统计信息

这些命令可以帮助你全面了解代码库中的任何历史修改，对于理解项目发展历程和进行代码审查非常有价值。