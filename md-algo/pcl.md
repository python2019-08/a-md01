# 1.开源PCL的依赖

PCL（Point Cloud Library）的核心依赖可分为**必选依赖**（编译运行基础）和**可选依赖**（扩展功能支持），以下是跨平台（含Android NDK）适配的关键依赖清单：

### 一、必选依赖（核心功能必需）
- **Boost**：核心依赖（版本≥1.58），提供容器、线程、正则等基础工具，PCL大量模块依赖其线程和智能指针。
- **Eigen**：线性代数库（版本≥3.2），用于点云旋转、平移、矩阵运算等几何计算，是PCL算法的数学基础。
- **FLANN**：近邻搜索库（版本≥1.8），支持快速点云匹配、聚类等算法，PCL的特征提取、配准模块必需。
- **VTK**（可选但推荐）：可视化工具库（版本≥6.2），用于点云渲染、结果可视化，若仅需算法核心可禁用，但开发调试必备。

### 二、可选依赖（扩展功能支持）
- **OpenNI2**：用于深度相机（如Kinect）数据采集，需点云实时输入时必备。
- **CUDA**：GPU加速（版本≥8.0），支持大规模点云并行处理（如体素滤波、配准），Android端需结合NDK与GPU架构适配。
- **OpenCV**：图像处理库（版本≥3.0），用于点云与图像融合（如RGB-D点云生成、特征匹配）。
- **Qhull**：用于凸包计算、Delaunay三角化，PCL的表面重建模块（如泊松重建）可选依赖。
- **PCL IO模块依赖**：若需支持PLY、PCD等格式读写，需依赖`libpng`、`libjpeg`（图像编码）、`zlib`（压缩）。

### 三、Android NDK适配注意事项
1. 优先使用 **vcpkg** 或 **Android-cmake** 构建依赖，避免手动编译兼容性问题。
2. Boost需禁用`python`、`mpi`等不必要模块，仅保留`system`、`thread`、`filesystem`等核心组件，减少NDK编译体积。
3. VTK在Android端可仅编译`Rendering`、`IO`核心模块，禁用Qt等桌面依赖，需适配GLES渲染。
4. Eigen无需编译，直接引入头文件即可（纯模板库），建议使用静态链接避免运行时依赖。

### 四、依赖安装建议（跨平台）
- **Linux/macOS**：通过系统包管理器（apt、brew）安装：`sudo apt install libboost-all-dev libeigen3-dev libflann-dev libvtk7-dev`。
- **Windows**：用vcpkg一键安装：`vcpkg install pcl[core,visualization,io]:x64-windows`。
- **Android NDK**：参考PCL官方`android-cmake`脚本，或使用vcpkg的Android triplet（如`arm64-android`）构建交叉编译依赖。

需要我帮你整理 **Android NDK+CMake+PCL依赖配置的具体CMakeLists.txt模板** 吗？可直接用于编译PCL核心模块到Android平台。