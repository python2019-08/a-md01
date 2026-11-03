# ch01.如何fork  https://github.com/gwaldron/osgearth.git

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
# ch02.github repository fork 后，如何更新--"Sync fork" 

在 GitHub 上 fork 了一个项目后，保持你的仓库与原项目（Upstream）同步更新非常简单。现在 GitHub 已经提供了非常方便的图形化按钮。
以下是最常用的网页端一键同步方法以及专业的本地命令行同步方法：

## 方法一：GitHub 网页端一键同步（最简单、最推荐）

GitHub 已经在 Repository 页面原生内置了同步功能，你不需要用命令行就能完成更新：
> 1. 打开你在 GitHub 上 fork 后的仓库页面。
> 2. 在项目文件的上方，你会看到一个 Sync fork 的按钮（如果原项目有新提交，按钮会呈高亮状态）。
> 3. 点击 Sync fork。
> 4. 如果没有冲突，点击 Update branch 即可。
> 💡 注意： 如果系统提示有代码冲突（Conflicts），网页端将无法直接同步。这时你需要使用下方的方法二（命令行）在本地解决冲突后再提交。

## 方法二：使用 Git 命令行同步（更可控、适合开发者）

如果你正在本地开发，使用命令行同步是标准的职业工作流。只需要配置一次“上游仓库（upstream）”即可：

### 第一步：配置上游仓库（只需操作一次）

打开终端（Terminal），进入你的本地项目目录，把原作者的仓库设置为你的上游源：
```bash

# 查看当前的远程仓库路径，此时应该只有你自己的 origin
(base) a@a-X:~/autoware.vehicle00A$ git remote -v
  origin	https://github.com/python2019-08/autoware.vehicle00A.git (fetch)
  origin	https://github.com/python2019-08/autoware.vehicle00A.git (push)


# 添加原作者的仓库为上游仓库（注意：这里填的是原作者的仓库地址，不是你自己的）
(base) abner@abner-X:~/autoware.vehicle00A$ git remote add upstream https://github.com/autowarefoundation/autoware.git

# 再次查看，确认多出了 upstream 这一项
(base) a@a-X:~/autoware.vehicle00A$ git remote -v
  origin	https://github.com/python2019-08/autoware.vehicle00A.git (fetch)
  origin	https://github.com/python2019-08/autoware.vehicle00A.git (push)
  upstream	https://github.com/autowarefoundation/autoware.git (fetch)
  upstream	https://github.com/autowarefoundation/autoware.git (push)

```

### 第二步：拉取并合并更新（每次需要更新时操作）

当原项目有更新时，在本地执行以下命令来获取并合并代码：
```bash
# 1. 切换到你的主分支（通常是 main 或 master）
git checkout main

# 2. 从原作者的仓库（upstream）拉取最新的全部代码和分支信息
git fetch upstream

# 3. 将原作者的 master/main 分支合并到你当前的本地分支
#（这里以 main 为例，如果是老项目请改成 master）
git merge upstream/main

# 4. 将本地更新后的代码推送到你自己的 GitHub 远程仓库（origin）
git push origin main
```

🌟 额外建议

• 不要直接在 main/master 分支上改代码： 强烈建议你在 fork 后的仓库中，每次开发新功能都拉一个独立的分支（如 feature-xyz）去修改。
• 保持 main 分支干净： 让你自己的 main 分支永远只用来同步原作者的 upstream/main。这样你永远不会遇到同步冲突，随时可以提交干净的 Pull Request（PR）。

如果你在同步过程中遇到了问题，可以告诉我：
• 网页端点击 Sync fork 时是否提示了代码冲突（Conflicts）？ 


=========================================

# ch03.如果fork 一个项目后，在fork上修改了，此时再 sync work ，需要合并代码吗

是的，通常需要合并代码。
当你在自己 fork 的仓库修改了代码，同时原项目（Upstream）也有了新的提交，此时你点击 Sync fork（或在本地运行 git merge upstream/main），Git 就会尝试将原项目的最新改动和你自己的改动合并（Merge）在一起。
## 1.Sync fork 的合并代码
根据你和原作者修改的具体位置，会发生以下两种情况：

### 情况一：没有修改同一个文件（最省心）

• 结果：自动合并（Auto-merge）。
• 原理： 如果原作者修改了 A 文件，而你修改了 B 文件，或者你们修改了同一个文件的不同地方，Git 非常智能，它会自动把两边的代码结合起来。
• 你需要做什么： 网页端直接点击 Update branch，或者本地执行命令，Git 会自动帮你完成，不需要你手动改任何代码。

### 情况二：修改了同一个文件的同一行（最常见）

• 结果：代码冲突（Code Conflict）。
• 原理： 如果原作者改了某个文件的第 10 行，而你也改了第 10 行，Git 无法替你决定到底保留谁的代码，这时就会卡住。
• 你需要做什么：
	1. GitHub 网页端会变红并提示无法自动同步，你需要把代码拉到本地。
	2. 在本地执行合并命令后，打开代码编辑器（如 VS Code），你会看到代码里多出了 <<<<<<< HEAD 和 >>>>>>> upstream 的标记。
	3. 手动挑选留下哪一边的代码，删掉标记，然后重新 git commit 并 git push 上去。

## 2.💡 职业开发者的终极防冲突建议：

为了让你在 Sync fork 时永远不头疼，建议采用 “保持主分支干净” 的工作流：
> 1. 永远不要直接在 main（或 master）分支上改代码。
> 2. 让你自己的 main 分支保持一尘不染，只用来做一件事：点击 Sync fork 同步原作者的代码。因为你没动过 main，它永远能和原作者百分之百完美自动合并。
> 3. 如果你想改代码，从 main 分支切出一个新分支（例如 git checkout -b my-feature），在 my-feature 分支上随便改。
> 4. 当你想把原作者的新代码合并到你的开发分支时，先去 main 刷新 Sync fork，然后切换回你的分支执行 git merge main。即使有冲突，也只会在你的开发分支里解决，绝对不会改乱你的主干。

你目前修改的代码是直接在 main/master 分支上改的，还是建了独立的分支？如果现在遇到了无法自动合并的提示，我可以教你如何在本地用终端或 VS Code 快速解决冲突。


=============================================

# ch03.GitHub上 fork了autoware项目后，tags 没有fork过来

这是 GitHub 默认的机制。无论是通过网页端的 Fork 按钮，还是 Sync fork 一键同步，GitHub 都只会复制和同步分支（Branches），默认是不会同步任何标签（Tags）的。
如果你在本地开发 Autoware 或者是编译特定版本的 ROS 节点，缺少 Tags 会导致无法拉取特定的稳定发布版（如 v1.0.0 等）。
要将原作者（Upstream）的全部 Tags 同步到你自己的 GitHub 仓库中，你需要通过本地命令行强行将 Tags 推送上去。请依次在本地终端执行以下 4 行命令：

## 命令行同步 Tags 步骤
```bash
# 0. 删掉刚刚配错的那个错误的 upstream 路径
# git remote remove upstream

# 1. 确保你本地已经添加了 Autoware 官方的原作仓库作为上游（upstream）
# 如果之前加过可以跳过这一步
git remote add upstream https://github.com/autowarefoundation/autoware.git

# 2. 从官方原作者仓库（upstream）中拉取所有的标签到你本地
git fetch upstream --tags

# 3. 切换到你本地要推送的分支（比如 main 或 master）
git checkout main

# 4. 把本地刚刚获取的所有 Tags，强行推送到你自己的 GitHub 远程仓库（origin）
git push origin --tags
```
执行完第 4 步后，刷新你自己的 GitHub 网页，点击 Tags 标签页，你就会发现官方的所有版本标签都已经成功同步过来了。

如果在执行 git push origin --tags 时遇到报错权限拒绝（Permission Denied），可以告诉我：
• 你目前使用的是 HTTPS 的 Personal Access Token (PAT) 还是 SSH 密钥 连的 GitHub？


======================================================

# ch05. (HEAD detached at 2.0.0)

```sh
(base) a@a-X:~/autoware.vehicle00A$ git branch 
* (HEAD detached at 2.0.0)
  main
  mybranch
```  

从你终端的输出 * (HEAD detached at 2.0.0) 来看，你当前处于一个非常特殊的 Git 状态，叫做 “游离头指针状态”（Detached HEAD）。
这意味着你当前虽然在修改代码，但你的修改没有绑定在任何分支上。如果你直接在这个状态下改代码并提交，一旦切换到别的分支，你刚刚写的代码极有可能会“丢失”或变得非常难找。
## sec.1 如何处理HEAD detached
不过别慌，你已经建好了一个叫 mybranch 的本地分支。我们只需要把你当前游离的代码“安全解救”并合并到 mybranch（或者基于当前创建个全新分支）即可。请根据你的实际需求，选择以下最适合你的方案：

### 方案一：如果你已经在当前 (2.0.0) 状态下改了代码，想存入 mybranch

如果你过去几天在这个状态下写了代码，现在想把这些改动安全地存进 mybranch 分支，请依次执行以下命令：
```bash
# 1. 强行创建一个临时分支（比如叫 temp），把当前所有的改动和提交锁在里面
git checkout -b temp

# 2. 切换回你之前建好的 mybranch 分支
git checkout mybranch

# 3. 把临时分支 temp 里的改动合并到 mybranch 中
git merge temp

# 4. 确认安全后，删掉临时分支
git branch -d temp
```
执行完后，输入 git branch，你会发现自己已经安全地站在了 mybranch 上，且改动的代码都在。

### 方案二：如果你在当前状态下【没改代码】，只想切换去 mybranch 开发

如果你只是不小心切到了 2.0.0 这个标签（Tag）看代码，自己并没有做任何修改，那非常简单，直接切换走人即可：
```bash
# 直接切换回你的 mybranch 分支
git checkout mybranch
```
执行这行命令后，你可以再次输入 git branch 确认，此时 * 号应该会正确地指在 mybranch 前面（变成 * mybranch），你就可以开始安全地写代码了。

### 💡 为什么会产生 Detached HEAD？

当你执行了类似 git checkout 2.0.0（切换到某个特定的 Tag 或 Commit ID）而不是 git checkout 分支名 时，Git 就会进入这种只读的游离状态。
在日常开发中，一定要确保 git branch 里的 * 号指在一个具体的分支名（如 main 或 mybranch）上再开始写代码。

请问你刚才在 (HEAD detached at 2.0.0) 状态下已经动手改过文件了吗？如果改过了，在执行上述方案时如果提示代码冲突（Conflict）或卡住，可以把报错贴给我，我们一起解决。


## sec.2 如何基于 2.0.0 这个标签 建立一个新分支

基于特定的标签（如 2.0.0）建立新分支非常简单。Git 允许你在创建分支的同时，直接指定它的“起点”。
请在终端中执行以下命令：

### 1. 核心命令（创建并自动切换）

```bash
git checkout -b 你的新分支名 2.0.0
```
例如： git checkout -b v2-parking-fix 2.0.0
这一行命令会做两件事：
> 1. 以标签 2.0.0 时的代码状态为基准（起点），创建一个名为 v2-parking-fix 的新分支。
> 2. 自动把你从当前的游离状态（Detached HEAD）切换到这个新分支上。
> 

### 2. 验证是否成功

创建完成后，你可以输入以下命令确认自己所处的状态：
```bash
git branch
```
如果成功，你会看到输出中多出了你刚刚建的分支，并且前面有一个 * 号，例如：
```text
  main
  mybranch
* v2-parking-fix
```

此时，HEAD detached 的警告就会彻底消失，你已经安全地站在了基于 2.0.0 版本延伸出来的独立分支上，可以放心修改代码并提交了！

### 3. 第一次推送到 GitHub 线上

当你在新分支上改完代码，执行完 git add 和 git commit 后，第一次推送到你的远程仓库时，记得加上 -u 参数：
```bash
git push -u origin 你的新分支名
```
请问你为这个基于 2.0.0 的新分支起好名字了吗？如果在创建时终端弹出了任何关于未提交改动（local changes）的终止警告，请随时把提示发给我。
