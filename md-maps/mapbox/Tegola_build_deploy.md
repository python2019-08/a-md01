# 1.Tegola 如何编译和部署
<!-- tx-yuanbaoAI -->
下面按**“源码编译 → 配置 → 部署 → 验证”**四步给一套能直接照做的 Tegola 流程，覆盖 PostGIS 和 GPKG 两种数据源，并标出 CGO 这个最容易翻车的点。当前 Tegola 主线要求 **Go ≥ 1.22**。

---

## 一、源码编译（CGO 是分水岭）

### 1. 环境准备
```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y golang-go build-base ca-certificates
go version   # 确认 >= 1.22

# 或者用官方 golang 镜像里的 Go，别用系统老版本
```

### 2. 克隆 + 编译
```bash
git clone https://github.com/go-spatial/tegola.git
cd tegola
go generate ./...
cd cmd/tegola
go build -o tegola .
```
当前目录出 `./tegola` 二进制。

### 3. CGO 与 GPKG 的关键关系（重点）
- Tegola 的 **gpkg provider 依赖 mattn/go-sqlite3，必须 CGO_ENABLED=1**
- 设 `CGO_ENABLED=0` 编译 → **gpkg provider 自动被排除**，只留 PostGIS
- Alpine 镜像编译必须装 `build-base`（gcc+musl-dev），否则 CGO 链断掉

纯 PostGIS 版（可去 CGO，但没必要）：
```bash
CGO_ENABLED=0 go build -tags 'noGpkgProvider' -o tegola .
```

带版本信息（公司交付建议）：
```bash
BUILD_PKG=github.com/go-spatial/tegola/internal/build
go build -ldflags "-w -X ${BUILD_PKG}.Version=$(git describe --tags) \
  -X ${BUILD_PKG}.GitRevision=$(git rev-parse --short HEAD) \
  -X ${BUILD_PKG}.GitBranch=$(git branch --show-current)" -o tegola .
```

### 4. Docker 编译（推荐交付方式）
官方 Dockerfile 思路（Alpine 两阶段）：
```dockerfile
FROM golang:1.22-alpine AS build
RUN apk add build-base
WORKDIR /go/src/github.com/go-spatial/tegola
COPY . .
RUN cd cmd/tegola && go build -o /opt/tegola .

FROM alpine:3.20
RUN apk add ca-certificates
COPY --from=build /opt/tegola /usr/local/bin/tegola
ENTRYPOINT ["tegola"]
```
构建：
```bash
docker build -t my-tegola .
```

---

## 二、配置文件（config.toml）

### PostGIS 数据源示例
```toml
[webserver]
port = ":8080"

[cache]
type = "file"
basepath = "/tmp/tegola"

[[providers]]
name = "pg"
type = "postgis"
host = "127.0.0.1"
port = 5432
database = "gis"
user = "tegola"
password = "tegola_pass"
srid = 3857
max_connections = 20

  [[providers.layers]]
  name = "roads"
  geometry_fieldname = "geom"
  id_fieldname = "gid"
  sql = "SELECT gid, ST_AsBinary(geom) AS geom, name, highway FROM roads WHERE geom && !BBOX!"

[[maps]]
name = "demo"
center = [116.397, 39.908, 10]

  [[maps.layers]]
  name = "roads"
  provider_layer = "pg:roads"
  min_zoom = 5
  max_zoom = 16
```
> `!BBOX!` 是 Tegola 必填令牌，否则全表扫。

### GPKG 数据源示例（必须 CGO 编译的二进制）
```toml
[[providers]]
name = "gpkg"
type = "gpkg"
filepath = "/opt/tegola_config/data.gpkg"

  [[providers.layers]]
  name = "buildings"
  geometry_fieldname = "geom"
  id_fieldname = "fid"
  sql = "SELECT fid, geom, name FROM buildings WHERE geom && !BBOX!"

[[maps]]
name = "gp"
center = [116.397, 39.908, 10]
  [[maps.layers]]
  name = "buildings"
  provider_layer = "gpkg:buildings"
  min_zoom = 10
  max_zoom = 18
```
GPKG 文件挂进容器时路径要对应：`/opt/tegola_config/data.gpkg`。

---

## 三、部署

### 方式 A：二进制直接跑
```bash
./tegola serve --config ./config.toml
```

### 方式 B：Docker 跑（本地 config + 可选 gpkg）
```bash
mkdir -p docker-config && cp config.toml docker-config/
# 如果用 gpkg，把 .gpkg 也放 docker-config/，并改 filepath 为 /opt/tegola_config/xxx.gpkg
docker run -d --name tegola -p 8080:8080 \
  -v $PWD/docker-config:/opt/tegola_config \
  my-tegola serve --config /opt/tegola_config/config.toml
```

### 方式 C：docker-compose（PostGIS + Tegola）
```yaml
version: '3.8'
services:
  postgis:
    image: postgis/postgis:16-3.4
    environment:
      POSTGRES_USER: tegola
      POSTGRES_PASSWORD: tegola_pass
      POSTGRES_DB: gis
    volumes:
      - pgdata:/var/lib/postgresql/data
  tegola:
    image: my-tegola
    depends_on:
      - postgis
    ports:
      - "8080:8080"
    volumes:
      - ./config.toml:/opt/tegola_config/config.toml
    command: ["serve", "--config", "/opt/tegola_config/config.toml"]
volumes:
  pgdata:
```
> 注意 config.toml 里 PostGIS host 写 `postgis` 不是 `127.0.0.1`。

---

## 四、验证（从进程到瓦片逐层测）

### 1. 进程与配置加载
启动后看日志应有：
```
starting server on :8080
registered map 'demo'
```
若报 `provider type "gpkg" not registered` → 你用的是 `CGO_ENABLED=0` 编的，换 CGO 版。

### 2. 内置 Viewer（最快速）
浏览器开 `http://localhost:8080/` → Tegola 自带 viewer 自动出 style.json 和图层列表。

### 3. Capabilities / TileJSON
```bash
curl http://localhost:8080/capabilities
curl http://localhost:8080/capabilities/demo
curl http://localhost:8080/capabilities/demo/style.json
```

### 4. 抽一块瓦片（z/x/y 按 Web Mercator）
```bash
curl -H "Accept: application/x-protobuf" \
  http://localhost:8080/maps/demo/10/524/393.pbf \
  -o tile.pbf
```
验证是不是合法 MVT：
```bash
python3 -c "import sys;d=open('tile.pbf','rb').read();print('len',len(d),'gzip?' , d[:2]==b'\x1f\x8b')"
```
或 `ogrinfo -ro tile.pbf`（GDAL 3.3+ 能识 MVT）。

### 5. Debug 瓦片（确认边界/坐标对不对）
```bash
curl "http://localhost:8080/maps/demo/10/524/393.pbf?debug=true" -o dbg.pbf
```
debug 层会画 tile 边框和 Z/X/Y 文本，前端 MapLibre 里加载一眼能看出错位没。

### 6. 缓存验证
配了 `[cache] type="file"` 后，请求一次再查：
```bash
ls /tmp/tegola/demo/10/524/393*
```
有文件 = 缓存生效；下次同请求不查 PG。

---

## 五、公司交付记住这 4 条
1. **GPKG 场景必须用 CGO 二进制**，Alpine 镜像忘装 `build-base` 是最常见的编译失败原因。
2. **PostGIS SQL 里 `!BBOX!` 不能省**，省了就是全表扫，低配机直接打满。
3. **生产前面一定挡 nginx proxy_cache**，Tegola 自身 LRU 不是为抗公网设计的。
4. **版本锁死**：`go.mod` 里 Tegola 用 `v0.21.x` 左右，别 `go get -u` 漂到 master，配置字段偶尔会变。

如果你愿意，下一步我可以给你一份 **“Tegola + nginx proxy_cache + 多实例无 Redis 最简生产 compose”**，把 `proxy_cache_key` 和瓦片 gzip 透传那几行直接写好，避免你后面在 `Content-Encoding` 上踩一遍坑。



========================================

# 2.请讲解命令 go build -mod vendor

 go build -mod vendor 是 Go 语言中 **用于锁定依赖版本、实现离线编译** 的核心命令。
在 Go 的 Modules（go.mod）时代，它的核心作用是：强迫 Go 编译器在编译时，只读取项目根目录下的 vendor 文件夹中的依赖源码，而不是去互联网下载，也完全忽略本地的全局缓存（$GOPATH/pkg/mod）。
以下是关于该命令的完整技术细节和应用场景：

## 核心工作原理
当你执行 go build -mod vendor 时，编译器的行为会发生以下根本性转变：

[ 默认 go build ] ──> 检查 go.mod ──> 读取本地缓存 ──> (缺少则) 从网络下载 ──> 编译
[ -mod vendor ]   ──> 检查 go.mod ──> 直接读取项目内 vendor/ 目录 ────────────> 编译


   1. 版本一致性检查：编译器会首先比对项目根目录下的 go.mod 文件和 vendor/modules.txt（记录了 vendor 文件夹中现有的依赖版本和条目）。
   2. 严格报错：如果发现 go.mod 中新增或修改了依赖，而 vendor 目录里没有同步更新，编译会立刻中断并报错（提示类似 import ... is not in vendor），绝不会擅自去网上拉取新包。

------------------------------
## 为什么要使用 vendor 模式？## 1. 100% 离线与密闭编译 (Air-Gapped Builds)
在很多企业内网、涉密机房或特殊的 CI/CD 构建流水线中，服务器是无法访问外网的。将所有第三方依赖直接打包进项目的 vendor 目录并提交到 Git 仓库，可以确保只要有 Go 编译器，没有任何网络也能随时随地编译成功。
## 2. 防止依赖“凭空消失” (Vendor Lock-in)
如果开源项目的作者在 GitHub 上删除了仓库，或者修改了历史 Tag，直接依赖网络的项目在重新构建时就会彻底崩溃。而 vendor 文件夹将源码直接物理保存在你的项目里，项目生存不再受制于外部开源世界。
## 3. 极速构建 (Zero-Download CI/CD)
在持续集成（CI/CD）阶段，每次构建都不需要经历 go mod download 的网络握手和下载过程，省去了数秒到数分钟的网络 IO 时间。
------------------------------
## 标准的使用工作流
通常，-mod vendor 不能孤立使用，它需要配合以下完整的生命周期命令：

# 1. 正常开发、引入新包后，将当前所有的依赖物理下载并同步到本地的 vendor 目录
go mod vendor
# 2. 将项目（包含生成的 vendor/ 目录）一起提交到代码仓库
git add go.mod go.sum vendor/
git commit -m "chore: update dependencies and vendor"
# 3. 在 CI/CD 服务器或生产环境，使用锁定模式安全编译
go build -mod vendor -o my_app .

------------------------------
## 💡 补充：Go 的自动识别机制
从 Go 1.14 开始，如果 Go 编译器检测到项目的根目录下已经存在 vendor 目录，并且 go.mod 中声明的 Go 版本大于等于 1.14，那么当你直接敲 go build 时，系统会默认自动隐式启用 -mod=vendor 行为。
你在编译 Tegola 时显式加上 -mod vendor，是一种更严谨、更安全的工程实践，能 100% 确保构建行为符合预期。
接下来你是想将 Tegola 部署到无法联网的服务器上，还是在配置其本地数据源？我们可以继续聊聊。






