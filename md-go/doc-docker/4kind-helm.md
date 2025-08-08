# 1.ubuntu 24.04上如何安装helm 

在 Ubuntu 24.04 上安装 Helm（Kubernetes 包管理工具）可以通过以下步骤完成：

---

### **方法 1：使用官方脚本安装（推荐）**
#### **1. 下载并运行安装脚本**
```bash
# curl -x http://127.0.0.1:8123  https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
此脚本会自动检测系统架构并安装最新稳定版 Helm。

#### **2. 验证安装**
```bash
helm version --short
```
输出示例：
```
v3.14.0+g8dce9e9
```

---

### **方法 2：手动下载二进制包**
#### **1. 下载 Helm 二进制文件**
```bash
# 获取最新版本号
HELM_VERSION=$(curl -s https://api.github.com/repos/helm/helm/releases/latest | grep 'tag_name' | cut -d '"' -f 4)

# 下载并解压
wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz

# 移动二进制文件到 PATH
sudo mv linux-amd64/helm /usr/local/bin/
```

#### **2. 清理临时文件**
```bash
rm -rf linux-amd64 helm-*.tar.gz
```

---

### **方法 3：通过 Snap 安装（Ubuntu 专属）**
```bash
sudo snap install helm --classic
```

---

### **方法 4：使用包管理器（APT）**
#### **1. 添加 Helm 官方仓库**
```bash
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-add-repository "deb https://baltocdn.com/helm/stable/debian/ all main"
```

#### **2. 安装 Helm**
```bash
sudo apt update
sudo apt install helm
```

---

### **验证 Helm 功能**
#### **1. 添加常用仓库**
```bash
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

#### **2. 搜索 Chart**
```bash
helm search repo nginx
```

---

### **卸载 Helm**
```bash
# 方法1/2安装的卸载方式
sudo rm /usr/local/bin/helm

# Snap 安装的卸载
sudo snap remove helm

# APT 安装的卸载
sudo apt remove helm
```

---

### **版本兼容性说明**
- Helm 3.x 需要 **kubectl** 和 **Kubernetes 集群**已正确配置。
- 如果遇到 `Error: INSTALLATION FAILED: Kubernetes cluster unreachable`，请先配置 `kubeconfig`：
  ```bash
  mkdir -p ~/.kube
  sudo cp /etc/kubernetes/admin.conf ~/.kube/config
  sudo chown $(id -u):$(id -g) ~/.kube/config
  ```

---

### **总结**
| 方法               | 适用场景                          | 命令                                                                 |
|--------------------|----------------------------------|----------------------------------------------------------------------|
| **官方脚本**       | 快速安装最新版（推荐）            | `curl https://raw.githubusercontent.com/... | bash`               |
| **手动下载**       | 需特定版本或离线环境              | `wget + tar + mv`                                                   |
| **Snap**           | Ubuntu 简易安装                   | `sudo snap install helm --classic`                                  |
| **APT**            | 适合长期维护的稳定版              | `sudo apt install helm`                                             |

选择最适合你的方式即可！完成后通过 `helm version` 验证安装成功。

===========================================
