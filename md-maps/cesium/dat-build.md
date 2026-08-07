# 1.cesium 全球瓦片数据如何制作
<!-- googleAI -->
制作 Cesium 全球瓦片数据是一项庞大的工程。Cesium 的核心需求主要分为两类：地形数据（Terrain）和影像/矢量底图数据（Imagery）。你需要根据不同的数据类型，选择不同的工具链进行切片制作。
以下是制作全球瓦片数据的完整技术路线和工业界标准方案：

------------------------------
## 🏔️ 一、 地形瓦片数据制作（Cesium Quantized-Mesh 格式）
Cesium 官方推荐且性能最好的地形格式是 Quantized-Mesh（量化网格）。它支持多细节层次（LOD）和裙边（Skirts）设计，能完美贴合地球曲率。
## 1. 核心制作工具：cesium-terrain-builder-docker
由于原版的 cesium-terrain-builder 较为陈旧，目前社区最常用的是经过重构、支持高并发的高性能 CTB Docker 镜像。
## 2. 制作步骤：

* 
* 第一步：准备原始 DEM 数据
* 你需要全球的高程数据（通常为 .tif 或 .img 格式）。
   * 免费公开的全球高程源包括：[NASADEM](https://earthdata.nasa.gov/)、[SRTM (30米分辨率)](https://earthexplorer.usgs.gov/) 或 [ASTER GDEM](https://asterweb.jpl.nasa.gov/gdem.asp)。
* 第二步：数据预处理（重投影与合并）
* 使用 GIS 命令行工具 [GDAL](https://gdal.org/) 将所有碎切片融合成一个大图，并转换投影。Cesium 地形必须使用 WGS84 经纬度投影（EPSG:4326）。
   * 运行命令：
   
   # 将多个 DEM 合并为一个并转为 EPSG:4326
   gdalwarp -of GTiff -co TILED=YES -co COMPRESS=DEFLATE -t_srs EPSG:4326 input1.tif input2.tif global_dem_4326.tif
   
   * 第三步：一键切片
* 使用 Docker 运行 CTB 工具，将 .tif 转换成符合 Cesium 规范的 quantized-mesh 瓦片目录：
   
   docker run -v /path/to/data:/data tumgis/ctb-quantized-mesh \
   ctb-tile -f Mesh -v -o /data/terrain_output /data/global_dem_4326.tif
   
   * 切片完成后，会自动生成一个 layer.json 文件和按 /z/x/y.terrain 目录层级排列的二进制文件。
* 

------------------------------
## 🌍 二、 影像底图瓦片数据制作（TMS / XYZ 格式）
Cesium 加载全球影像（卫星图、地图底图）最常使用标准 TMS (Tile Map Service) 或 XYZ 瓦片 规范。
## 1. 核心制作工具：GDAL (gdal2tiles.py)
gdal2tiles 是最经典、最稳定的开源栅格切片工具。
## 2. 制作步骤：

* 
* 第一步：获取全球影像数据
* 通常为大尺度的高分辨率遥感卫星图（如 GeoTIFF 格式）。
* 第二步：运行切片脚本
* 使用 GDAL 自带的 Python 脚本进行切片。切片时必须指定投影系统。Cesium 原生对 EPSG:4326 (Geodetic) 支持最好：
   
   # -z 0-10 表示切片层级为 0 到 10 层# -w geodetic 指定为地理坐标系（TMS 规范）
   python gdal2tiles.py -z 0-10 -w geodetic global_image.tif /path/to/output_tiles
   
   * 生成的目录结构包含大量的 .png 或 .jpg 图片，以及一个 tilemapresource.xml 配置文件。
* 

## 3. 现代化进阶方案：使用 martin 或 mbtileserver
如果你不想在硬盘上生成数千万个细碎的图片文件（文件太多会导致系统磁盘 I/O 极其缓慢）：

   1. 使用工具（如 QGIS 或 gdal_translate）将全球影像打包成一个单一的 .mbtiles 文件。
   2. 使用你之前了解到的 [mbtileserver](https://github.com/consbio/mbtileserver) 或 [martin](https://github.com/maplibre/martin) 服务端程序直接运行托管这个 .mbtiles 文件。
   3. Cesium 前端直接调用服务器输出的标准标准 XYZ 接口（UrlTemplateImageryProvider）加载底图。

------------------------------
## 🏢 三、 3D 城市/建筑白模数据制作（3D Tiles 格式）
如果你手里有全球的二维建筑轮廓（如来自 OpenStreetMap 的矢量数据）以及它们的高度属性，你想把它们变成 Cesium 的三维实体：
## 1. 核心制作工具：py3dtiles 或 3dtiles-compiler

* 
* py3dtiles：Python 编写的开源 3D Tiles 转换工具。
* loaders.gl (Cesium 兼容)：支持将多种空间数据源动态转化为 3D Tiles。
* 

## 2. 制作思路：

   1. 提取属性：从 Shapefile 或 PostGIS 数据库中拉取建筑的多边形边界（Polygon）和 height（高度）字段。
   2. 生成拉伸体：利用工具将二维多边形沿 Z 轴拉伸，转化为 .b3dm（Batched 3D Model）格式。
   3. 构建空间索引（Bounding Volume Hierarchy）：根据全球经纬度划分四叉树或八叉树结构，生成控制加载优先级的 tileset.json 索引文件。

------------------------------
## 🛠️ 四、 前端 Cesium 怎么加载这些本地数据？
当你的数据切片完成后，直接通过 Nginx 部署为静态文件服务（或放进 S3/OSS 对象存储中），并在前端通过几行代码即可加载：

const viewer = new Cesium.Viewer("cesiumContainer");
// 1. 加载你制作的全球影像底图const customImagery = new Cesium.UrlTemplateImageryProvider({
  url: "http://your-server-ip/image_tiles/{z}/{x}/{y}.png",
  tilingScheme: new Cesium.GeographicTilingScheme() // 对应 EPSG:4326
});
viewer.imageryLayers.addImageryProvider(customImagery);
// 2. 加载你制作的全球地形数据const customTerrain = new Cesium.CesiumTerrainProvider({
  url: "http://your-server-ip/terrain_output",
  requestVertexNormals: true // 开启地形光照阴影
});
viewer.terrainProvider = customTerrain;

------------------------------
## 💡 工业界生产省钱秘籍 (商用避坑)

   1. Cesium ion 官方云服务：Cesium 官方提供 Cesium ion 平台，你只需把大 .tif 文件传上去，它自动在云端帮你切好地形和 3D Tiles。但是，超过免费额度后极其昂贵。因此自建上述 Docker 开源切片链是国内企业私有化部署的唯一选择。
   2. 切片磁盘危机：全球精细切片极其恐怖。如果切到 16 层以上，小文件的数量会达到数十亿级，普通机械硬盘的 inode 会直接爆掉。强烈建议在生产中：影像底图采用 .mbtiles / .pmtiles + martin 方案；只有地形数据才不得不采用 quantized-mesh 散碎文件夹形式。

如果想尝试，建议先下载一个省份级别（如海南岛）的免费小范围 DEM 影像文件，用上述 Docker 命令行跑一次流程。需要具体某一步的详细命令行参数或排错指南吗？

