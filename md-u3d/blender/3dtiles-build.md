# ch0.开源 3D Tiles 切片与生成工具
<!-- google AI -->
除了 Cesium 官方的 3d-tiles-tools 之外，社区中还有许多优秀的开源 3D Tiles 切片与生成工具。由于 3D Tiles 包含了不同的子格式（如点云 .pnts、倾斜摄影或通用三维模型 .b3dm/.glb），你可以根据原始数据源的类型来选择最合适的开源工具：
## 1. 🐍 Python 生态（最推荐，适合地理空间、建筑数据）

* 
* [py3dtiles](https://py3dtiles.org/)
* 适用数据： 点云数据（如 .las、.laz、.xyz、.ply）及部分三维几何。
   * 特点： 功能非常全面的 Python 库和命令行工具，支持大规模点云的八叉树空间划分和 LOD 树形结构生成，可以直接输出符合 OGC 标准的 tileset.json 和 .pnts 瓦片。 [1, 2, 3] 
* [Py3DTilers](https://github.com/Oslandia/py3dtilers)
* 适用数据： 通用 3D 模型（.obj、.ifc）、城市 GML 数据（CityGML）或地理矢量数据（GeoJSON）。
   * 特点： 它基于 py3dtiles 构建，专门用于将复杂的城市级几何对象、IFC 建筑模型等转换为带属性（Batch Table）的 B3DM 瓦片集。 [4, 5] 
* 

## 2. 🗄️ 数据库转 3D Tiles（适合大规模城市白模、GIS 矢量）

* 
* [pg2b3dm](https://github.com/Geodan/pg2b3dm)
* 适用数据： PostGIS 数据库中的 3D 矢量数据（如 MultiPolygonZ）。
   * 特点： 这是一个非常高效的命令行工具，能直接读取 PostGIS 数据库中的三维建筑要素，将其按照空间索引切片，并导出为 3D Tiles。非常适合用于生成全国规模的城市 3D 建筑物白模。 [6] 
* 

## 3. 🌐 C++ / 桌面软件与插件生态

* 
* blender-3d-tiler
* 适用数据： 任何能导入 Blender 的 3D 模型（如 .fbx、.obj、.gltf 等）。
   * 特点： 利用 Blender 的强力图形 API，在软件内部对复杂的 3D 场景进行网格切割、轻量化并导出为标准 3D Tiles 瓦片。对于美术或手工精细建模的数据非常有帮助。 [7] 
* [QGIS (3.34及以上版本)](https://qgis.org/)
* 适用数据： 各类常规 GIS 矢量、网格、高程数据。
   * 特点： 开源地理信息系统桌面端 QGIS 目前在原生或插件支持下，已经具备了将场景直接导出和发布为 3D Tiles 的功能，适合不习惯敲代码的 GIS 工程师。 [8] 
* 

## 4. 🖨️ 其他专用文件格式转换器

* 
* gltf-to-3d-tiles
* 适用数据： 单个或多个标准的 .gltf / .glb 模型。
   * 特点： 快速将标准的 glTF 资源直接封装或转换成 3D Tiles 格式。 [6] 
* Cesium Point Cloud Generator (CPCG)
* 适用数据： 带有 RGB 颜色信息的 XYZ 文本点云。
   * 特点： 慕尼黑工业大学开源的 Java 工具，利用本地 SQLite 数据库作为空间索引缓冲，专门生成支持多细节层次（LOD）的轻量化点云 3D Tiles。 [9] 
* 

------------------------------
## 💡 工具选型快速指南

| 您的原始数据格式 | 推荐使用的开源工具 | 输出的 3D Tiles 类型 |
|---|---|---|
| .las / .laz / .xyz (激光雷达点云) | py3dtiles / CPCG | Point Cloud (.pnts / 3D Tiles 1.1) |
| PostGIS 数据库 (全城建筑底框 + 高度) | pg2b3dm | Batched 3D Model (.b3dm) |
| .obj / .fbx / .ifc (手工建模/BIM) | Py3DTilers 或 blender-3d-tiler | Batched 3D Model (.b3dm / .glb) |
| CityGML / CityJSON (城市语义模型) | Py3DTilers 或 tyler | 带有层级 Batch Table 的 3D Tiles |

请问你手头现有的原始数据是什么格式（例如：las 点云、BIM 的 IFC、倾斜摄影的 OSGB，还是数据库里的矢量）？告诉你具体的格式和数据量大小，我可以为你推荐最契合的转换路线和具体命令。

[1] https://py3dtiles.org
[2] [https://www.osgeo.org](https://www.osgeo.org/projects/py3dtiles/)
[3] [https://www.osgeo.org](https://www.osgeo.org/projects/py3dtiles/)
[4] [https://isprs-annals.copernicus.org](https://isprs-annals.copernicus.org/articles/X-4-W3-2022/165/2022/isprs-annals-X-4-W3-2022-165-2022.pdf)
[5] [https://github.com](https://github.com/Oslandia/py3dtilers)
[6] [https://threejs3d.com](https://threejs3d.com/cesium-projects/projects/pka-awesome-3d-tiles)
[7] [https://github.com](https://github.com/CesiumGS/3d-tiles/blob/main/RESOURCES.md)
[8] [https://threejs3d.com](https://threejs3d.com/cesium-projects/projects/pka-awesome-3d-tiles)
[9] [https://github.com](https://github.com/tum-gis/cesium-point-cloud-generator)


# ch1.pip install py3dtiles

## 第一步：先临时关闭pip代理（当前终端生效）

同时还有一个关键点：**新版py3dtiles在PyPI包名变更，以及代理环境干扰**。

```bash
# 清除pip代理环境变量
unset HTTP_PROXY
unset HTTPS_PROXY
unset ALL_PROXY
# 小写版本一并清除
unset http_proxy
unset https_proxy
unset all_proxy
```

然后测试：
```bash
# 看是否还有代理
echo $HTTPS_PROXY
# 应该输出空
pip config list
```

如果 `pip config list` 看到 `proxy = [http://127.0.0.1:7897](http://127.0.0.1:7897)`，说明pip全局配置里写死了代理，执行：
```bash
pip config unset global.proxy
```

## 第二步：安装 py3dtiles（两种情况）
> ⚠️ 重要：仓库包名历史变化，**pypi上的 `py3dtiles` 旧包已经停止维护**，现在官方包叫 `py3dtiles` 但是很多版本在pypi缺失；也可以直接从git源码安装。

### 方案A：国内清华源安装（推荐）
```bash
pip install py3dtiles -i [https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
```

### 方案B：源码安装（如果上面找不到包，必用）
```bash
git clone [https://github.com/Oslandia/py3dtiles.git](https://github.com/Oslandia/py3dtiles.git)
cd py3dtiles
pip install .
```

## 第三步：验证安装
```bash
py3dtiles --version
```

## 备选：如果py3dtiles编译麻烦（C++依赖）
py3dtiles底层带C++扩展，在Ubuntu上编译需要系统库：
```bash
sudo apt update
sudo apt install libboost-dev liblas-dev libeigen3-dev
```

## 补充：替代工具备选（点云转3D Tiles）
如果py3dtiles编译踩坑，轻量备选：
1. **pyt3dtiles**（纯Python，无C++扩展，适合点云pnts瓦片）
```bash
pip install pyt3dtiles -i [https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
```

另外提醒：你是python3.12环境，py3dtiles源码编译是支持3.12的。

=====================================================

# ch2. pyt3dtiles 处理点云

pyt3dtiles: 纯Python，无C++编译依赖，专门生成 **pnts点云瓦片**，适合你ROS2 SLAM的PLY点云.
> 一句话定位：轻量简易版3D Tiles点云生成库，**没有复杂分块LOD分层**，默认生成**单根瓦片（root pnts）**，上手零编译，适合快速原型验证；缺点：**不支持自动空间分块**，亿级超大点云会卡，只适合园区/小场景SLAM点云。
> 对比 py3dtiles：py3dtiles带C++扩展、自动瓦片树分层（HLOD），但是安装容易踩坑；**pyt3dtiles 纯Python+numpy，pip直接装，Python3.12友好**。

## 1. 安装（你当前py312环境，先清除代理）
```bash
# 清除代理（你刚才报错根源）
unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
# 清华源安装
pip install pyt3dtiles -i [https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
```

## 2. 最小示例1：直接用numpy构造点云，输出3D Tiles
```python
import numpy as np
from pyt3dtiles import PntsWriter, TilesetWriter

# 1. 构造点云坐标 (x,y,z) 浮点32位
points_xyz = np.array([
    [0,0,0],
    [1,0,0],
    [0,1,0],
    [1,1,0],
    [0,0,1]
], dtype=np.float32)

# 2. 点颜色 RGB uint8
rgb = np.array([
    [255,0,0],
    [0,255,0],
    [0,0,255],
    [255,255,0],
    [255,0,255]
], dtype=np.uint8)

# 3. 写入pnts二进制文件
pnts_writer = PntsWriter()
pnts_writer.add_points(points_xyz, rgb)
pnts_writer.save("scene.pnts")

# 4. 生成tileset.json（3D Tiles入口文件）
tileset = TilesetWriter()
# 包围盒：[xmin,ymin,zmin, dx,0,0, 0,dy,0, 0,0,dz]
tileset.set_bounding_volume_box([-1, -1, -1, 2,0,0, 0,2,0, 0,0,2])
tileset.add_tile("scene.pnts", geometric_error=10)
tileset.save("tileset.json")
```

运行后输出2个文件：
- `scene.pnts`：点云二进制瓦片
- `tileset.json`：3D Tiles主描述文件
直接丢进 **三岳i3D / CesiumJS / Foxglove** 就能加载。

## 3. 示例2：读取SLAM导出的PLY点云（你最常用！）

> 场景：CloudCompare清理后的`scan.ply`（激光雷达SLAM点云）转3D Tiles
```python
import numpy as np
from plyfile import PlyData
from pyt3dtiles import PntsWriter, TilesetWriter

# 读取PLY点云
plydata = PlyData.read("scan.ply")
vertex = plydata["vertex"]
# 读取xyz
xyz = np.column_stack([vertex["x"], vertex["y"], vertex["z"]]).astype(np.float32)
# 如果ply带rgb颜色
rgb = np.column_stack([vertex["red"], vertex["green"], vertex["blue"]]).astype(np.uint8)

# 生成pnts
writer = PntsWriter()
writer.add_points(xyz, rgb)
writer.save("slam_scene.pnts")

# 计算包围盒
xmin, ymin, zmin = xyz.min(axis=0)
xmax, ymax, zmax = xyz.max(axis=0)
bx = xmax - xmin
by = ymax - ymin
bz = zmax - zmin

tileset = TilesetWriter()
box_param = [xmin, ymin, zmin, bx,0,0, 0,by,0, 0,0,bz]
tileset.set_bounding_volume_box(box_param)
tileset.add_tile("slam_scene.pnts", geometric_error=5.0)
tileset.save("tileset.json")
```
> 依赖：读取ply需要 plyfile
```bash
pip install plyfile -i [https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
```

## 4. 关键优缺点（针对你的巡逻机器人项目）
✅ 优点
1. **纯Python，无C++编译**，不会出现py3dtiles那种系统库依赖报错，Python3.12完美兼容
2. 代码极简，很容易嵌入ROS2自动化脚本，SLAM跑完自动生成3D Tiles
3. 只生成pnts（点云瓦片），正好匹配你的激光雷达点云场景


❌ 缺点（重点！）
1. **不支持自动空间分块瓦片树**！全部点都塞进**单个pnts**。
    - 小园区（几十万点）没问题；**百万点以上，加载卡顿，没有LOD分级**，远距离不会自动降低精度。
    - py3dtiles优势：自动切分多瓦片+分层LOD，大场景流式加载。
2. 只支持 **pnts点云瓦片**，**不支持b3dm模型瓦片**，不能转网格模型。
3. 缺少坐标转换工具（WGS84/UTM），坐标系转换需要你自己写。

## 5. 使用建议（你的项目选型）
- 快速原型、小场景园区测试、**验证i3D引擎加载SLAM点云**：用 pyt3dtiles，省事，零编译。
- 真实大园区、百万级点云，需要远近分级LOD、流式加载：还是要用py3dtiles（源码编译安装）。

## 6. 加载验证
生成好tileset.json + pnts后，两种验证方式：
1. 用简单http服务预览：`python -m http.server 8000`，在CesiumJS网页打开
2. 直接导入**三岳i3D引擎**，叠加机器人TF、导航costmap

如果你需要，我可以给你写一个自动下采样+坐标平移的增强版本（把机器人局部笛卡尔坐标系平移，适配3D Tiles）。

要不要顺便对比 pyt3dtiles 单瓦片 和 py3dtiles多瓦片LOD 在i3D引擎里加载的性能差异？

============================================

# ch3.pyt3dtiles 处理网格模型瓦片
**`pyt3dtiles` 原生只支持 pnts（点云瓦片），不原生支持 b3dm / i3dm 网格模型瓦片！**
它仓库定位就是轻量极简工具，**没有内置生成b3dm网格瓦片的API**。

> 两条路线解决你的需求（网格/建筑模型，不是点云）：
> 方案1：**py3dtiles**（支持b3dm批量网格模型，也就是你一开始想装的库，支持建筑、三角网格，适合园区建筑白模）✅
> 方案2：pyt3dtiles + 外部glb转b3dm工具（组合方案，不推荐，麻烦）

下面给你 **py3dtiles 的 B3DM 网格模型完整示例**（B3DM=Batched 3D Model，3D Tiles里用来放三角网格模型，建筑、墙体、障碍物，正好你机器人仿真场景）。

## py3dtiles：生成B3DM建筑网格模型（非点云）
B3dm：批量静态三角网格，可附带批量属性（每栋建筑ID、楼层、高度，数字孪生可拾取查询）。

### 1. 安装（先清代理）
```bash
unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
# 源码安装（推荐，pypi包经常缺失）
git clone [https://gitlab.com/py3dtiles/py3dtiles.git](https://gitlab.com/py3dtiles/py3dtiles.git)
cd py3dtiles
pip install .
```
依赖：生成glTF网格需要 `numpy`，`trimesh` 方便构造模型
```bash
pip install trimesh numpy -i [https://pypi.tuna.tsinghua.edu.cn/simple](https://pypi.tuna.tsinghua.edu.cn/simple)
```

### 2. 完整示例：生成一栋立方体建筑，输出b3dm + tileset.json
```python
import numpy as np
import trimesh
from py3dtiles.tileset.content import B3dm
from py3dtiles.tileset import TilesetWriter

# ========== 1. 构造三角网格：一栋立方体建筑（5m×5m×3m） ==========
# trimesh生成立方体
mesh = trimesh.creation.box(extents=[5,5,3])
# 顶点、三角面
verts = mesh.vertices.astype(np.float32)
faces = mesh.faces.astype(np.uint16)

# ========== 2. 构造glTF，打包进B3DM ==========
# py3dtiles B3dm.from_meshes 接收网格列表
b3dm = B3dm.from_meshes(
    meshes=[
        {
            "vertices": verts,
            "indices": faces.flatten(),
            "material": {"baseColorFactor": [0.7,0.7,0.7,1.0]} # 灰色建筑
        }
    ],
    batch_table={"building_id":[1], "height":[3]} # 批量属性，孪生可查询
)

# 保存b3dm瓦片文件
b3dm.save("building.b3dm")

# ==========3. 构建tileset.json 入口文件 ==========
ts_writer = TilesetWriter()
# 包围盒：[xmin,ymin,zmin, dx,0,0, 0,dy,0, 0,0,dz]
box = [-2.5, -2.5, 0, 5,0,0, 0,5,0, 0,0,3]
ts_writer.set_bounding_volume_box(box)
# 添加瓦片，geometric_error越大，远距离越早消失
ts_writer.add_tile("building.b3dm", geometric_error=2.0)
ts_writer.save("tileset.json")
print("生成完成：building.b3dm + tileset.json")
```

### 3. 多栋建筑示例（批量生成多个立方体，一个b3dm内多实例）
```python
import numpy as np
import trimesh
from py3dtiles.tileset.content import B3dm
from py3dtiles.tileset import TilesetWriter

meshes = []
batch_building_id = []
batch_height = []

# 3栋建筑，不同位置
positions = [
    [0,0,0],
    [10,0,0],
    [0,10,0]
]
heights = [3,4,5]

for idx, pos in enumerate(positions):
    h = heights[idx]
    mesh = trimesh.creation.box(extents=[5,5,h])
    mesh.apply_translation(pos)
    meshes.append({
        "vertices": mesh.vertices.astype(np.float32),
        "indices": mesh.faces.flatten().astype(np.uint16),
        "material": {"baseColorFactor":[0.6,0.6,0.8,1]}
    })
    batch_building_id.append(idx+1)
    batch_height.append(h)

# 打包为单个b3dm
b3dm = B3dm.from_meshes(
    meshes=meshes,
    batch_table={"building_id":batch_building_id, "height":batch_height}
)
b3dm.save("buildings.b3dm")

# tileset
ts = TilesetWriter()
box = [-2.5,-2.5,0, 15,0,0,0,15,0,0,0,8]
ts.set_bounding_volume_box(box)
ts.add_tile("buildings.b3dm", geometric_error=3)
ts.save("tileset.json")
```

## 3. 加载验证（三岳i3D / CesiumJS）
```bash
python -m http.server 8000
```
浏览器打开 `[http://127.0.0.1:8000/tileset.json](http://127.0.0.1:8000/tileset.json)`，i3D引擎直接加载，**带建筑语义属性**，可以拾取看building_id、高度。

## 4. 区分：B3DM vs I3DM
- **B3DM（上面例子）**：批量三角网格，建筑墙体，适合少量、不规则建筑；每个建筑独立三角面，适合做碰撞网格导出给墨子物理引擎。
- **I3DM（实例化模型）**：大量重复物体（路灯、树木、交通桩），同一个模型实例多次摆放，省存储，适合园区大量相同障碍物。py3dtiles也支持i3dm。

## 5. 回到你的选型
1. **如果你要建筑/障碍物网格模型（非点云）**：必须用 **py3dtiles**，支持b3dm/i3dm。
2. **pyt3dtiles 只能点云pnts，不能做网格模型瓦片**，这点一定要清楚。

## 6. 机器人仿真场景的完整管线（室外园区）
1. CityEngine生成园区建筑白模 → 导出glb
2. trimesh读取glb，送入py3dtiles生成b3dm
3. 生成tileset.json，i3D引擎加载3D Tiles场景
4. 提取网格，导出给墨子物理引擎做碰撞，用于ROS2巡逻机器人仿真
5. 叠加激光雷达SLAM点云（pnts），虚实融合

如果你需要，我再写一段 **I3DM（路灯实例）** 的示例代码，适合园区大量重复障碍物。


============================================

# ch3.完整介绍3D Tiles工具
（按你机器人/3D Tiles管线顺序：点云预处理 → 瓦片生成 → 场景建模 → 孪生平台）

## 1. CloudCompare（CC，免费开源，**你SLAM最常用**）

**定位：点云/三角网格处理GUI工具**
- 核心：激光雷达SLAM点云（PLY/LAS/LAZ/E57）裁剪、降噪、ICP配准、下采样、点云-网格距离对比、提取截面、滤波、法向量计算
- 输出：清理干净的PLY/LAS点云，**作为py3dtiles的输入源**
- 优点：免费、跨平台、支持超大点云，机器人室外SLAM必备
- 局限：**不能直接输出3D Tiles**，只做预处理
> 你的巡逻机器人流程：激光雷达采集 → CloudCompare去噪/裁剪 → 导出PLY → py3dtiles转3D Tiles

## 2. py3dtiles（开源Python库+CLI，本地离线转3D Tiles）
**定位：命令行/Python API，点云/模型批量转3D Tiles**
- 输入：ply / las / laz / xyz点云、OBJ、IFC
- 输出：标准3D Tiles（pnts点云瓦片、b3dm模型瓦片，支持3D Tiles 1.1原生glTF）
- 亮点：本地离线、可嵌入Python自动化流水线，可合并多个tileset、可修改瓦片元数据；内存可控，支持亿级点云
- 安装：`pip install py3dtiles`
- 常用命令：
```bash
# ply点云转3D Tiles
py3dtiles convert scan.ply --out ./tiles
# 预览本地瓦片
py3dtiles view ./tiles/tileset.json
```
- 局限：GUI弱，没有可视化编辑；复杂BIM/倾斜摄影瓦片效果不如Cesium ion

## 3. Cesium ion（Cesium官方云平台，在线瓦片化+托管）
**定位：SaaS云端3D Tiles生成+云端托管**
- 上传：倾斜摄影、点云、BIM、OBJ/FBX/glb、CityGML，云端自动切分生成3D Tiles
- 自带全球地形、OSM建筑底图；生成后提供token，直接流式加载到CesiumJS、Unreal、三岳i3D引擎
- 优点：一键生成高质量LOD瓦片，不用折腾本地算力；适合快速验证
- 缺点：**云端、有流量/存储配额，国内访问慢；涉密/离线项目不能用**


## 4. CIMPro孪大师（国产数字孪生平台，漂视网络）
**定位：国产三维孪生可视化平台，低代码场景搭建**
- 支持直接导入：OSGB倾斜摄影、3D Tiles、BIM、工业CAD、点云、glTF，兼容国产信创
- 能力：二三维融合、接入MQTT/OPC UA实时数据流、做孪生大屏、场景交互、模型动画；可对接机器人实时定位、导航路径叠加
- 和三岳i3D区别：CIMPro是**上层应用平台（做孪生项目）**；三岳i3D是底层三维渲染引擎。
- 缺点：商业软件，重在可视化应用，**不是点云预处理、瓦片生成工具**

## 横向对比总表
|工具|开源|类型|核心用途|输出3D Tiles|适合你的机器人项目？|
|---|---|---|---|---|---|
|CloudCompare|✅开源|GUI点云处理|SLAM点云清洗、配准、裁剪|❌|⭐⭐⭐⭐⭐（必用）|
|py3dtiles|✅开源|Python/CLI|本地批量点云转3D Tiles|✅|⭐⭐⭐⭐⭐（离线流水线首选）|
|Cesium ion|❌商用SaaS|云端平台|在线一键生成3D Tiles+托管|✅|⭐⭐⭐（快速原型，不适合离线）|
|CityEngine|❌商业|程序建模|批量生成城市建筑白模|❌（间接导出后再转）|⭐⭐⭐（搭建仿真虚拟城市）|
|CIMPro孪大师|❌商业|孪生应用平台|加载3D Tiles、做数字孪生可视化大屏|❌|⭐⭐（上层孪生展示）|

==========================================================

# ch4.如何安装与使用 3d-tiles-tools 
3d-tiles-tools 是 Cesium 官方提供的工具集，主要用于处理、转换和优化 3D Tiles 数据。它分为两个版本：Node.js 命令行版（最成熟）和 Python 实验版（适合集成）。

针对你的「路面建模」课题，建议使用 Node.js 版 进行手动处理，或使用 Python 调用 实现自动化。

## 1. 安装步骤 (Node.js 版本)
这是目前功能最全的版本，支持 .glb 与 .b3dm 之间的相互转换。

### 1.1 安装 Node.js
确保你的 Ubuntu 系统已安装 Node.js（建议版本 16.x 以上）。

### 1.2 通过 npm 安装
```bash
# 全局安装命令行工具
npm install -g 3d-tiles-tools
```
> 请谨慎使用此类代码。

### 1.3 验证安装
```bash
3d-tiles-tools --help
```
 

## 2. 常用操作指令
在你的 方案一（Python 重建） 导出 .glb 模型后，可以使用以下指令将其转化为 3D Tiles 标准文件：

### A. glTF 转 B3DM (3D Tiles 的核心瓦片格式)
```bash
3d-tiles-tools glbToB3dm  -i  ./ancient-buildings.glb -o  ./ancient-buildings.b3dm
```
 
### B. 优化 3D Tiles 数据集 (压缩与清理)
如果您已经有了一个 tileset.json，可以用它来进行批量优化：
```bash
3d-tiles-tools upgrade -i ./tileset_old/tileset.json -o ./tileset_new/
```
 
### C. 合并与拆分
它还可以将分散的瓦片合并，这对于处理长距离路面分块非常有用。

## 3. 如何集成到 Python 全流程中？
既然你在开发 Python 环境的自动化链路，可以使用 subprocess 模块来调用它：
```python
import subprocess

def convert_to_3dtiles(glb_path, output_b3dm_path):
    # 调用 node.js 工具进行转换
    command = ["3d-tiles-tools", "gltfToB3dm", glb_path, output_b3dm_path]
    try:
        subprocess.run(command, check=True)
        print("3D Tiles 瓦片轉換成功！")
    except subprocess.CalledProcessError as e:
        print(f"轉換失敗: {e}")
```

### 总结
1. 3d-tiles-tools 首选 Node.js 版本安装，需先确保系统有 16.x 以上 Node.js 环境，通过 `npm install -g` 全局安装；
2. 核心用途是将路面模型的 .glb 转为 3D Tiles 标准的 .b3dm 格式，也可优化/合并瓦片数据集；
3. 集成到 Python 自动化流程时，通过 `subprocess` 模块调用命令行指令即可，需做好异常捕获。

=====================================================

# ch5. 3d-tiles-tools 工具如何使用，才能把一个gltb文件转成可以满足网络环境快速加载模型的需求

你想通过 `3d-tiles-tools` 将 `.gltb` 文件转换成支持网络快速加载的 3DTiles 格式，核心是做好**瓦片切片、LOD分级、格式优化**，下面我会给你一步到位的实操指南，从环境准备到最终优化，确保模型在网络环境下加载快、占用带宽低。

### 一、核心前提：环境准备
`3d-tiles-tools` 是基于 Node.js 的命令行工具，首先要装好依赖：
1. 安装 Node.js（建议v16+，LTS版本）：https://nodejs.org/
   - 验证安装：终端输入 `node -v` 和 `npm -v`，能显示版本号即成功。
2. 全局安装 3d-tiles-tools：
   ```bash
   npm install -g 3d-tiles-tools
   ```
   - 验证安装：输入 `3d-tiles-tools --version`，显示版本号即成功。

### 二、核心操作：gltb 转 3DTiles（快速加载版）
#### 1. 基础转换（生成可加载的 3DTiles）
先把 `.gltb` 转成基础的 3DTiles 格式（B3DM 瓦片），终端执行：
```bash
# 核心命令：转换gltb为3DTiles，输出到指定文件夹
3d-tiles-tools convert ./your-model.gltb ./output-tiles/ --tilesetName "road-model"
# 3d-tiles-tools convert ./ancient-buildings.glb ./ancient-buildings-3dtiles/ --tilesetName "ancient-buildings"
```
- `./your-model.gltb`：你的路面模型文件路径（替换成实际路径）；
- `./output-tiles/`：输出的 3DTiles 文件夹（自动创建）；
- `--tilesetName`：给瓦片集命名（方便识别）。

#### 2. 关键优化（满足网络快速加载）
基础转换后的模型可能体积大、加载慢，必须加这些优化参数，**这是网络快速加载的核心**：
```bash
# 带全量优化的转换命令（重点！）
3d-tiles-tools convert ./your-model.gltb ./optimized-tiles/ \
  --tilesetName "road-model" \
  --maxTextureSize 2048 \       # 贴图最大尺寸限制为2K（网络加载最优）
  --simplifyLevels 3 \          # 生成3级LOD（细节分级，远看加载低模）
  --simplifyRatio 0.5 \         # 每级LOD的模型面数减半（平衡精度和体积）
  --tileSize 1024 \             # 瓦片大小限制（避免单瓦片过大）
  --compress draco \            # 用Draco压缩模型（体积减少50%-80%）
  --outputFormat b3dm           # 输出标准B3DM格式（兼容性最好）
```

### 三、参数详解（为什么这些参数能让加载更快）
| 参数                | 作用（网络优化核心）                                                                 |
|---------------------|--------------------------------------------------------------------------------------|
| `--maxTextureSize`  | 限制贴图像素（2K是网络加载的最优尺寸，4K贴图体积大、加载慢，1K精度不足）             |
| `--simplifyLevels`  | 生成LOD（细节层次）：网络加载时，远距加载低模（小体积），近距加载高模（保精度）       |
| `--simplifyRatio`   | 控制LOD的面数衰减：每级面数减半，既减少总数据量，又不影响视觉效果                     |
| `--tileSize`        | 拆分大模型为小瓦片：网络可分片加载（不用等整个模型下载完），降低首屏加载时间           |
| `--compress draco`  | Draco压缩：无损压缩模型顶点/三角面数据，体积大幅减小，且加载时解压成本极低             |

### 四、进阶：批量优化/验证（确保可用）
#### 1. 验证转换后的瓦片是否有效
转换完成后，先检查瓦片集是否合法，避免加载报错：
```bash
3d-tiles-tools validate ./optimized-tiles/tileset.json
```
- 输出 `Validation succeeded` 即无问题；
- 若报错，优先检查 `.gltb` 文件是否合法（可先用 Blender 重新导出，勾选 `Apply Modifiers`）。

#### 2. 进一步压缩瓦片（可选）
如果模型仍偏大，可对瓦片做 gzip 压缩（Web服务器开启gzip后，加载更快）：
```bash
3d-tiles-tools compress ./optimized-tiles/tileset.json --gzip
```

### 五、网络部署注意事项（最后一步）
转换好的 3DTiles 要在网络环境快速加载，服务器端需配置：
1. 开启 **gzip/Brotli 压缩**（匹配上面的压缩操作）；
2. 支持 **范围请求（Range Requests）**（让浏览器分片下载瓦片）；
3. 静态资源开启 **CDN 加速**（尤其大模型，CDN能降低延迟）。

### 总结
1. 核心流程：`安装Node.js → 装3d-tiles-tools → 带优化参数转换gltb → 验证 → 服务器配置`；
2. 快速加载的关键：**LOD分级+Draco压缩+2K贴图+瓦片拆分**，这四个参数缺一不可；
3. 适配你的10米路面模型：`simplifyLevels=2` 即可（模型小，无需过多LOD），重点保留 `--compress draco` 和 `--maxTextureSize 2048`。

如果需要，我可以给你一份**针对10米路面模型的一键转换脚本**（Windows/Linux通用），直接替换路径就能用，避免手动输参数出错。