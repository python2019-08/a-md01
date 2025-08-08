# 1.如何查看某个docker image的基本信息

要查看 Docker 镜像的基本信息，可以使用以下几种方法。这些方法能获取镜像的标签、大小、创建时间、层信息、环境变量等元数据。


### **1. 使用 `docker image inspect` 命令（最详细）**
```bash
docker image inspect <image_name>:<tag>
# 示例：
docker image inspect ubuntu:22.04
```

**输出信息包括**：
- 镜像 ID、创建时间、大小
- 基础层信息（`Parent`）
- 容器配置（`Config`）：包括启动命令、环境变量、暴露的端口等
- 历史记录（`History`）：镜像构建过程中的每一层操作

**格式化输出特定字段**：
```bash
# 获取镜像大小（以人类可读格式显示）
docker image inspect --format='{{.Size | humanize}}' ubuntu:22.04

# 获取创建时间
docker image inspect --format='{{.Created}}' ubuntu:22.04

# 获取所有环境变量
docker image inspect --format='{{range $index, $value := .Config.Env}}{{$value}}{{"\n"}}{{end}}' ubuntu:22.04
```


### **2. 使用 `docker images` 命令（简洁信息）**
```bash
docker images <image_name>
# 示例：
docker images ubuntu
```

**输出字段**：
- `REPOSITORY`：镜像仓库名称
- `TAG`：镜像标签
- `IMAGE ID`：镜像唯一标识符
- `CREATED`：创建时间
- `SIZE`：镜像大小

**查看详细大小信息**：
```bash
docker images --digests --size  # 显示完整的 digest 和真实磁盘占用
```


### **3. 使用 `docker history` 查看构建历史**
```bash
docker history <image_name>:<tag>
# 示例：
docker history ubuntu:22.04
```

**输出信息**：
- 每一层的创建时间、作者、命令和大小
- 可查看镜像构建过程中的具体操作


### **4. 查看镜像配置（JSON 格式）**
```bash
docker image inspect --format='{{json .Config}}' ubuntu:22.04 | jq  # 需要安装 jq
```

**常用配置字段**：
- `Cmd`：默认启动命令
- `Env`：环境变量列表
- `ExposedPorts`：暴露的端口
- `Volumes`：声明的卷
- `WorkingDir`：工作目录


### **5. 使用第三方工具（更友好的界面）**
#### **Dive（深入分析镜像层）**
1. **安装**：
   ```bash
   # macOS
   brew install dive
   # Linux
   wget https://github.com/wagoodman/dive/releases/download/v0.11.0/dive_0.11.0_linux_amd64.deb
   sudo dpkg -i dive_0.11.0_linux_amd64.deb
   ```

2. **使用**：
   ```bash
   dive ubuntu:22.04
   ```

#### **Docker UI 工具**
- **Portainer**：可视化管理 Docker，可查看镜像详情。
- **Lazydocker**：终端界面的 Docker 管理工具。


### **示例输出**
```bash
$ docker image inspect --format='{{.Id}} {{.Created}} {{.Size | humanize}}' ubuntu:22.04
sha256:847381c11e4a7ff8a1c89f9207ea0f1c3b03d53337296341a2e2d3e4a0d9b 2023-10-04T15:26:38.611341061Z 77.8 MB
```


### **总结**
- **快速查看**：使用 `docker images`。
- **详细信息**：使用 `docker image inspect`。
- **构建历史**：使用 `docker history`。
- **层分析**：使用 `dive` 工具。

根据需求选择合适的方法，可获取镜像的完整元数据和构建细节。



===============================================================
# 2.Docker 配置了过多的镜像仓库和代理
```sh
$ sudo cat /etc/docker/daemon.json
{
    "registry-mirrors": [
        "http://hub-mirror.c.163.com",
        "https://docker.nju.edu.cn",
        "https://docker.xuanyuan.me",
        "http://docker.m.daocloud.io",
        "http://docker.imgdb.de",
        "http://docker.hlmirror.com",
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
    ],
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    },
    "insecure-registries": ["localhost:5000"]
}
```
从你的 `daemon.json` 配置可以看出，问题出在 **Docker 配置了过多的镜像仓库和代理**，特别是 `https://proxy.1panel.live` 这个代理地址导致了镜像拉取失败。以下是解决方案：

---

### **1. 清理并简化 `daemon.json`**
#### （1）备份当前配置
```bash
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
```

#### （2）编辑配置，仅保留可靠的镜像源
```bash
sudo tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.nju.edu.cn",
    "https://mirror.azure.cn"
  ],
  "insecure-registries": ["localhost:5000"]
}
EOF
```

#### （3）删除所有代理相关配置
确保配置中不包含 `proxy.1panel.live` 或其他代理地址。

---

### **2. 彻底重启 Docker 服务**
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

---

### **3. 验证代理是否已清除**
```bash
docker info | grep -i proxy
```
**预期输出**：无任何代理信息（如果仍有输出，继续下一步）。

---

### **4. 完全重置 Docker 配置（可选）**
如果代理仍然存在，可能是缓存问题：
```bash
sudo systemctl stop docker
sudo rm -rf /var/lib/docker/network/files/  # 清除网络缓存
sudo systemctl start docker
```

---

### **5. 手动拉取镜像测试**
```bash
docker pull kiwigrid/k8s-sidecar:1.30.3
```
如果拉取失败，直接使用国内镜像源：
```bash
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/k8s-sidecar:1.30.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/k8s-sidecar:1.30.3 kiwigrid/k8s-sidecar:1.30.3
```

---

### **6. 重启 Kind 集群和 Jenkins**
```bash
kind restart cluster --name=kind
kubectl delete pod -n jenkins jenkins-0
kubectl get pods -n jenkins -w
```

---

### **关键修改点**
| 问题原因 | 解决方案 |
|----------|----------|
| `daemon.json` 中配置了无效代理 | 删除所有代理和不可靠镜像源 |
| Docker 缓存导致配置未生效 | 完全重启 Docker 并清除缓存 |
| 镜像拉取超时 | 改用国内镜像源或手动导入 |

---

### **验证修复**
1. **确认代理已清除**：
   ```bash
   docker info | grep -i proxy
   ```
2. **确认镜像已存在**：
   ```bash
   docker images | grep kiwigrid/k8s-sidecar
   ```
3. **确认 Jenkins Pod 运行**：
   ```bash
   kubectl get pods -n jenkins
   ```

如果仍有问题，请提供：
```bash
docker info | grep -i registry
kubectl describe pod -n jenkins jenkins-0
```
===========================================
# 3.清除错误的代理配置
```sh
Warning  Failed          17m (x4 over 19m)     kubelet            Failed to pull image "docker.io/kiwigrid/k8s-sidecar:1.30.3": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/kiwigrid/k8s-sidecar:1.30.3": failed to resolve reference "docker.io/kiwigrid/k8s-sidecar:1.30.3": failed to do request: Head "https://registry-1.docker.io/v2/kiwigrid/k8s-sidecar/manifests/1.30.3": proxyconnect tcp: dial tcp 127.0.0.1:8123: connect: connection refused
```

这个错误表明 Kubernetes 无法通过代理（`127.0.0.1:8123`）拉取镜像 `docker.io/kiwigrid/k8s-sidecar:1.30.3`，原因是代理连接被拒绝。以下是完整的解决方案：

---

### **1. 检查并修复 Docker 代理配置**
#### （1）查看当前 Docker 代理设置
```bash
docker info | grep -i proxy
```
如果输出包含无效代理（如 `127.0.0.1:8123`），需要清除或更新配置。

#### （2）清除错误的代理配置
```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/proxy.conf <<EOF
[Service]
Environment=""
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

#### （3）验证代理已禁用
```bash
docker info | grep -i proxy  # 应无输出
```

---

### **2. 直接手动拉取镜像**
#### （1）在宿主机拉取镜像
```bash
docker pull kiwigrid/k8s-sidecar:1.30.3
```
如果拉取成功，Kind 会自动复用该镜像（无需额外操作）。

#### （2）如果拉取失败（无代理无法访问外网）
- **选项1**：更换国内镜像源  
  ```bash
  docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/k8s-sidecar:1.30.3
  docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/k8s-sidecar:1.30.3 kiwigrid/k8s-sidecar:1.30.3
  ```
- **选项2**：离线机器需手动导入镜像  
  在能联网的机器上：
  ```bash
  docker pull kiwigrid/k8s-sidecar:1.30.3
  docker save kiwigrid/k8s-sidecar:1.30.3 > sidecar.tar
  ```
  在目标机器上：
  ```bash
  docker load < sidecar.tar
  ```

---

### **3. 重启 Kind 集群**
```bash
kind restart cluster --name=kind
```

---

### **4. 重新创建 Jenkins Pod**
```bash
kubectl delete pod -n jenkins jenkins-0
kubectl get pods -n jenkins -w  # 等待状态变为 Running
```

---

### **5. 验证修复**
```bash
kubectl logs -n jenkins jenkins-0 -c init  # 查看初始化容器日志
kubectl exec -n jenkins jenkins-0 -- cat /run/secrets/additional/chart-admin-password  # 获取密码
```

---

### **关键排查点**
| 现象 | 原因 | 解决方案 |
|------|------|----------|
| `proxyconnect tcp: connection refused` | Docker 代理配置错误 | 清除或修复 `/etc/systemd/system/docker.service.d/proxy.conf` |
| `failed to pull image` | 网络不通或镜像不存在 | 1. 手动拉取镜像<br>2. 使用国内镜像源或离线导入 |
| Pod 卡在 `Init` 状态 | 初始化容器失败 | 检查 `kubectl logs -n jenkins jenkins-0 -c init` |

---

### **总结**
1. **修复 Docker 代理配置** → 清除无效代理或配置可用的代理。  
2. **确保镜像存在** → 手动拉取或离线导入 `kiwigrid/k8s-sidecar:1.30.3`。  
3. **重启集群和 Pod** → `kind restart` + `kubectl delete pod`。  

完成以上步骤后，Jenkins Pod 应能正常启动。如果仍有问题，请提供：
```bash
docker info | grep -i proxy
kubectl describe pod -n jenkins jenkins-0 | grep -A 20 "Events:"
```
===============================================
# 4.彻底清除 Docker 代理配置

```sh
$ docker info | grep -i proxy
   https://proxy.1panel.live/
```
从你的操作和输出可以看出，虽然你尝试清除了 Docker 的代理配置，但 `docker info` 仍然显示代理 `https://proxy.1panel.live/` 生效。这说明代理配置可能存在于 **其他位置**（如 Docker 的全局配置文件或环境变量）。以下是彻底解决问题的步骤：

---

### **1. 彻底清除 Docker 代理配置**
#### （1）检查所有可能的代理配置位置
```bash
# 检查 Docker 服务配置文件
sudo cat /etc/systemd/system/docker.service.d/*.conf

# 检查 Docker 环境文件
sudo cat /etc/environment | grep -i proxy

# 检查用户级 Docker 配置
cat ~/.docker/config.json | grep -i proxy
```

#### （2）删除所有代理相关配置
```bash
# 删除 Docker 服务代理配置
sudo rm -rf /etc/systemd/system/docker.service.d/proxy.conf

# 删除环境变量中的代理（如果存在）
sudo sed -i '/HTTP_PROXY=/d' /etc/environment
sudo sed -i '/HTTPS_PROXY=/d' /etc/environment

# 删除用户级 Docker 代理配置
sed -i '/proxies/d' ~/.docker/config.json
```

<!-- 
 ​​临时解决方案​​: 如果找不到代理配置来源，可以强制覆盖代理设置：

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
Environment="HTTP_PROXY=127.0.0.1:8123"
Environment="HTTPS_PROXY=27.0.0.1:8123"
Environment="NO_PROXY=localhost,127.0.0.1,.cluster.local"
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker 
-->

#### （3）彻底重启 Docker
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

---

### **2. 验证代理是否已清除**
```bash
docker info | grep -i proxy  # 应该无输出
```
如果仍有输出，可能是 **Docker 守护进程缓存** 或 **其他配置文件残留**，尝试：
```bash
sudo systemctl stop docker
sudo systemctl start docker
```

---

### **3. 手动拉取镜像（绕过代理）**
```bash
docker pull kiwigrid/k8s-sidecar:1.30.3
```
如果拉取失败，可能是网络限制（如防火墙），需：
- 更换国内镜像源（如阿里云）。
- 或使用离线导入镜像的方式。

---

### **4. 重启 Kind 集群**
```bash
kind restart cluster --name=kind
kubectl delete pod -n jenkins jenkins-0
```

---

### **5. 检查 Jenkins Pod 状态**
```bash
kubectl get pods -n jenkins -w
```
如果 Pod 仍无法启动，检查日志：
```bash
kubectl logs -n jenkins jenkins-0 -c init
```

---

### **关键问题总结**
| 现象 | 原因 | 解决方案 |
|------|------|----------|
| `docker info` 仍显示代理 | 代理配置残留 | 彻底清除 `/etc/environment`、`~/.docker/config.json` 等 |
| `Failed to pull image` | 代理清除后网络仍不通 | 1. 手动拉取镜像<br>2. 更换镜像源或离线导入 |
| Pod 卡在 `Init` | 初始化容器失败 | 检查 `kubectl logs -n jenkins jenkins-0 -c init` |

---

### **最终验证**
1. **确认代理已清除**：
   ```bash
   docker info | grep -i proxy  # 应无输出
   ```
2. **确认镜像已存在**：
   ```bash
   docker images | grep kiwigrid/k8s-sidecar
   ```
3. **确认 Jenkins Pod 运行**：
   ```bash
   kubectl get pods -n jenkins
   ```

如果问题仍未解决，请提供以下信息：
```bash
sudo cat /etc/systemd/system/docker.service.d/*
kubectl describe pod -n jenkins jenkins-0
```

=========================================
# 5.Docker 无法连接官方仓库

```sh
(base) abner@abner-XPS:~/abner2/zdev/gopath/src/k8s001$ docker images | grep kiwigrid/k8s-sidecar
kiwigrid/k8s-sidecar         1.30.3              de5e422bf8ac   3 months ago    80MB
(base) abner@abner-XPS:~/abner2/zdev/gopath/src/k8s001$ docker pull docker.io/library/nginx:latest
Error response from daemon: Get "https://registry-1.docker.io/v2/": context deadline exceeded (Client.Timeout exceeded while awaiting headers)
```

从你的操作和报错来看，核心问题是 **Docker 无法连接官方仓库（`registry-1.docker.io`）**，即使本地已有 `kiwigrid/k8s-sidecar:1.30.3` 镜像。以下是逐步解决方案：

---

### **1. 诊断网络连接问题**
#### （1）测试基础网络连通性
```bash
ping 8.8.8.8  # 测试外网连通性
curl -v https://registry-1.docker.io  # 直接测试 Docker Hub 访问
```
- 如果超时，说明网络层有问题（防火墙、DNS 或代理配置）。

#### （2）检查 Docker 服务网络模式
```bash
docker info | grep -i proxy  # 确认代理配置已清除
docker info | grep -i dns    # 检查 DNS 配置
```

---

### **2. 修复 Docker 网络配置**
#### （1）强制重置 Docker 网络
```bash
sudo systemctl stop docker
sudo rm -rf /var/lib/docker/network/files/
sudo systemctl start docker
```

#### （2）显式指定 Docker 使用国内镜像源
编辑 `/etc/docker/daemon.json`：
```bash
sudo tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com"
  ],
  "dns": ["8.8.8.8", "114.114.114.114"]  
}
EOF
sudo systemctl restart docker
```

---

### **3. 手动加载本地镜像（终极方案）**
既然 `kiwigrid/k8s-sidecar:1.30.3` 已存在本地，直接复用：
```bash
# 确认镜像 ID
docker images | grep kiwigrid/k8s-sidecar

# 导出镜像（可选，用于备份）
docker save kiwigrid/k8s-sidecar:1.30.3 > sidecar.tar

# 强制重新加载镜像（解决缓存问题）
docker load -i sidecar.tar
```

---

### **4. 验证 Kind 和 Jenkins**
#### （1）重启 Kind 集群
```bash
kind restart cluster --name=kind
```

#### （2）重建 Jenkins Pod
```bash
kubectl delete pod -n jenkins jenkins-0
kubectl get pods -n jenkins -w
```

---

### **5. 备选方案：离线安装**
如果网络始终无法恢复：
1. 在联网机器拉取所有依赖镜像：
   ```bash
   docker pull kiwigrid/k8s-sidecar:1.30.3
   docker pull jenkins/jenkins:lts
   docker save kiwigrid/k8s-sidecar:1.30.3 jenkins/jenkins:lts > all-images.tar
   ```
2. 在目标机器导入：
   ```bash
   docker load < all-images.tar
   ```

---

### **关键修复步骤总结**
| 步骤 | 命令/操作 |
|------|----------|
| **重置 Docker 网络** | `sudo rm -rf /var/lib/docker/network/files/` |
| **配置国内镜像源** | 修改 `/etc/docker/daemon.json` |
| **强制使用本地镜像** | `docker load -i sidecar.tar` |
| **重启 Kind** | `kind restart cluster` |

---

### **验证成功**
1. **确认 Docker 能拉取镜像**：
   ```bash
   docker pull docker.mirrors.ustc.edu.cn/library/nginx:latest
   ```
2. **确认 Jenkins Pod 运行**：
   ```bash
   kubectl logs -n jenkins jenkins-0 -c init
   ```

如果仍有问题，请提供：
```bash
ip route show default
sudo iptables -L -n -v
```
