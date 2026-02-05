# 1.如何从unity把 模型导出成fbx 
当然可以，Unity 官方提供了非常便捷的工具来完成这项操作。
导出方案：使用 Unity 官方 FBX Exporter

这是最稳定、兼容性最好的方式，可以完美导出模型层级和材质球信息。
### 安装插件：
   在 Unity 中打开 Window -> Package Manager，搜索并安装 FBX Exporter。
### 选择模型：
    在 Hierarchy 面板中选中你的 6 层楼模型根节点。

### 开始导出：
点击右键选择 Export To FBX...。
在弹出窗口中，将 Export Format 设置为 Binary（兼容性更好）。
LOD Level 选择 Highest（确保内外部模型细节不丢失）。

### 保存：
    点击 Export，你就能得到一个 .fbx 文件，这个文件可以被 Blender、3ds Max 或你的 Web 看板（Three.js）识别。


=========================================================
# 2.unity 的fbx exporter 导出的fbx 模型 放到新的unity工程中后 只剩下白模，没有纹理贴图

这是因为 FBX 文件默认通常只包含网格和材质引用，而不一定直接嵌入贴图原始数据。当模型进入新环境时，Unity 无法自动找回丢失的路径关联。 

你可以通过以下步骤解决：
### 1. 导出时的关键设置
在导出 FBX 前，请确保在 FBX Exporter 的导出选项窗口中：
> 1. Export Format: 选择 Binary（二进制格式支持嵌入）。
> 2. Embed Textures: 勾选此选项。它会将贴图数据打包进 FBX 文件中。 

### 2. 导入后的提取操作
将 FBX 放入新工程后，即使勾选了嵌入，模型可能仍显示为白模。你需要手动“提取”它们：
> * 在 Unity 中选中该 FBX 模型文件。
> * 在 Inspector 面板中点击 Materials 标签页。
> * 点击 Extract Textures...，选择一个文件夹保存导出的贴图。
> * （可选）点击 Extract Materials...，以便对材质球进行二次编辑。 

###  3. 手动重连材质（如果上述无效）
如果贴图已在工程中但未显示：
* 在模型的 Materials 面板下，将 Location 设置为 Use External Materials (Legacy)，Unity 会尝试按名称匹配贴图。
* 或者直接将提取出的贴图拖入材质球的 Albedo (Base Map) 通道中。 
注意： Unity 的 FBX Exporter 插件 对非标准 Shader（如高度自定义的 Shader Graph）的支持有限。如果使用了复杂着色器，建议手动迁移贴图。
 
你导出的模型是使用了 Unity 标准着色器 (Standard Shader) 还是特殊的 Shader Graph/URP 材质？