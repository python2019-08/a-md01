# 1.如何在 Ubuntu 22.04 (LTS) 上安装 Microsoft Teams

Microsoft Teams 工具属于 Microsoft Office 365 系列。 Microsoft Teams 可用于商务会议、在线课程和共享文件。 Microsoft Teams 的视频会议、工作区聊天和文件共享功能减少了微软自有 Skype 和微软教室的使用量。

2009 年，微软宣布推出适用于 Linux 操作系统的 Teams。受到 Microsoft Teams 重要性的启发，我们准备了本指南，以使用终端和图形用户界面在 Ubuntu 22.04 上安装 Microsoft Teams。

## 1.1如何在 Ubuntu 22.04 上安装 Microsoft Teams 
 
此方法使用其 Debian 软件包安装 Microsoft Teams。按照以下步骤下载 debian 软件包并安装它以获取 Microsoft Teams。

第1步：首先，使用以下命令从官网下载Debian软件包：
```sh
$ wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.5.00.10453_amd64.deb
```
注意：安装时，teams_1.5.00.10453 是 Debian 软件包的最新版本。

使用“ls”命令检查下载的包的可用性：
```sh
$ ls
```
输出显示Debian软件包已成功下载。

第 2 步：通过以下命令安装 Debian 软件包：

确保您输入的包名称正确。
```sh
$ sudo dpkg -i teams_1.5.00.10453_amd64.deb
```
注意：如果遇到任何依赖性错误，可以使用以下命令修复它：
```sh
$ sudo apt --fix-broken install
```
第 3 步：建议从终端启动 Microsoft 团队来验证安装：
```sh
$ teams
```
 

## 1.2如何从 Ubuntu 22.04 中删除 Microsoft Teams
我们已使用 Debian 软件包和 snap 商店执行安装。

### 使用 dpkg 命令
如果 Microsoft Teams 是使用 Debian 软件包安装的，您可以通过提供以下命令将其删除：
```sh
$ sudo dpkg --remove teams
```
### 使用 Ubuntu 软件中心
打开 Ubuntu 软件中心并搜索团队。单击已安装的 Microsoft Teams 版本：

导航到垃圾桶图标：

它会要求确认，点击“卸载”继续：

输入密码继续：

Microsoft Teams 将从 Ubuntu 22.04 中删除。

## 1.3结论
Microsoft Teams 属于 Microsoft Office 365 系列。它用于视频会议、文件共享、工作区聊天和应用程序集成。受 Microsoft Teams 重要性的启发，本指南提供了 Ubuntu 22.04 上 Microsoft Teams 的详细安装指南。可以使用终端下载并安装 Microsoft Teams 的 Debian 软件包，而 Ubuntu 软件中心可用于从 snap 商店获取 Microsoft Teams。