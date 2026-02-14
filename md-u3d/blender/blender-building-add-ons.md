免费纹理资源 https://texture.ninja/textures/Brick/1

# 1.blender最全的城市建筑插件测评
2025-03-09 15:09:33
https://www.bilibili.com/video/BV1iHRbYXEQL/?spm_id_from=333.337.search-card.all.click&vd_source=4212b105520112daf65694a1e5944e23
最全的blender城市建筑插件测评，大家对哪个插件最感兴趣，留言评论呦~
仙仙的Blender3D辅助私人小窝 (企鹅群)：664662577


## 1-整体城市道路规划
###  1.iCity （收费软件）
     
###  2.The Tity Generator （收费软件）

###  3.BlendGis
    导入的是白模，需要自己贴图。
```sh
$ git clone https://github.com/domlysz/BlenderGIS.git
```
###  4.Blosm For Blend/Blend-Osm
Blosm for Blender: Google 3D cities, OpenStreetMap, terrain。
```sh
https://github.com/vvoovv/blosm
```
Terrain import is now a part of the blender-osm addon. Get it for free at https://gumroad.com/l/blender-osm

###  5.Maps Models Importer
 安装麻烦，使用简单。
```sh
 
```

## 2-单独建筑
###  2.1.Procedural Alleys 
付费
    Procedural Alleys 是 Blender 上小巷生成的最佳工具，专注狭窄街巷、后巷、曲线巷，一键生成、氛围拉满、细节丰富，适合快速制作亚洲风格小巷场景。
>     若你需要大型城市，选 Ultimate City；
>     若需要免费 + 定制，选 Buildify；
>     若需要小巷 + 氛围，选 Procedural Alleys。     

    维度 | Procedural Alleys | Buildify | Ultimate City
    ---|-------------------|----------|--------------
    价格 | $18（付费）       | 免费      | $40–$60（付费）
    核心 | 小巷 / 街巷生成    | 建筑 / 街区生成 | 完整城市生成
    场景 | 狭窄街巷、后巷、曲线巷 | 单栋 / 街区建筑 | 完整城市（建筑 + 路网 + 交通）
    资产 | 小巷专用资产（800MB+） | 无内置资产，纯节点 | 250+ 城市资产
    定制 | 中（参数 + 资产替换） | 高（纯节点） | 中（资产替换）
    上手 | 低（面板操作） | 中（需节点基础） | 低（面板操作）
    版本 | 3.4–4.2      | 3.2+          | 2.8–3.2（4.0+ 一般）
    适合 | 小巷 / 后巷 / 曲线巷场景 | 建筑单体、真实数据城市 | 快速完整城市

###  2.2.Building Nodes
免费、开源
   快速，欧式风格。
   Building Nodes（BuildingNodes） 是 Blender 上一款**免费、开源**、几何节点驱动的程序化建筑生成插件，主打极简节点、面板式建筑逻辑、实时编辑，适合快速制作规则化楼房与街区。

    全称：BuildingNodes（简称 Building Nodes）
    作者：Durman（GitHub 开源）
    价格：完全免费
    版本：v1.0+（适配 Blender 3.2–4.2）
    定位：面板式程序化建筑生成（类似预制板搭楼）
    技术：基于 Geometry Nodes，极简节点逻辑，无需复杂数学

编辑与导出
> **可编辑**：生成后为普通网格，可手动修改、加细节、换材质
> **导出友好**：低模优化，一键导出 FBX/OBJ 到 Unity/Unreal
> **风格复用**：一套风格可应用到任意基础网格，批量生成建筑群


###  2.3.UItimate City Addon
付费
    城市配套资产多，如交通灯、交通道、交通控制设备、石块等。

    作者 / 平台：Blender Market 付费插件
    版本：v1.1（适配 Blender 2.8–3.2，对 4.0+ 兼容性一般）
    定位：资产库 + 程序化生成的一站式城市制作工具    

###  2.4.Buildit-Auto Generate Buildings
付费
   付费、模块化、一键式建筑生成插件，主打快速批量生成城市楼房，适合游戏、影视、可视化中的背景建筑与街区快速搭建。

版本：v1.0（2023-07）
适配：Blender 3.5+（含 4.0+）
定位：模块化建筑生成器，以预制模块快速组合生成楼房
技术：基于 Blender 内置模块系统，**非几何节点，生成后可直接编辑**

###  2.5.Buildify
免费、开源
    随意编辑建筑形状，和Blend-Osm配合使用，非常方便。
    下载地址  https://paveloliva.gumroad.com/l/buildify

    Buildify 如何使用
    Buildify 是一个基于 几何节点 (Geometry Nodes) 的 Blender 工具，它可以让你通过简单的网格操作（如挤出、缩放）快速生成程序化的建筑。 
    对于最新的 Blender 4.4，由于它完全支持几何节点系统，你可以按照以下步骤使用：

    1. 安装与导入
    Buildify 本质上是一个包含几何节点预设的 .blend 文件，而不是传统的插件。 
    下载文件：从 Pavel Oliva 的 Gumroad 下载 Buildify 的最新版本（建议下载专门针对 Blender 4.x 优化的版本，如果可用）。
    追加 (Append)：在你的 Blender 4.4 工程中，点击 File > Append，定位到下载的 Buildify.blend 文件，进入 NodeTree 文件夹，选择其中的几何节点组并追加到当前文件。 

    2. 基本使用步骤
    创建底稿：在场景中新建一个平面（Plane）或简单的多边形网格。
    添加修改器：
    选中该网格，在 修改器属性 (Modifier Properties) 选项卡中点击 Add Modifier。
    选择 Geometry Nodes，并在下拉菜单中指定刚才追加的 Buildify 节点。
    编辑生成：进入编辑模式 (Edit Mode)，通过 E 键挤出 (Extrude) 边或面，或者移动顶点，建筑会自动根据你的网格轮廓实时生成楼层、窗户和屋顶。 

    3. 自定义与优化 (针对 8GB 显存)
    由于你使用的是 RTX 3060 Ti，在大规模城市生成时需注意：
    模块替换：Buildify 使用集合（Collections）来存放模块（如窗户、门、墙）。你可以创建自己的低多边形模块放进对应的集合中，以减少渲染压力。
    限制实例：在几何节点面板中，可以调整“楼层高度”或“每层模块数量”，避免瞬间生成数百万个高精度面片导致显存溢出。
    Blosm 联动：如果你想生成现实世界的街道，可以将 Buildify 与 Blosm 插件 结合使用。Blosm 负责抓取地图数据，Buildify 负责将这些数据转化为 3D 建筑。 
    4. 4.4 版本注意事项
    原理化 BSDF 升级：由于 Blender 4.0 之后材质节点有重大变动，如果发现追加过来的建筑材质发黑或粉红，请在 Shader 编辑器中重新连接 Principled BSDF 节点的贴图接口。
    应用修改器：如果你需要将生成的建筑导出到其他软件，记得点击修改器上的箭头并选择 Apply，将其转换为真正的网格模型。 


###  2.6. Auto-Building
付费
    建筑类型丰富，主要是中世纪建筑。
    付费、几何节点驱动、面板式的程序化建筑生成插件，主打面 / 边缘资产散射、自动布尔开孔、屋顶 / 立柱 / 基础一体化生成，适合快速制作细节丰富、风格多样的单体建筑与街区。

## 3-几何节点文件
###  3.1.Abandoned City Generator - Geometry Nodes
    程序化生成 abandoned city 城市模型。
###  3.2.Villagen 
    欧洲城堡风格，自由画线，非常好用。

###  3.3.Castle generator setup for Geometrynodes Fields

###  3.4.Cottage Generator Setup for Geometrynodes
    乡村小木屋风格的建筑。  

## 4-资产库类型    
###  4.1.Procedural Building Generator 2
付费（约 $45–$55，含基础预设包）
    资产库类型，包含多种风格建筑模型。
###  4.2.Night And Day - Procedural City Buildings
付费、几何节点驱动、昼夜一体化的程序化城市建筑插件，主打一键生成带日夜切换的低模城市建筑群，内置海量建筑 / 道路资产与视差映射窗户照明，
适配：Blender 4.0+（稳定支持 4.1–4.2）
    包含白天和黑夜两种风格的建筑资产库。
###  4.3.Medieval City Generator
    中世纪风格建筑资产库。包含城堡建筑、城堡门、城堡门廊、城堡门廊门等。
低价位、几何节点驱动、曲线绘制式的中世纪城市生成工具，主打快速绘制街区、低模高效、资产复用，适合快速搭建中世纪 / 奇幻风格的城镇、村庄与城堡场景。
## 5-辅助插件
免费、开源
   Building Tools    

================================================
# 2.Maps Models Importer 如何下载安装

Maps Models Importer 是一款强大的开源插件，用于将 Google Maps 的 3D 城市模型截取并导入 Blender。该插件高度依赖特定版本的软件协同工作，主要流程如下： 
### 1. 下载地址
插件下载： 前往 GitHub - MapsModelsImporter Releases 下载最新版的 .zip 文件。
注意： 必须下载 Release 页面下的 .zip 包，直接从 GitHub 首页点击“Download ZIP”下载的源码包通常无法直接安装。
核心配套工具 (RenderDoc)： 前往 RenderDoc 官网 下载安装。
关键限制： 插件对版本要求极严。例如最新版本插件（v0.7.0）要求使用 RenderDoc 1.31（不要使用更新版本）和 Blender 4.1。 

### 2. 安装步骤
安装插件：
启动 Blender，点击 Edit > Preferences > Add-ons。
点击 Install...，选中下载的 MapsModelsImporter.zip 文件并点击安装。
在插件列表中勾选启用 Import-Export: Maps Models Importer。
配置环境：
你需要创建一个特殊的 Chrome 浏览器快捷方式，在“目标”栏参数后添加 --disable-gpu-sandbox --gpu-startup-dialog 等命令。
这步操作是为了让 RenderDoc 能够成功“注入”浏览器的显卡进程，抓取 3D 数据。 

### 3. 使用技巧与常见问题
操作逻辑： 使用 RenderDoc 注入浏览器后，在 Google Maps 卫星视图下移动视角并按下 Print Screen 进行抓取，保存为 .rdc 文件。
导入模型： 在 Blender 中选择 File > Import > Google Maps Capture (.rdc) 导入。
黑白显示： 刚导入的模型可能是黑白的。你需要将 3D 视图的着色模式切换为 Material Preview（材质预览） 或 Rendered（渲染） 才能看到纹理。
系统限制： 由于技术限制，该插件目前仅支持 Windows 系统，无法在 Linux 或 macOS 上运行。 

### 避坑指南：
如果你正在处理周总的路面建模项目，请注意该插件抓取的模型通常由极其零碎的三角面组成，且 UV 坐标非常杂乱。如果你需要将此模型作为研究生课题的对照组，建议在导入后配合前文提到的 Decimate（精简） 修改器进行优化。


===============================================================

# 3.blender 如何使用skp
在 Blender 中使用 .skp (SketchUp) 文件，主要有以下三種路徑。由於 Blender 原生不支持 .skp，你必須依賴插件或中間格式。

1. 使用免費插件：SketchUp Importer (最推薦)
這是目前社群最常用的開源方案，支持直接導入 .skp 文件。

下載地址：前往 GitHub - SketchUp Importer 下載最新版的 .zip。
            https://github.com/martijnberger/sketchup_importer.git
            
安裝：Edit > Preferences > Add-ons > Install，選中 zip 並勾選啟用。

優點：保留組件（Component）層級，材質映射相對準確。
注意：它對 SketchUp 版本有要求，若報錯，請先將 SKP 文件另存為 2017 或更早版本。

===============================================================
# 4.Blender 如何导出 3DTiles
在 Blender 中直接导出 3DTiles（倾斜摄影和数字孪生标准格式）是一项进阶操作，因为 Blender 原生并不支持这种分层分块的格式。

要实现导出，需依赖第三方插件或外部转化工具，以下是针对「路面建模」课题最可行的路径：

## x.1. 推荐方案：使用 Blender-3dtiles 插件
这是目前最直接的开源方案，适合将 Blender 中的 Mesh 转化为 3DTiles 格式（B3DM）。
- 下载路径：GitHub - cityvis/blender-3dtiles
- 安装：下载 .zip 包后，在 Blender 中通过 **Edit > Preferences > Add-ons > Install** 安装
- 导出逻辑：根据 Blender 中的物体层级自动生成 tileset.json 索引文件
- 优势：操作简单，适合导出10米的路面模型

## x.2. 专业方案：Blender -> glTF -> 3DTiles
如果插件兼容性出问题，行业标准做法是利用 glTF 作为中间桥梁：
### Blender 导出
将模型导出为 .glb 格式（确保勾选 **Apply Modifiers** 和 **Include Textures**）。

### 外部转化工具
- Cesium ion：将 .glb 上传到 Cesium 云端，自动切片成 3DTiles 并提供加载链接
- 3d-tiles-tools：Cesium 官方提供的命令行工具，适合需要全自动化处理的 Python 开发者
- loaders.gl：强大的 JS/Python 库，适合在方案一中集成

## 3. 针对周总项目与研究生课题的重点建议
1. **地理坐标（CRS）**：3DTiles 是带地理坐标的。Blender 的原点是 (0,0,0)，导出 3DTiles 时，必须在插件设置中填入正确的**经纬度（WGS84）**，否则模型会漂浮在地球中心。
2. **批量分块（LOD）**：如果路面模型面数极高，3DTiles 的优势在于分级加载；若仅为10米路段，导出为一个单一的 B3DM 瓦片即可。
3. **性能优化**：导出前务必检查贴图大小（建议不超过 2K），并使用 Mesh Optimizer 进行减面，否则在 Unity 或 Web 端加载 3DTiles 会非常卡顿。