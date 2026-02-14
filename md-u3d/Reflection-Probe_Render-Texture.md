# 反射探针（Reflection Probe）和 Render Texture

如何 把场景里成百上千个静态物体（模型、贴图、灯光）直接烘焙成一张大的 Render Texture 或者 远景球（Skybox）?

既然客户明确场景只是“背景板”，将其从“实时 3D 模型”转化为“贴图级背景”能极大地解放移动端的性能。在 Unity 中实现这一目标的具体方案如下：
## 方案一：全景球/天空盒化（适合固定视角或大场景）
如果你的相机只在中心旋转，或者移动范围很小，可以将整个场景烘焙成一个 Skybox。
### 1。放置反射探针（Reflection Probe）：
* 在场景中心放置一个 Reflection Probe。
* 将 Type 设置为 Baked。
* 点击 Bake，Unity 会生成一张包含 360 度场景的 Cubemap。
### 2.创建天空盒材质：
* 新建一个 Material，Shader 选择 Skybox/Cubemap。
* 将刚才烘焙出的 Cubemap 拖入。
### 3.应用背景：
* 在 Lighting 窗口将该材质设为 Skybox Material。
* 删掉场景中成百上千的原型物体。


## 方案二：离线渲染为“正交背板”（最适合塔防视角）
塔防通常是俯视视角（正交或低角度透视）。你可以将其渲染为一张高精度底图。
架设特写相机：
新建一个 Camera，对准你的场景。如果是传统 2.5D 塔防，将 Projection 设为 Orthographic（正交）。
背景色设为透明（Alpha = 0）。
渲染到 Render Texture (RT)：
在 Assets 里新建一个 Render Texture（尺寸设为 2048x2048 或更高）。
把这个 RT 拖给相机的 Target Texture。
持久化贴图：
运行一次游戏，右键 RT 选择 Export to PNG/TGA（或者写个简单的脚本把 RT 转存为 Texture2D）。
替换场景：
新建一个巨大的 Quad（平面） 或 Sprite 放在地板上。
将导出的贴图贴上去。
删除原始模型。

## 方案三：静态合批与层级剔除（如果不删除模型）
如果客户还需要一点点透视感（相机移动时背景要有轻微位移），不能直接变图片，那就用以下组合拳：
Static Batching（静态合批）：勾选所有背景物体的 Static 标签。Unity 会在启动时将它们合并为一个大的 Mesh，Draw Call 降至个位数。
Layer Cull Distances：通过代码 camera.layerCullDistances 设置。
让背景里的小碎石、小草在相机稍远时直接彻底不渲染，而只保留大房子和地表。
LOD Group：为成百上千的小物体设置超简单的低模（甚至就是一个面片）。

====================================================
# 2. Reflection Probe 无法点击 Bake 按钮的问题
你遇到的 Reflection Probe 无法点击 Bake 按钮的问题，是 Unity 中反射探针烘焙的常见故障，核心原因通常是**探针配置、场景设置或引擎状态异常**。下面我先分析关键原因，再给你一步步可落地的解决方法，确保能正常点击 Bake 并完成烘焙：

### 一、先明确：Bake 按钮灰显/无法点击的核心原因
Reflection Probe 的 Bake 按钮能否点击，取决于 3 个核心条件，只要一个不满足就会灰显：
1. **探针类型必须是 Baked**（而非 Realtime/Custom）；
2. **探针的 Bounding Volume 必须有效**（能包裹需要烘焙的场景范围）；
3. **Unity 编辑器处于可编辑状态**（无编译错误、无播放模式、无资源导入中）。

### 二、分步解决：从基础到进阶
#### 步骤 1：检查最基础的配置（90% 问题出在这里）
先确认反射探针的核心设置，这是最容易忽略的点：
1. 选中场景中的 Reflection Probe 物体，打开 Inspector 面板；
2. 确认 **Type** 选项已设置为 `Baked`（Realtime/Custom 模式下 Bake 按钮会直接消失/灰显）；
3. 检查 **Bounding Volume**（包围盒）：
   - 模式选择 `Box`（默认），确保 Box 的范围完全包裹你要烘焙的场景（比如场景中心的大场景）；
   - 如果 Box 范围为 0（比如长宽高都是 0），Bake 按钮会灰显——拖动 Box 的控制点放大，或直接修改 `Size` 数值（比如设为 (100,100,100)）；
4. 确认编辑器状态：
   - 退出 Play 模式（播放按钮为停止状态）；
   - 等待场景中所有资源导入完成（右下角无加载进度条）；
   - 检查控制台（Console）是否有编译错误（红色报错）——代码编译失败会导致所有编辑功能锁定，先修复报错。

#### 步骤 2：修复 Unity 编辑器的缓存/状态异常
如果配置没问题但仍无法点击，大概率是编辑器缓存或状态异常：
1. **清除 Reflection Probe 缓存**：
   - 选中反射探针，在 Inspector 面板底部点击 `Clear Baked Data`；
   - 关闭 Unity，删除项目根目录下的 `Library` 文件夹（注意：删除后 Unity 会重新生成，耗时取决于项目大小）；
   - 重新打开项目，选中探针再次尝试点击 Bake。
2. **重置反射探针设置**：
   - 右键 Inspector 面板的 Reflection Probe 组件 → `Reset`，重置所有参数；
   - 重新设置 Type 为 Baked，调整 Bounding Volume 范围，再尝试 Bake。
3. **检查 Lighting 设置**：
   - 打开 `Window → Rendering → Lighting Settings`；
   - 确认 `Auto Generate` 未勾选（自动烘焙会锁定手动 Bake 按钮）；
   - 如果勾选了，先取消勾选，点击 `Generate Lighting` 完成当前光照烘焙，再回到探针操作。

#### 步骤 3：进阶排查（针对复杂场景）
如果以上步骤仍无效，排查场景或项目级的深层问题：
1. **检查场景中的非法资源**：
   - 移除场景中缺失材质/纹理的物体（红色材质球）——这类资源会导致烘焙流程卡死；
   - 暂时隐藏大量重复的原型物体（你方案中提到的“成百上千的原型物体”），先保留核心场景物体，减少烘焙压力。
2. **确认渲染管线兼容**：
   - 如果使用 URP/HDRP（通用/高清渲染管线），确保反射探针适配对应管线：
     - URP：在 `Project Settings → Graphics → Scriptable Render Pipeline Settings` 中选择 URP 配置文件；
     - HDRP：反射探针需使用 `HDRP Reflection Probe` 组件（而非默认的 Reflection Probe）。
3. **检查权限/路径问题**：
   - 确保项目路径无中文、空格或特殊字符（比如 `D:\游戏项目\场景烘焙` 改为 `D:\GameProject\SceneBake`）；
   - 确保 Unity 有项目文件夹的读写权限（比如不要放在系统盘的 Program Files 目录下）。

#### 步骤 4：替代方案（快速完成全景烘焙）
如果始终无法点击 Bake，可绕过反射探针直接生成 Cubemap（达到同样的天空盒效果）：
1. 在场景中放置一个空物体，添加 `Camera` 组件；
2. 将相机设为正交相机，`Field of View` 设为 90，`Clear Flags` 设为 `Skybox`；
3. 打开 `Window → Rendering → Render Textures`，新建一个 `Cubemap`（分辨率建议 2048 或 4096）；
4. 选中相机，在 Inspector 面板点击 `Render To Cubemap`，选择新建的 Cubemap，点击 `Render`；
5. 用这个 Cubemap 创建天空盒材质（Shader 选 `Skybox/Cubemap`），应用到 Lighting 设置中。

### 三、关键注意事项（适配你的场景）
针对你“删除成百上千的原型物体”的需求：
1. 烘焙完成后再删除原型物体——烘焙需要场景中的物体来生成 Cubemap，删除后再烘焙会得到空的全景图；
2. 如果场景物体太多导致烘焙卡顿，可先将物体分组，隐藏非核心物体，烘焙完成后再删除。

### 总结
Reflection Probe 无法点击 Bake 的核心解决要点：
1. 确保探针 Type 为 Baked，Bounding Volume 范围有效；
2. 退出 Play 模式、修复编译错误、取消光照自动烘焙；
3. 清除 Library 缓存或重置探针设置；
4. 若仍无效，直接用相机渲染 Cubemap 替代反射探针烘焙。

按这个流程排查，99% 的 Bake 按钮灰显问题都能解决，且适配你“全景球/天空盒化”的核心需求。