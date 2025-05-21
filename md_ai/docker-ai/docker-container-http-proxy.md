# 1. 如何为所有docker容器设置代理？ {#articleContentId .title-article}
  
于 2023-03-21 22:59:01 首次发布  
本文链接：[https://blog.csdn.net/bigbaojian/article/details/129699708](https://blog.csdn.net/bigbaojian/article/details/129699708) 
 
### 1.1方法一

要为所有 Docker 容器设置代理，可以按照以下步骤进行：

(1).  在您的 Docker
    主机上设置代理服务器，首先创建一个systemd插入（drop-in）目录，`sudo mkdir -p /etc/systemd/system/docker.service.d`，然后在`/etc/systemd/system/docker.service.d/http-proxy.conf`文件中添加以下内容来配置代理：

```sh
cat >> /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=http://your-proxy:your-port"
Environment="HTTPS_PROXY=http://your-proxy:your-port"
Environment="NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"
EOF
```

将`your-proxy`和`your-port`替换为您的代理服务器和端口号，并将`NO_PROXY`配置为不需要使用代理的主机名或
IP 地址。

(2).  重新加载 Docker 服务以使新配置生效：

```sh
sudo systemctl daemon-reload
sudo systemctl restart docker
```

这将重新启动 Docker 服务，并使用新的代理设置来启动所有 Docker 容器。\
验证配置是否已加载并匹配您所做的更改，例如：

```sh
sudo systemctl show --property=Environment docker
```

## 1.2 方法二

您也可以使用 docker run 命令启动新的容器，并在启动命令中包含 --env 或-e 选项来设置特定容器的代理环境变量，例如：

```sh
docker run -e HTTP_PROXY=http://your-proxy:your-port -e HTTPS_PROXY=http://your-proxy:your-port alpine /bin/sh

### my cmd, 
### remark: HTTP_PROXY  is not correct but http_proxy  is correct.
###         HTTPS_PROXY is not correct but https_proxy is correct.
docker run -i -t -v ./:/home/abel:rw --gpus all --shm-size 16G    -e http_proxy=http://192.168.1.107:8123 -e https_proxy=http://192.168.1.107:8123  nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04 /bin/bash 
```

这将启动一个基于 Alpine Linux 的新容器，并为该容器设置代理环境变量。
对于现有的容器，您可以使用 docker exec 命令来执行命令，例如：

```sh
docker exec -e HTTP_PROXY=http://your-proxy:your-port -e HTTPS_PROXY=http://your-proxy:your-port container-name /bin/sh
### my cmd, 
### remark: HTTP_PROXY  is not correct but http_proxy  is correct.
###         HTTPS_PROXY is not correct but https_proxy is correct.
docker exec -it -e http_proxy=http://192.168.1.107:8123 -e https_proxy=http://192.168.1.107:8123 container-name /bin/sh
```
 
这将在名为 container-name 的容器中启动一个新的 shell会话，并为该会话设置代理环境变量。

注意，如果您的容器应用程序需要使用特定的代理设置，您可能需要在容器内部进行进一步的配置。例如，您可能需要将代理服务器地址和端口号添加到应用程序配置文件中，或者在容器内部安装特定的代理客户端软件。

### 参考

[https://docs.docker.com/network/proxy/](https://docs.docker.com/network/proxy/) 


<=====================================================================================>
<=====================================================================================>
# 2. Docker HTTP(S) Proxy：在容器内部设置HTTP(S)代理的方法
作者：404 
2024.01.18 03:26浏览量：17
简介：本文将详细介绍如何在Docker容器内部设置HTTP(S)代理，以便容器内的应用程序可以方便地通过代理访问互联网。 

Docker HTTP(S) Proxy是一种在Docker容器内部设置HTTP(S)代理的方法，以便于容器内的应用程序可以方便地通过代理访问互联网。在容器内部设置HTTP(S)代理可以保护应用程序免受外部网络的直接访问，提高安全性。同时，通过代理访问互联网可以加速网络连接速度，提高应用程序的性能。
设置HTTP(S)代理的方法主要有两种：使用Dockerfile配置和使用docker run命令添加参数。

## 2.1使用Dockerfile配置：
在Dockerfile中，可以使用RUN指令和apt-get命令来安装代理相关的软件，例如curl和wget。然后通过环境变量或者映射容器内的端口来代理外部请求。以下是一个简单的例子：

### (1) 安装curl

RUN apt-get update && apt-get install -y curl

### (2) 设置HTTP代理
ENV http_proxy=”http://proxy.example.com:8080“
ENV https_proxy=”https://proxy.example.com:8080“

### (3) 映射容器内的80端口到宿主机的8080端口
EXPOSE 80

### (4) 容器启动时，检查是否有代理环境变量，如果没有则设置默认代理
CMD [“curl”, “—head”, “—fail”, “http://google.com“]”

## 2.2 使用docker run命令添加参数：
在运行容器时，可以通过添加-e参数来设置环境变量，从而实现代理。例如：
```sh
docker run -it -e http_proxy=http://proxy.example.com:8080 -p8080:8080 —name my_container my_image
```
这样，容器内的应用程序就可以通过代理访问互联网了。

需要注意的是，Docker HTTP(S) Proxy主要适用于容器内部的HTTP(S)请求。如果需要代理容器内部的本地回环请求（例如容器内的服务调用另一个容器的服务），可以考虑使用Docker Networks或者Docker Volume来实现。
总的来说，Docker HTTP(S) Proxy是一种在容器内部设置HTTP(S)代理的方法，可以通过环境变量或者映射容器内的端口来实现。这使得容器内的应用程序可以方便地通过代理访问互联网。