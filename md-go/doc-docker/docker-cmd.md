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
