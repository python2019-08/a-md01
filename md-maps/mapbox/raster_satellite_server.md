# 1. 如何给 mapbox提供 光栅(raster) 卫星地图服务？

```txt
martin 只给mapbox提供矢量地图数据服务， 如何给 mapbox提供 卫星地图服务？
```

Martin 本身确实只专注于提供矢量切片（Vector Tiles）和字体/精灵图服务，它无法直接读取 TIFF 等栅格影像并将其切片为卫星地图瓦片。
要在 Mapbox 中使用卫星地图服务，通常有两种解决路径：路径一（推荐）是直接在 Mapbox 前端配置现有的公共卫星地图源（如天地图、高德、Google）；路径二是如果您有自己的卫星影像数据（如 GeoTIFF），需要使用专门的栅格切片工具将其发布为 Raster Tiles，再供 Mapbox 调用。
------------------------------
## 方法一：直接在 Mapbox 中接入第三方公共卫星地图（免搭建服务端）
这是最快速、成本最低的方法。Mapbox 支持标准的 raster 图层，您可以直接在前端代码中配置第三方地图厂商提供的 XYZ 或 WMTS 卫星地图服务（例如天地图）。
在 Mapbox GL JS 中的配置范例如下：

```javascript
map.on('load', () => {
    // 1. 添加卫星影像数据源 (以天地图影像为例，需自行申请 token)
    map.addSource('tianditu-satellite', {
        'type': 'raster',
        'tiles': [
            'https://tianditu.gov.cn{z}&TILEROW={y}&TILECOL={x}&tk=您的天地图TOKEN'
        ],
        'tileSize': 256
    });

    // 2. 将卫星图层添加到地图中（放在最底层）
    map.addLayer({
        'id': 'satellite-layer',
        'type': 'raster',
        'source': 'tianditu-satellite',
        'paint': {}
    }, '您原有的Martin矢量图层ID'); // 确保卫星图不会盖住 Martin 的道路或标签
});
```

------------------------------
## 方法二：如果您拥有自主的卫星数据，如何自行发布卫星地图服务？
如果您手中有本地的 .tif 卫星影像，您无法使用 Martin，但可以使用以下开源或轻量化工具来发布与 Mapbox 兼容的栅格瓦片服务（Raster Tiles）：
## 1. 使用 mbtiles 格式 + 轻量级瓦片服务器（如 TileServer‑GL）
这是与 Martin 最像、且与 Mapbox 生态最契合的方案：

* 步骤 A（切片）：使用 [Maptiler Desktop](https://www.maptiler.com/) 或开源的 gdal2tiles 工具，将您的 GeoTIFF 影像切片并打包成一个 .mbtiles 文件（注意选择 Raster 格式，而非 Vector）。
* 步骤 B（发布）：使用 [TileServer‑GL](https://github.com/maptiler/tileserver‑gl)（基于 Node.js，有官方 Docker 镜像）来运行这个 .mbtiles 文件。它会为您自动生成 Mapbox 所需的标准 XYZ 瓦片接口（如 http://localhost:8080/styles/satellite/{z}/{x}/{y}.png）。

## 2. 使用 GeoServer 发布 WMTS / TMS 服务
如果您的数据量非常庞大，或者需要企业级的 GIS 管理：

* 将卫星影像导入 [GeoServer](https://geoserver.org/)。
* 利用 GeoServer 的 GeoWebCache 模块，将影像发布为标准的 WMTS 或 TMS（栅格瓦片）服务。
* 在 Mapbox 中以 type: 'raster' 的方式引入 GeoServer 的 URL 接口。

## 3. 静态文件服务（直接切片放 Nginx）
如果地图范围很小，不需要任何后端框架：

* 使用 gdal2tiles.py 将 TIFF 图片直接切碎成由 {z}/{x}/{y}.png 组成的文件夹目录。
* 将整个文件夹直接丢进 Nginx、Apache 或对象存储（如 AWS S3、MinIO）中。
* Mapbox 的 tiles 网址直接指向 Nginx 的静态路径：https://your‑server.com{z}/{x}/{y}.png。

------------------------------
## 💡 架构建议
在实际的 WebGIS 项目中，混合架构是最常见的解决方案：
* 底层的卫星背景、地形地貌：使用方法一（调用天地图/Mapbox官方卫星）或方法二（用 Nginx/TileServer‑GL 发布栅格瓦片）。
* 上层的业务数据、行政边界、POI标签、动态轨迹：继续使用 Martin 服务器 输出高性能的矢量切片。

两者在 Mapbox 前端通过 map.addLayer() 进行叠加，就能完美实现「Martin 矢量数据 + 卫星影像底图」的组合。
如果您有特定来源的卫星影像数据，可以告诉我您的数据格式与数据量大小，我能为您推荐最适合的自动化切片与发布工具。 

======================================
======================================

# 3. 从哪里可以下载.tif 衛星影像？

下載帶有地理坐標的 .tif（通常為 GeoTIFF）衛星影像，管道主要分為「國際官方免費遙感數據庫」與「地圖下載器軟體（適合高解析度底圖）」兩大類。
------------------------------
## 一、 國際官方遙感數據平台（100% 免費、科研與專業級）
這些平台提供的是真實的原始衛星遙感觀測數據，包含多光譜波段，下載下來直接就是標準的 GeoTIFF 格式（無縫包含經緯度與投影坐標），非常適合 GIS 分析。

### Copernicus Data Space Ecosystem (歐洲太空總署)
* 網址：[Copernicus Browser](https://browser.dataspace.copernicus.eu/)
   * 影像源：Sentinel-2 (哨兵2號)。
   * 特點：免費提供全球最高 10 公尺解析度的衛星影像，每 5 天更新一次。在網頁上框選區域後，可直接下載原始波段或合成好的高解析度 .tif 圖檔。 [1, 2] 

### USGS EarthExplorer (美國地質調查局)
* 網址：[USGS EarthExplorer](https://earthexplorer.usgs.gov/)
   * 影像源：Landsat 全系列 (陸地衛星)、哨兵衛星、DEM 高程數據。
   * 特點：擁有全球最完整的歷史觀測數據（長達50年）。解析度通常為 15～30 公尺，註冊免費帳號後即可框選範圍下載 .tif 壓縮包。 [2, 3, 4] 
### NASA Earthdata Search (美國國家航空暨太空總署)
* 網址：[NASA Earthdata](https://earthdata.nasa.gov/)
   * 特點：適合尋找氣象、植被（MODIS衛星）、環境監測等全球尺度的 .tif 數據。 [2, 5] 
 

------------------------------
## 二、 地圖下載器工具（適合獲取 Google / 天地圖等高解析度「地圖底圖」）
如果您不需要做光譜分析，只是想要超清晰、能看到建築物和道路的 Google Earth 或天地圖衛星「照片」來做 Mapbox 的底圖，官方平台無法直接下載，必須藉助地圖下載工具。這些工具會自動幫你把網絡上的瓦片拼成一張巨大的 .tif 影像並寫入坐標。
## 1. 免費開源工具

### SAS.Planet（強烈推薦）
   * 獲取方式：GitHub 開源項目。
   * 特點：完全免費。它能直接讀取 Google Maps、Bing Maps、Here 等幾十種地圖源。你可以在軟體內畫一個矩形，選擇你要的層級（Zoom 18-19 級可看清車輛），然後導出（Export）時選擇 GeoTIFF 格式即可。

## 2. 國產老牌 GIS 下載軟體（有免費額度或版本限制）

### 圖新地球 (LocaSpace Viewer / LSV)
* 特點：內置了豐富的免費地圖源（包含國內無偏移的衛星圖）。支持直接框選區域並導出為帶坐標的 .tif 影像。 [6, 7] 
### 奧維互動地圖 (PC端)
* 特點：可以導入各種自定義地圖源。選定區域後可以導出無偏移、含經緯度坐標的 TIFF 影像，但大面積或超高像素的導出通常需要其 VIP/SVIP 權限。 
### BIGEMAP / 水經注下載器
* 特點：專門的地圖下載器。免費版通常有限制導出解析度（如只能導出到17級），更高解析度（如0.5米高清）或大圖幅導出需要付費授權。 [9] 

  
------------------------------
## 💡 小建議
如果您是要做 Mapbox 的衛星底圖測試，建議直接下載 [SAS.Planet](https://www.youtube.com/watch?v=pofkRcXdClc)，框選一個城市的小區域，下載一幅 18 級的 Google 衛星 GeoTIFF，這是最快且最清晰的測試數據來源。
請問您這次下載衛星影像，主要是想用於哪一個國家/地區？需要的清晰度（解析度）大約是多少（例如：看清城市建築，還是看大自然山川地形）？

[1] https://browser.dataspace.copernicus.eu
[2] [https://www.youtube.com](https://www.youtube.com/watch?v=HbN7KmR8mLo)
[3] https://earthexplorer.usgs.gov
[4] [https://blog.csdn.net](https://blog.csdn.net/mrib/article/details/49948857)
[5] [https://tech.ardswc.gov.tw](https://tech.ardswc.gov.tw/EPaper/Home/EPaper?PaperID=dc892cc4-2972-4df8-b287-0cecce7bdac1)
[6] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/683083126)
[7] [https://juejin.cn](https://juejin.cn/post/7579999793319395334)
[8] [https://www.ovital.com](https://www.ovital.com/136413-2/)
[9] [https://www.bigemap.com](http://www.bigemap.com/bigemap_index.php/information/mapdown/detail20190821516.html)
[10] [https://nodass.namr.gov.tw](https://nodass.namr.gov.tw/newsInfo?id=93)
[11] [https://www.sphs.hc.edu.tw](https://www.sphs.hc.edu.tw/ischool/rfile/1115ce48e6e5be7bd91a25c19f55bba3)
[12] https://opendata.csrsr.ncu.edu.tw


======================================
======================================

# 4. 有没有 比TileServer-GL更好的rust或golang的 柵格切片服务开源项目

截至 2026 年，Go 語言（Golang）和 Rust 生態中確實出現了許多在效能、記憶體佔用和部署便利性上完勝 TileServer-GL 的開源柵格切片服務項目。
TileServer-GL 基於 Node.js，在高併發或容器化部署時比較笨重。以下推薦幾款當前最優秀的 Go 和 Rust 開源替代方案：
------------------------------
## 一、 Go 語言（Golang）頂級推薦：Mbtiles-Server  
   https://github.com/consbio/mbtileserver.git 

------------------------------
## 二、 Rust 語言頂級推薦：Martin (原生支持) / Versatiles
您前面提到的 Martin 其實在最新版本中已經進化了！雖然它的核心是 PostGIS 矢量服務，但它目前已經原生支援直接讀取 .mbtiles 格式的柵格衛星地圖。
## 1. Martin (是的，最新版的 Martin 其實可以！)

* Martin 連接 PostGIS 時確實只能吐出矢量。但是，如果您把衛星影像用工具打包成 satellite.mbtiles（柵格格式），Martin 可以直接讀取並分發它。
* 代碼範例：
```sh
# 沒錯，直接把 Martin 當作衛星地圖服務器啟動
martin /path/to/your/satellite.mbtiles
```
* 優勢： (1)極致的 Rust 效能：併發處理能力與 Nginx 旗鼓相當，記憶體佔用幾乎可以忽略不計。(2)統一架構：您可以只運行一個 Martin 服務，同時連 PostGIS（負責業務矢量線條）和讀取本地 mbtiles（負責衛星底圖），完美對接 Mapbox。

## 2. Versatiles (Rust 生態的新星)
[versatiles-rs](https://github.com/versatiles-org/versatiles-rs.git)  

* 項目特點：這是一個專門為了大規模地圖切片與分發而設計的 Rust 開源框架。
* 優勢： (1)新型格式支持：除了 .mbtiles，它還支持他們自創的 .versatiles 格式（比 mbtiles 更安全、高併發查詢更快、檔案體積更小。(2)多後端支持：可以將切片直接無縫代理到 AWS S3 或 MinIO 對象存儲。
* 適合場景：雲原生（Cloud Native）架構，或者需要處理數百 GB 以上、超大規模衛星影像的現代 GIS 項目。

------------------------------
## 📊 終極挑選決策指南

* 如果您已經在使用 Martin：
👉 直接用 Martin！ 只需要把您的衛星 .tif 用 gdal2tiles 或 MapTiler 打包成一個 .mbtiles 檔案，然後直接作為參數傳給 Martin。這樣您就不需要引入任何新工具，架構最乾淨，效能也是 Rust 級別的頂尖。 

如果您想嘗試用 Martin 或 Go 服務來跑衛星圖，我可以為您提供將 .tif 快速轉換為與它們相容的 .mbtiles 檔案的命令行指令。您想試試看嗎？

======================================
======================================

# 5. 現成衛星圖 MBTiles 的獲取管道，以及手動下載、切片轉換的完整實戰指南
從 [Copernicus Data Space Ecosystem (CDSE)](https://browser.dataspace.copernicus.eu/) 下載衛星圖並製作成 MBTiles 是一項非常實用的操作。然而，「直接手動下載再切片」對於個人開發者來說，精力與硬件成本極高。

以下為您提供現成衛星圖 MBTiles 的獲取管道，以及手動下載、切片轉換的完整實戰指南。
 
## 一、 有沒有現成的衛星圖 MBTiles？
有，但免費的通常有分辨率限制，高分辨率的需要付費或自己下載。

### 1. MapTiler 官方付費/免費試用數據
#### MapTiler Satellite Medium Res
    [MapTiler Satellite Medium Res](https://www.maptiler.com/on-prem-datasets/dataset/satellite-2021/) 提供了全球中分辨率（最高到 Zoom 13）的衛星圖 MBTiles 下載，已經過雲層剔除和無縫拼接處理。
```sh
aria2c -c -x 10 -s 10 -k 10M  https://data.maptiler.com/download/WyI3ZmY5MjFmMy1kYzQ0LTRkNmYtOTlhNS05ZWE3YTNkZmRhNzQiLG51bGwsMjM3NjNd.anmdkQ.VyweDuIJHnG4_gQE0-3-VbGShwI/maptiler-server-map-styles-and-samples-3.16.zip

aria2c -c -x 10 -s 10 -k 10M   https://data.maptiler.com/download/WyI3ZmY5MjFmMy1kYzQ0LTRkNmYtOTlhNS05ZWE3YTNkZmRhNzQiLG51bGwsMjMzNzRd.anmdkQ.tkNi6gCK8saFp5_l9k6kN6NuM94/maptiler-geocoding-index-2025-06-30-v2.15.8-europe_switzerland.tar.gz
```
   
#### MapTiler Satellite Low Res
    [MapTiler Satellite Low Res](https://www.maptiler.com/on-prem-datasets/dataset/satellite/) 則提供免費的全球低分辨率底圖（Zoom 0-13）。  

![maptiler](img/maptiler.png)

### 2. 開源社區自製與平替方案（PMTiles / MBTiles）
   * Protomaps 衛星方案：許多開發者不使用 MBTiles 存儲大型衛星圖，而是使用更現代的 PMTiles。您可以關注一些基於藍理雷達（Blitzortung）或 EOX 數據源開放的下載站（例如一些開源遙感社區分享的區域性 [limaps.org](https://www.limaps.org/tileserver.html)）。
   * Linz / USGS 區域切片：如果您只需要特定國家（如美國 USGS、新西蘭 LINZ），官方地質局網站通常會直接提供全境打包好的 GeoTIFF 或 WMTS 服務，比歐洲航天局更容易直接切片。  
    
## 二、 從 Copernicus 製作 MBTiles 的完整流程
如果您需要特定區域、特定時間的高分辨率（如 Sentinel-2 的 10 米分辨率）最新衛星圖，可以按照以下三個步驟自行製作： [7] 
### 步驟 1：從 Copernicus Browser 下載原始數據 (GeoTIFF)
請勿直接在瀏覽器中右鍵保存 JPG/PNG，那樣會丟失地理坐標信息。

>    1. 打開 Copernicus Browser 並登入帳號。 [1, 2] 
>    2. 在左側搜索框選定您的目標區域 (AOI)、時間範圍，並勾選 Sentinel-2（其可見光波段分辨率最高可達 10 米）。 [1, 7] 
>    3. 篩選出雲量低（Cloud Cover < 10%）的滿意影像。 [8] 
>    4. 點擊右側工具欄的 "Download image" (下載圖表) 按鈕。
>    5. 關鍵設置：切換到 "Analytical" (分析) 標籤頁：
>    * Format (格式)：必須選擇 TIFF (8-bit 或 16-bit)，這會下載帶有地理坐標的 GeoTIFF 格式。
>       * Resolution (分辨率)：選擇 High (高)。
>       * Layers (圖層)：選擇 True Color (真彩色)（由 B04, B03, B02 波段合成）。
>    6. 點擊 Download 下載得到 .tiff 文件。 [9] 

### 步驟 2：使用 GDAL 進行投影轉換與切片 (核心步驟)
   下載下來的 GeoTIFF 通常使用的是 UTM 投影（如 WGS 84 / UTM zone 50N），而網頁地圖（Martin / MapLibre）使用的是 Web Mercator (EPSG:3857) 投影。我們需要使用地理數據老牌工具 GDAL 進行處理。 [9] 
   您可以通過 Docker 或環境包管理工具（如 brew install gdal 或 conda install gdal）安裝 GDAL。

#### 1. 投影重投影 (Reproject)
將 UTM 投影轉換為 Web Mercator，並強制輸出為標準 RGB：
```sh
gdalwarp -t_srs EPSG:3857 -r bilinear -of GTiff input_sentinel.tif reprojected.tif
```

#### 2. 生成標準瓦片目錄 (XYZ 結構)
使用 gdal2tiles.py 工具將大圖切割成瓦片目錄。這裡需要指定你想生成的層級（例如 Zoom 10 到 15）：
```sh
gdal2tiles.py --zoom=10-15 --webviewer=none  reprojected.tif  ./tiles_output/
```
處理完成後，./tiles_output/ 文件夾內會生成標準的 /z/x/y.png 瓦片目錄。

### 步驟 3：將瓦片目錄打包為 MBTiles 文件
得到瓦片目錄後，我們可以使用 MapBox 官方開源的 mbutil 工具，將成千上萬個碎圖片文件打包成單個不佔用文件系統索引的 .mbtiles 數據庫文件。

#### 1. 安裝 mbutil (需要 Python 環境)：
```sh
pip install mbutil
```
   
#### 2. 執行打包命令
   （注意：gdal2tiles 默認生成的 TMS 瓦片結構，轉成 MBTiles 時通常需要注意 y 軸翻轉，mbutil 默認支持標準的 XYZ 結構）：
```sh
mbutil ./tiles_output/ my_satellite.mbtiles --image_format=png
```
打包完成後，您就得到了可以在 Martin 中直接掛載運行的 my_satellite.mbtiles 文件了！

------------------------------
## 三、 精力有限的個人開發者「極速替代方案」
手動去下載 1G 甚至幾十 G 的原始 .tif 文件再切片非常消耗電腦的 CPU 和硬碟。既然您已經決定使用 Martin，有一個更簡單的「白嫖」套路： [8, 9] 
### 繞過下載，直接用 Martin 代理代理 Copernicus 的 WMTS 服務
Copernicus Data Space Ecosystem 本身提供了標準的 WMTS / WMS 服務 API（基於 Sentinel Hub 生態）。 [10, 11] 

>    1. 您可以在 CDSE 後台申請一個身份驗證的客戶端憑證（Credentials）。
>    2. 在 Martin 的 config.yaml 配置文件中，不要掛載本地文件，而是配置一個 HTTP 遠端光柵源 (Raster Source)，直接指向 Copernicus 的 WMTS 瓦片網址。
>    3. 這樣一來，前端向 Martin 請求衛星圖瓦片時，Martin 會自動去 Copernicus 拉取最新數據並緩存。您既不需要下載大文件，也不需要自己切片，直接擁有了全中國乃至全球的 10 米高精度實時衛星圖。

如果您對這個「免下載切片」的 Martin 配置方案感興趣，我可以為您提供對應的配置文件寫法。

[1] https://browser.dataspace.copernicus.eu
[2] [https://medium.com](https://medium.com/@steve.lacroix32/downloading-sentinel-2-satellite-images-with-python-8048971904cd)
[3] [https://www.maptiler.com](https://www.maptiler.com/on-prem-datasets/dataset/satellite-2021/)
[4] [https://www.maptiler.com](https://www.maptiler.com/on-prem-datasets/dataset/satellite/)
[5] [https://www.youtube.com](https://www.youtube.com/watch?v=HbN7KmR8mLo)
[6] [https://www.limaps.org](https://www.limaps.org/tileserver.html)
[7] [https://www.youtube.com](https://www.youtube.com/watch?v=g_kr3vNJiTE)
[8] [https://knowyourspace.dk](https://knowyourspace.dk/2022/07/07/how-to-download-a-satellite-image-from-copernicus-open-access-hub/)
[9] [https://forum.dataspace.copernicus.eu](https://forum.dataspace.copernicus.eu/t/helping-me-with-dem/4496)
[10] [https://www.sentinel-hub.com](https://www.sentinel-hub.com/explore/copernicus-data-space-ecosystem/)
[11] [https://dataspace.copernicus.eu](https://dataspace.copernicus.eu/news/2026-7-31-copernicus-browser-now-also-supports-external-wms-and-wmts-layers)


=================================================
# 6.martin 如何加载多栅格MBTiles文件
<!-- googleAI -->
要让 Martin 瓦片地图服务器加载并同时使用这两个 mbtiles 文件（世界卫星地图和北京卫星地图），你可以使用 命令行直接加载 或 使用配置文件 YAML 两种方式。 [1, 2] 
需要注意的是，由于这两个文件分别属于不同的数据源 ID，在前端地图框架（如 MapLibre GL JS 或 Mapbox GL JS）中，你需要通过配置同一个图层样式（Style）或双图层叠加的方式，让它们在不同层级下无缝切换。
以下是具体的加载和配置步骤：
## 🛠️ 步骤一：使用 Martin 加载多个 MBTiles## 方法 A：命令行直接加载（最快捷）
将两个 mbtiles 文件放在同一个文件夹内（例如 ./tiles 目录），或者直接在启动命令中列出它们的路径。 [1] 
```sh
# 方式 1：直接指定文件夹（Martin 会自动扫描内部所有 .mbtiles 文件）
martin ./tiles
# 方式 2：显式指定多个文件路径
martin ./tiles/world_0_6.mbtiles ./tiles/beijing_0_13.mbtiles
```
启动后，Martin 会根据文件名自动生成两个不同的瓦片源 ID（假设为 world_0_6 和 beijing_0_13）。你可以访问 http://localhost:3000/catalog 查看自动生成的元数据列表。 [1, 3] 
## 方法 B：使用 YAML 配置文件（适合生产环境）
如果你想自定义数据源的 ID 或限制缩放层级（Zoom），可以使用配置文件。新建一个 config.yaml 文件： [1, 4] 
```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/maplibre/martin/main/schemas/config.json
srv:
  listen_addresses: "0.0.0.0:3000"

mbtiles:
  paths:
    - ./tiles  # 自动扫描此目录下的所有 mbtiles 文件
```
然后使用以下命令启动： [4] 

```sh
martin --config config.yaml
```
------------------------------
## 🎨 步骤二：在前端地图中配置无缝切换
MapTiler 提供的卫星图通常是栅格瓦片（Raster Tiles）。由于 Martin 把它们分成了两个独立的数据源，你在前端（以 MapLibre GL JS 为例）需要定义两个 sources，并在 layers 中分别限制它们的显示层级（minzoom 和 maxzoom），从而实现低层级看世界、高层级看北京的效果。 [5] 
前端网页代码示例如下：

const map = new maplibregl.Map({
    container: 'map',
    style: {
        version: 8,
        sources: {
            // 1. 世界卫星图数据源 (Zoom 0-6)
            "world-satellite-source": {
                "type": "raster",
                "tiles": ["http://localhost:3000/world_0_6/{z}/{x}/{y}"],
                "tileSize": 256
            },
            // 2. 北京卫星图数据源 (Zoom 0-13)
            "beijing-satellite-source": {
                "type": "raster",
                "tiles": ["http://localhost:3000/beijing_0_13/{z}/{x}/{y}"],
                "tileSize": 256
            }
        },
        layers: [
            // 1. 渲染世界底图：在全局 0-6 级显示，超过 6 级自动隐藏
            {
                "id": "world-satellite-layer",
                "type": "raster",
                "source": "world-satellite-source",
                "minzoom": 0,
                "maxzoom": 6 
            },
            // 2. 渲染北京大图：在 0-13 级都渲染
            //（因为北京范围在 0-6 级时会叠在世界图上方，高层级 6-13 级时由于世界图隐去，只显示北京）
            {
                "id": "beijing-satellite-layer",
                "type": "raster",
                "source": "beijing-satellite-source",
                "minzoom": 0,
                "maxzoom": 14 // 稍微设置大一点允许客户端放大缩放
            }
        ]
    },
    center: [116.40, 39.90], // 北京中心点
    zoom: 4 // 初始层级
});

## 💡 核心提示

   1. 服务地址确认：请根据 Martin 实际运行的控制台输出，将 http://localhost:3000/ 后面的名称替换为你本地实际的文件名（不带 .mbtiles 后缀）。
   2. 瓦片格式（Raster vs Vector）：MapTiler 的卫星地图是 Raster（栅格jpg/png） 格式，所以在前端配置时 type 必须指定为 "raster"，千万不要写成 "vector"。 [1, 5, 6] 

如果你需要了解如何在 Docker 环境下挂载这两个文件，或者如何配置 Nginx 转发，请随时告诉我！

[1] [https://maplibre.org](https://maplibre.org/martin/sources-mbtiles/)
[2] [https://www.youtube.com](https://www.youtube.com/watch?v=ijejfRcQI-I)
[3] [https://www.youtube.com](https://www.youtube.com/watch?v=ijejfRcQI-I)
[4] [https://maplibre.org](https://maplibre.org/martin/config-file/)
[5] [https://gis.stackexchange.com](https://gis.stackexchange.com/questions/478196/setting-up-maplibre-osm2pgsql-and-martin-tile-server)
[6] [https://maplibre.org](https://maplibre.org/martin/sources-tiles/)


# 7. 多数据源如何写style.json

```sh
~/nv/mapsrv/martin$> ./target/release/martin  /home/abner/a2/zdev/nv/map_data/world-bj
2026-08-10T16:45:13.028637Z  INFO martin: Starting Martin v1.13.0
2026-08-10T16:45:13.028652Z  INFO martin: Config file is not specified, auto-detecting sources
2026-08-10T16:45:13.029269Z  WARN martin::config::file::tiles::pmtiles: Defaulting `pmtiles.allow_http` to `true`. This is likely to become an error in the future for better security.
2026-08-10T16:45:13.029315Z  INFO resolve: martin::config::file::cache: Initializing PMTiles directory cache with maximum size 128 MB
2026-08-10T16:45:13.034286Z  INFO resolve:resolve_tile_sources: martin::config::file::file_config: Configured source source.id=satellite-2017-11-02_china_tianjin source.path=/mnt/a2disk/a2/zdev/nv/map_data/world-bj/satellite-2017-11-02_china_tianjin.mbtiles
2026-08-10T16:45:13.037289Z  INFO resolve:resolve_tile_sources: martin::config::file::file_config: Configured source source.id=maptiler-satellite-lowres source.path=/mnt/a2disk/a2/zdev/nv/map_data/world-bj/maptiler-satellite-lowres.mbtiles
2026-08-10T16:45:13.073654Z  INFO resolve:resolve_tile_sources: martin::config::file::file_config: Configured source source.id=satellite-2017-11-02_china_beijing source.path=/mnt/a2disk/a2/zdev/nv/map_data/world-bj/satellite-2017-11-02_china_beijing.mbtiles
```

```sh
~/nv/map_data$ curl http://localhost:3000/maptiler-satellite-lowres   
{"tilejson":"3.0.0","tiles":["http://localhost:3000/maptiler-satellite-lowres/{z}/{x}/{y}"],"attribution":"<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>","bounds":[-180.0,-85.051129,179.996547,85.051129],"maxzoom":6,"minzoom":0,"name":"Satellite Lowres v3","version":"1","color":"#FFFFFF","format":"jpg","generator":"MapTiler Data","profile":"mercator","scale":"2.000000"}
~/nv/map_data$ 
~/nv/map_data$ 
~/nv/map_data$ curl http://localhost:3000/satellite-2017-11-02_china_beijing
{"tilejson":"3.0.0","tiles":["http://localhost:3000/satellite-2017-11-02_china_beijing/{z}/{x}/{y}"],"attribution":"<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>","bounds":[115.686,39.414,117.119,40.426],"center":[116.4025,39.92,13],"description":"Region Beijing extract from https://openmaptiles.com","maxzoom":13,"minzoom":0,"name":"OpenMapTiles Satellite","version":"1.2","basename":"china_beijing.mbtiles","color":"#0C1C2B","format":"jpg","format_arguments":"-f jpeg -bg 12 28 43 ","generator":"MapTiler Pro 8.0","id":"openmaptiles_satellite","maskLevel":"5","profile":"mercator","scale":"1.000000"}
~/nv/map_data$ 
~/nv/map_data$ 
~/nv/map_data$ 
~/nv/map_data$ curl http://localhost:3000/satellite-2017-11-02_china_tianjin
{"tilejson":"3.0.0","tiles":["http://localhost:3000/satellite-2017-11-02_china_tianjin/{z}/{x}/{y}"],"attribution":"<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>","bounds":[116.528,38.378,118.531,39.779],"center":[117.52950000000001,39.078500000000005,13],"description":"Region Tianjin extract from https://openmaptiles.com","maxzoom":13,"minzoom":0,"name":"OpenMapTiles Satellite","version":"1.2","basename":"china_tianjin.mbtiles","color":"#0C1C2B","format":"jpg","format_arguments":"-f jpeg -bg 12 28 43 ","generator":"MapTiler Pro 8.0","id":"openmaptiles_satellite","maskLevel":"5","profile":"mercator","scale":"1.000000"}
```

如何写 style文件?

## 需求说明
三个栅格MBTiles：
> 1. `maptiler‑satellite‑lowres`：全球低分辨率卫星，**maxzoom=6**，负责0‑6级全局底图
> 2. `satellite‑2017‑11‑02_china_beijing`：北京卫星，**maxzoom=13**，bounds北京范围
> 3. `satellite‑2017‑11‑02_china_tianjin`：天津卫星，**maxzoom=13**，bounds天津范围

MapLibre‑GL 图层规则：
- 0‑6级：显示全球低分辨率卫星底图
- 7‑13级：北京区域切北京瓦片、天津区域切天津瓦片；超出两地仍回退到低分辨率底图
- 栅格 `tileSize:256`，图层按**从上往下渲染顺序**，zoom约束+bounds过滤实现多瓦片拼接。

> 保存为 `style.json`，放到 React `public/` 目录直接使用。

```json
{
  "version": 8,
  "name": "Beijing‑Tianjin Composite Satellite",
  "sources": {
    "sat‑lowres‑global": {
      "type": "raster",
      "tiles": ["http://localhost:3000/maptiler‑satellite‑lowres/{z}/{x}/{y}"],
      "attribution": "<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>",
      "bounds": [-180.0, -85.051129, 179.996547, 85.051129],
      "minzoom": 0,
      "maxzoom": 6,
      "tileSize": 256
    },
    "sat‑beijing": {
      "type": "raster",
      "tiles": ["http://localhost:3000/satellite‑2017‑11‑02_china_beijing/{z}/{x}/{y}"],
      "attribution": "<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>",
      "bounds": [115.686, 39.414, 117.119, 40.426],
      "minzoom": 7,
      "maxzoom": 13,
      "tileSize": 256
    },
    "sat‑tianjin": {
      "type": "raster",
      "tiles": ["http://localhost:3000/satellite‑2017‑11‑02_china_tianjin/{z}/{x}/{y}"],
      "attribution": "<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>",
      "bounds": [116.528, 38.378, 118.531, 39.779],
      "minzoom": 7,
      "maxzoom": 13,
      "tileSize": 256
    }
  },
  "layers": [
    {
      "id": "sat‑global‑bg",
      "type": "raster",
      "source": "sat‑lowres‑global",
      "minzoom": 0,
      "maxzoom": 6
    },
    {
      "id": "sat‑beijing‑layer",
      "type": "raster",
      "source": "sat‑beijing",
      "minzoom": 7,
      "maxzoom": 13
    },
    {
      "id": "sat‑tianjin‑layer",
      "type": "raster",
      "source": "sat‑tianjin",
      "minzoom": 7,
      "maxzoom": 13
    }
  ]
}
```

### React‑map‑gl 调用片段
```tsx
<Map
  mapLib={maplibreGl}
  mapStyle="/style.json"
  initialViewState={{
    longitude: 116.4025,
    latitude: 39.92,
    zoom: 8
  }}
/>
```

### 重要注意事项
1. **bounds 只是源元数据，MapLibre不会自动做空间裁剪**
   > 北京、天津有小部分地理重叠区域（廊坊交界），z7‑13 重叠位置两个瓦片会**叠加混合渲染**，出现透明度混叠。
   - 解决方案A：如果要严格地理裁剪，需要给图层加 `filter` 或者使用 `clip‑layer` 插件；
   - 解决方案B：预处理合并MBTiles，生成一个京津合并的mbtiles，这是生产环境最优。

2. zoom逻辑
   - z ≤6：只渲染全球低分辨率；
   - 7 ≤ z ≤13：北京范围加载北京瓦片，天津范围加载天津瓦片，其它地区**无瓦片空白**（因为global源maxzoom=6）。
   > 如果希望z>7非京津区域仍然看到全球底图，需要把 `sat‑lowres‑global` 的 `maxzoom` 改成13。但原始mbtiles只有到z6，高于z6会返回空白瓦片。

3. 瓦片格式是jpg，浏览器原生支持，无需额外配置。

### 调试技巧
- 浏览器F12‑Network，看瓦片请求URL，确认请求的是正确source id；
- 访问 `http://localhost:3000/<source‑id>` 查看每个source的tilejson是否正常。

如果你需要，我可以再给一版：**叠加矢量地名标签（道路/城市名）的完整style.json**。