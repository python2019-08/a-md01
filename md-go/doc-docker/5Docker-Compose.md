# 1.说说 Docker Compose。


以下通过一个 **Python 博客应用（Flask + MySQL）** 的案例，演示 Docker Compose 的完整使用流程，包含服务定义、依赖配置和一键部署。


### **一、案例背景**
- **应用架构**：  
  - Web 服务：基于 Flask 的博客后端，通过 MySQL 存储数据。  
  - 数据库：MySQL 5.7 容器，存储博客文章和用户信息。  
- **目标**：用一个 `docker-compose.yml` 文件定义两个服务，一键启动并实现数据持久化。


### **二、项目目录结构**
```
blog-app/
├── app/                  # Flask 应用代码
│   ├── app.py           # 主程序
│   └── requirements.txt # 依赖列表
├── docker-compose.yml   # Compose 配置文件
└── Dockerfile           # 构建 Flask 镜像的文件
```


### **三、关键文件内容**

#### **1. Flask 应用代码（`app/app.py`）**
```python
from flask import Flask
import pymysql
import os

app = Flask(__name__)
# 从环境变量获取数据库连接信息
DB_HOST = os.environ.get('DB_HOST', 'db')
DB_USER = os.environ.get('DB_USER', 'root')
DB_PASSWORD = os.environ.get('DB_PASSWORD', 'secret')
DB_NAME = os.environ.get('DB_NAME', 'blog')

# 连接数据库（示例：创建表并插入测试数据）
@app.route('/')
def hello():
    conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS posts (id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(100))")
    cursor.execute("INSERT INTO posts (title) VALUES (%s)", ("First Post",))
    conn.commit()
    cursor.close()
    conn.close()
    return "Blog app running! (Connected to MySQL: %s)" % DB_HOST

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
```

#### **2. 依赖列表（`app/requirements.txt`）**
```
Flask==2.3.2
pymysql==1.0.2
```

#### **3. 构建 Flask 镜像的 Dockerfile（`Dockerfile`）**
```dockerfile
FROM python:3.10-slim

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

CMD ["python", "app.py"]
```


### **四、Docker Compose 配置文件（`docker-compose.yml`）**
```yaml
version: "3.9"

services:
  # Web 服务（Flask 应用）
  web:
    build: .          # 基于当前目录的 Dockerfile 构建镜像
    ports:
      - "5000:5000"   # 主机端口 5000 映射到容器端口 5000
    environment:      # 传递环境变量给容器
      - DB_HOST=db    # 指向 MySQL 服务的名称（Docker 内部 DNS）
      - DB_USER=root
      - DB_PASSWORD=secret
      - DB_NAME=blog
    depends_on:       # 确保 db 服务先启动
      - db
    networks:         # 共享网络（默认自动创建）
      - blog_network   # 自定义网络名称，用于服务间通信

  # MySQL 数据库服务
  db:
    image: mysql:5.7    # 使用官方 MySQL 5.7 镜像
    environment:
      - MYSQL_ROOT_PASSWORD=secret  # 根用户密码
      - MYSQL_DATABASE=blog         # 初始化数据库名
    volumes:            # 数据卷持久化存储数据
      - blog_data:/var/lib/mysql    # 命名卷映射到容器内数据目录
    networks:
      - blog_network   # 与 web 服务共享网络

# 定义命名卷和网络
volumes:
  blog_data:  # 命名卷，用于持久化 MySQL 数据

networks:
  blog_network:  # 自定义网络，确保服务间通过服务名直接通信
```


### **五、操作步骤**

#### **1. 启动应用**
```bash
# 在项目根目录执行（后台运行）
docker-compose up -d
```

#### **2. 验证运行状态**
```bash
# 查看服务状态
docker-compose ps
# 输出类似：
# NAME     COMMAND                  SERVICE  STATUS   PORTS
# blog_db_1  "docker-entrypoint.s…"  db       running  3306/tcp
# blog_web_1 "python app.py"         web      running  0.0.0.0:5000->5000/tcp

# 访问应用（浏览器打开 http://localhost:5000 或命令行 curl）
curl http://localhost:5000
# 输出："Blog app running! (Connected to MySQL: db)"
```

#### **3. 停止应用**
```bash
docker-compose down  # 停止并删除容器和网络（保留数据卷）
docker-compose down --volumes  # 清除数据卷（谨慎操作！）
```


### **六、关键机制说明**
1. **服务间通信**  
   - 通过服务名（如 `db`）直接访问 MySQL 容器，Docker 自动为服务分配内部 DNS 解析。

2. **数据持久化**  
   - `blog_data` 命名卷独立于容器存在，即使删除 `db` 容器，数据仍保留，重启后自动挂载。

3. **依赖管理**  
   - `depends_on: db` 确保 `web` 服务在 `db` 启动后才运行，但不等待数据库完全就绪（如需等待，可添加自定义脚本）。


### **七、扩展场景**
- **添加 Redis 缓存**：在 `services` 中新增 `redis` 服务，配置端口和网络，`web` 服务通过服务名 `redis` 访问。  
- **配置日志和监控**：在 `web` 服务中添加 `logging` 配置，或用 `volumes` 挂载日志文件到主机。  

通过这个案例，可清晰看到 Docker Compose 如何简化多容器应用的部署，实现环境快速复现和协同开发。

============================================================
# 2. 在实际使用中，如何排查Docker Compose的问题？

在实际使用中，可以从以下几个方面排查 Docker Compose 的问题：

### 查看日志
- **容器日志**：使用`docker-compose logs [服务名称]`命令查看指定服务容器的日志输出。例如，`docker-compose logs web`可以查看名为`web`的服务容器的日志，从中可以获取应用程序的运行时错误、启动过程中的异常信息等。
- **Compose 日志**：如果在执行`docker-compose`命令时遇到问题，可以通过查看`docker-compose`本身的日志来获取更多信息。一些系统可能会将`docker-compose`的日志记录在系统日志文件中，具体位置可能因系统而异，如`/var/log/syslog`或`/var/log/messages`。

### 检查配置文件
- **语法检查**：使用`docker-compose config`命令来验证`docker-compose.yml`文件的语法是否正确。该命令会解析配置文件，并检查是否存在语法错误。如果有错误，会输出相应的错误信息，提示你修改配置文件。
- **配置项检查**：仔细检查`docker-compose.yml`文件中的各项配置，包括服务定义、网络配置、卷挂载等。确保配置项的名称、格式和值都符合 Docker Compose 的要求。例如，检查端口映射是否正确，环境变量是否设置正确，以及依赖关系是否定义合理等。

### 查看容器状态
- **使用 docker-compose ps**：执行`docker-compose ps`命令可以查看当前由 Docker Compose 管理的容器的状态。查看容器的状态列，确认容器是否正在运行（`Up`）、已停止（`Exited`）或存在错误（`Error`）等。如果容器状态为`Exited`，可以结合日志进一步查看容器退出的原因。
- **使用 docker inspect**：对于特定的容器，可以使用`docker inspect [容器名称或ID]`命令获取更详细的容器信息，包括容器的配置、网络设置、挂载的卷等。这有助于检查容器的实际配置是否与`docker-compose.yml`文件中的定义一致，以及是否存在其他可能影响容器运行的因素。

### 网络问题排查
- **检查网络配置**：确认`docker-compose.yml`文件中的网络配置是否正确。检查服务是否正确连接到指定的网络，以及网络的驱动类型、子网设置等是否符合需求。可以使用`docker network inspect [网络名称]`命令来查看网络的详细信息，验证网络配置是否正确。
- **容器间通信测试**：如果容器之间需要进行通信，例如一个服务需要连接到另一个服务的端口，可以在容器内部使用工具进行网络连接测试。例如，在容器中使用`ping`命令测试与其他容器的网络连通性，或者使用`telnet`命令尝试连接到其他容器的指定端口，以确定是否存在网络连接问题。

### 资源限制和性能问题排查
- **查看资源使用情况**：使用`docker stats`命令可以查看容器的资源使用情况，包括 CPU、内存、磁盘 I/O 和网络带宽等。如果发现某个容器占用了过多的资源，可能会影响其他容器的运行，需要进一步分析原因，可能是应用程序本身的问题，也可能是资源限制配置不合理。
- **调整资源限制**：根据应用程序的实际需求，合理调整容器的资源限制。在`docker-compose.yml`文件中，可以使用`deploy.resources.limits`和`deploy.resources.reservations`等配置项来设置容器的 CPU 和内存限制。例如，如果发现某个服务经常因为内存不足而崩溃，可以适当增加其内存限制。

### 依赖关系和启动顺序问题
- **确认依赖关系**：检查`docker-compose.yml`文件中的`depends_on`配置项，确保服务之间的依赖关系正确定义。依赖关系决定了服务的启动顺序，确保依赖的服务先启动，被依赖的服务后启动。但需要注意的是，`depends_on`只能保证服务的启动顺序，不能确保服务在启动时已经完全就绪。
- **手动启动服务**：如果怀疑启动顺序存在问题，可以尝试手动逐个启动服务，观察每个服务的启动情况和依赖关系是否正常。通过这种方式，可以更精确地控制服务的启动过程，以便发现和解决潜在的问题。

### 镜像构建和拉取问题
- **镜像构建日志**：如果在`docker-compose.yml`文件中使用了`build`选项来构建镜像，查看镜像构建过程中的日志以获取错误信息。可以使用`docker-compose build --no-cache [服务名称]`命令重新构建镜像，并查看输出的日志，了解构建过程中是否出现错误，如安装依赖失败、文件复制错误等。
- **镜像拉取问题**：如果使用了外部镜像，确保镜像名称、标签正确，并且能够从指定的镜像仓库中拉取到镜像。检查网络连接是否正常，以及是否有足够的权限访问镜像仓库。如果镜像拉取失败，可以尝试手动使用`docker pull [镜像名称]`命令拉取镜像，查看具体的错误信息。