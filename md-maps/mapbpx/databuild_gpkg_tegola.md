# GeoPackage(gpkg)完整制作流程（面向Tegola使用场景）
> 重点：**GeoPackage存放原始矢量要素，不是预切瓦片**；Tegola读取gpkg实时裁切生成MVT瓦片，**必须建好R‑Tree空间索引，否则瓦片查询极慢**。
> 适合：数据会频繁修改，不想每次重新切pmtiles/mbtiles；**静态底图优先pmtiles，不要用gpkg**。

## 方式一：QGIS可视化制作（最常用）
### 步骤1：准备源数据
shp、geojson、kml等矢量，统一坐标系：**推荐EPSG:3857（Web墨卡托），和瓦片服务坐标系对齐**，避免Tegola实时投影消耗CPU。

### 步骤2：导出为GeoPackage
1. 图层右键 → **导出 → 另存要素为**
2. 格式：`GeoPackage`
3. 输出文件名：`province.gpkg`
4. 图层名称：表名（例如`roads`，后面tegola要填写这个tablename）
5. CRS：`EPSG:3857`
6. 【关键】**自定义选项 → 创建空间索引 ✅勾选**（不勾选，Tegola瓦片查询会巨慢）
7. 几何类型：强制统一为`Multi‑Point / Multi‑LineString / Multi‑Polygon`，**禁止GeometryCollection，Tegola不支持**。
8. 编码UTF‑8，确定导出。

> 一个gpkg文件可以存放多张矢量表（道路、水系、行政边界）。

### 步骤3：校验空间索引是否生成
QGIS打开gpkg图层 → 图层属性 → 源信息，查看是否存在空间索引。
没有索引，执行工具：`数据库管理器`，对geom字段创建R‑Tree空间索引。

## 方式二：ogr2ogr命令行制作（批量、脚本自动化，GDAL工具）
```bash
# shp → gpkg，转3857，自动创建空间索引
ogr2ogr -f GPKG province.gpkg source.shp \
-t_srs EPSG:3857 \
-nlt MULTIPOLYGON \
-lco SPATIAL_INDEX=YES \
-nln roads
```
参数说明：
- `-nlt MULTIPOLYGON`：强制转为多多边形，规避GeometryCollection问题
- `-lco SPATIAL_INDEX=YES`：生成R‑Tree空间索引，**必须开启**
- `-nln roads`：gpkg内部表名（tegola的tablename对应这个）

给已有gpkg补建空间索引：
```bash
ogrinfo province.gpkg -sql "SELECT CreateSpatialIndex('roads','geom')"
```

把多个shp导入同一个gpkg（追加模式）
```bash
ogr2ogr -update -append -f GPKG province.gpkg water.shp -nln water -nlt MULTILINESTRING
```

## 面向Tegola的gpkg硬性约束（省级数据，2核4G服务器）
1. **坐标系优先EPSG:3857**，不要交给Tegola运行时做坐标转换，CPU开销巨大。
2. 几何类型禁止`GeometryCollection`，MVT瓦片规范不支持，直接报错/空白瓦片。
3. **必须带R‑Tree空间索引**，省级数据没有索引，瓦片请求直接超时。
4. 几何字段名尽量为`geom`，主键字段`fid`（整数），对应tegola配置`id_fieldname = "fid"`。
5. 不要存Z/M维度，尽量去掉三维坐标，减少计算压力。
6. 省级gpkg体积会很大，放到SSD磁盘；sqlite随机读对磁盘非常敏感。
7. Tegola读取gpkg，**必须使用CGO编译版本**；alpine静态无cgo镜像**不支持gpkg数据源**。

## 最简tegola.toml读取gpkg示例
```toml
[[providers]]
name = "province_data"
type = "gpkg"
filepath = "/data/province.gpkg"

[[providers.layers]]
name = "roads"
tablename = "roads"
geometry_fieldname = "geom"
id_fieldname = "fid"

[[providers.layers]]
name = "water"
tablename = "water"
geometry_fieldname = "geom"
id_fieldname = "fid"

[[maps]]
name = "province_map"
[[maps.layers]]
provider_layer = "province_data.roads"
[[maps.layers]]
provider_layer = "province_data.water"

# 【重要】2核4G必须开启磁盘缓存，否则每次请求都查询sqlite
[cache]
type = "file"
basepath = "./tegola_cache"
```

## 重要权衡（回到你的省级2核4G场景）
1. ✅使用gpkg+Tegola的场景：业务矢量要素会经常增删改，不想反复重切瓦片；
2. ❌**静态底图（几乎不改数据）不要制作gpkg**，优先用tilemaker输出pmtiles，交给Martin，CPU/IO压力远小于Tegola+gpkg。

### 坑点清单
1. QGIS导出忘记勾选空间索引，Tegola瓦片请求卡顿超时；
2. GeometryCollection混合几何类型，瓦片空白报错；
3. 使用无CGO的Tegola二进制，启动直接报错gpkg provider不可用；
4. gpkg放在机械硬盘，大量瓦片请求随机IO打满。

如果你需要，我可以写一条完整的`tilemaker`命令，对比生成pmtiles，让你直观对比两种产物的差异。