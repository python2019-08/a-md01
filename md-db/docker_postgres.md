# <<docker postgres>> 
<---------------->

若你想使用 Docker 来运行 PostgreSQL 数据库，下面为你详细介绍基本步骤：

# 1. 拉取 PostgreSQL 镜像
你能通过 `docker pull` 命令从 Docker Hub 拉取 PostgreSQL 镜像。若未指定版本，默认会拉取最新版本。
```bash
docker pull postgres
```
若你需要特定版本，可在镜像名后添加版本标签，例如：
```bash
docker pull postgres:14
```

<---------------------------------------->
------------------------------------------
#  2. 运行 PostgreSQL 容器
使用 `docker run` 命令来启动一个新的 PostgreSQL 容器。你需要设置一些环境变量，像数据库的密码、数据库名等。
```bash
docker run --name my-postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres
```
在上述命令里：
- `--name my-postgres`：给容器设定名字为 `my-postgres`。
- `-e POSTGRES_PASSWORD=123456`：设置 PostgreSQL 的超级用户（`postgres`）的密码为 `123456`。
- `-p 5432:5432`：将容器内部的 5432 端口映射到宿主机的 5432 端口。
- `-d`：让容器在后台运行。

<---------------------------------------->
------------------------------------------
# 3. docker容器内 连接到 PostgreSQL 数据库
你可以使用 `psql` 命令行工具连接到运行在容器内的 PostgreSQL 数据库。
```bash
docker exec -it my-postgres psql -U postgres
```
在这个命令中：
- `docker exec -it my-postgres`：在名为 `my-postgres` 的容器里执行交互式命令。
- `psql -U postgres`：以 `postgres` 用户身份连接到 PostgreSQL 数据库。

<---------------------------------------->
------------------------------------------
# 4 ubuntu上，docker容器外 连接到docker容器里的 PostgreSQL 数据库
在 Ubuntu 系统里，要从 Docker 容器外部连接到容器内的 PostgreSQL 数据库，可按以下步骤操作：

## 4.1. 运行 PostgreSQL 容器
确保你已运行了包含 PostgreSQL 的 Docker 容器，并且正确映射了端口。以下是一个示例命令：
```bash
   docker run --name postgres-container -e POSTGRES_PASSWORD=yourpassword -p 5432:5432 -d postgres
## docker run --name my-postgres        -e POSTGRES_PASSWORD=123456       -p 5432:5432 -d postgres
```
在上述命令中：
- `--name postgres-container`：给容器指定名字为 `postgres-container`。
- `-e POSTGRES_PASSWORD=yourpassword`：设置 PostgreSQL 的超级用户（`postgres`）的密码为 `yourpassword`。
- `-p 5432:5432`：把容器内部的 5432 端口映射到宿主机的 5432 端口。
- `-d`：让容器在后台运行。

## 4.2. 安装 PostgreSQL 客户端
在 Ubuntu 上安装 `postgresql-client` 包，它包含了用于连接 PostgreSQL 数据库的 `psql` 工具。
```bash
sudo apt update
sudo apt install postgresql-client
```

## 4.3. 连接到容器内的 PostgreSQL 数据库
使用 `psql` 工具连接到容器内的 PostgreSQL 数据库。在连接时，要指定正确的主机、端口、用户名和密码。
```bash
psql -h localhost -p 5432 -U postgres -d postgres
```
在上述命令中：
- `-h localhost`：指定数据库所在的主机为本地主机。
- `-p 5432`：指定数据库的端口为 5432。
- `-U postgres`：指定连接数据库的用户名为 `postgres`。
- `-d postgres`：指定要连接的数据库名为 `postgres`。

当你运行此命令后，系统会提示你输入密码，输入之前设置的密码（`yourpassword`）即可完成连接。

## 4.5完整示例脚本
以下是一个完整的示例脚本，将上述步骤整合在一起：
```bash
#!/bin/bash

# 运行 PostgreSQL 容器
docker run --name postgres-container -e POSTGRES_PASSWORD=yourpassword -p 5432:5432 -d postgres

# 等待数据库启动
sleep 10

# 安装 PostgreSQL 客户端
sudo apt update
sudo apt install -y postgresql-client

# 连接到容器内的 PostgreSQL 数据库
psql -h localhost -p 5432 -U postgres -d postgres
```

你可以将上述脚本保存为一个 `.sh` 文件，例如 `connect_postgres.sh`，然后给它添加执行权限并运行：
```bash
chmod +x connect_postgres.sh
./connect_postgres.sh
```

通过以上步骤，你就能在 Ubuntu 系统的 Docker 容器外部成功连接到容器内的 PostgreSQL 数据库。 

<---------------------------------------->
------------------------------------------

# 5. 升级 psql 到17.4
若你想在 Ubuntu 系统中将 `psql` 客户端升级到 17.4 版本，可按以下步骤操作：

## 5.1. 添加 PostgreSQL 官方 APT 仓库
要获取最新版本的 PostgreSQL 客户端，需添加 PostgreSQL 官方 APT 仓库。

```bash
# 添加 PostgreSQL 官方仓库的公钥
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# 添加 PostgreSQL 官方 APT 仓库
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

## 5.2. 更新系统的包列表
添加仓库之后，更新系统的包列表，让系统能够识别新仓库中的软件包。

```bash
sudo apt update
```

## 5.3. 安装 PostgreSQL 17.4 客户端
执行下面的命令来安装 PostgreSQL 17.4 客户端：

```bash
sudo apt install postgresql-client-17
```

## 5.4. 验证安装
安装完成后，你可以使用下面的命令来验证 `psql` 客户端是否已成功升级到 17.4 版本：

```bash
psql --version
```

## 5.5.完整脚本示例
以下是将上述步骤整合在一起的完整脚本：

```bash
#!/bin/bash

# 添加 PostgreSQL 官方仓库的公钥
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# 添加 PostgreSQL 官方 APT 仓库
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# 更新系统的包列表
sudo apt update

# 安装 PostgreSQL 17.4 客户端
sudo apt install postgresql-client-17

# 验证安装
psql --version
```

你可以将上述脚本保存为一个 `.sh` 文件，例如 `upgrade_psql.sh`，然后赋予其执行权限并运行：

```bash
chmod +x upgrade_psql.sh
./upgrade_psql.sh
```

按照以上步骤操作，你就能在 Ubuntu 系统上将 `psql` 客户端升级到 17.4 版本。 

<---------------------------------------->
------------------------------------------
#  5. 停止和移除容器
当你不需要这个容器时，可以使用以下命令停止并移除它：
```bash
# 停止容器
docker stop my-postgres

# 移除容器
docker rm my-postgres
```

下面是一个完整的示例脚本，将上述步骤整合在一起：

```bash
#!/bin/bash

# 拉取 PostgreSQL 镜像
docker pull postgres

# 运行 PostgreSQL 容器
docker run --name my-postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres

# 等待数据库启动
sleep 10

# 连接到 PostgreSQL 数据库
docker exec -it my-postgres psql -U postgres

# 停止和移除容器
docker stop my-postgres
docker rm my-postgres
```

你可以将上述脚本保存为一个 `.sh` 文件，例如 `postgres_docker.sh`，然后给它添加执行权限并运行：
```bash
chmod +x postgres_docker.sh
./postgres_docker.sh
```

通过这些步骤，你就能使用 Docker 快速搭建一个 PostgreSQL 数据库环境。 


<----------------------------------------------------------->
<----------------------------------------------------------->
# 6.docker postgis

`PostGIS` 是一个为 `PostgreSQL` 数据库增加空间数据类型、空间索引和空间函数的扩展。使用 Docker 部署 `PostGIS` 可以简化安装和配置过程，以下为你详细介绍使用 Docker 部署 `PostGIS` 的步骤：

### 1. 拉取 PostGIS 镜像
在 Docker Hub 上有许多可用的 `PostGIS` 镜像，其中 `postgis/postgis` 是比较常用的官方镜像。你可以使用以下命令拉取指定版本的镜像，例如 `15-3.3` 版本：
```bash
docker pull postgis/postgis:15-3.3
```
这里的 `15` 代表 `PostgreSQL` 的版本，`3.3` 代表 `PostGIS` 的版本，你可以根据自身需求选择合适的版本。

### 2. 创建并运行 PostGIS 容器
使用以下命令创建并启动一个 `PostGIS` 容器：
```bash
docker run --name postgis-container -e POSTGRES_PASSWORD=your_password -p 5432:5432 -d postgis/postgis:15-3.3
```
参数解释如下：
- `--name postgis-container`：为容器指定一个名称，这里是 `postgis-container`。
- `-e POSTGRES_PASSWORD=your_password`：设置 `PostgreSQL` 的超级用户 `postgres` 的密码，你需要将 `your_password` 替换为你自己设定的密码。
- `-p 5432:5432`：将容器内部的 `5432` 端口映射到宿主机的 `5432` 端口，这样你就可以从宿主机访问容器内的 `PostgreSQL` 数据库。
- `-d`：让容器在后台运行。

### 3. 连接到 PostGIS 数据库
你可以使用各种数据库客户端工具连接到运行在 Docker 容器中的 `PostGIS` 数据库，例如 `psql`。在宿主机上使用以下命令连接：
```bash
psql -h localhost -p 5432 -U postgres -d postgres
```
输入之前设置的密码，若连接成功，你就可以在 `psql` 命令行中执行 SQL 语句来管理数据库。

### 4. 验证 PostGIS 扩展
连接到数据库后，你可以通过以下 SQL 语句验证 `PostGIS` 扩展是否已正确安装：
```sql
SELECT postgis_version();
```
如果输出 `PostGIS` 的版本信息，则说明 `PostGIS` 扩展已经成功安装并可以正常使用。

### 完整示例代码
以下是一个完整的示例脚本，包含拉取镜像、创建并运行容器以及验证 `PostGIS` 扩展的步骤：
```sh
# 拉取 PostGIS 镜像
docker pull postgis/postgis:15-3.3

# 创建并运行 PostGIS 容器
docker run --name postgis-container -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgis/postgis:15-3.3

# 等待容器启动
sleep 10

# 连接到数据库并验证 PostGIS 扩展
docker exec -it postgis-container psql -U postgres -d postgres -c "SELECT postgis_version();"    
```
    


将上述脚本保存为 `docker-postgis.sh`，然后赋予执行权限并运行：
```bash
chmod +x docker-postgis.sh
./docker-postgis.sh
```

通过以上步骤，你就可以使用 Docker 快速部署和使用 `PostGIS` 数据库。