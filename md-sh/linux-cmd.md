# 1.date 命令 按格式输出 举例

在Linux中，`date`命令用于显示或设置系统日期和时间。以下是按不同格式输出日期和时间的示例：

### 输出当前日期和时间
```bash
date
# 示例输出：Tue Sep 12 15:30:00 UTC 2023
```

### 按指定格式输出日期
- **年-月-日**
```bash
date +%Y-%m-%d
# 示例输出：2023-09-12
```
- **月/日/年**
```bash
date +%m/%d/%Y
# 示例输出：09/12/2023
```
- **日-月-年**
```bash
date +%d-%m-%Y
# 示例输出：12-09-2023
```

### 按指定格式输出时间
- **时:分:秒**
```bash
date +%H:%M:%S
# 示例输出：15:30:00
```
- **12小时制时间**
```bash
date +%I:%M:%S %p
# 示例输出：03:30:00 PM
```

### 组合日期和时间格式
- **年-月-日 时:分:秒**
```bash
date +%Y-%m-%d\ %H:%M:%S
# 示例输出：2023-09-12 15:30:00
```
- **月/日/年 12小时制时间**
```bash
date +%m/%d/%Y\ %I:%M:%S\ %p
# 示例输出：09/12/2023 03:30:00 PM
```

### 输出其他日期相关信息
- **星期几**
```bash
date +%A
# 示例输出：Tuesday
```
- **月份全称**
```bash
date +%B
# 示例输出：September
```
- **月份缩写**
```bash
date +%b
# 示例输出：Sep
```
- **一年中的第几天**
```bash
date +%j
# 示例输出：255
```

### 输出日期的偏移量
- **明天的日期**
```bash
date -d "tomorrow" +%Y-%m-%d
# 示例输出：2023-09-13
```
- **昨天的日期**
```bash
date -d "yesterday" +%Y-%m-%d
# 示例输出：2023-09-11
```
- **一周后的日期**
```bash
date -d "next week" +%Y-%m-%d
# 示例输出：2023-09-19
```
- **一个月前的日期**
```bash
date -d "last month" +%Y-%m-%d
# 示例输出：2023-08-12
```

### 格式化输出到文件
```bash
date +%Y-%m-%d\ %H:%M:%S > log.txt
```

这些只是`date`命令的一些常见用法，你可以根据需要组合不同的格式选项来获得所需的日期和时间输出。


=============================================================
# 2.Linux文件占用查看简易教程（linux查看文件占用）
Linux文件占用查看简易教程

在Linux系统中，有时候我们需要查看某个文件被哪个进程占用，以及占用进程的PID（进程ID），这时候我们可以利用系统自带的工具来查看。本文将介绍几种常用的Linux文件占用查看的方法。

方法一：lsof

lsof是一个可以列出当前系统所有打开的文件的命令，我们可以利用它来查看哪个进程正在占用某个文件。下面是查看占用文件的命令：

lsof 
例如，我们想要查看/mnt/data.txt这个文件被哪个进程占用，可以输入以下命令：

lsof /mnt/data.txt
运行以上命令之后，系统将会列出占用该文件的进程以及对应的PID等信息。

方法二：fuser

fuser是一个用来列出打开某个文件的进程的命令，我们可以利用它来查看哪个进程正在占用某个文件。下面是查看占用文件的命令：

fuser -v 
例如，我们想要查看/mnt/data.txt这个文件被哪个进程占用，可以输入以下命令：

fuser -v /mnt/data.txt
运行以上命令之后，系统将会列出占用该文件的进程以及对应的PID等信息。

方法三：lslk

lslk是一个类似于ps命令的工具，它可以列出系统当前正在运行的进程，并且可以查看某个进程对应的文件描述符。我们可以利用它来查看哪个进程正在占用某个文件。下面是查看占用文件的命令：

lslk -f 
例如，我们想要查看/mnt/data.txt这个文件被哪个进程占用，可以输入以下命令：

lslk -f /mnt/data.txt
运行以上命令之后，系统将会列出占用该文件的进程以及对应的PID等信息。

方法四：fstat

fstat是一个用来显示系统打开文件信息的命令，我们可以利用它来查看某个文件被哪个进程占用。下面是查看占用文件的命令：

fstat 
例如，我们想要查看/mnt/data.txt这个文件被哪个进程占用，可以输入以下命令：

fstat /mnt/data.txt
运行以上命令之后，系统将会列出占用该文件的进程以及对应的PID等信息。

总结

以上就是常用的Linux文件占用查看的方法。我们可以根据自己的习惯和需要来选择使用对应的命令来查看占用文件的进程信息。在平时使用中，我们可以根据文件占用信息来判断是否可以对某个文件进行删除、移动、修改等操作，从而避免了进程和文件的冲突。

======================================================
# 3. linux 的/run/

在Linux系统中，`/run/` 是一个重要的临时文件系统挂载点，主要用于存储系统运行时产生的临时数据。以下是关于 `/run/` 的详细解析：


### **一、基本概念与用途**
- **存储运行时数据**：  
  用于存放系统启动后运行过程中产生的临时文件，例如：
  - 进程PID文件（记录进程ID，如`/run/nginx.pid`）
  - 套接字文件（用于进程间通信，如D-Bus套接字）
  - 锁文件（确保资源独占访问，如包管理器的锁文件）
  - 设备临时信息（如U盘挂载信息）。

- **生命周期**：  
  该目录在系统启动时创建，关机时自动清空，属于**易失性存储**（数据不会持久化）。

- **实现方式**：  
  通常基于`tmpfs`（内存文件系统），数据存储在内存中，读写速度极快，但断电后数据丢失。


### **二、目录结构与典型文件**
#### **1. 核心子目录与文件**
- **`/run/user/`**：  
  存储用户相关的运行时数据，每个用户有独立子目录（如`/run/user/1000`对应UID为1000的用户），包含：
  - 桌面环境进程信息（如GNOME的D-Bus套接字）
  - 应用程序临时文件（如浏览器缓存）。

- **`/run/lock/`**：  
  存放锁文件，例如包管理器`apt`的锁文件`/run/lock/apt.lock`，防止多个进程同时修改系统软件包。

- **`/run/systemd/`**：  
  存储systemd相关的运行时数据，如：
  - 服务状态文件（`/run/systemd/system/*.service.pid`）
  - 套接字激活文件（用于按需启动服务）。

- **`/run/udev/`**：  
  存放udev设备管理器的临时数据，如设备节点信息和规则缓存。

#### **2. 示例文件用途**
| 文件名                  | 用途描述                                                                 |
|-------------------------|--------------------------------------------------------------------------|
| `/run/nginx.pid`        | Nginx Web服务器的进程ID文件，用于系统管理工具识别和控制进程。           |
| `/run/dbus/system_bus_socket` | D-Bus系统总线的套接字文件，用于进程间通信。                          |
| `/run/networkd-dhcp4.lock` | NetworkManager的DHCP锁文件，防止多实例同时获取IP地址。                |


### **三、与其他临时目录的区别**
| 目录       | 位置     | 持久性       | 典型用途                                                                 |
|------------|----------|--------------|--------------------------------------------------------------------------|
| `/run/`    | 内存     | 系统重启清空 | 存储进程运行时数据（PID、锁、套接字）。                                 |
| `/tmp/`    | 磁盘或内存 | 可配置持久   | 存储用户和应用的临时文件（如下载的临时文件、解压缩缓存）。             |
| `/var/run/` | 磁盘     | 系统重启清空 | 传统Unix系统中存放运行时数据，现代Linux逐渐被`/run/`取代（通过符号链接指向`/run/`）。 |


### **四、系统设计意义**
1. **安全性提升**：  
   - 限制对运行时数据的访问权限（如`/run/user/`目录仅用户自身可访问），防止恶意程序篡改进程信息。

2. **性能优化**：  
   - 基于内存的`tmpfs`存储，避免磁盘I/O开销，适合频繁读写的临时数据（如进程间通信套接字）。

3. **系统启动流程改进**：  
   - 在systemd架构中，`/run/`在系统启动早期创建，允许服务在挂载其他文件系统前即可写入运行时数据。


### **五、常见操作与注意事项**
1. **查看目录占用**：  
   ```bash
   df -h /run  # 查看/run的内存使用情况
   du -sh /run/*  # 查看子目录占用
   ```

2. **权限管理**：  
   - `/run/`目录通常由`root`用户创建，普通用户仅能访问`/run/user/[UID]`下的文件。

3. **禁止手动修改**：  
   - 系统运行时文件由服务自动管理，手动修改可能导致服务异常（如删除PID文件会导致进程管理工具无法识别进程）。

4. **与`/var/run/`的兼容性**：  
   - 为兼容旧版程序，许多Linux发行版会创建符号链接`/var/run -> /run`，确保传统软件仍能正常工作。


### **六、总结**
`/run/`是Linux系统中管理运行时数据的核心目录，其设计目标是高效存储进程状态、通信套接字等临时信息。理解其用途有助于系统维护（如排查服务启动故障时查看PID文件）和开发调试（如定位进程间通信问题）。在日常使用中，通常无需手动操作该目录，系统会自动管理其中的文件。

==========================================================
# 4.LANG=C LC_ALL=C date --date "+3 months"

`LANG=C LC_ALL=C date --date "+3 months"` 是一个在Linux系统中用于获取当前日期加上三个月后的日期的命令。以下是对这个命令的详细解释：

- **`LANG=C LC_ALL=C`**：这部分是设置语言环境为C。在Linux中，语言环境会影响到一些命令的输出格式，通过将语言环境设置为C，可以确保命令的输出是标准的、不依赖于特定语言的格式。这样可以避免因为语言环境的不同而导致的日期格式不一致等问题。

- **`date`**：这是Linux系统中用于显示或设置系统日期和时间的命令。

- **`--date "+3 months"`**：这是`date`命令的一个选项，用于指定要计算的日期是当前日期加上三个月后的日期。`+3 months`表示在当前日期的基础上增加三个月。

例如，如果当前日期是2023年9月1日，执行这个命令后，输出的结果将会是2023年12月1日。

需要注意的是，这个命令的输出格式可能会因系统设置的不同而有所差异。如果需要特定格式的输出，可以使用`date`命令的其他选项来进行格式化。例如，要输出“年-月-日”格式的日期，可以使用`+%Y-%m-%d`选项，即`LANG=C LC_ALL=C date --date "+3 months" +%Y-%m-%d`。

=============================================================
# 4.linux的info 命令

`info` 命令是 Linux 系统中用于查看软件文档的工具，它是 GNU 项目的标准文档格式，提供了比 `man` 命令更结构化、更交互的帮助信息。以下是关于 `info` 命令的详细介绍：


### **一、基本用法**
```bash
info [选项] [主题]
```

- **示例**：
  ```bash
  info bash          # 查看bash的帮助文档
  info gcc           # 查看GCC的帮助文档
  info info          # 查看info命令本身的帮助
  ```


### **二、核心功能与特性**
1. **文档结构**  
   `info` 文档以 **节点（node）** 为单位组织，节点间通过超链接互联，形成树状结构。例如：
   - 主节点（Main）：概述文档内容
   - 子节点：详细介绍各功能模块

2. **交互模式**  
   进入 `info` 界面后，可使用以下快捷键导航：
   - **方向键**：上下移动光标
   - `Enter`：进入当前光标指向的节点
   - `b`：返回上一个节点
   - `u`：进入当前节点的父节点
   - `n`/`p`：切换到下一个/上一个节点
   - `/`：搜索当前节点内容
   - `q`：退出 `info` 界面

3. **离线文档**  
   文档存储在本地，路径通常为 `/usr/share/info/`，无需联网即可查看。


### **三、常用选项**
| 选项                | 作用描述                                                                 |
|---------------------|--------------------------------------------------------------------------|
| `-f, --file=FILE`   | 指定要查看的info文件（如 `info -f /usr/share/info/bash.info`）            |
| `-d, --directory=DIR` | 添加文档搜索目录（多个目录用冒号分隔）                                   |
| `-m, --menu`        | 显示主菜单节点                                                           |
| `-k, --apropos=KEY` | 搜索包含关键词KEY的所有节点                                              |
| `-o, --output=FILE` | 将输出保存到文件，而非显示在终端                                          |
| `-w, --where`       | 显示当前查看的文档路径                                                   |
| `--help`            | 显示info命令的帮助信息                                                   |


### **四、与man命令的对比**
| 特性                | info命令                                 | man命令                                  |
|---------------------|-----------------------------------------|-----------------------------------------|
| **文档格式**        | GNU标准格式，结构化节点+超链接          | 传统UNIX格式，单页文本                   |
| **内容深度**        | 更详细，适合复杂软件（如GCC、Emacs）    | 简洁，适合快速查询命令用法               |
| **交互性**          | 支持节点跳转、搜索，类似电子书          | 静态显示，仅支持简单翻页                 |
| **适用场景**        | 系统管理员、开发者深入学习软件功能      | 普通用户快速查询命令参数                 |


### **五、实战示例**
#### 1. 查看bash文档的“变量”章节
```bash
info bash
# 进入交互界面后，输入：
/m variables        # 搜索“variables”关键词
```

#### 2. 搜索所有包含“regular expression”的info文档
```bash
info -k "regular expression"
```

#### 3. 导出GCC文档到HTML格式
```bash
info -o gcc.html gcc
# 需先安装texinfo工具：sudo apt-get install texinfo
```


### **六、常见问题与解决方案**
1. **提示“没有找到主题的info文档”**  
   - 原因：软件未安装info文档，或文档路径未添加
   - 解决：
     ```bash
     # 安装bash的info文档（示例）
     sudo apt-get install bash-doc  # Debian/Ubuntu
     sudo yum install bash-doc      # CentOS/RHEL
     ```

2. **自定义文档路径**  
   - 在`.bashrc`中添加：
     ```bash
     export INFOPATH=$INFOPATH:/path/to/custom/info
     ```

3. **转换info文档为其他格式**  
   - 使用`info2html`工具：
     ```bash
     info2html bash.info -o bash.html
     ```


### **七、扩展应用：info文档的制作**
如果需要为自定义软件编写info文档，可通过以下步骤：
1. 安装`texinfo`工具：
   ```bash
   sudo apt-get install texinfo  # Debian/Ubuntu
   ```
2. 编写`.texi`源文件（示例`myapp.texi`）：
   ```texi
   @c MyApp Info文档示例
   @node Main
   @title MyApp Documentation
   @section 简介
   MyApp是一个示例软件，用于演示info文档编写...
   @end node
   ```
3. 生成info文档：
   ```bash
   makeinfo myapp.texi -o myapp.info
   ```


### **总结**
`info` 命令是 Linux 系统中深度学习软件的重要工具，尤其适合探索 GNU 项目的复杂工具（如 GCC、Emacs）。尽管其交互逻辑不如 `man` 命令直观，但结构化的文档组织方式能提供更系统的知识体系。建议在需要深入理解软件原理时优先使用 `info`，而日常快速查询则使用 `man`。

===============================
# 5. 如何给 curl命令添加代理信息

要给 `curl` 命令添加代理信息，可以使用 `-x` 或 `--proxy` 参数指定代理服务器地址。以下是几种常见的代理配置方式：

---

### **1. 使用 HTTP/HTTPS 代理**
```bash
curl -x http://代理服务器IP:端口 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
# curl -x http://127.0.0.1:8123  -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```
或：
```bash
curl --proxy http://代理服务器IP:端口 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

#### **示例**（假设代理服务器是 `192.168.1.100:8080`）：
```bash
curl -x http://192.168.1.100:8080 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **2. 使用 SOCKS 代理**
如果代理是 SOCKS5 协议（如 Shadowsocks、VPN），需指定 `socks5://`：
```bash
curl --proxy socks5://代理服务器IP:端口 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

#### **示例**（SOCKS5 代理 `127.0.0.1:1080`）：
```bash
curl --proxy socks5://127.0.0.1:1080 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **3. 代理需要认证**
如果代理需要用户名和密码，使用以下格式：
```bash
curl -x http://用户名:密码@代理服务器IP:端口 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

#### **示例**（用户 `admin`，密码 `123456`）：
```bash
curl -x http://admin:123456@192.168.1.100:8080 -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **4. 通过环境变量配置代理**
如果不想每次输入代理信息，可以设置环境变量：
```bash
export http_proxy=http://代理服务器IP:端口
export https_proxy=http://代理服务器IP:端口
curl -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

#### **示例**：
```bash
export http_proxy=http://192.168.1.100:8080
export https_proxy=http://192.168.1.100:8080
curl -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **5. 忽略代理对某些地址生效**
如果代理会干扰某些地址，可以通过 `--noproxy` 排除：
```bash
curl -x http://代理服务器IP:端口 --noproxy "dl.k8s.io" -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **常见问题**
1. **代理连接失败**  
   - 检查代理服务器是否可用：
     ```bash
     ping 代理服务器IP
     ```
   - 检查端口是否开放：
     ```bash
     telnet 代理服务器IP 端口
     ```

2. **证书错误**  
   如果代理拦截 HTTPS 流量导致证书错误，可临时跳过验证（不推荐）：
   ```bash
   curl -x http://代理服务器IP:端口 -k -LO "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
   ```

---

### **总结**
| 场景               | 命令示例                                                                 |
|--------------------|--------------------------------------------------------------------------|
| **HTTP 代理**      | `curl -x http://192.168.1.100:8080 -LO "URL"`                           |
| **SOCKS5 代理**    | `curl --proxy socks5://127.0.0.1:1080 -LO "URL"`                        |
| **代理认证**       | `curl -x http://admin:123456@192.168.1.100:8080 -LO "URL"`              |
| **环境变量代理**   | `export http_proxy=http://192.168.1.100:8080; curl -LO "URL"`           |
| **忽略证书错误**   | `curl -x http://代理IP:端口 -k -LO "URL"`                               |

按实际代理类型和参数替换即可！

=====================================================
# 6. wget 命令如何指定代理信息

在 `wget` 命令中指定代理信息，可以通过以下方式配置代理服务器：

---

### **1. 使用 `-e` 参数临时指定代理**
```bash
wget -e use_proxy=yes -e http_proxy=http://代理IP:端口 -e https_proxy=http://代理IP:端口 "下载URL"
```

#### **示例**（HTTP/HTTPS 代理）：
```bash
wget -e use_proxy=yes -e http_proxy=http://192.168.1.100:8080 -e https_proxy=http://192.168.1.100:8080 "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

#### **示例**（SOCKS5 代理）：
```bash
wget -e use_proxy=yes -e http_proxy=socks5://127.0.0.1:1080 -e https_proxy=socks5://127.0.0.1:1080 "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **2. 使用 `--proxy` 参数（部分 `wget` 版本支持）**
```bash
wget --proxy=on --http-proxy=http://代理IP:端口 --https-proxy=http://代理IP:端口 "下载URL"
```

#### **示例**：
```bash
wget --proxy=on --http-proxy=http://192.168.1.100:8080 --https-proxy=http://192.168.1.100:8080 "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **3. 通过环境变量配置代理**
```bash
export http_proxy=http://代理IP:端口
export https_proxy=http://代理IP:端口
wget "下载URL"
```

#### **示例**：
```bash
export http_proxy=http://192.168.1.100:8080
export https_proxy=http://192.168.1.100:8080
wget "https://dl.k8s.io/release/v1.33.2/bin/linux/amd64/kubectl"
```

---

### **4. 代理需要用户名和密码**
```bash
wget -e use_proxy=yes -e http_proxy=http://用户名:密码@代理IP:端口 -e https_proxy=http://用户名:密码@代理IP:端口 "下载URL"
```

#### **示例**：
```bash
wget -e use_proxy=yes -e http_proxy=http://admin:123456@192.168.1.100:8080 -e https_proxy=http://admin:123456@192.168.1.100:8080 "https://example.com/file.tar.gz"
```

---

### **5. 忽略代理对某些地址生效**
如果代理会影响某些域名，可以通过 `--no-proxy` 排除：
```bash
wget -e use_proxy=yes -e http_proxy=http://代理IP:端口 --no-proxy "example.com" "https://example.com/file.tar.gz"
```

---

### **常见问题**
1. **代理连接失败**  
   - 检查代理服务器是否在线：
     ```bash
     ping 代理IP
     ```
   - 检查端口是否开放：
     ```bash
     telnet 代理IP 端口
     ```

2. **证书错误**  
   如果代理导致 HTTPS 证书错误，可临时关闭验证（不推荐）：
   ```bash
   wget --no-check-certificate -e use_proxy=yes -e http_proxy=http://代理IP:端口 "https://example.com/file.tar.gz"
   ```

---

### **总结**
| 场景               | 命令示例                                                                 |
|--------------------|--------------------------------------------------------------------------|
| **临时 HTTP 代理** | `wget -e use_proxy=yes -e http_proxy=http://代理IP:端口 "URL"`          |
| **SOCKS5 代理**    | `wget -e use_proxy=yes -e http_proxy=socks5://127.0.0.1:1080 "URL"`    |
| **代理认证**       | `wget -e use_proxy=yes -e http_proxy=http://用户:密码@代理IP:端口 "URL"` |
| **环境变量代理**   | `export http_proxy=http://代理IP:端口; wget "URL"`                     |
| **忽略证书**       | `wget --no-check-certificate -e use_proxy=yes -e http_proxy=... "URL"` |

按实际代理类型替换即可！

============================================================
# 7.find . -type f -name "*.cmake" -exec grep -Hn "GEOS" {} + 和 find . -type f -name "*.cmake" | grep -Hn "GEOS" 区别

这两条命令的**功能和输出结果有本质区别**，核心差异在于它们处理文件的方式不同：


### 1. `find . -type f -name "*.cmake" -exec grep -Hn "GEOS" {} +`
#### 作用：
- 先通过 `find` 命令找到所有 `.cmake` 文件；
- 然后对**每个找到的文件内容**执行 `grep` 搜索，查找包含 "GEOS" 的行。

#### 输出示例：
```
./FindGEOS.cmake:10:find_package(GEOS REQUIRED)
./GEOSConfig.cmake:5:set(GEOS_VERSION 3.11.2)
```
- 结果显示**文件名、行号和包含 "GEOS" 的具体内容行**（实际匹配的是文件内容）。


### 2. `find . -type f -name "*.cmake" | grep -Hn "GEOS"`
#### 作用：
- 先通过 `find` 命令找到所有 `.cmake` 文件，输出这些文件的**路径名**；
- 然后通过管道 `|` 将这些**文件路径名**传递给 `grep`，搜索路径名中包含 "GEOS" 的字符串。

#### 输出示例：
```
(标准输入):1:./FindGEOS.cmake
(标准输入):3:./build/GEOSConfig.cmake
```
- 结果显示**包含 "GEOS" 的文件路径名**（实际匹配的是文件名/路径，而非文件内容）；
- 由于 `grep` 处理的是管道输入的文本（文件路径），`-H` 会显示 `(标准输入)` 而非实际文件名，`-n` 显示的是管道输入中的行号（非文件内容行号）。


### 核心区别总结
 
 维度  | 第一条命令（`-exec grep`） | 第二条命令（管道 `| grep`） 
|---------|----------------------------|-------------------|
| 搜索对象 | **文件内容**中是否包含 "GEOS"  | **文件路径名**中是否包含 "GEOS" 
| 用途  | 查找内容涉及 "GEOS" 的 `.cmake` 文件 | 查找文件名/路径包含 "GEOS" 的 `.cmake` 文件  
| `grep` 处理的输入 |   实际文件的内容 |   `find` 输出的文件路径字符串  
| 输出中的行号 |  匹配内容在文件中的实际行号  | 路径名在 `find` 输出结果中的行号（无实际意义） |

简单说：  
- 想找**内容里有 GEOS** 的 `.cmake` 文件 → 用第一条命令；  
- 想找**文件名/路径里有 GEOS** 的 `.cmake` 文件 → 用第二条命令（但通常会简化为 `find . -name "*GEOS*.cmake"`）。

====================================
# 8.find ./ -type d -name "x64-linux-dbg" -exec rm -fr {} +
使用 `find` 的 `-exec` 选项来执行删除操作，例如：

```bash
find ./ -type d -name "x64-linux-dbg" -exec rm -fr {} +
```

### 说明：
- `-type d`：指定查找类型为目录（与你命令中的 `-d` 作用相同，但 `-type d` 是标准写法）
- `-name "x64-linux-dbg"`：匹配名称为 `x64-linux-dbg` 的目录
- `-exec rm -fr {} +`：对找到的每个目录执行 `rm -fr` 命令（`{}` 代表找到的目录，`+` 表示批量处理以提高效率）

执行此命令会递归删除当前目录下所有名为 `x64-linux-dbg` 的目录，请谨慎操作，确保不会误删重要文件。