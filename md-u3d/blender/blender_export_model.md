# 1.blender 的模型导出给 unity用，对于坐标需要如何设置

<!-- doubaoAI -->
### 一、核心结论
Blender模型导出给Unity时，**坐标系统适配是关键**（Blender为右手坐标系+Y轴向上，Unity为左手坐标系+Y轴向上但轴向指向不同），需通过「Blender导出设置+Unity导入设置」两步适配，核心原则：
- Blender侧：导出时勾选「应用变换」「重置缩放/旋转」，轴向映射为「Y Forward、Z Up」；
- Unity侧：导入时确认「缩放因子=1」「轴向修正」自动生效，无需额外调整。

### 二、Blender端：导出前的坐标/变换准备（关键步骤）
#### 1. 重置模型基础变换（避免导入后偏移/缩放异常）
在Blender中选中模型，执行以下操作：
- 清除位置：`Object > Clear > Location`（快捷键 `Alt+G`）→ 模型归位世界原点(0,0,0)；
- 清除旋转：`Object > Clear > Rotation`（快捷键 `Alt+R`）→ 模型轴向与世界轴对齐；
- 清除缩放：`Object > Clear > Scale`（快捷键 `Alt+S`）→ 模型缩放恢复为1（避免Unity中缩放因子异常）；
- 应用变换：按 `Ctrl+A` → 选择「Rotation & Scale」→ 将旋转/缩放应用到网格（核心！否则导出后Unity中模型仍有隐藏变换）。

#### 2. FBX导出设置（适配Unity坐标）
Blender导出FBX（Unity首选格式）时，在导出面板按以下配置：
| 导出选项                | 配置值/操作                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| **Scale**               | 缩放因子设为 `1.0`（避免Unity中模型大小异常）；                             |
| **Forward Axis**        | 选择 `Y Forward`（Blender的Y轴对应Unity的Z轴，适配Unity左手坐标系）；       |
| **Up Axis**             | 选择 `Z Up`（Blender的Z轴对应Unity的Y轴，匹配Unity的Y轴向上）；             |
| **Apply Transform**     | 勾选「Apply Transform」（应用所有变换到网格，等同于手动Ctrl+A）；            |
| **Object Types**        | 仅勾选「Mesh」（若有骨骼动画勾选「Armature」，剔除Camera/Light等无用对象）；  |
| **Geometry**            | 勾选「Smooth Faces」「Triangulate Faces」（Unity对三角面兼容性更好）；        |
| **Export Selected Only** | 建议勾选（仅导出选中的模型，避免导出冗余对象）；                             |

#### 3. 特殊场景：多模型/场景整合
若导出多个楼宇模型（如教学楼、图书馆），需：
- 统一所有模型的原点：选中模型 → `Object > Set Origin > Origin to Geometry`（原点归到模型几何中心）；
- 按Unity场景坐标系排列：Blender中按「X=东、Y=北、Z=高」摆放模型（匹配Unity场景坐标逻辑）。

### 三、Unity端：导入后的坐标校验与调整
#### 1. 导入设置（自动适配，极少需手动改）
将FBX拖入Unity后，选中文件打开「Import Settings」：
| 导入选项                | 配置值/校验项                                                              |
|-------------------------|-----------------------------------------------------------------------------|
| **Scale Factor**        | 设为 `1`（Blender导出时已设1.0，无需缩放）；                                |
| **Mesh Compression**    | 根据需求选（移动端选Low/Medium，PC选Off）；                                 |
| **Axis Conversion**     | Unity会自动根据FBX的Forward/Up轴修正（无需手动改，默认已适配）；            |
| **Read/Write Enabled**  | 若需在代码中修改网格（如楼宇变形），勾选；                                  |
| **Import Animation**    | 无动画则取消勾选，减少资源体积；                                            |

#### 2. 场景中坐标校验
将模型拖入Unity场景后，检查：
- **Transform组件**：Position/Rotation/Scale 应为 (0,0,0)/(0,0,0)/(1,1,1)（若有偏移，回到Blender重置变换）；
- **轴向匹配**：Blender中模型的“前方向（Y）”对应Unity的“前方向（Z）”，“上方向（Z）”对应Unity的“上方向（Y）”，模型无翻转/颠倒即适配成功；
- **大小适配**：若模型过大/过小，优先在Blender中缩放模型并应用变换（而非Unity中改Scale，避免批处理异常）。

### 四、常见问题与解决方案
| 问题现象                | 原因                          | 解决方案                                                                 |
|-------------------------|-------------------------------|--------------------------------------------------------------------------|
| 模型导入后旋转90度/颠倒 | Blender导出时轴向设置错误     | 重新导出，确认Forward=Y、Up=Z，勾选Apply Transform；                     |
| 模型位置偏移/漂浮       | Blender中未重置位置/应用变换  | Blender中Alt+G归位原点，Ctrl+A应用变换后重新导出；                        |
| 模型缩放异常（过大/过小）| 导出Scale≠1或Unity导入Scale≠1 | 两端均设为1，Blender中Ctrl+A应用缩放后导出；                              |
| 多个模型拼接错位        | 各模型原点未统一              | Blender中为每个模型执行「Origin to Geometry」，按统一坐标系排列后导出；    |

### 五、简化流程（校园楼宇模型导出示例）
1. Blender中打开楼宇模型 → 选中模型 → Alt+G/Alt+R/Alt+S重置变换 → Ctrl+A应用旋转/缩放；
2. 导出FBX：Scale=1、Forward=Y、Up=Z、勾选Apply Transform、仅导出Mesh；
3. Unity中导入FBX：Scale Factor=1，直接拖入场景 → 校验Transform为(0,0,0)/(0,0,0)/(1,1,1)；
4. 若模型方向错误，在Unity中选中模型 → 旋转Transform（如Rotation=(90,0,0)）→ 点击「Apply」保存预制体（仅临时修正，优先Blender端调整）。

### 六、总结
核心是**Blender端做好变换重置+轴向适配**，Unity端仅需校验导入设置，99%的坐标问题均可通过Blender导出前的「重置变换+应用变换+轴向设置」解决。对于校园3D楼宇可视化项目，建议批量处理模型：统一原点、统一缩放、统一轴向，避免导入后逐个调整。

若导出后仍有坐标异常，可在Unity中通过`ModelImporter`代码批量修正导入设置（如强制Scale=1、轴向修正），需要的话我可提供对应的批量处理代码。

==========================================================
# 2.blender中的东西太多，找不到某个物体，只能在大纲里看到它。如何快速把视图对准要找的物体
