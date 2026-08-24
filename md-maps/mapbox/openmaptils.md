# 1.OpenMapTiles 


https://github.com/openmaptiles/openmaptiles


OpenMapTiles is an extensible and open vector tile schema for a OpenStreetMap basemap. It is used to generate vector tiles for openmaptiles.org and openmaptiles.com.
We encourage you to collaborate, reuse and adapt existing layers and add your own layers or use our approach for your own vector tile project. The repository is built on top of the openmaptiles/tools to simplify vector tile creation.
🔗 Docs http://openmaptiles.org/docs
🔗 Schema: http://openmaptiles.org/schema
🔗 Production package: http://openmaptiles.com/

Styles
You can start from several GL styles supporting the OpenMapTiles vector schema.
🔗 Learn how to create Mapbox GL styles with Maputnik and OpenMapTiles.
OSM Bright
Positron
Dark Matter
Klokantech Basic
Klokantech 3D
Fiord Color
Toner

We also ported over our favorite old raster styles (TM2).
🔗 Learn how to create TM2 styles with Mapbox Studio Classic and OpenMapTiles.
Light
Dark
OSM Bright
Pencil
Woodcut
Pirates
Wheatpaste


Schema
OpenMapTiles consists out of a collection of documented and self contained layers you can modify and adapt. Together the layers make up the OpenMapTiles tileset.
🔗 Study the vector tile schema
aeroway
boundary
building
housenumber
landcover
landuse
mountain_peak
park
place
poi
transportation
transportation_name
water
water_name
waterway


Develop
To work on OpenMapTiles you need Docker and Python.
Install Docker. Minimum version is 1.12.3+.
Install Docker Compose. Minimum version is 1.7.1+.
Install OpenMapTiles tools with pip install openmaptiles-tools


Build
Build the tileset.
git clone git@github.com:openmaptiles/openmaptiles.git
cd openmaptiles
# Build the imposm mapping, the tm2source project and collect all SQL scripts
make
# You can also run the build process inside a Docker container
docker run -v $(pwd):/tileset openmaptiles/openmaptiles-tools make
You can execute the following manual steps (for better understanding) or use the provided quickstart.sh script.
./quickstart.sh



Prepare the Database
Now start up the database container.
docker-compose up -d postgres
Import external data from OpenStreetMapData, Natural Earth and OpenStreetMap Lake Labels.
docker-compose run import-water
docker-compose run import-natural-earth
docker-compose run import-lakelines
docker-compose run import-osmborder
Download OpenStreetMap data extracts and store the PBF file in the ./data directory.
cd data
wget http://download.geofabrik.de/europe/albania-latest.osm.pbf
Import OpenStreetMap data with the mapping rules from build/mapping.yaml (which has been created by make).
docker-compose run import-osm


Work on Layers
Each time you modify layer SQL code run make and docker-compose run import-sql.
make clean && make && docker-compose run import-sql

Now you are ready to generate the vector tiles. Using environment variables you can limit the bounding box and zoom levels of what you want to generate (docker-compose.yml).
docker-compose run generate-vectortiles




License
All code in this repository is under the BSD license and the cartography decisions encoded in the schema and SQL are licensed under CC-BY.
Products or services using maps derived from OpenMapTiles schema need to visibly credit "OpenMapTiles.org" or reference "OpenMapTiles" with a link to http://openmaptiles.org/. Exceptions to attribution requirement can be granted on request.
For a browsable electronic map based on OpenMapTiles and OpenStreetMap data, the credit should appear in the corner of the map. For example:
© OpenMapTiles © OpenStreetMap contributors
For printed and static maps a similar attribution should be made in a textual description near the image, in the same fashion as if you cite a photograph.
===============================================
# 2. MapTiler 的服務是免费开源的吗？
<!-- googleAI -->
MapTiler 的服務本身並非完全免費或開源，它是一家商業公司，採取的是「免費點數額度（Free Tier）+ 商業收費（Paid）」的模式。 [1, 2] 
它的核心產品線大多是閉源的商業軟體或雲端服務，但它深度擁抱開源生態，並且發起或維護了數個極為著名的開源地圖項目。 [2, 3] 
------------------------------
## 一、 產品線的免費與開源狀況

| 產品名稱 | 是否免費？ | 是否開源？ | 核心限制 / 說明 |
|---|---|---|---|
| MapTiler Cloud (雲端地圖 API) | 有免費額度 (每月約 10 萬次地圖檢視) | ❌ 閉源 (商業雲端基礎設施) | 僅限個人或非商業評估。超過額度或用於特定商業用途需付費。 |
| MapTiler Server (私有化地圖服務器) | 有免費版 (限制 100 個月活躍用戶) | ❌ 閉源 (商業軟體) | 免費版有限制商業使用，且不支援高階叢集部署。 |
| MapTiler Engine (前身為 MapTiler Desktop 切片工具) | 有免費版 (會印上浮水印) | ❌ 閉源 (商業桌面軟體) | 免費版可用於測試，但輸出的地圖會有 MapTiler 的浮水印，需購買 Pro 版解鎖。 |

------------------------------
## 二、 MapTiler 旗下著名的「完全開源且免費」項目
雖然它的主體軟體收費，但 MapTiler 團隊開發並開源了許多 WebGIS 界不可或缺的開源神器，這也是為什麼很多人會誤以為它是開源軟體的原因： [3] 

   1. OpenMapTiles：
   * 狀態：[完全開源 (GitHub)](https://github.com/openmaptiles/openmaptiles)。
      * 說明：這是一套將 OpenStreetMap (OSM) 數據轉換為矢量地圖切片的工具與 Schema 規範。你可以下載它的源碼，自己在家免費編譯、生成全世界的矢量地圖切片。 [1, 4] 
   2. TileServer-GL：
   * 狀態：[完全開源 (GitHub)](https://github.com/maptiler/tileserver-gl)。
      * 說明：這是一款極其輕量、基於 Node.js 的地圖瓦片服務器。它可以讀取 .mbtiles 檔案（不論是矢量還是衛星柵格），並發布為 Mapbox 兼容的服務。這是 MapTiler Server 的開源免費替代品。
   3. MapLibre GL JS：
   * 狀態：完全開源。
      * 說明：在 Mapbox GL JS 宣布閉源收費後，MapTiler 作為主要發起者之一，聯合其他廠商 fork 並維護了這個完全免費開源的地圖前端渲染引擎。 [3] 
   
------------------------------
## 💡 給您的替代方案建議
如果您在尋找完全免費、無限制、且 100% 開源的衛星地圖發布解決方案（不想被 MapTiler 的商業授權綁定），建議使用以下開源組合：

* 
* 切片工具：使用開源的 gdal2tiles (Python 腳本) 替代 MapTiler Engine，將您的衛星 .tif 圖片切碎。
* 服務器端：使用開源的 TileServer-GL（MapTiler 的開源版）或者直接用 Nginx 託管切片文件夾，即可產出完全免費的衛星地圖服務給 Mapbox 調用。
* 

您目前正在評估的項目是屬於個人練習、公司內部系統、還是公開的商業產品？我可以依據您的應用場景為您精確判斷是否會觸及 MapTiler 的付費紅線。

[1] [https://www.reddit.com](https://www.reddit.com/r/openstreetmap/comments/1ak6zjq/is_openmaptiles_free_or_not_i_do_not_understand/)
[2] [https://europeanpurpose.com](https://europeanpurpose.com/tool/maptiler)
[3] [https://www.maptiler.com](https://www.maptiler.com/open-source/)
[4] https://openmaptiles.org
