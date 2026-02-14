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

=======================================================================================

# 2. PCL（Point Cloud Library）点云库学习记录

https://github.com/HuangCongQing/pcl-learning.git

 
PCL（Point Cloud Library）点云库  **个人开发环境：Ubuntu18.04**
* 如有疑问，微信：shuangyu_ai 
  * **Plus: _可承接点云处理相关项目，欢迎私聊_**
  * **PCL微信交流群二维码每周都更新一次，请关注公众号【双愚】后台回复PCL加群**
  * 更多自动驾驶相关交流群，欢迎扫码加入：[自动驾驶感知(PCL/ROS+DL)：技术交流群汇总(新版)](https://mp.weixin.qq.com/s?__biz=MzI4OTY1MjA3Mg==&mid=2247486575&idx=1&sn=3145b7a5e9dda45595e1b51aa7e45171&chksm=ec2aa068db5d297efec6ba982d6a73d2170ef09a01130b7f44819b01de46b30f13644347dbf2#rd) 

* [**【本仓库测试pcd数据】**](./data)


**墙裂建议先看下：[PCL(Point Cloud Library)学习指南&资料推荐](https://zhuanlan.zhihu.com/p/268524083)**

**<font color='red'>PCL学习入门指南&代码实践(最新版)入门视频： </font> https://www.bilibili.com/video/BV1HS4y1y7AB**

**代码对应系列笔记：[PCL(Point Cloud Library)学习记录（最新）](https://www.yuque.com/huangzhongqing/pcl)**


<img src="assets/wechat_group(PCL).png" alt="微信交流群二维码" width="40%;" height="40%" />


**相关项目实战:**

* 3D-MOT(多目标检测和追踪):
  [https://github.com/HuangCongQing/3D-LIDAR-Multi-Object-Tracking/tree/kitti](https://github.com/HuangCongQing/3D-LIDAR-Multi-Object-Tracking/tree/kitti)
    * 需要学习ROS：https://github.com/HuangCongQing/ROS

@[双愚](https://github.com/HuangCongQing/pcl-learning) , 若fork或star请注明来源

> * 点云数据的处理可以采用获得广泛应用的Point Cloud Library (点云库，PCL库)。
> * PCL库是一个最初发布于2013年的开源C++库。它实现了大量点云相关的通用算法和高效的数据管理。
> * 支持多种操作系统平台，可在Windows、Linux、Android、Mac OS X、部分嵌入式实时系统上运行。如果说OpenCV是2D信息获取与处理的技术结晶，那么PCL在3D信息获取与处理上，就与OpenCV具有同等地位
> * PCL是BSD授权方式，可以免费进行商业和学术应用。

* 英文官网：https://pcl.readthedocs.io/projects/tutorials/en/latest/#
  * https://pointclouds.org/
* GitHub：https://github.com/PointCloudLibrary/pcl
  * 学习基于pcl1.9.1：https://github.com/PointCloudLibrary/pcl/tree/pcl-1.9.1

**Tips:**

* ubuntu下使用PCL，需要写**CMakeLists.txt**文件，然后编译才可以生成可执行文件.
* 可执行文件在build文件夹下，所以运行可执行文件时，后面添加参数的pcd文件，应放在build文件夹下才能获取到。**（注意文件路径）**
* `make -j `   (-j 自动多线程， -j4 四线程)
 
## 实战项目

不理解的地方,欢迎提issue: https://github.com/HuangCongQing/pcl-learning/issues

* 3D-MOT(多目标检测和追踪)
  * https://github.com/HuangCongQing/3D-LIDAR-Multi-Object-Tracking/tree/kitti
* 3D点云目标检测&语义分割-SOTA方法,代码,论文,数据集等
  * https://github.com/HuangCongQing/3D-Point-Clouds

## 相关链接

* 公众号：点云PCL
* https://github.com/Yochengliu/awesome-point-cloud-analysis
* https://github.com/QingyongHu/SoTA-Point-Cloud
* https://github.com/PointCloudLibrary/pcl
* 参考书籍：点云库PCL学习教程，朱德海，北京航空航天大学出版社
* Plus：ROS学习-https://github.com/HuangCongQing/ROS

**入门资料：**
- **<font color='red'>PCL学习入门指南&代码实践(最新版)入门视频： </font> https://www.bilibili.com/video/BV1HS4y1y7AB**
- **视频**：[bilibili-PCL点云库官网教程](https://space.bilibili.com/504859351/channel/detail?cid=130387)
- **点云库PCL学习教程书籍每章总结：**[https://github.com/MNewBie/PCL-Notes](https://github.com/MNewBie/PCL-Notes)
- 百度网盘资料：

链接：[https://pan.baidu.com/s/1ziq8s_kj5QpM8eXO_d6RJg](https://pan.baidu.com/s/1ziq8s_kj5QpM8eXO_d6RJg)<br />提取码：g6ny<br />

**代码实践资料：**

- 官方各模块示例(和对应的对象函数对照着看)【英文】：[https://pcl.readthedocs.io/projects/tutorials/en/latest/#](https://pcl.readthedocs.io/projects/tutorials/en/latest/#)
- 官方各模块对应的对象和函数【英文】：
  - [https://pointclouds.org/documentation/modules.html](https://pointclouds.org/documentation/modules.html)
  - [https://pointclouds.org/](https://pointclouds.org/) 点击网站中的12宫图，没一格对应一个模块的对象函数详解
- [黑马机器人系列文档：PCL-3D点云](http://robot.czxy.com/docs/pcl/)：[http://robot.czxy.com/docs/pcl/](http://robot.czxy.com/docs/pcl/)
- [CSDN博主系列文章PCL学习(64篇)](https://www.cnblogs.com/li-yao7758258/category/954066.html)：[https://www.cnblogs.com/li-yao7758258/category/954066.html](https://www.cnblogs.com/li-yao7758258/category/954066.html)
 
============================================================

# 3.pcl 和 PyCOLMAP的关系

