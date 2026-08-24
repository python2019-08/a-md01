# 0. 瓦片服务选用结论
矢量瓦片服务 选用 martin 和 tegola,
光栅瓦片服务 选用 martin 和 mbtileserver 、 [versatiles-rs](https://github.com/versatiles-org/versatiles-rs.git)  

================================================================
# 1.Martin 提供 矢量  和 柵格（衛星） 服务，需要起两个martin服务吗

不需要啟動兩個 Martin 服務。您只需要啟動一個 Martin 服務，它就可以同時提供 PostGIS 矢量服務與 .mbtiles 衛星柵格服務。
Martin 的底層設計非常現代化。它在啟動時可以接收多個數據源參數，並在同一個端口（預設為 3000）下為不同的數據源生成各自的路由接口。
------------------------------
## 💻 統一啟動的命令行範例
您只需要在啟動 Martin 時，同時傳入 PostGIS 的連接字串以及衛星 .mbtiles 檔案的路徑即可。
## 範例一：直接在命令行傳參

# 啟動一個服務，同時加載資料庫（矢量）與本地文件（衛星）
martin postgres://postgres:password@localhost:5432/gis_db /path/to/your/satellite.mbtiles

## 範例二：使用配置文件（Config File，更推薦用於生產環境）
如果您的數據源很多，寫在命令行會很冗長。您可以寫一個 config.yaml 配置文件：

# config.yamlpostgres:
  - connection_string: 'postgres://postgres:password@localhost:5432/gis_db'
    # 這裡會自動加載資料庫內所有的幾何圖層
mbtiles:
  # 指定衛星地圖 mbtiles 的路徑，並給它一個識別 ID
  satellite_base: /path/to/your/satellite.mbtiles

然後用這個配置文件啟動 Martin：

martin --config config.yaml

------------------------------
## 🌐 啟動後的 API 接口路由結構
一個 Martin 服務啟動後，它會自動為您區分矢量與柵格的 URL：

   1. 元數據接口 (TileJSON)：
   * 資料庫矢量圖層：http://localhost:3000/rpc.your_function 或 http://localhost:3000/table.your_table
      * 衛星柵格圖層：http://localhost:3000/satellite_base
   2. 地圖瓦片接口 (Tiles URL)：
   * 資料庫矢量：http://localhost:3000/table.your_table/{z}/{x}/{y}.pbf
      * 衛星柵格：http://localhost:3000/satellite_base/{z}/{x}/{y}.webp（或 .png/.jpg，取決於您的 mbtiles 內部格式）
   
------------------------------
## 🛠️ 在 Mapbox GL JS 中如何同時調用？
在前端代碼中，您同樣只需要指向這同一個 Martin 服務器，分別添加兩個 source 和 layer 即可：

map.on('load', () => {
    // 1. 接入 Martin 提供的衛星柵格底圖
    map.addSource('martin-satellite', {
        'type': 'raster',
        'url': 'http://localhost:3000/satellite_base' // 直接讀取 Martin 的 TileJSON
    });
    map.addLayer({
        'id': 'satellite-layer',
        'type': 'raster',
        'source': 'martin-satellite'
    });

    // 2. 接入 Martin 提供的 PostGIS 業務矢量圖層（例如管線、邊界）
    map.addSource('martin-vector-business', {
        'type': 'vector',
        'url': 'http://localhost:3000/table.your_table' 
    });
    map.addLayer({
        'id': 'business-layer',
        'type': 'line', // 或 fill, circle
        'source': 'martin-vector-business',
        'source-layer': 'your_table', // PostGIS 表名
        'paint': { 'line-color': '#ff0000', 'line-width': 2 }
    });
});

------------------------------
## 💡 這樣架構的額外好處

* 免去跨域問題（CORS）：因為矢量與柵格都在同一個域名和端口下（例如 localhost:3000），前端調用時不會觸發瀏覽器的跨域限制。
* 極致的資源節約：Rust 的異步網絡框架（Actix-web）非常強大，這兩種服務共享同一個進程核心，高併發下基本只取決於您硬碟讀取 .mbtiles 的速度與資料庫的查詢效能，伺服器本身的記憶體佔用極低。

您目前準備使用的配置環境中，PostGIS 資料庫與衛星 .mbtiles 檔案是放在同一台伺服器上嗎？如果有任何配置上的疑問，我可以幫您檢查 yaml 文件的寫法。

================================================================
# 2.一个 Martin 同时提供 矢量 和 柵格（衛星） 服务，且只采用 mbtiles 文件，啟動的命令行如何写
<!-- douyin-doubao-ai -->
Gemini 的说法**半对，有容易误导人的关键点**：

> ✅ Martin **确实可以读取栅格 mbtiles（png/jpeg卫星瓦片）**，它不校验瓦片内容，mbtiles 里存什么二进制，就原样返回什么二进制，**不限制必须是pbf矢量瓦片**。
> ❗ 但它**不会做任何图像解码、图像转换、不读GeoTIFF原始文件**，只负责把 mbtiles 内部已经切好的瓦片字节流吐出去。它不能直接喂 `.tif`，必须预先用 gdal2tiles/maptiler 把 GeoTIFF 切片打包成栅格 mbtiles。

### 单进程同时加载【矢量mbtiles + 卫星栅格mbtiles】命令行
把两个 mbtiles 直接传给 martin，一个进程同时对外提供两套瓦片源：
```bash
martin ./vector_data.mbtiles ./satellite_raster.mbtiles --port 3000
```

目录方式（目录下所有mbtiles自动加载）
```bash
martin ./data_dir --port 3000
```
```
data_dir/
├─ vector_data.mbtiles    # pbf矢量瓦片
└─ satellite_raster.mbtiles # png/jpeg卫星栅格mbtiles
```

访问地址：
- 矢量瓦片：`http://127.0.0.1:3000/vector_data/{z}/{x}/{y}.pbf`
- 卫星栅格瓦片：`http://127.0.0.1:3000/satellite_raster/{z}/{x}/{y}.png`
- 每个数据源自带 TileJSON：`http://127.0.0.1:3000/satellite_raster.json`

### Maplibre‑GL JS 前端配置片段
```javascript
// 矢量源
map.addSource('vec-src', {
  type: 'vector',
  url: 'http://127.0.0.1:3000/vector_data.json'
});
// 卫星栅格源
map.addSource('sat-src', {
  type: 'raster',
  url: 'http://127.0.0.1:3000/satellite_raster.json'
});

// 先加卫星底图，再叠道路等矢量图层
map.addLayer({id:'sat', type:'raster', source:'sat-src'}, 'some-vector-layer-id');
```

### 重要边界（踩坑点）
1. Martin **不生成栅格瓦片**，你必须提前外部工具把 GeoTIFF → 栅格 mbtiles；直接丢 GeoTIFF 文件给 Martin，直接报错。
2. 栅格 mbtiles 的瓦片坐标系必须是 **TMS**（mbtiles标准内部y轴向下），Martin会自动做 XYZ/Y反转转换，对外输出标准XYZ接口，前端不用处理y翻转。
3. 对比 TileServer‑GL：
    - Martin：Rust，性能高，内存低；**只转发已经切好的瓦片二进制**，没有内置GDAL，不能直接读GeoTIFF。
    - TileServer‑GL(NodeJS)：可以直接读GeoTIFF在线切片，CPU开销更大。
4. 如果你还要叠加 PostGIS，命令可以混合数据库url + mbtiles：
```bash
martin postgresql://user:pwd@localhost/db ./vector_data.mbtiles ./satellite_raster.mbtiles --port 3000
```

### 澄清之前我的旧回答的错误
我之前的认知有偏差，误以为 Martin 只接受 vector mbtiles；实际代码层面，Martin 的 mbtiles 驱动**不校验瓦片内容格式**，mbtiles里存png/jpeg也可以直接对外输出，这是v1.0之后稳定具备的能力。

> 但是网络上很多中文教程依然写“Martin只支持矢量”，是早期版本（0.7及更早）的认知残留。

如果你需要，我可以给一份完整的 `martin.yaml` 配置文件示例，方便生产环境使用。

===============================================
# 3. Martin 提供 矢量  和 柵格（衛星） 服务 的martin.yaml 配置文件示例

<!-- googleAI- -->
太感謝您的深度補充與精確指正了！這段補充完全擊中了 Martin 核心驅動的底層本質（只做二進制字節流的 KV 轉發，不校驗/不解碼內容物），並且精準指出了網絡上大量舊版教程（如 0.7 以前版本）的認知殘留。
您提供的這套「單進程同時加載」與「目錄自動掃描」的解決方案，正是目前利用 Martin 實現極致效能的最佳實踐。
------------------------------
## 🛠️ 生產環境推薦：martin.yaml 完整配置文件示例
為了讓您的這套架構在生產環境中更安全、更好維護（避免命令行過長或參數遺漏），建議使用 YAML 配置文件 來啟動。以下為您整理一份結合了「PostGIS 數據庫 + 矢量 mbtiles + 衛星柵格 mbtiles」的完美配置範例：

# martin.yaml
# 1. 基礎網絡配置keep_alive: 75listen_addresses: '0.0.0.0:3000' # 監聽所有網卡worker_processes: 4              # 依據 CPU 核心數調整
# 2. 加載本地 MBTiles 文件（同時支持矢量與柵格）mbtiles:
  # 方案 A：手動指定並重命名 ID（推薦，URL 路徑更漂亮）
  vector_biz:
    path: /var/mapdata/vector_data.mbtiles
  satellite_base:
    path: /var/mapdata/satellite_raster.mbtiles

  # 方案 B：也可以直接指定整個目錄自動加載（會以檔名作為 ID）
  # sources:
  #   - /var/mapdata/
# 3. 如果未來需要動態疊加 PostGIS 數據庫（可選，不需使用可直接刪除本段）postgres:
  - connection_string: 'postgresql://user:pwd@localhost:5432/gis_db'
    # 默認會加載所有帶 geometry 欄位的表，也可以在這裡精細化控制 auto_publish
# 4. 全局跨域與安全配置cors_origin: "*" # 允許前端跨域調用

啟動指令極簡化：

martin --config ./martin.yaml

------------------------------
## ⚠️ 補充兩個您提到「TMS 坐標系轉換」與「MIME Type」的實戰細節：
> 
>    1. 瓦片格式與 Content-Type 的自動識別：
>    Martin 讀取 satellite_raster.mbtiles 時，會去讀取該 mbtiles 內部 metadata 表中的 format 字段（如 png、jpg 或 webp）。當前端請求瓦片時，Martin 會自動在 HTTP Header 中返回正確的 Content-Type: image/png。因此，在打包 mbtiles 時，確保元數據中的 format 正確非常重要。
>    
>    2. TMS 轉 XYZ 的 Y 軸翻轉：
>    標準的 mbtiles 內部瓦片是 TMS（左下角為原點），而 Mapbox/Maplibre 默認是 XYZ（左上角為原點）。誠如您所言，Martin 內部會自動處理這個 $y = 2^z - 1 - y$ 的翻轉邏輯。前端調用 Martin 的 TileJSON（.../satellite_base.json）時，Martin 返回的 tiles 網址本身就是標準的 XYZ 結構，前端完全不需要加上 scheme: 'tms'，開箱即用。
> 

這套 Rust 架構（Martin）相比於 NodeJS 架構（TileServer-GL），在高併發下的內存和 CPU 損耗幾乎可以忽略不計，非常不浪費伺服器資源。
如果您的衛星 GeoTIFF 還沒有切片，需要我提供如何使用 gdal2tiles 命令行將 .tif 完美切片並打包成 Martin 可讀的 柵格 .mbtiles 的標準指令嗎？


