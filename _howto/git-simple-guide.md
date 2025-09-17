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
 
git checkout 原分支 :   git checkout  dev-5066-service123
git rebase dev
git push
git push -f  origin HEAD:dev-5066-service123
 

 $ git branch
      dev
    * dev-5066-service123                            
 $ git checkout dev
 $ git pull 
 $ git checkout dev-5066-service123
 $ git rebase dev
 $ git stash  pop

 
###### git reset --soft
 ~/work$ git diff origin/clang-duanzy
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789^C
 ~/work$ git push -f
 ~/work$ git reset --soft origin/dev^C
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789^C
 ~/work$ git reset --soft 34d3c44bd37016ac5caf7b0e99dc5ed4b708c789
 ~/work$ git status
On branch clang-duanzy

##### 
git log --pretty=oneline  osgearth02\src\osg_stylereader.cpp
git show 7a29f358387edb22daa2a2d2df150121ddf92840:osgearth02\src\osg_stylereader.cpp

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

git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch _howto/git-simple-guide.md' --prune-empty --tag-name-filter cat -- --all

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

$ git push origin main --force --all
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

===============================================
# 9.一个git repository（名为X）中，有一个文件夹 a被加在.gitignore，但是a本身也是一个git repository，是否可行

是的，这种情况是可行的，并且在Git中被称为**子模块（Submodule）**。以下是详细说明和操作步骤：


### **1. 原理说明**
- **Git子模块**：允许你将一个Git仓库作为另一个Git仓库的子目录，主仓库记录子仓库的提交ID，而不包含子仓库的实际内容。
- **.gitignore的作用**：如果主仓库的 `.gitignore` 中包含文件夹 `a`，Git会忽略 `a` 目录下的所有文件**除非 `a` 是一个已注册的子模块**。此时，Git会特殊处理 `a`，仅跟踪其版本信息。


### **2. 操作步骤**
#### **场景1：已有子仓库 `a`，想将其添加到主仓库 `X`**
```bash
# 在主仓库X的根目录下执行
git submodule add <a的远程仓库URL> a

# 此时，Git会：
# 1. 在X中创建a目录，并克隆a的内容
# 2. 在X的根目录下生成.gitmodules文件（记录子模块配置）
# 3. 将a目录作为子模块添加到X的暂存区

# 提交更改
git commit -m "Add submodule a"
git push origin main
```

#### **场景2：已有目录 `a`，想将其转为子模块**
```bash
# 1. 先将a目录初始化为独立的Git仓库
cd a
git init
git add .
git commit -m "Initial commit for a"
git remote add origin <a的远程仓库URL>
git push -u origin main
cd ..

# 2. 在主仓库X中，将a转为子模块
git submodule add <a的远程仓库URL> a

# 3. 删除主仓库中a目录的跟踪（保留子模块信息）
git rm -r --cached a
echo "a/" >> .gitignore
git add .gitignore .gitmodules a
git commit -m "Convert directory a to submodule"
git push origin main
```


### **3. 使用注意事项**
#### **克隆包含子模块的仓库**
```bash
# 方法1：递归克隆（自动初始化并更新所有子模块）
git clone --recursive <主仓库URL>

# 方法2：分步操作
git clone <主仓库URL>
cd X
git submodule init    # 初始化子模块配置
git submodule update  # 拉取子模块内容
```

#### **更新子模块**
```bash
# 在主仓库中更新子模块到最新提交
cd a
git pull origin main  # 更新子模块到最新版本
cd ..
git add a             # 记录子模块的新提交ID
git commit -m "Update submodule a"
git push origin main
```

#### **查看子模块状态**
```bash
git submodule status  # 显示子模块的当前提交ID
```


### **4. .gitignore与子模块的关系**
- 如果 `.gitignore` 中包含 `a/`，但 `a` 是已注册的子模块，Git会**忽略 `a` 目录下的文件内容**，但**跟踪子模块的元数据**（如提交ID）。
- 子模块的版本控制完全独立于主仓库，可以有自己的提交历史和分支。


### **5. 潜在问题**
1. **子模块路径冲突**：确保 `.gitignore` 中没有直接忽略子模块的路径（如 `a/`），否则子模块可能无法正常工作。
2. **权限问题**：确保克隆子模块时有权限访问其远程仓库。
3. **分支管理**：子模块默认处于“游离HEAD”状态，需手动切换分支进行开发。


### **总结**
- **可行**：Git允许将已被 `.gitignore` 的文件夹作为子模块管理。
- **关键点**：通过 `.gitmodules` 文件显式注册子模块，Git会特殊处理这些目录，即使它们被 `.gitignore` 忽略。

如果需要更复杂的子项目管理（如多个仓库联动），还可以考虑使用 **Git Worktree** 或 **GitHub Actions** 实现自动化集成。
=========================================================
# 10.Git 自动添加 git 子模块(.gitmodules)
https://geek-docs.com/git/git-questions/74_git_adding_git_submodules_automatically_gitmodules.html
在本文中，我们将介绍如何通过编辑.gitmodules文件自动添加Git子模块的方法。

## s1.什么是Git子模块？
Git子模块是一个Git仓库中引用了另一个Git仓库的方式。它允许在一个项目中管理多个不同存储库的版本。子模块可以提供代码复用和跨项目的依赖管理。

## s2.如何手动添加Git子模块？
要手动添加Git子模块，可以使用以下命令：
```sh
git submodule add <repository_url> <path_to_submodule>
``` 
其中，<repository_url>是子模块的Git仓库URL，<path_to_submodule>是子模块在主存储库中的路径。



例如，要将名为submodule_repo的Git仓库作为子模块添加到主存储库的submodules文件夹中，可以运行以下命令：
```sh
git submodule add https://github.com/username/submodule_repo.git submodules/submodule_repo
```
运行完上述命令后，Git会自动将子模块克隆到主存储库，并将子模块的元数据保存在.gitmodules文件中。

## s3.自动化添加Git子模块(.gitmodules)
有时，在某些情况下我们可能需要自动添加多个Git子模块到主存储库中。通过编辑.gitmodules文件，我们可以实现这一目标。

首先，打开.gitmodules文件并在文件末尾添加你想要添加的子模块的配置。每个子模块的配置应该以如下格式开始：
```
[submodule "<path_to_submodule>"]
    path = <path_to_submodule>
    url = <repository_url>
```
其中，<path_to_submodule>是子模块在主存储库中的路径，<repository_url>是子模块的Git仓库URL。

例如，假设我们想要自动添加名为submodule1和submodule2的子模块，我们可以这样编辑.gitmodules文件：
```
[submodule "submodules/submodule1"]
    path = submodules/submodule1
    url = https://github.com/username/submodule1.git

[submodule "submodules/submodule2"]
    path = submodules/submodule2
    url = https://github.com/username/submodule2.git
``` 

完成编辑后保存文件。然后运行以下命令来初始化并更新子模块：
```sh
git submodule init
git submodule update
``` 

Git将自动根据.gitmodules文件中的配置为主存储库添加子模块。

## s4.修改已存在的Git子模块(.gitmodules)
如果我们想要修改已存在的Git子模块，我们也可以通过编辑.gitmodules文件实现。找到子模块的配置部分并对其进行修改，然后运行以下命令来应用修改：
```sh
git submodule sync
git submodule update --remote
```
git submodule sync命令用于同步配置更改，而git submodule update --remote则会拉取最新的子模块更新。

## s5.移除Git子模块(.gitmodules)
如果我们想要移除已存在的Git子模块，可以使用以下命令：

        1.编辑.gitmodules文件，删除对应子模块的配置。
        2.运行以下命令以应用更改并从主存储库中删除子模块文件夹：
```sh
git submodule deinit -f <path_to_submodule>
git rm -f <path_to_submodule>
```

## s6.总结
通过编辑.gitmodules文件，我们可以自动添加、修改和移除Git子模块。这使得我们能够更方便地管理多个Git存储库的版本。请记住，在修改.gitmodules文件后，始终运行适当的Git命令来应用更改。希望这篇文章对你理解和使用Git子模块有所帮助。

==================================================== 
# 11 .gitmodules 如何指定submodule的版本

`.gitmodules` 文件本身并不直接存储子模块的具体版本（ commit SHA ），它主要记录子模块的仓库地址和本地路径等配置信息。子模块的具体版本（即当前检出的 commit ）是保存在主项目的 Git 索引中的（通过 `git add` 提交到主仓库）。

不过，你可以通过以下方式**间接固定子模块版本**，并在 `.gitmodules` 中辅助配置：

### 1. 核心：通过 commit 固定版本（必须步骤）
子模块的版本由其当前检出的 commit SHA 决定，这部分信息会被主项目跟踪。操作步骤：
```bash
# 进入子模块目录
cd openssl

# 检出目标版本（标签/分支/commit）
git checkout openssl-3.5.2  # 标签
# 或 git checkout 1a2b3c4d  # 具体commit

# 返回主项目，提交子模块的版本变更
cd ..
git add openssl  # 记录子模块当前的commit
git commit -m "Lock openssl submodule to version 3.5.2"
```

此时，主项目的 Git 历史会记录子模块的当前 commit SHA，其他人克隆后更新子模块时会自动检出该版本。


### 2. 辅助：在 `.gitmodules` 中指定默认分支（可选）
如果希望子模块默认跟踪某个分支（如稳定版分支），可以在 `.gitmodules` 中添加 `branch` 配置：
```ini
[submodule "openssl"]
    path = openssl
    url = https://github.com/openssl/openssl.git
    branch = openssl-3.5  # 指定默认跟踪的分支（非强制，仅为克隆时默认）
    
[submodule "submodule_name"]
    path = path/to/submodule
    url = https://github.com/user/repo.git
    branch = main  # 或其他分支名    
```

这个配置的作用是：
- 当执行 `git submodule update --remote` 时，会默认从指定分支拉取最新代码
- 不影响已固定的 commit 版本（已提交的 commit 仍会被主项目锁定）


### 总结
- **版本锁定核心**：通过在主项目中提交子模块的具体 commit SHA 实现（必须执行 `git add <子模块路径>` 并提交）。
- **.gitmodules 作用**：存储子模块的仓库地址、路径等配置，可选配置默认跟踪分支，但不直接存储版本号。

其他人克隆项目后，执行以下命令即可获取与你相同的子模块版本：
```bash
git submodule update --init --recursive
```

========================================================
# 12.git submodule update --init --recursive   --progress -v  --depth=1 

### **答案：**
`git submodule update --init --recursive --progress -v --depth=1` **是正确的命令**，但需要根据实际情况调整参数。以下是详细解释：

---

### **1. 参数说明**
| 参数 | 作用 |
|------|------|
| `--init` | 初始化子模块（首次克隆） |
| `--recursive` | 递归初始化嵌套子模块 |
| `--progress` | 显示克隆进度（适合大仓库） |
| `-v` (或 `--verbose`) | 输出详细日志（调试用） |
| `--depth=1` | 浅克隆（只拉取最新提交，减少下载量） |

---

### **2. 适用场景**
- **首次克隆大仓库**（如 Linux 内核、LLVM）：  
  使用 `--depth=1` 可显著加快速度，但会丢失历史记录。
- **调试网络问题**：  
  `-v` 和 `--progress` 可查看卡住的具体步骤。
- **仅需最新代码**：  
  如果不需要子模块的完整历史，`--depth=1` 是最佳选择。

---

### **3. 注意事项**
#### **(1) `--depth=1` 的限制**
- **无法切换分支/标签**：  
  浅克隆的仓库无法通过 `git checkout <tag>` 切换到旧版本。  
  **解决方法**：  
  如需完整历史，移除 `--depth=1` 或后续运行：
  ```bash
  git fetch --unshallow
  ```

#### **(2) 子模块 URL 问题**
- 如果子模块的 URL 是 SSH（如 `git@github.com:...`），确保：
  1. SSH 密钥已配置。
  2. 网络可访问 GitHub。  
  **替代方案**：  
  改用 HTTPS URL：
  ```bash
  git config -f .gitmodules submodule.<path>.url https://github.com/...
  git submodule sync
  ```

#### **(3) 缓存问题**
- 如果之前克隆失败，清理缓存再重试：
  ```bash
  rm -rf .git/modules/<子模块路径>  # 删除子模块缓存
  git submodule update --init --recursive
  ```

---

### **4. 完整推荐命令**
#### **场景 1：快速克隆（适合开发）**
```bash
git submodule update --init --recursive --progress --depth=1
```

#### **场景 2：完整克隆（需历史记录）**
```bash
git submodule update --init --recursive --progress
```

#### **场景 3：调试网络问题**
```bash
GIT_TRACE=1 GIT_CURL_VERBOSE=1 git submodule update --init --recursive -v --progress
```

---

### **5. 常见问题处理**
| 问题 | 解决方案 |
|------|----------|
| 卡在 `Cloning into...` | 检查网络，或用 `git clone <URL>` 手动测试 |
| 权限错误 | 改用 HTTPS URL 或配置 SSH 密钥 |
| 子模块未定义 | 运行 `git submodule status` 检查注册信息 |

---

### **总结**
- **命令正确性**：✅ 可安全使用，但需注意 `--depth=1` 的副作用。  
- **推荐场景**：首次克隆大仓库时优先使用 `--depth=1`。  
- **调试建议**：遇到问题时添加 `-v --progress` 查看详细日志。

======================================
# 13 比较 git clone --recursive <url> 和 git submodule update --init --recursive -v

### **`git clone --recursive` vs. `git submodule update --init --recursive` 的区别**

| 对比项 | `git clone --recursive <URL>` | `git submodule update --init --recursive -v` |
|--------|-------------------------------|-----------------------------------------------|
| **用途** | 克隆主仓库 **并** 初始化所有子模块 | 在已克隆的主仓库中 **初始化/更新** 子模块 |
| **适用场景** | 首次克隆项目时一次性下载所有代码 | 主仓库已克隆，但子模块未初始化或需要更新 |
| **执行时机** | 项目初始化阶段 | 项目维护阶段（如切换分支后同步子模块） |
| **网络请求** | 克隆主仓库 + 所有子模块 | 仅处理子模块（主仓库已存在） |
| **输出信息** | 显示主仓库和子模块的克隆进度 | 显示子模块的更新详情（`-v` 启用详细日志） |
| **缓存机制** | 无缓存，全部重新下载 | 复用已有子模块（除非强制更新） |
| **典型问题** | 若子模块很大，首次克隆耗时较长 | 子模块 URL 变更时需手动修复 |

---

### **如何选择？**
1. **全新克隆项目** → 用 `git clone --recursive`  
   ```bash
   git clone --recursive https://github.com/openssl/openssl.git
   ```
   - 适合首次下载，确保主仓库和子模块一次性到位。

2. **修复或更新子模块** → 用 `git submodule update`  
   ```bash
   cd osg  # 进入已克隆的主仓库
   git submodule update --init --recursive -v
   ```
   - 适合子模块未初始化或需要同步到指定提交。

---

### **常见问题处理**
#### **1. 子模块克隆卡住**
- **原因**：网络问题或子模块仓库不可访问。
- **解决**：
  ```bash
  # 尝试单独克隆卡住的子模块（如 openssl）
  git clone https://github.com/openssl/openssl.git 3rd/openssl
  # 然后重新运行
  git submodule update --init --recursive
  ```

#### **2. 子模块分支不匹配**
- **现象**：子模块的提交哈希与 `.gitmodules` 中定义的分支不符。
- **解决**：
  ```bash
  git submodule foreach --recursive 'git checkout $(git config -f ${toplevel}/.gitmodules submodule.${sm_path}.branch || echo main)'
  ```

#### **3. 强制重新下载子模块**
- **适用场景**：子模块代码损坏或需要彻底更新。
- **命令**：
  ```bash
  git submodule deinit --force .           # 清理现有子模块
  git submodule update --init --recursive  # 重新初始化
  ```

---

### **关键参数说明**
| 参数 | 作用 |
|------|------|
| `--recursive` | 递归处理嵌套子模块 |
| `--init` | 初始化未注册的子模块 |
| `-v` 或 `--verbose` | 显示详细操作日志 |
| `--progress` | 显示克隆进度条（适合大仓库） |

---

### **总结**
- **首次克隆** → `git clone --recursive`  
- **后期维护** → `git submodule update --init --recursive -v`  
- **调试技巧**：添加 `GIT_TRACE=1` 查看底层 Git 操作：
```bash
  GIT_TRACE=1 git submodule update --init --recursive -v
```

===============================================
#  14.git checkout OpenSceneGraph-3.6.5 和git switch -c OpenSceneGraph-3.6.5 

## Q
OpenSceneGraph-3.6.5是tag； git checkout OpenSceneGraph-3.6.5 和git switch -c OpenSceneGraph-3.6.5后，代码都切换到OpenSceneGraph-3.6.5了吗

## A
### **问题解答**

---

#### **1. 两种命令的区别**
| **命令**                          | **作用**                                                                 | **是否切换到目标代码**       |
|-----------------------------------|--------------------------------------------------------------------------|-----------------------------|
| `git checkout OpenSceneGraph-3.6.5` | 切换到标签 `OpenSceneGraph-3.6.5` 对应的提交（**分离头指针状态**）。       | ✅ 是，但处于分离头状态       |
| `git switch -c OpenSceneGraph-3.6.5` | **错误用法**：尝试创建新分支 `OpenSceneGraph-3.6.5`，而非切换到标签。      | ❌ 否，会创建新分支           |

---

#### **2. 正确切换到标签的方法**
##### **(1) 直接切换到标签（分离头状态）**
```bash
git checkout OpenSceneGraph-3.6.5
```
**效果**：
- 代码会切换到标签对应的提交。
- 但处于 **分离头指针（detached HEAD）状态**（无分支绑定）。

##### **(2) 基于标签创建新分支并切换**
```bash
git checkout -b my-osg-3.6.5 OpenSceneGraph-3.6.5
```
或（Git 2.23+）：
```bash
git switch -c my-osg-3.6.5 OpenSceneGraph-3.6.5
```
**效果**：
- 创建新分支 `my-osg-3.6.5`，并指向标签对应的提交。
- 此时处于正常分支状态，可自由修改代码。

---

#### **3. 验证是否切换成功**
```bash
git describe --tags  # 查看当前所在的标签
git branch           # 查看当前分支（若为分离头状态，显示 "HEAD detached at OpenSceneGraph-3.6.5"）
```
**期望输出**：
```
OpenSceneGraph-3.6.5
```

---

#### **4. 关键注意事项**
1. **分离头指针的风险**：
   - 在分离头状态下提交的更改可能丢失（除非手动创建分支保存）。
   - 建议始终基于标签创建新分支：
     ```bash
     git checkout -b my-osg-3.6.5 OpenSceneGraph-3.6.5
     ```

2. **标签与分支的区别**：
   - **标签（Tag）**：静态标记某个提交（如版本发布），不可直接修改。
   - **分支（Branch）**：动态的开发线，可继续提交代码。

3. **`git switch` 的局限性**：
   - `git switch -c` 只能基于现有分支或提交创建新分支，**不能直接切换到标签**。
   - 切换到标签必须用 `git checkout <tag>`。

---

#### **5. 总结**
| **需求**                | **正确命令**                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| 临时查看标签代码        | `git checkout OpenSceneGraph-3.6.5`（分离头状态）                          |
| 基于标签开发新功能      | `git checkout -b my-osg-3.6.5 OpenSceneGraph-3.6.5`（推荐）               |
| 错误操作                | `git switch -c OpenSceneGraph-3.6.5`（错误，会创建同名分支而非切换标签）   |

**最终建议**：  
若需修改代码，始终用 `git checkout -b <新分支名> <标签名>` 创建分支！

=================================================
# 14.如何fork  https://github.com/gwaldron/osgearth.git

要在 GitHub 上 fork `https://github.com/gwaldron/osgearth.git` 仓库，只需按照以下步骤操作：


### 步骤 1：访问仓库页面
打开浏览器，进入 `osgearth` 仓库的 GitHub 页面：  
[https://github.com/gwaldron/osgearth](https://github.com/gwaldron/osgearth)


### 步骤 2：点击 "Fork" 按钮
在仓库页面的右上角，找到并点击 **"Fork"** 按钮（图标是一个分叉的树枝）。  
![Fork 按钮位置示意图](https://picsum.photos/id/0/800/200?alt=Fork按钮位于GitHub仓库页面右上角)


### 步骤 3：确认 fork 操作
点击后，GitHub 会自动将原仓库复制到你的个人账号下。  
- 若你属于多个组织，可能需要选择 fork 到哪个账号/组织（默认是你的个人账号）。  
- 等待几秒，页面会自动跳转到你 fork 后的仓库页面，地址格式为：  
  `https://github.com/你的用户名/osgearth`


### 步骤 4：验证 fork 结果
在你的个人 GitHub 账号主页（`https://github.com/你的用户名`）中，可以看到新 fork 的 `osgearth` 仓库，说明操作成功。


### 后续操作：克隆你 fork 的仓库到本地
fork 后，若需要在本地修改代码，可通过以下命令克隆你自己的仓库：
```bash
# 替换 "你的用户名" 为你的 GitHub 用户名
git clone https://github.com/你的用户名/osgearth.git
```

这样就可以在本地修改代码，并通过 `git push` 推送到你 fork 的仓库，之后还能通过 "Pull Request" 向原仓库提交修改。

=================================================
# 15.fork得到  https://github.com/我的用户名/osgearth后，如果原始代码有更新，如何更新我的fork

当原始仓库（`gwaldron/osgearth`）有更新时，要同步到你的 fork 仓库（`你的用户名/osgearth`），需要通过以下步骤操作：


### 步骤 1：在本地仓库添加「上游仓库」（Upstream）
首先，需要将原始仓库设置为本地仓库的「上游仓库」（用于跟踪原始代码的更新）。  
打开终端，进入你本地克隆的 fork 仓库目录，执行以下命令：

```bash
# 进入你的本地仓库目录
cd osgearth

# 添加上游仓库（原始仓库地址）
git remote add upstream https://github.com/gwaldron/osgearth.git

# 验证是否添加成功（会显示 origin 和 upstream 两个远程仓库）
git remote -v
```

- `origin`：指向你的 fork 仓库（`你的用户名/osgearth`），用于推送你的修改。
- `upstream`：指向原始仓库（`gwaldron/osgearth`），用于拉取原始代码的更新。


### 步骤 2：拉取上游仓库的最新代码
从上游仓库（原始仓库）拉取最新更新到本地：

```bash
# 拉取 upstream 仓库的所有分支更新（确保本地与上游同步）
git fetch upstream
```


### 步骤 3：合并上游更新到你的本地分支
假设你要同步到本地的 `main` 分支（或其他主分支，如 `master`，根据仓库实际分支名调整）：

```bash
# 切换到你要更新的本地分支（通常是 main 或 master）
git checkout main

# 将 upstream/main 的更新合并到本地 main 分支
git merge upstream/main
```

- 若合并过程中出现冲突，需要手动编辑冲突文件，解决后执行 `git add <冲突文件>` 和 `git commit` 完成合并。


### 步骤 4：将本地更新推送到你的 fork 仓库
合并完成后，将本地同步后的代码推送到你的 GitHub fork 仓库（`origin`）：

```bash
git push origin main
```

此时，你的 fork 仓库（`你的用户名/osgearth`）就会与原始仓库的最新代码保持一致了。


### 总结：更新 fork 的完整流程（后续可重复执行）
```bash
# 1. 拉取上游仓库最新代码
git fetch upstream

# 2. 切换到目标分支（如 main）
git checkout main

# 3. 合并上游更新
git merge upstream/main

# 4. 推送到你的 fork 仓库
git push origin main
```

这样就能随时同步原始仓库的更新到你的 fork 中，确保你的代码基于最新版本开发。