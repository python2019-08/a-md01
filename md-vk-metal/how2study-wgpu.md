# wgpu 完整学习路线（从零基础到独立写3D渲染器）
前置：会基础 Rust，懂基础图形学概念（缓冲区、纹理、着色器、管线），不懂会标注补学位置。

## 一、前置基础（必须先搞定，否则寸步难行）
### 1. Rust 基础（最低门槛）
需要掌握：
- 所有权、借用、生命周期、结构体、trait
- 闭包、异步（wgpu queue 提交少量用到）
- crates、Cargo 工程结构、模块管理
推荐：官方《The Rust Programming Language》前10章，或 Rust By Example。

### 2. 图形基础（不用精通，但要懂名词）
不用学 Vulkan/Metal 底层，只懂通用图形概念：
- CPU/GPU 数据交互：VertexBuffer、IndexBuffer、UniformBuffer
- 纹理、采样器、着色器（顶点/片元）
- 渲染管线、帧缓冲、视口、深度测试、混合
- 基础渲染流程：准备资源 → 录制命令 → GPU 提交绘制
如果完全零基础：B站/知乎搜「计算机图形学入门」，看懂光栅化基础即可。

### 3. WGSL 着色器
wgpu 唯一标准着色语言，比 GLSL/HLSL 简单。
核心知识点：
- 变量、存储修饰符 `var`/`let`、`uniform`/`storage`
- 顶点输入输出、片元输出
- 纹理采样、矩阵变换、基础光照

## 二、环境搭建（1分钟跑通第一个三角形）
### Cargo.toml 最小依赖
```toml
[package]
name = "wgpu-demo"
version = "0.1.0"
edition = "2021"

[dependencies]
# wgpu 核心库
wgpu = "0.20"
# 窗口管理（wgpu 本身不带窗口，winit 官方配套）
winit = "0.29"
# 图像加载（纹理）
image = { version = "0.25", features = ["png"] }
# 矩阵数学（变换：平移旋转缩放MVP）
nalgebra-glm = "0.18"
```

### 最小运行逻辑分层（固定模板）
所有 wgpu 项目结构完全统一：
1. winit 创建窗口、事件循环
2. 创建 Instance、Adapter、Device、Queue
3. 创建 Surface（窗口交换链）
4. 创建渲染管线、BindGroup、Buffer、Texture
5. 每一帧：获取交换链纹理 → 启动渲染通道 → 录制绘制指令 → 提交队列

## 三、官方核心教程（最优学习资料，优先级最高）
### 1. learn-wgpu（全网最系统中文+英文教程）
仓库：https://github.com/sotrh/learn-wgpu
路线按章节循序渐进：
1. 初始化窗口、画纯色屏幕
2. 绘制三角形（顶点缓冲区、基础WGSL）
3. 索引缓冲、颜色插值
4. 纹理贴图、采样器
5. Uniform 缓冲区 + MVP矩阵（3D基础）
6. BindGroup 资源绑定模型（wgpu 核心设计）
7. 深度缓冲、3D立方体
8. 实例化渲染、多物体
9. 模型加载 glTF
10. 计算管线 GPGPU（通用并行计算）
11. WASM 网页打包、浏览器运行

> 优点：每一章完整可运行代码，讲解底层逻辑，同时区分 wgpu 和原生 Vulkan 的差异。

### 2. wgpu 官方文档 docs.rs/wgpu
重点看：
- Device、Queue、RenderPipeline、BindGroup 结构体说明
- 所有描述符 *Descriptor 配置参数含义
- 原生扩展接口（需要底层能力时使用）

### 3. wgpu 官方示例仓库
https://github.com/gfx-rs/wgpu/tree/trunk/examples
覆盖高级功能：光追、多线程渲染、离屏渲染、多渲染目标、MSAA抗锯齿、异步资源加载。

## 四、分阶段学习计划（3阶段循序渐进）
### 阶段1：入门（7天，目标：画出3D立方体，理解整套流程）
1. 跟着 learn-wgpu 01~08 章节逐行敲代码，不要复制粘贴
2. 弄懂核心四大件（wgpu 灵魂）
   - BindGroupLayout / BindGroup：GPU资源绑定，替代Vulkan描述符集
   - RenderPipeline：着色器+光栅化状态集合
   - RenderPassEncoder：录制绘制指令，替代Vulkan CommandBuffer
   - Surface/交换链：窗口帧缓冲自动管理
3. 掌握WGSL基础，自己修改颜色、纹理、坐标
4. 实操任务：
   - 修改立方体大小、位置
   - 替换图片纹理
   - 开启/关闭深度测试观察效果

### 阶段2：进阶（14天，目标：自制简易渲染器，加载外部模型）
学习内容：
1. glTF 模型加载（wgpu 标准模型格式）
2. PBR基础材质（金属/粗糙度、法线贴图）
3. 实例化渲染，一次性绘制上千物体
4. 相机系统：轨道相机、FPS自由相机
5. 多BindGroup分层资源管理
6. 离屏渲染、渲染到纹理（水面反射、阴影基础）
7. WASM 编译，同一套代码跑浏览器
实操项目：搭建小型场景编辑器，加载多个模型、切换材质。

### 阶段3：高级（长期，对标专业渲染能力）
1. Compute Shader 通用计算：粒子、流体、并行数据处理
2. 光照进阶：点光/平行光、阴影贴图
3. MSAA、HDR、色调映射、后处理（模糊、泛光）
4. 多线程资源创建、异步加载纹理模型
5. wgpu 底层扩展：获取 Vulkan/Metal 原生句柄，对接硬件特有功能
6. 整合 egui GUI，做带界面的渲染工具
7. 阅读 Bevy 引擎渲染源码，学习工业级分层架构

## 五、关键核心概念重点吃透（wgpu独有，和Vulkan完全不同）
1. **BindGroup**
   wgpu 统一资源绑定方案，不用手动管理描述符池，是最大简化点；
   所有 buffer/texture/sampler 必须打包进 BindGroup 传给管线。
2. 无 RenderPass 对象
   Vulkan 需要提前创建 RenderPass，wgpu 在每帧动态开启渲染通道，大幅简化代码。
3. 自动同步、自动资源布局
   不用手动写内存屏障、图片布局转换，wgpu 内部自动处理，新手最大减负。
4. 统一 WGSL
   一套着色器兼容 Vulkan/Metal/DX12/网页，不用维护多套GLSL/MSL/HLSL。
5. 跨平台自动后端选择
   代码不用修改，Windows走DX12、macOS走Metal、Linux/Android走Vulkan、WASM走WebGPU。

## 六、避坑指南（新手高频问题）
1. 资源生命周期
   wgpu 靠引用计数自动释放，但要保证 Buffer/Texture/BindGroup 在提交队列时不被提前销毁。
2. 交换链大小
   窗口缩放必须重建 Surface 交换链，否则画面拉伸/黑屏。
3. WGSL 绑定索引匹配
   BindGroupLayout 的 binding 编号必须和 WGSL `@binding(x)` 严格对应，否则黑屏无输出。
4. WASM 特殊限制
   网页端无法使用原生扩展，文件读取需要 wasm-bindgen 处理。
5. 性能误区
   频繁重建 Pipeline 会严重卡顿，管线统一初始化缓存复用。

## 七、配套实战项目（练手梯度）
1. 初级：2D 像素游戏、图片渲染、简单几何图形
2. 中级：3D 场景漫游、模型查看器、粒子系统
3. 高级：光线追踪Demo、离线渲染工具、数字孪生Web可视化
4. 引擎级：基于wgpu封装自己的简易3D框架

## 八、学习资料汇总清单
### 教程
1. learn-wgpu（必学）
2. wgpu examples 官方示例
3. Bevy 源码（工业级上层封装参考）
### WGSL
1. W3C WGSL 规范
2. learn-wgpu 配套着色器示例
### 图形数学
nalgebra-glm 矩阵库文档，MVP变换实现

## 九、对比两条学习路线选择
1. 只想快速做跨桌面+网页3D、避开Vulkan复杂度：**纯wgpu路线（推荐）**
2. 想深入底层硬件、只做本地Vulkan程序：先学 vulkano，不适合wgpu
3. C++开发者：bgfx/LLGL，wgpu生态不匹配

## 一句话学习总结
先补 Rust + 基础图形名词 → 跟着 learn-wgpu 逐章节手写代码吃透渲染流程 → 练习模型、光照、网页打包 → 最后做完整独立渲染项目，全程不用接触 Vulkan 底层复杂逻辑。