# bgfx 完整学习路线（C++ 跨平台图形封装，规避 Vulkan/Metal/DX 繁琐底层）
## 一、前置基础
### 1. 语言基础
- C++ 基础：类、RAII、智能指针、容器、指针，能看懂面向对象代码
- 不用精通现代C++20，但至少掌握 C++11 以上
> 对比 wgpu：bgfx 是纯C++，无内存安全保护，资源要手动管理，RAII 靠自己规范

### 2. 图形基础（和 wgpu 通用，不用重学）
核心概念必须懂：
顶点缓冲、索引缓冲、Uniform、纹理/采样器、渲染管线、帧缓冲、深度测试、MVP矩阵、着色器
**不需要提前学 Vulkan/Metal/DX12**，bgfx 完全屏蔽底层API细节

### 3. 着色器相关（bgfx 和 wgpu 最大区别）
wgpu：统一 WGSL；
bgfx：自研着色器预编译工具 `shaderc`，一套 .sc 源码，一键编译输出 GLSL/HLSL/MSL/SPIR-V 多平台着色器
需要学会：
- bgfx 专属着色器语法 `.sc`
- `varying.def.sc` 共享变量定义
- 使用 `shaderc` 批量编译着色器

## 二、环境搭建（3种主流方式）
### 方式1：官方仓库一键编译（推荐，完整示例）
仓库：https://github.com/bkaradzic/bgfx
配套依赖 bx（工具库）、bimg（图片加载），三者绑定使用
```
bgfx/
├── bx    基础工具：数学、文件、线程、内存
├── bimg  图片解码、纹理处理
├── examples  上百个可运行Demo（学习核心素材）
```
编译支持：Windows(VS)、macOS(Xcode)、Linux(Make)、Android、iOS、WebGL
1. 克隆仓库 `git clone --recursive`（必须递归拉子模块）
2. 执行 `gen/` 下对应脚本生成工程文件
3. 直接编译 examples，一键运行三角形、3D模型、PBR、后处理等Demo

### 方式2：CMake 集成到自有项目
适合已有C++工程，单独链接 bgfx 静态库
要点：
- 链接 `bgfx.lib` `bimg.lib` `bx.lib`
- 运行时拷贝 shaders、textures 资源目录
- 初始化窗口可搭配：GLFW / SDL / 原生Win32/Cocoa

### 方式3：单头文件简易集成（轻量工具）
bgfx 提供单文件分发，适合小型工具、嵌入式快速验证

### 最小初始化代码模板（固定流程）
1. 配置 bgfx 初始化参数 `bgfx::Init`（渲染后端、分辨率、Debug标记）
2. `bgfx::init()` 启动图形设备（自动选用 Vulkan/DX12/Metal/GL）
3. 创建窗口/交换链视图
4. 每一帧标准循环：
   - 设置视图 `bgfx::setView`（视口、相机、清屏色、深度）
   - 绑定顶点/索引缓冲、纹理、Uniform
   - 设置材质程序（编译好的着色器）
   - 提交绘制 `bgfx::submit(viewID)`
   - 帧收尾 `bgfx::frame()`
5. 退出销毁资源 `bgfx::shutdown()`

## 三、核心学习资料（优先级从高到低）
### 1. 官方 examples（最重要，必看）
仓库 examples 分梯度覆盖全部功能，循序渐进：
1. hello-triangle：最简入门，绘制三角形
2. hello-texture：贴图、采样器
3. hello-cube：3D、MVP矩阵、深度缓冲
4. hello-pbr：标准金属粗糙度PBR渲染
5. hello-shadow：阴影贴图
6. hello-offscreen：离屏渲染、渲染到纹理
7. hello-compute：Compute Shader 通用计算
8. 多线程资源加载、实例化渲染、MSAA、HDR、后处理、骨骼动画、glTF加载

特点：代码精简、注释清晰，每个Demo只演示单一功能，复制改造极易。

### 2. 官方文档
官网：https://bkaradzic.github.io/bgfx/
- API Reference：所有 `bgfx::` 函数、枚举、结构体完整说明
- 着色器工具 shaderc 使用文档
- 跨平台编译、Web 打包、Android/iOS 移植教程

### 3. 着色器文档（shaderc）
bgfx 着色器是独立体系，重点掌握：
- `attribute` 顶点输入
- `varying` 顶点/片元传递数据
- `uniform` 全局常量缓冲区
- `sampler2D` 纹理采样
- `#ifdef BGFX_*` 平台宏区分底层API差异

### 4. 社区项目参考
- Urho3D / Ogre3D 部分分支使用 bgfx 作为渲染后端
- 大量独立游戏、数字孪生编辑器、离线渲染工具开源工程

## 四、分阶段学习计划（3阶段，总周期约20天）
### 阶段1：入门基础（5天，目标：画出3D立方体）
1. 编译运行 hello-triangle，拆解完整渲染循环
2. 吃透核心顶层API（bgfx 设计精髓：**全部操作延迟提交**）
   bgfx 所有 setXXX 函数不直接调用GPU，只是写入命令缓存，`submit/frame` 统一批量提交，自动处理同步、屏障、资源布局，这是对比原生Vulkan最大简化
3. 学习缓冲资源管理：
   - `bgfx::createVertexBuffer` / `createIndexBuffer`
   - `bgfx::createUniform` 全局参数
   - `bgfx::createTexture2D` 纹理加载
4. 学会 shaderc 编译 `.sc` 着色器，修改顶点/片元逻辑观察画面变化
5. 实操任务：自定义立方体，更换纹理、调整相机视角

#### 必须吃透的核心概念（bgfx独有）
1. **View（视图）**
   替代传统Framebuffer+渲染通道，一个View对应一个渲染层，可分层渲染UI、3D场景、阴影，极简管理多渲染目标
2. 延迟提交架构
   无需手动管理CommandBuffer、命令池，完全由bgfx内部处理
3. 自动后端切换
   同一套代码Windows走DX12、macOS Metal、Linux Vulkan、Web走WebGL，无需平台分支代码

### 阶段2：进阶实战（10天，目标：搭建完整PBR场景查看器）
1. 学习相机系统：正交/透视投影、轨道相机
2. PBR完整管线：法线贴图、金属粗糙度、多光源
3. 离屏渲染、阴影贴图、多Pass渲染
4. 实例化渲染批量绘制上千物体
5. 后处理管线：泛光、模糊、色调映射
6. glTF模型加载、骨骼动画
7. 多线程异步加载纹理、模型资源
8. Web平台编译打包（Emscripten），网页运行bgfx程序

实操项目：做简易模型浏览器，支持拖拽模型、切换材质、开关阴影/后处理

### 阶段3：高级拓展（长期，对标商用渲染器）
1. Compute Shader 粒子系统、流体模拟、并行数据计算
2. MSAA、HDR、渲染管线状态封装
3. 对接GUI：Dear ImGui + bgfx（主流组合）
4. 底层拓展：获取原生 VkDevice/MTLDevice/DX12 句柄，对接硬件特有拓展
5. 移动端适配：Android/iOS 打包、性能优化
6. 资源池封装，统一管理Buffer/Texture/Program生命周期，避免内存泄漏

## 五、bgfx vs wgpu 学习差异（你之前关注wgpu，重点区分）
| 维度 | bgfx(C++) | wgpu(Rust) |
|------|-----------|------------|
| 语言 | C++，手动资源销毁，易泄漏 | Rust所有权，自动释放，内存安全 |
| 着色器 | .sc 预编译，多平台输出多套着色器 | WGSL统一单一份着色器 |
| 跨Web | WebGL2，无WebGPU原生支持 | 完整WebGPU，性能更强 |
| 底层可控 | 可获取原生API句柄，自由度高 | 原生句柄访问有限 |
| 架构 | 延迟提交View分层渲染 | Encoder编码器模式 |
| 社区 | C++商用项目居多 | Rust独立游戏、Bevy引擎生态 |
| 上手坑 | 忘记销毁资源导致显存泄漏 | 所有权编译期报错，调试友好 |

## 六、高频踩坑避坑指南
1. **资源忘记销毁**
   bgfx 所有 createXX 创建的资源（Buffer/Texture/Program）必须调用 `bgfx::destroy()`，否则显存持续泄漏；建议封装RAII智能指针自动释放。
2. 着色器编译失败
   必须使用配套 shaderc，不能直接手写GLSL/HLSL；`.sc` 的 varying 必须和 varying.def.sc 匹配。
3. 窗口缩放画面黑屏
   窗口大小变化后，需要重建View分辨率、交换链，更新投影矩阵。
4. 顺序问题：setView 必须在绘制指令之前，frame 每一帧末尾调用。
5. Web平台限制：Compute、部分硬件拓展在Emscripten下不可用。
6. 频繁创建 Program（着色器管线）严重卡顿，全局缓存复用。

## 七、配套工具链清单
1. bx：数学库、文件IO、字符串、线程（替代glm、自有工具函数）
2. bimg：图片加载PNG/JPG/TGA，纹理压缩
3. shaderc：bgfx专属着色器编译器
4. 推荐搭配：GLFW（窗口）+ Dear ImGui（界面）
5. 建模：Blender导出glTF用于测试场景

## 八、选型&学习总结
1. 适合学 bgfx 的人群：
   - 主力开发C++，做桌面/安卓/iOS多平台3D工具、游戏
   - 需要深度底层硬件拓展能力，不想完全被高层抽象限制
   - 不需要 WebGPU，仅兼容WebGL网页即可
2. 学习最简路径：
   掌握C++基础图形概念 → 拉取bgfx完整仓库跑examples → 逐例拆解入门到PBR → 自制完整渲染Demo → 集成ImGui做工具
3. 核心优势：不用手写上千行Vulkan初始化代码，一套代码跨全平台，工业级稳定，大量商用项目落地。