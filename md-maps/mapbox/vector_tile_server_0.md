# 0. 瓦片服务选用结论
矢量瓦片服务 选用 martin 和 tegola,
光栅瓦片服务 选用 martin 和 mbtileserver 

 
# 1.矢量瓦片服务
## 1.1googleAI
<!-- https://github.com/mapbox/awesome-vector-tiles 中的服务器列表 -->

在你提供的列表中，基于 Rust 和 Go (Golang) 开发的地图瓦片服务器共有以下几款：
### 🦀 基于 Rust 开发的 Server

* martin：一个极其快速且轻量级的 PostGIS、MBtiles 和 PMtiles 瓦片服务器，支持瓦片复制、差异对比和更新。
* t-rex：一款独立的 MVT（矢量瓦片）服务器，采用单可执行文件设计，支持从 PostGIS 中读取数据并支持自定义瓦片网格。
* MVT Server：一个用于从 PostGIS 发布地图资源的平台型服务。

### 🐹 基于 Go (Golang) 开发的 Server

* mbtileserver：一个简单的服务器，专门用于发布和托管存储在 .mbtiles 格式文件中的地图瓦片。只读 MBTiles，不碰 PostGIS。
* Tegola：一款经典的矢量瓦片服务器，支持提供 Mapbox 矢量瓦片（MVT），数据源支持 PostGIS 和 GeoPackage。 Go 侧自己做 simplify/clip，内置 file/S3/Redis 缓存，功能最全但 RSS 比 Rust 系高。
* pg_tileserv：一个非常轻量且专为 PostGIS 设计的瓦片服务器，它接收 HTTP 瓦片请求后直接在数据库执行 SQL 并返回 MVT 瓦片。极薄代理，无缓存，现在维护基本停滞。
* go-vtile-example：一个用 Go 语言编写的矢量瓦片服务器示例/原型项目。只是示例项目，不是生产件。

---- 
如果你想了解这些服务器的性能差异、适用场景（如：选 PostGIS 直流还是选 MBTiles 静态文件），或者需要具体的部署配置示例，请告诉我！

## 1.2 tx-yuanbao-AI

从你贴的那份列表里，按 **Rust** 和 **Go** 两种语言把“正经瓦片 server”挑出来，并标清楚各自定位：

### 🦀 Rust 系
- **martin** — Blazing fast and lightweight PostGIS, MBtiles and PMtiles tile server written in Rust. 动态 PostGIS（ST_AsMVT）+ 静态 PMTiles/MBTiles + 多源合并，MapLibre 官方亲儿子，生产首选。
- **t-rex** — MVT server in a single executable written in Rust. Serves tiles from PostGIS supporting custom tile grids. 偏 GDAL/PostGIS 自管数据，带本地 cache 目录，可离线烤瓦片。
- **MVT Server** — One platform for publishing cartographic resources from PostGIS (developed in Rust).（列表里较新条目，社区曝光少于 martin/t-rex）

> 备注 列表里 **ClusterBuster** 描述没写语言，但它是 MVT+clustering 的 server，不属于上面三者；**Hastile** 是 Haskell，**LOD** 没标语言，**BBOX** 是 JVM（Sourcepole 出品）。

### 🐹 Go 系
-  pg_tileserv \ Tegola \mbtileserver \go-vtile-example 

### 一句话回收你上一轮的结论
- **Rust 两条主力：martin（动态+静态通吃，最省内存）、t-rex（PostGIS/GDAL 自管切片）**
- **Go 三条：martin 的对照 pg_tileserv（太薄停更）、Tegola（要 Redis/S3 缓存就它）、mbtileserver（纯 MBTiles 托管）**
- 所以“pg_tileserv 没缓存 → 优先 Tegola/Martin”这个判断成立，但更精确是：  
  **要 Rust 极速动态选 martin；要 Go 系内置 Redis 缓存选 Tegola；pg_tileserv 只剩“最小可跑 demo”价值。**

如果你在 martin vs t-rex 之间还犹豫，我可以按“是否要 PMTiles 混合源 / 是否要自定义 tile grid / 是否纯 PostGIS”再给你一刀切的分法。

=====================================================
# 2.这些服务器的性能差异、适用场景
<!-- googleAI -->
这些基于 Rust 和 Go 的地图瓦片服务器在架构设计上主要分为两大阵营：数据库动态切片（PostGIS 直流） 和 静态文件托管（MBTiles/PMTiles）。
两者的性能差异与适用场景的核心逻辑可以总结为：Rust 追求极致的单核吞吐量与低内存占用；Go 追求极佳的并发处理能力与生态扩展性。
------------------------------
## 🚀 性能差异对比

| 服务器名称 | 开发语言 | 核心驱动模式 | 性能特征与瓶颈 |
|---|---|---|---|
| martin | 🦀 Rust | 混合型（PostGIS + 静态文件） | 性能天花板。无垃圾回收（GC）停顿，内存占用极低。在直接读取 .mbtiles 或 .pmtiles 时速度极快。若连接 PostGIS，瓶颈仅在数据库的 ST_AsMVT 执行效率。 |
| t-rex | 🦀 Rust | 数据库型（PostGIS） | 早期经典 Rust 项目。并发性能优秀，但在功能特性和对新格式（如 PMTiles）的支持上，目前稍逊于后起之秀 martin。 |
| MVT Server | 🦀 Rust | 数据库型（PostGIS） | 针对特定复杂地图资源发布进行了优化，单机吞吐量高。 |
| pg_tileserv | 🐹 Go | 数据库型（纯 PostGIS） | 极轻量。它不负责任何瓦片生成逻辑，只是数据库的“搬运工”（把 HTTP 请求翻译成 SQL）。性能几乎 100% 取决于你的 PostGIS 数据库性能和索引优化。 |
| Tegola | 🐹 Go | 数据库型（PostGIS/GeoPackage） | 带有内置的高效内存/文件/S3 缓存机制。未命中缓存时，由于在 Go 语言层面对几何数据做了解析和裁剪，CPU 消耗高于 pg_tileserv，但缓存命中后并发极强。 |
| mbtileserver | 🐹 Go | 文件型（纯 MBTiles） | 利用 golang/groupcache 机制。面对高并发、大流量的静态瓦片请求时，Go 的并发调度（Goroutine）和缓存优化能轻松跑满带宽，性能非常稳定。 |

martin/Tegola/mbtileserver 

------------------------------
## 🎯 适用场景与选型指南## 场景一：数据每天/每小时都在变（如：实时车辆轨迹、外卖配送范围、动态业务热力图）

* 推荐选择：pg_tileserv 或 martin
* 选型理由：
* pg_tileserv：如果你的团队熟悉 SQL，它是绝对的首选。你只需要在 PostGIS 中写一个存储过程（Function），前端传入参数，它就能实时切片返回。部署极其简单，一行命令即可。
   * martin：如果你不仅需要连接 PostGIS，还希望带有高级特性（如瓦片动态合并、函数图层），martin 的动态 SQL 映射能力在 Rust 的加持下能提供更高的吞吐量。

## 场景二：全国/全球级别的海量基础底图（如：OSM 离线地图、卫星影像图、等高线图）

* 推荐选择：martin 或 mbtileserver
* 选型理由：
* 这类数据通常是预先切好并打包成 .mbtiles 或 .pmtiles 文件的（少则几十 GB，多则几个 TB）。
   * martin：支持下一代格式 PMTiles。PMTiles 支持直接托管在对象存储（如 AWS S3/阿里云 OSS）上，martin 可以作为一个超轻量的代理层，不需要本地硬盘存放大文件，省钱且扩容极方便。
   * mbtileserver：如果你的文件就是传统的 .mbtiles 格式，且需要部署在多台服务器上做负载均衡，mbtileserver 极其稳定，内置的缓存机制非常适合抗公网的高并发大流量。

## 场景三：企业级 GIS 资产管理与多数据源混合（如：既有 PostGIS 矢量，又有 GeoPackage 离线包）

* 推荐选择：Tegola
* 选型理由：
* Tegola 是目前 Go 生态里功能最完备的独立矢量瓦片服务器。它支持配置复杂的图层样式、多数据源组合，并且拥有成熟的 三方缓存分发机制（可以直接把切好的瓦片自动同步到 AWS S3）。适合作为企业内部的长久基础 GIS 服务架构。

------------------------------
## 💡 总结选型建议

   1. 追求“简单、快速、连接 PostGIS” 👉 选 pg_tileserv（Go 语言，开箱即用，SQL 即图层）。
   2. 追求“极致性能、支持现代化格式（PMTiles）、省内存” 👉 选 martin（Rust 语言，全能效率王）。
   3. 已经有大批现成的 .mbtiles 文件，只想安稳发布 👉 选 mbtileserver（Go 语言，高并发缓存极稳）。

你想好你的地图数据打算存放在数据库中，还是打包成本地文件了吗？我们可以针对具体的存储方式来聊聊具体的配置和部署方法。


===============================================
# 3.综合看来,最终可以选的服务端程序, 是martin/Tegola/mbtileserver ?

<!-- googleAI -->

是的，如果你的目标是锁定在 Rust 或 Go 语言开发、现代化、高并发且轻量级 的地图瓦片服务器，那么最终的候选名单就是这三款：martin、Tegola 和 mbtileserver。
为了让你在做最终的技术选型决策时思路最清晰，我们可以根据它们各自的核心底座（数据源）和独门绝技，进行一次极简的“对号入座”：
## 🏁 最终选型三剑客## 1. 👑 现代全能效率王：martin (Rust)

* 核心底座：PostGIS 数据库 + .mbtiles 文件 + .pmtiles 文件（全能支持）。
* 独门绝技：
* 唯一原生支持 .pmtiles 的服务器，能够完美承接云原生生态。
   * 性能极其恐怖，内存占用极低，支持动态 SQL 函数图层、瓦片动态合并（Fonts/Sprite 也能发布）。
* 适用场景：技术栈追求前瞻性，数据源“动静结合”（大底图用 .pmtiles，业务数据用 PostGIS），或者对单机吞吐量有极致要求的项目。

## 2. 🛡️ 企业级稳健派：Tegola (Go)

* 核心底座：PostGIS 数据库 + GeoPackage (.gpkg) 文件。
* 独门绝技：
* 极其强大的三方缓存（Cache）策略。它内置了成熟的机制，如果瓦片没命中就去 PostGIS 实时切，切完自动同步到 AWS S3、Redis 或本地文件，下次直接走缓存。
   * 图层和几何体裁剪（Simplification）的配置项在企业级大地图分发中非常精细和成熟。
* 适用场景：核心数据全部存储在 PostGIS 中，需要复杂的图层配置，并且需要通过多级缓存（如 S3/Redis）来抗公网千万级并发的企业私有化项目。

## 3. 📦 纯粹的静态托管：mbtileserver (Go)

* 核心底座：纯 .mbtiles 文件。
* 独门绝技：
* 极其专一，开箱即用。你不需要懂任何数据库配置，只要把 .mbtiles 文件丢进目录它就自动发布。
   * 内置地图在线预览功能，且原生兼容 ArcGIS Tile Map Service 接口，方便对接 Esri 生态。
* 适用场景：项目不涉及 PostGIS 动态计算，手里只有一堆现成切好的传统 .mbtiles 离线包，只想用最快、最稳的方式把它变成标准的 HTTP XYZ 接口。

------ 
## 💡 决策黄金法则（三选一）

* 想全面拥抱现代化技术、支持 .pmtiles 且要性能天花板 👉 选 martin。
* 核心在 PostGIS 数据库，需要极强的缓存管理和企业级图层配置 👉 选 Tegola。
* 手头只有 .mbtiles 文件，不想折腾任何复杂配置，只想快速发布 👉 选 mbtileserver。

你目前更倾向于选用哪一种数据存储方式（PostGIS 数据库、.mbtiles 还是 .pmtiles）作为起步呢？我可以为你提供对应服务器的 Docker 快速一键部署脚本和基础配置文件。

===============================================

# 4.mbtileserver（consbio/mbtileserver）瓦片读取逻辑
> 核心结论：**业务代码层面，每一次瓦片HTTP请求，都会执行一次SQL查询访问SQLite数据库；但不一定发生真正磁盘IO，有两层缓存帮你扛压力**。

1. **应用层：mbtileserver内置 groupcache**
它自带 `golang/groupcache`，做瓦片Blob内存缓存（LRU）。
- 同一个瓦片短时间重复请求：groupcache命中，直接返回内存里的pbf二进制，**不走SQLite，不读磁盘**。
- 冷访问、很久没访问过的瓦片：groupcache未命中 → 打开sqlite连接，执行`SELECT tile_data FROM tiles WHERE ...`查询mbtiles数据库。

> groupcache有自动大小限制，不会无限吃内存；高频热点瓦片驻留内存；冷门瓦片会被淘汰。

2. **SQLite +操作系统Page Cache（OS内核缓存）**
即便走到SQLite查询：
- 如果该瓦片所在的sqlite页面，已经被操作系统page cache缓存住，**没有磁盘物理读，只是内存拷贝**，速度很快。
- 只有完全冷数据，才真正触发SSD/HDD磁盘读取。

> ⚠️注意：**mbtileserver不会把整个mbtiles全部加载进内存**，始终按需查询。

## 2核4G服务器上的现实表现
1. 园区场景，高频访问局部区域：热点瓦片被groupcache+OS pagecache接住，绝大多数请求无磁盘IO，响应很快。
2. 用户随意拖拽地图，到处跳视角，大量冷门瓦片：每次请求走到SQLite查询，会产生大量随机磁盘读；**机械硬盘会明显卡顿，SSD表现尚可**。
3. groupcache是进程内缓存；重启服务，全部缓存清空，全部变成冷查询。

## 重要限制
1. **没有磁盘持久化瓦片缓存**，缓存全部在内存，进程销毁全部丢失。
2. groupcache不支持磁盘溢出，超过内存容量直接淘汰旧瓦片。
3. SQLite本身读是并发安全，但大量并发随机查询，会出现锁争抢、IO瓶颈，mbtileserver不做SQL层面优化（不开WAL，不改cache_size）。

## 优化手段（2核4G环境）
### 方案1：前端浏览器缓存（最有效，零服务器开销）
mbtileserver输出Cache‑Control响应头，MapLibre前端浏览器缓存瓦片，重复浏览同一区域，根本不会发http请求到后端。
```http
Cache‑Control: public,max‑age=86400
```

### 方案2：前面套Nginx proxy_cache（强烈推荐）
Nginx做代理层磁盘缓存，把命中的瓦片持久化到磁盘。
- 第一次请求：代理转发给mbtileserver，查询sqlite；Nginx把瓦片存入本地磁盘缓存。
- 后续相同z/x/y请求：Nginx直接返回缓存，**完全不会打到mbtileserver进程，完全避开sqlite**。

> 2核4G，Nginx+mbtileserver是性价比最高组合，显著降低sqlite查询压力。

### 方案3：更换pmtiles格式，用Martin提供服务
pmtiles是单文件，不需要sqlite数据库；瓦片索引在文件头部，直接HTTP Range随机读取，**没有SQL查询开销**，高并发场景优于mbtiles。

## mbtileserver vs Martin 缓存差异
- mbtileserver：内置groupcache内存缓存；没有磁盘瓦片缓存；每次miss必须走SQLite查询。
- Martin：**没有内置瓦片内存缓存**；完全依赖操作系统pagecache；但支持pmtiles，绕开sqlite开销。

## 什么时候会性能崩掉（2核4G）
1. 大量用户随机漫游地图，访问大量不重复瓦片，缓存命中率极低；大量随机sqlite查询，磁盘IO打满。
2. mbtiles文件很大（全国），冷访问，全部miss，大量磁盘读。

简短总结：
> 不是每一次http请求都会物理读磁盘；热点瓦片被groupcache+OS pagecache命中，直接内存返回；冷瓦片一定会走到SQL查询。2核4G内网园区场景够用；生产建议前置Nginx proxy_cache，大幅降低数据库压力。

如果你需要，我可以给一份Nginx proxy_cache最小配置，专门适配mbtileserver瓦片服务。

===============================================

# 5. Martin / Tegola / mbtileserver：能不能把**全中国瓦片全部加载进内存**
> 核心结论：**三个服务都没有“启动一次性全量加载全部瓦片到内存”的功能；全部都是 LRU 按需缓存，访问过才进内存，满了就淘汰旧瓦片**。
> 全中国矢量瓦片（z0‑z14）磁盘体积几十GB，**物理上不可能完整全部塞进内存**，没有任何一个瓦片服务器做这件事。

## 逐个拆解
### 1. Martin
- 内存缓存：Moka LRU，可配置`--cache‑size‑mb`，默认512MB，最大可以手动调大（比如16G、32G）。
- 行为：瓦片被请求之后才放入内存缓存；**不会启动时预读全部mbtiles/pmtiles到内存**。缓存满，自动淘汰冷瓦片。
- 数据源：mbtiles还是走sqlite查询；pmtiles走文件HTTP‑Range；内存缓存只存**已经访问过的瓦片**。
- 没有官方“预种子全部瓦片进内存”命令；只能用外部工具批量请求瓦片，把热点刷进缓存。
> 即便你服务器64G内存，把cache‑size‑mb设到48G，也只能存最近访问过的瓦片，不是全中国所有瓦片。

### 2. Tegola
- `[cache] type="memory"`：进程内LRU内存缓存，配置`max_size`控制瓦片条目数量，不是字节数。
- 同样：**访问过才进内存，超出max_size直接淘汰旧瓦片**。
- 有命令 `tegola cache seed`：可以批量生成瓦片，写入`file/redis`缓存；**seed到磁盘/redis，不能seed全部直接进memory内存缓存**，memory依旧是访问才加载。
> memory缓存适合小范围；全国场景memory完全不现实，一般用file/redis。

### 3. mbtileserver（consbio/mbtileserver）
- groupcache内存缓存，LRU；同样**请求命中才入内存，不会启动全量加载mbtiles**。
- groupcache会自动控制内存上限，溢出淘汰；没有预加载全部瓦片的能力。

## 关键现实：全中国瓦片数据量级
以z0‑z14矢量瓦片为例，磁盘体积约 **30‑60GB**（取决于要素过滤）。
- 就算你机器有64G物理内存，全部瓦片完整放入内存，几乎占满全部RAM；
- z15及以上，瓦片数量指数爆炸，磁盘直接上百GB，内存完全放不下。

> ✅可以做到：**热点高频访问区域常驻内存**；
> ❌做不到：**全国所有瓦片永久全部驻留内存**。

## 两种可行方案（想要尽量减少磁盘IO）
### 方案A：依靠操作系统 PageCache（最推荐，零代码改动）
把mbtiles/pmtiles放在SSD；服务器有大内存。
操作系统会把频繁读取的文件页自动缓存到内核pagecache。
> 服务进程本身不占用这部分内存，是OS接管；重启服务，pagecache还在，不需要重新读盘。
> Martin/mbtileserver读文件时，热点瓦片直接从内核内存返回，不走磁盘。
> 这是生产环境处理全国瓦片最实用手段。

### 方案B：预种子缓存（只把热点区域刷入缓存）
1. Tegola：`tegola cache seed`，把业务关心的热点区域（比如主要城市）种子到`file`磁盘缓存；访问时直接读缓存文件。
2. Martin/mbtileserver：用外部脚本并发请求瓦片，把热点刷进服务内存缓存。
> 不要尝试seed整个中国，会消耗巨量时间+磁盘空间。

## 三者对比简表
|服务|是否支持启动全量载入全部瓦片到内存|内存缓存机制|预种子能力|
|---|---|---|---|
|Martin|❌不支持|LRU，访问后才缓存，可设置最大MB|无内置seed命令，需外部脚本|
|Tegola|❌不支持|LRU，访问后才缓存；memory缓存按瓦片个数|seed命令，但只能seed到file/redis，不能直接seed进memory|
|mbtileserver|❌不支持|groupcache LRU，访问后才缓存|无内置seed|

## 选型建议针对你的场景
1. 如果数据源是静态预切好的全国pmtiles/mbtiles：优先Martin，依赖操作系统pagecache，不要指望应用层内存缓存装下全国。
2. 如果是动态生成瓦片（PostGIS/GPKG）：Tegola，热点用`file`磁盘缓存，不要指望memory缓存扛全国。
3. mbtileserver适合小数据集，全国场景不推荐。

> 误区澄清：很多人以为“开大cache_size就可以把整个数据集装进内存”，cache_size只是**访问过的瓦片的上限**，不会主动把磁盘上所有瓦片全部读入内存。

如果你需要，我可以给一个简单shell脚本示例，批量种子指定bbox瓦片到缓存。

====================================================

# 6. `Martin、Tegola：完全可以不用PostGIS`
> 两者**PostGIS只是可选数据源，不是强制依赖**，不配置PG连接，就完全不会访问PostGIS数据库，甚至机器上都不需要安装PostgreSQL/PostGIS。

## Martin（优先推荐，适配你的pmtiles/mbtiles）
### 不使用PostGIS的两种运行方式
1. **命令行直接指定瓦片目录**
不给任何postgres连接字符串、不设置`DATABASE_URL`环境变量，只挂载mbtiles/pmtiles文件目录：
```bash
# 只读取目录下 *.mbtiles *.pmtiles，完全不碰PostGIS
martin ./data/tiles/
```

2. **yaml配置文件，只写mbtiles/pmtiles数据源，不写postgres块**
`config.yaml`
```yaml
sources:
  - type: pmtiles
    path: /data/china.pmtiles
    id: china_base

server:
  port: 3000
  listen_addresses: "0.0.0.0:3000"
cache_size_mb: 4096
```
> ⚠️只要配置文件**不写postgres块、不传入数据库连接串、不设置DATABASE_URL环境变量**，Martin就不会去连接、发现任何PostGIS表，PostGIS完全不参与流程。

> 坑提醒：Martin如果检测到`DATABASE_URL`环境变量，会自动扫描PostGIS表；内网部署务必清除这个环境变量。

## Tegola
Tegola支持两种数据源：`postgis` / `gpkg`。
只要**toml配置里不写任何`type="postgis"`的provider**，就完全不会连接PostGIS，可以只用GeoPackage（gpkg本地sqlite文件）做数据源。

最小`tegola.toml`完全无PostGIS示例：
```toml
[[providers]]
name = "my_gpkg_data"
type = "gpkg"
filepath = "/data/park.gpkg"

[[providers.layers]]
name = "roads"
tablename = "roads"
geometry_fieldname = "geom"
id_fieldname = "fid"

[[maps]]
name = "park_map"
[[maps.layers]]
provider_layer = "my_gpkg_data.roads"

[cache]
type = "file"
basepath = "./tegola_cache"
```
> ⚠️注意：gpkg数据源需要CGO编译版本的tegola；纯静态无cgo二进制不支持gpkg。

> 注意区分：
> - Tegola的gpkg是**原始矢量要素库，运行时实时生成MVT瓦片**；
> - Tegola**不能直接读取mbtiles/pmtiles成品瓦片文件**，这一点和Martin不一样。

## 三者对比（无PostGIS场景）
|软件|不依赖PostGIS?|可用数据源|备注|
|---|---|---|---|
|Martin|✅是|pmtiles、mbtiles、geojson|**推荐，直接读预切瓦片文件**|
|Tegola|✅是|GeoPackage(gpkg)|只能读原始要素，实时计算瓦片；不识别mbtiles/pmtiles瓦片包|
|mbtileserver|✅是|mbtiles|只支持mbtiles，功能极简|

## 结合你的项目的选型建议
1. **静态底图（tilemaker输出pmtiles/mbtiles，几乎不改动）**
👉优先选 **Martin，完全关闭PostGIS**，只加载瓦片文件，架构最简单，不需要任何数据库。

2. **数据会频繁修改，不想重新切瓦片，没有PostGIS**
👉使用 **Tegola + GeoPackage(gpkg)**，不配置postgis provider；
代价：每次未缓存的瓦片请求，都要对gpkg做sqlite空间查询，IO压力更大，务必开启cache。

3. ❌不要做：不要强行用Tegola读取mbtiles，它做不到。

## 常见踩坑
1. Martin：不要残留`DATABASE_URL`环境变量，否则会自动尝试连接Postgres，启动报错。
2. Tegola：gpkg版本必须是CGO编译；alpine镜像默认cgo关闭，要选正确镜像。
3. 不配置PostGIS，不等于不需要磁盘IO：
    - Martin：读pmtiles/mbtiles文件；
    - Tegola(gpkg)：读sqlite gpkg要素库。

如果你需要，我可以给一份完整docker‑compose，Martin只加载pmtiles，零PostGIS。

===============================================

# 7.# 地图业务公司选型：Martin / Tegola / mbtileserver
如果一个地图业务的公司要选型tile server服务,以便于将来接相关项目,martin\tegola\mbtileserver 如何选?
<!-- douyin-doubaoAI -->
> 公司接项目，要面对**多种客户场景**：园区、市县、省级；有静态底图项目，也有业务数据实时更新的动态项目；服务器配置参差不齐（2核4G～高配云主机）；要兼顾社区活跃度、维护成本、交付效率、可运维性。

## 三者核心定位（商用视角）
### mbtileserver
- **定位：极简静态瓦片工具，只支持mbtiles**
- 优点：部署简单、体积小；适合内网小项目快速交付。
- 致命短板：
  1. 不支持pmtiles；内存缓存无法按字节配置，必须改源码；
  2. **没有动态瓦片能力，不能对接PostGIS/GPKG动态数据**；
  3. 社区活跃度低，属于小工具，不是企业级平台；
- 适合：辅助工具，**不建议作为公司主力tile‑server**，只拿来做极小内网项目。

### Tegola（Go）
- **定位：动态瓦片服务器，数据源PostGIS / GeoPackage(gpkg)**
- 优点：
  1. 支持file/redis/s3多缓存后端，支持种子缓存、清除缓存API；
  2. 可读取gpkg本地文件，不需要部署PG库；
  3. Go语言，二次开发门槛低。
- 短板：
  1. **不能直接读取mbtiles/pmtiles成品瓦片**，静态底图不能直接喂给它；
  2. gpkg需要CGO编译，alpine镜像踩坑多；
  3. 社区活跃度相比Martin弱，新版本迭代慢；
  4. 动态生成瓦片消耗CPU，低配机器压力大。
- 适用：**动态业务图层项目，数据频繁增删改**。

### Martin（MapLibre官方，Rust）
- **定位：全能矢量瓦片服务，静态+动态都支持**
1. 静态：直接读取 **pmtiles / mbtiles**，优先pmtiles性能更好；
2. 动态：对接PostGIS，实时生成MVT瓦片；
3. 支持多源混合：一部分来自pmtiles静态底图，一部分来自PostGIS业务图层合并输出；
4. 原生参数`--cache‑size‑mb`，字节级控制内存；Rust低内存、无GC抖动，低配服务器（2核4G）表现优秀；
5. MapLibre官方维护，社区活跃，文档完善，云原生docker友好；
6. 附带工具链 martin‑cp，可以把数据源导出mbtiles，方便项目交付交付离线包。

> 短板：**不支持GeoPackage(gpkg)数据源**；动态场景依赖PostGIS。

## 公司级两套方案（推荐）
### 方案A：主力标准方案（绝大多数项目）👉**以Martin作为主力tile‑server**
**适用项目：**
1. 绝大多数静态底图项目：园区、市县、省级底图，预切pmtiles/mbtiles；
2. 静态底图 + PostGIS动态业务图层混合项目（最常见政企GIS项目）；
3. 客户服务器配置参差不齐，2核4G低配也能稳定跑；
4. 公网访问、有并发压力的项目。

**工作流：**
- 静态底图：tilemaker → pmtiles，Martin直接加载；
- 动态业务数据：入库PostGIS，Martin读取PG实时生成瓦片；
- 可把静态+动态合并为一套瓦片接口给前端MapLibre。

> 交付优势：一套服务覆盖两类主流项目，减少维护多套技术栈的成本。

### 方案B：补充备选，Tegola作为动态场景补充
**什么时候启用Tegola：**
客户项目要求动态更新业务数据，**但是客户不愿意部署PostgreSQL/PostGIS数据库**，只能提供GeoPackage(gpkg)文件，此时使用 `Tegola + gpkg + file磁盘缓存`。

> 注意：Tegola只处理动态业务图层；静态底图依然用Martin提供服务，不要让Tegola扛大体积底图。

### mbtileserver定位：边角辅助工具
仅用于非常简单的内网演示原型，不作为生产主力。

## 现实项目场景对照表
|项目场景|首选|备注|
|---|---|---|
|园区/市县/省级静态底图，几乎不改数据|Martin + pmtiles|2核4G机器友好|
|静态底图 + PostGIS业务图层混合（政企最常见）|Martin|一个服务合并多源|
|业务要素频繁修改，客户拒绝部署PostGIS，只有gpkg原始数据|Tegola+gpkg|务必开启file缓存|
|公网高并发访问|Martin|Rust性能优势明显|
|离线项目，交付离线mbtiles数据包|Martin|martin‑cp工具辅助打包|
|极小内网演示原型|mbtileserver|仅原型，不做生产主力|

## 商用落地注意点
1. **不要让Tegola读取大的静态底图**，Tegola是实时计算瓦片，CPU开销远大于直接读预切瓦片的Martin。静态底图交给Martin，Tegola只负责小范围动态业务图层。
2. Martin没有gpkg支持：如果客户给gpkg原始数据，两种选择：
   - 导入PostGIS，交给Martin；
   - 或者Tegola读取gpkg，分开部署。
3. 架构最佳实践：统一前置Nginx proxy_cache，做HTTP层缓存，进一步降低后端压力，兼容高低配服务器。
4. 许可证：三者都是MIT开源协议，商用无版权风险。

## 总结
> **公司接项目，主力选用 Martin；Tegola作为gpkg无PG场景的补充；mbtileserver仅做简单原型工具。**
> Martin最大价值：**同一套程序同时覆盖静态瓦片项目 + PostGIS动态瓦片项目，适配高低配服务器，减少团队维护多套技术栈的负担。**

如果你需要，我可以整理一份公司项目交付通用docker‑compose模板：Martin为主，同时给出Tegola备选配置。

