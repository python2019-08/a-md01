# 1. 最新2025 Docker国内可用镜像源仓库地址分享
 更新时间：2025年02月19日 09:22:20   作者：猫头虎  

在使用Docker时,您是否经常遇到拉取镜像缓慢或下载中断的问题？特别是对于我们在国内的开发者,网络条件限制常常导致镜像下载速度令人头疼,为了让您的开发工作更加顺畅,小编特意收集并整理了2025年最新、可用的国内Docker镜像源地址,希望能大幅提升您的Docker下载速度

##### 目录 {#目录 .catalogue}
-   [Docker 国内镜像源地址](#_label0)
-   [完整的 Docker 配置示例](#_label1)
-   [Windows 和 macOS 配置指南](#_label2)
-   -   [测试效果](#_lab2_2_0)
-   [Linux 系统配置指南](#_label3)
-   -   [测试配置效果](#_lab2_3_1)
-   [常见问题解答 (Q&A)](#_label4)

## Docker 国内镜像源地址

以下是最新的 Docker 镜像源地址，直接复制添加到 Docker 配置文件中即可：

```plaintext
 {
  "registry-mirrors": [
    "https://docker.hpcloud.cloud",
    "https://docker.m.daocloud.io",
    "https://docker.unsee.tech",
    "https://docker.1panel.live",
    "http://mirrors.ustc.edu.cn",
    "https://docker.chenby.cn",
    "http://mirror.azure.cn",
    "https://dockerpull.org",
    "https://dockerhub.icu",
    "https://hub.rat.dev",
    "https://proxy.1panel.live",
    "https://docker.1panel.top",
    "https://docker.m.daocloud.io",
    "https://docker.1ms.run",
    "https://docker.ketches.cn"
  ]
}
```

## 完整的 Docker 配置示例

小编还为大家附上了一个完整的 Docker
配置示例，其中还包含了缓存管理的设置，可以有效节省存储空间：

```
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "registry-mirrors": [
    "https://docker.hpcloud.cloud",
    "https://docker.m.daocloud.io",
    "https://docker.unsee.tech",
    "https://docker.1panel.live",
    "http://mirrors.ustc.edu.cn",
    "https://docker.chenby.cn",
    "http://mirror.azure.cn",
    "https://dockerpull.org",
    "https://dockerhub.icu",
    "https://hub.rat.dev",
    "https://proxy.1panel.live",
    "https://docker.1panel.top",
    "https://docker.m.daocloud.io",
    "https://docker.1ms.run",
    "https://docker.ketches.cn"
  ]
}
```

> **贴士**：配置文件路径在不同操作系统上略有不同，接下来我们会详细介绍各平台的设置方法。

## Windows 和 macOS 配置指南

在 Windows 和 macOS 上，您可以直接通过 Docker Desktop
的**图形化界面**完成镜像源配置：

1.  打开 Docker Desktop 应用。
2.  进入 **Settings**（设置） \> **Docker Engine**。
3.  在 JSON 配置中添加上方的 `"registry-mirrors"` 字段。
4.  保存配置，Docker 会自动重启并应用新的镜像源。

![](//img.jbzj.com/file_images/article/202502/202521991302354.jpg)

### 测试效果

添加镜像源后，试着拉取一些热门镜像（如 `nginx`）来确认配置是否生效：

```
docker pull nginx
```

如果速度明显提升，那么配置成功啦！

![](//img.jbzj.com/file_images/article/202502/202521991302355.jpg)

## Linux 系统配置指南

对于 Linux 用户，需要手动修改 Docker 的配置文件来添加镜像源：

-   使用编辑器打开配置文件 `/etc/docker/daemon.json`（如果没有该文件，可以新建一个）。
-   将以下内容粘贴进去：

```
 {
   "registry-mirrors": [
  "https://docker.hpcloud.cloud",
  "https://docker.m.daocloud.io",
  "https://docker.unsee.tech",
  "https://docker.1panel.live",
  "http://mirrors.ustc.edu.cn",
  "https://docker.chenby.cn",
  "http://mirror.azure.cn",
  "https://dockerpull.org",
  "https://dockerhub.icu",
  "https://hub.rat.dev",
  "https://proxy.1panel.live",
  "https://docker.1panel.top",
  "https://docker.m.daocloud.io",
  "https://docker.1ms.run",
  "https://docker.ketches.cn"
   ]
 }
``` 

保存文件后，重新启动 Docker 服务：
 
```
sudo systemctl daemon-reload
sudo systemctl restart docker
``` 
### 测试配置效果

运行以下命令来验证镜像源配置是否生效：
 
``` brush:bash;
docker info | grep "Registry Mirrors"
```
如果输出显示配置的镜像源地址，说明设置成功！

## 常见问题解答 (Q&A)

-   **Q: 配置了镜像源，速度还是不快怎么办？**A:
    可以试着切换不同的镜像源，或在网络条件较好的环境中进行拉取。

-   **Q: 如果想还原默认配置该怎么做？**A:
    删除 `daemon.json` 中的 `"registry-mirrors"` 配置项，然后重启
    Docker 服务即可。

到此这篇关于2025最新Docker国内可用镜像源仓库地址分享的文章就介绍到这了,更多相关Docker镜像源仓库地址内容请搜索脚本之家以前的文章或继续浏览下面的相关文章希望大家以后多多支持脚本之家！

**您可能感兴趣的文章:**

-   [国内可用的Docker镜像源测试指南](/server/335904l7i.htm "国内可用的Docker镜像源测试指南"){target="_blank"}
-   [docker国内镜像源配置及走代理设置小结](/server/333822w7u.htm "docker国内镜像源配置及走代理设置小结"){target="_blank"}
-   [docker直接下载太慢,如何更换国内靠谱镜像源](/server/320596zuc.htm "docker直接下载太慢,如何更换国内靠谱镜像源"){target="_blank"}
-   [给Docker更换国内镜像源操作](/article/200312.htm "给Docker更换国内镜像源操作"){target="_blank"}
-   [docker国内镜像源配置的解决方案](/server/337401bd2.htm "docker国内镜像源配置的解决方案"){target="_blank"}
    
<=====================================================================>
<=====================================================================>
# 2. docker的ubuntu容器内 Connection reset by peer

## 2.1 question
在docker的ubuntu容器内
```sh
# git clone https://github.com/DigitalPhonetics/IMS-Toucan
Cloning into 'IMS-Toucan'...
fatal: unable to access 'https://github.com/DigitalPhonetics/IMS-Toucan/': Recv failure: Connection reset by peer
```

## 2.2 answer

当在 Docker 的 Ubuntu 容器内执行 `git clone` 命令时出现 `Recv failure: Connection reset by peer` 错误，这通常意味着在与 GitHub 服务器建立连接或传输数据的过程中，连接被对方（GitHub 服务器）重置了，可能是由于网络问题、防火墙限制、GitHub 服务器端问题等因素导致的。以下是一些可能的解决办法：

### (1). 检查网络连接
确保容器内的网络连接正常，可以尝试在容器内使用 `ping` 命令测试与 GitHub 服务器的连通性：
```bash
ping github.com
```
如果无法 `ping` 通，可能是容器的网络配置有问题，或者主机的网络存在问题。你可以尝试重启 Docker 服务：
```bash
sudo systemctl restart docker
```
然后重新启动容器，再次尝试 `git clone` 操作。

### (2). 检查防火墙和代理设置
- **防火墙**：防火墙可能会阻止容器与 GitHub 服务器的连接。你可以暂时关闭主机的防火墙（仅在测试时进行，测试完成后重新开启）来检查是否是防火墙导致的问题。例如，对于 `ufw` 防火墙：
```bash
sudo ufw disable
```
然后重新在容器内执行 `git clone` 命令，完成后再重新启用防火墙：
```bash
sudo ufw enable
```
- **代理设置**：如果你使用了代理，要确保代理设置正确，并且代理服务器能够正常访问 GitHub。可以在容器内通过以下命令临时取消代理设置：
```bash
unset http_proxy
unset https_proxy
```
之后再尝试 `git clone` 操作。

### (3). 更换 Git 协议
GitHub 支持 `https` 和 `git` 两种协议进行代码克隆，你可以尝试使用 `git` 协议进行克隆：
```bash
git clone git://github.com/DigitalPhonetics/IMS-Toucan.git
```
不过需要注意的是，某些网络环境可能会限制 `git` 协议的使用。

### (4). 增加超时时间
可以通过设置 `git` 的 `http.postBuffer` 和 `http.lowSpeedLimit`、`http.lowSpeedTime` 参数来增加超时时间和缓冲区大小，以应对网络不稳定的情况。在容器内执行以下命令：
```bash
git config --global http.postBuffer 524288000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
```
然后再次尝试 `git clone` 操作。

### (5). 检查 GitHub 服务器状态
访问 [GitHub 状态页面](https://www.githubstatus.com/) 检查 GitHub 服务器是否正常运行。如果 GitHub 服务器出现故障，可能会导致连接被重置，你需要等待服务器恢复正常后再尝试克隆操作。

按照以上步骤操作，应该能够解决 `git clone` 时连接被重置的问题。 

<=====================================================================>
<=====================================================================>
# 3. docker run -it -v ./:/root  ubuntu /bin/bash

```sh
sudo apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
(base) abner@abner-XPS:/mnt/disk2/abner/zdev/ai/av/IMS-Toucan$   docker run -it -v ./:/home/ubuntu   ubuntu /bin/bash

```
<====================================================================>
<====================================================================>
# 4.Docker 持久化存储方案
在 Docker 中，持久化存储方案是确保容器内数据在容器停止或删除后仍然保留的重要手段。以下为你详细介绍几种常见的 Docker 持久化存储方案：

### 1. 数据卷（Volumes）
数据卷是 Docker 官方推荐的持久化存储方案，它是由 Docker 管理的主机文件系统中的一部分，独立于容器的生命周期。
- **创建和使用命名数据卷**
    - **创建命名数据卷**：可以使用 `docker volume create` 命令创建一个命名数据卷。
```bash
docker volume create my_volume
```
    - **在容器中使用命名数据卷**：在运行容器时，使用 `-v` 或 `--volume` 选项将命名数据卷挂载到容器内的指定路径。
```bash
docker run -it -v my_volume:/container_path ubuntu /bin/bash
```
这里的 `my_volume` 是命名数据卷的名称，`/container_path` 是容器内的挂载路径。
- **匿名数据卷**
    - 当你只指定容器内的路径而不指定主机路径或命名数据卷时，Docker 会创建一个匿名数据卷。
```bash
docker run -it -v /container_path ubuntu /bin/bash
```
不过，匿名数据卷的管理相对复杂，因为很难直接找到它们在主机上的存储位置。
- **数据卷的优点**
    - 数据卷可以在多个容器之间共享和重用。
    - 数据卷的创建和管理由 Docker 负责，操作相对简单。
    - 数据卷可以在容器停止、删除后继续存在，实现数据的持久化。

### 2. 绑定挂载（Bind Mounts）
绑定挂载是将主机上的任意目录或文件挂载到容器内的指定路径。
- **使用绑定挂载**
    - 在运行容器时，使用 `-v` 或 `--volume` 选项指定主机路径和容器内路径。
```bash
docker run -it -v /host_path:/container_path ubuntu /bin/bash
```
这里的 `/host_path` 是主机上的路径，`/container_path` 是容器内的挂载路径。
- **绑定挂载的优点**
    - 可以直接使用主机上已有的数据，无需额外创建数据卷。
    - 可以对挂载的文件或目录进行更灵活的操作，因为它们直接位于主机文件系统中。
- **绑定挂载的缺点**
    - 依赖于主机文件系统的目录结构，可移植性较差。
    - 权限管理相对复杂，需要确保主机和容器对挂载路径有正确的访问权限。

### 3. 存储驱动（Storage Drivers）
存储驱动主要用于管理容器镜像和容器层的存储，但也可以间接影响数据的持久化。
- **常见的存储驱动**
    - **Overlay2**：是目前 Docker 默认的存储驱动，它通过联合挂载技术将多个文件系统层合并为一个统一的视图，提供了较好的性能和兼容性。
    - **Btrfs**：基于 Btrfs 文件系统，支持写时复制（CoW）和快照功能，适合需要频繁创建和删除容器的场景。
    - **ZFS**：具有强大的存储和管理功能，如数据压缩、快照、克隆等，但对系统资源要求较高。
- **选择存储驱动**
    - 存储驱动的选择取决于你的系统环境、性能需求和数据管理要求。一般来说，Overlay2 是大多数场景下的首选。

### 4. 外部存储系统
对于企业级应用或需要大规模数据存储的场景，可以使用外部存储系统与 Docker 集成。
- **网络文件系统（NFS）**
    - NFS 允许将远程服务器上的文件系统挂载到本地主机，然后在 Docker 容器中使用绑定挂载将 NFS 挂载点挂载到容器内。
    - 需要在主机上安装 NFS 客户端，并进行相应的配置。
- **分布式存储系统（如 Ceph、GlusterFS）**
    - 分布式存储系统提供了高可用性、可扩展性和数据冗余等特性，适合大规模集群环境。
    - 需要对分布式存储系统进行部署和配置，并使用相应的驱动与 Docker 集成。

综上所述，不同的 Docker 持久化存储方案各有优缺点，你可以根据具体的应用场景和需求选择合适的方案。 