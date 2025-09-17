# 1.如何fork  https://github.com/gwaldron/osgearth.git

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
# 2.fork得到  https://github.com/我的用户名/osgearth后，如果原始代码有更新，如何更新我的fork

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