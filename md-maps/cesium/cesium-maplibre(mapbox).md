# 1.cesium 和 maplibre(mapbox) 比较
<!-- douyin-doubao-ai -->
 # CesiumJS vs MapLibre‑GL JS（结合你现有技术栈：tilemaker、Martin、mbtiles/pmtiles、OSRM、内网园区/全国GIS）
> MapLibre 是 Mapbox‑GL‑JS 的开源分支，**完全去掉Mapbox厂商锁，BSD协议，内网私有化部署友好**；CesiumJS Apache‑2.0协议，开源，Ion云服务是商业可选，库本体完全开源免费。

## 核心本质差异
1. **MapLibre‑GL JS：平面地图优先，附带有限3D能力**
底层是**平面墨卡托投影**；可以倾斜、俯仰、建筑拉伸挤出；支持地球模式，但不是真正的椭球地球，适合二维矢量瓦片MVT为主的业务系统。
原生深度适配：`mbtiles / pmtiles / MVT矢量瓦片`，也就是你tilemaker输出的瓦片，**style.json样式体系完整强大**，标签、道路、POI渲染效果一流。

2. **CesiumJS：真正椭球3D地球引擎**
以WGS84椭球为核心；原生面向**全球三维、地形、3D‑Tiles、点云、模型、时序动态仿真（CZML）**；适合数字孪生、大场景三维仿真、飞行器轨迹、真实地形高程。
> ⚠️Cesium**没有原生MVT矢量瓦片渲染**，加载tilemaker产出的mvt/mbtiles需要第三方插件，会有性能、标签扭曲问题，这是最大痛点。

## 详细对比表
|对比维度|MapLibre‑GL JS|CesiumJS|
|---|---|---|
|核心投影|Web墨卡托（3857），可选地球模式|WGS84椭球（4326）真实地球球面|
|原生数据格式|MVT矢量瓦片、pmtiles/mbtiles、GeoJSON、raster‑dem地形|3D‑Tiles、CZML时序、glTF模型、影像栅格、quantized‑mesh地形；MVT需要第三方插件|
|样式系统|**Mapbox Style JSON，生态极强**，表达式、sprite精灵图，直接复用tilemaker输出瓦片，配合Martin瓦片服务开箱即用|没有原生矢量样式规范；矢量瓦片靠社区插件，样式开发成本高，标签在地形上容易扭曲变形|
|3D能力|建筑2D面挤出为伪3D；地形栅格叠加；不支持大规模三维模型、点云流式加载|原生3D‑Tiles流式LOD，海量城市模型、点云、倾斜摄影；真实球面地形；支持宇宙视角、飞行仿真、时间动画CZML|
|包体积|~300‑400KB|~700‑1000KB，体积更大，初始化开销更高|
|交互习惯|互联网地图习惯：左键拖拽、右键俯仰，符合普通用户直觉|三维引擎习惯；可自定义相机控制器，但默认操作对普通用户不友好|
|协议|BSD，商业修改分发无负担|Apache‑2.0，商业友好；Ion云服务可选付费，库本身免费|
|适配你的流水线|tilemaker/martin输出mbtiles/pmtiles直接接入，style.json直接写，**内网项目首选二维底图**|tilemaker的矢量瓦片只能转栅格图片给Cesium，矢量渲染要额外插件；适合叠加倾斜摄影、BIM模型场景|
|性能|**MVT矢量瓦片渲染性能优秀，标签流畅**；大GeoJSON性能一般|3D‑Tiles海量三维数据性能优秀；原生矢量瓦片性能弱于MapLibre|

## 针对你的项目（园区/全国，tilemaker + Martin + OSRM）怎么选
### ✅优先选 MapLibre‑GL JS，当下面场景：
1. **主体业务是二维地图，道路规划，OSRM路径规划展示，园区路网、POI、建筑面；使用tilemaker输出mbtiles/pmtiles矢量瓦片，Martin做瓦片服务**。
2. 需要精细地图样式：道路颜色、宽度、标签、sprite图标，大量使用style.json。
3. 普通业务系统，面向普通操作人员，不需要倾斜摄影、BIM、海量点云。
4. 内网私有化，完全复用整套你已经搭好的tilemaker‑Martin‑OSRM链路，几乎没有额外改造。

> 可以做：建筑挤出3D效果、叠加dem地形，但不适合大规模三维实景。

### ✅优先选 CesiumJS，当下面场景：
1. 项目需要**倾斜摄影、BIM模型、城市三维模型、点云、真实地形高程、飞行轨迹仿真、数字孪生**。
2. 必须球面真实地球，做全球大范围三维可视化。

> 代价：
> tilemaker输出的MVT矢量瓦片，不能原生渲染；要么把矢量瓦片在服务端预渲染成png栅格瓦片给Cesium，要么引入第三方MVT插件，会增加开发工作量、存在标签拉伸问题。
> 你的style.json不能直接复用，需要重新写图层样式逻辑。

## 混合架构（部分项目会这么做）
- 二维浏览、路径规划：MapLibre‑GL JS，复用整套瓦片流水线。
- 切换三维孪生模式：打开Cesium页面，加载3D‑Tiles实景模型；二维底图使用服务端渲染好的栅格瓦片。
> 不建议直接在Cesium内部强行跑MVT矢量瓦片做业务底图，生产环境坑较多。

## 简短决策口诀
- **主要用tilemaker/martin输出矢量瓦片、OSRM路径规划、园区/全国二维业务地图 → MapLibre‑GL JS（省心，完全适配你的现有工具链）**
- **有倾斜摄影、BIM、点云、大规模三维数字孪生需求 → CesiumJS**

## 补充现实坑
1. Cesium第三方MVT插件（cesium‑vectortile‑gl等）属于社区项目，不是官方维护，版本升级会有兼容性风险，生产环境要评估维护成本。
2. MapLibre也支持地球模式、地形、建筑挤出，但这是**墨卡托投影模拟效果，不是真实椭球面**，大范围高纬度会有几何畸变，园区、国内业务几乎感知不到。
3. 两者都可以完全内网部署，不需要调用任何外网服务。

如果你需要，我可以给一份极简示例：MapLibre加载Martin提供pmtiles矢量瓦片，同时叠加OSRM路径规划结果的前端最小demo。

