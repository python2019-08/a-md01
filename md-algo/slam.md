# 1.学习slam算法难吗？  如果只是slam算法的应用，调参数，难吗

这是一个很好的问题，需要从不同层面来理解SLAM的难度。简单来说：

**SLAM算法本身（理论+研发）非常难，但SLAM算法的应用和调参可以相对简单。**

---

### **1. SLAM算法研发（非常难）**
#### **难度等级：★★★★★（极高）**
这需要深入理解以下核心领域：

| 领域 | 具体内容 | 难度 |
|------|----------|------|
| **数学基础** | 线性代数、矩阵论、概率论、图优化、李群李代数 | ★★★★ |
| **计算机视觉** | 特征提取、多视图几何、相机模型、光流法 | ★★★★ |
| **滤波与优化** | 卡尔曼滤波、粒子滤波、非线性优化（Gauss-Newton, Levenberg-Marquardt） | ★★★★☆ |
| **传感器融合** | IMU、激光雷达、相机的时间同步与标定 | ★★★★ |
| **工程实现** | C++高性能编程、实时系统、嵌入式部署 | ★★★☆ |

**适合人群**：研究生、算法工程师、有强烈数学和编程背景的研究人员。

---

### **2. SLAM算法应用与调参（中等难度）**
#### **难度等级：★★★☆☆（中等）**
这更像是 **"SLAM工程师"** 或 **"应用工程师"** 的工作：

#### **主要工作内容**：
1. **选择合适的SLAM框架**：
   - **视觉SLAM**：ORB-SLAM3、OpenVSLAM、VINS-Fusion
   - **激光SLAM**：Cartographer、HectorSLAM、LOAM
   - **多传感器**：VINS-Mono、LIO-SAM

2. **参数调优流程**：
   ```yaml
   # 以ORB-SLAM3的参数文件为例：
   Camera.fx: 535.0     # 相机内参（需要标定）
   Camera.fy: 535.0
   ORBextractor.nFeatures: 1000  # 特征点数量（影响精度/速度）
   ORBextractor.scaleFactor: 1.2 # 金字塔尺度因子
   ```

3. **常见调参场景**：
   - **精度优化**：调整特征点数量、匹配阈值、优化器参数
   - **实时性优化**：降低图像分辨率、减少特征点、简化后端优化
   - **鲁棒性优化**：应对动态物体、光照变化、快速运动

#### **需要的技能**：
| 技能 | 具体要求 | 学习难度 |
|------|----------|----------|
| **框架使用** | 理解各参数含义，会看文档和论文 | ★★☆ |
| **传感器标定** | 相机内参、IMU-相机外参标定 | ★★★ |
| **数据分析** | 使用EVO等工具评估轨迹精度 | ★★☆ |
| **问题诊断** | 通过日志和可视化定位问题源头 | ★★★ |

**适合人群**：机器人工程师、应用开发工程师、有基本编程和数学基础的技术人员。

---

### **3. 具体案例：调参难度分析**

#### **案例1：ORB-SLAM3在室内机器人上的调参**
```yaml
# 问题：在走廊环境中容易跟踪丢失
# 调参方案：
ORBextractor.nFeatures: 2000 → 3000    # 增加特征点
ORBextractor.scaleFactor: 1.2 → 1.1     # 减小尺度变化，增强重复纹理识别
ThDepth: 35 → 25                        # 调整深度阈值，改善三角化
```

**难度**：需要理解特征提取原理，但通过实验可以较快掌握。

#### **案例2：VINS-Fusion在无人机上的IMU参数**
```yaml
# 问题：无人机剧烈运动时轨迹漂移
# 调参方案：
acc_n: 0.019 → 0.01        # 调整加速度计噪声参数
gyr_n: 0.015 → 0.008       # 调整陀螺仪噪声参数
estimator_iterations: 4 → 6 # 增加优化迭代次数
```

**难度**：需要理解IMU预积分和噪声模型，相对专业。

---

### **4. 学习路径建议**

#### **如果只想做应用和调参**：
1. **基础阶段（1-2个月）**：
   - 学习Linux基础、C++编程
   - 掌握ROS（Robot Operating System）
   - 了解相机和传感器基本原理

2. **实践阶段（2-3个月）**：
   - 部署ORB-SLAM3，跑通官方Demo
   - 学习使用EVO进行轨迹精度评估
   - 尝试调整关键参数观察效果

3. **进阶阶段（3-6个月）**：
   - 掌握传感器标定（相机、IMU、联合标定）
   - 学习阅读论文中的参数说明部分
   - 参与实际机器人项目调参

#### **如果需要深入算法研发**：
- **需要额外2-3年**的系统学习，包括多门数学课程和大量论文阅读。

---

### **5. 工具和资源推荐**
| 工具类型 | 推荐工具 | 用途 |
|----------|----------|------|
| **SLAM框架** | ORB-SLAM3, VINS-Fusion, Cartographer | 直接应用 |
| **评估工具** | EVO, RPE/ATE指标 | 量化调参效果 |
| **可视化** | RViz, Pangolin | 实时调试 |
| **数据集** | KITTI, EuRoC, TUM | 测试验证 |

---

### **总结**
| 方向 | 难度 | 学习时间 | 适合人群 |
|------|------|----------|----------|
| **SLAM算法研发** | 极难 | 2-3年+ | 算法研究员、博士生 |
| **SLAM应用调参** | 中等 | 6-12个月 | 机器人工程师、开发者 |
| **单纯使用SLAM** | 简单 | 1-2个月 | 集成应用开发者 |

**结论**：如果只是做SLAM算法的应用和调参，通过系统学习和实践，**完全可以在半年到一年内掌握**。这更像是一门工程技术，而不是理论研究。
==============================================================
# 2.如果想从开源项目学习slam，应该以什么顺序学习哪些项目

学习SLAM从开源项目入手是很实用的方法。以下是建议的学习顺序和项目推荐：

## 1. **初级阶段：基础概念和理解**

### 推荐项目：
**ORB-SLAM2** (C++)
- GitHub: https://github.com/raulmur/ORB_SLAM2.git
   注释版本: https://github.com/electech6/ORB_SLAM2_detailed_comments.git
    android版本： https://github.com/FangGet/ORB_SLAM2_Android.git
- **学习重点**：
  - 完整的SLAM系统架构（前端、后端、回环检测）
  - 特征点法的经典实现
  - 多线程设计（跟踪、局部建图、回环检测）
- **建议学习顺序**：
  1. 先编译运行Demo
  2. 阅读论文理解算法流程
  3. 从主线程 `Tracking` 开始阅读代码

**PTAM** (C++)
- 现代特征点SLAM的鼻祖
- 代码相对简单，适合理解基本原理

## 2. **中级阶段：深入算法细节**

### 视觉SLAM方向：
**DSO** (Direct Sparse Odometry) (C++)
- GitHub: https://github.com/JakobEngel/dso
- **学习重点**：
  - 直接法SLAM
  - 稀疏直接法优化
  - 光度标定和误差模型

**LSD-SLAM** (C++)
- 大规模直接法SLAM
- 学习半稠密建图

### 激光SLAM方向：
**Cartographer** (C++)
- Google开源的2D/3D SLAM
- 学习图优化和子图管理

**LOAM** (C++)
- 激光里程计的经典算法

## 3. **高级阶段：现代方法和框架**

### 基于学习的SLAM：
**DROID-SLAM** (Python/PyTorch)
- 基于深度学习的SLAM
- 学习现代深度学习在SLAM中的应用

**ORB-SLAM3** (C++)
- github 
      https://github.com/UZ-SLAMLab/ORB_SLAM3.git
      https://github.com/electech6/ORB_SLAM3_detailed_comments.git
      https://github.com/mingjitianming/ORB_SLAM3_annotation.git
      https://github.com/zhouyong1234/ORB-SLAM3-GRID-MAP.git
      https://github.com/YWL0720/YOLO_ORB_SLAM3_with_pointcloud_map.git
      https://github.com/Abonaventure/ORB_SLAM3_AR-for-Android.git
- ORB-SLAM2的升级版，支持多传感器
- 学习多地图系统和IMU融合

### 优化库和框架：
**g2o** (C++)
- 图优化库，很多SLAM系统的后端
- 学习非线性优化原理

**Sophus** (C++)
-李群李代数库

**Ceres Solver** (C++)
- Google的非线性优化库

## 4. **具体学习路径建议**

### 第1-2个月：基础入门
```bash
# 1. 从ORB-SLAM2开始
git clone https://github.com/raulmur/ORB-SLAM2.git
cd ORB-SLAM2
chmod +x build.sh
./build.sh

# 2. 运行TUM数据集示例
./Examples/Monocular/mono_tum Vocabulary/ORBvoc.txt Examples/Monocular/TUM1.yaml PATH_TO_SEQUENCE_FOLDER
```

**学习步骤**：
1. 编译调试，理解项目结构
2. 阅读 `System.cc` → `Tracking.cc` → `LocalMapping.cc` → `LoopClosing.cc`
3. 修改参数观察效果

### 第3-4个月：算法深入
```bash
# 学习DSO，理解直接法
git clone https://github.com/JakobEngel/dso.git

# 学习g2o，理解后端优化
git clone https://github.com/RainerKuemmerle/g2o.git
```

### 第5-6个月：项目实践
- 尝试在真实数据上运行
- 修改算法模块（如特征提取、回环检测）
- 添加新功能（如保存地图、重定位）

## 5. **配套理论学习资源**

### 必读论文：
1. **ORB-SLAM** 系列论文（1,2,3）
2. **DSO: Direct Sparse Odometry**
3. **LSD-SLAM: Large-Scale Direct Monocular SLAM**
4. **Cartographer: Real-Time Loop Closure in 2D LIDAR SLAM**

### 书籍：
- 《视觉SLAM十四讲》- 高翔（中文最佳入门）
- 《Multiple View Geometry in Computer Vision》- Hartley
- 《State Estimation for Robotics》- Tim Barfoot

## 6. **实践项目建议**

### 模仿练习：
1. **实现简单的VO**：基于特征点的视觉里程计
2. **复现PnP求解**：理解位姿估计
3. **实现BA优化**：使用g2o或Ceres
4. **添加回环检测**：基于词袋模型

### 进阶挑战：
```cpp
// 示例：尝试改进ORB-SLAM2的某个模块
class ImprovedFeatureExtractor : public ORB_SLAM2::ORBextractor {
public:
    void operator()(cv::InputArray image, std::vector<cv::KeyPoint>& keypoints, cv::OutputArray descriptors) {
        // 改进特征提取逻辑
    }
};
```

## 7. **工具和环境准备**

### 必备工具：
```bash
# 环境
- Ubuntu 18.04/20.04
- OpenCV 3.4+
- Eigen3
- Pangolin (可视化)
- ROS (可选，但推荐)

# 调试工具
- gdb
- valgrind
- cmake
- g2o/sophus/DBoW2
```

## 8. **学习路线图总结**

| 阶段 | 时间 | 主要项目 | 目标 |
|------|------|----------|------|
| **基础** | 1-2月 | ORB-SLAM2, PTAM | 理解SLAM流程 |
| **进阶** | 2-3月 | DSO, g2o | 掌握优化方法 |
| **深入** | 2-3月 | ORB-SLAM3, 激光SLAM | 多传感器融合 |
| **实践** | 2-3月 | 自选项目改进 | 独立开发能力 |

## 9. **常见问题解决**

### 编译问题：
```bash
# ORB-SLAM2常见问题解决
sudo apt-get install libblas-dev liblapack-dev
sudo apt-get install libpython2.7-dev  # 解决Pangolin问题
```

### 数据集准备：
- TUM Dataset: 单目、RGB-D基准
- KITTI: 自动驾驶场景
- EuRoC: 无人机MAV数据

**最重要的建议**：不要只看不练，边读代码边实践，从运行→理解→修改→创新逐步深入。每个项目至少花费1-2个月时间认真研究。

==============================================================
# 3. android ndk 如何查询 相机镜头个数，如何从某个相机镜头获取图片

在 Android NDK 中查询相机镜头个数并获取特定镜头的图像，需要结合 **Camera2 API** 或 **NDK Camera API**（Android 11+）。以下是分步指南：

---

### **1. 查询相机镜头个数（NDK）**
#### **方法1：使用 `ACameraManager` (Android NDK Camera API)**
```cpp
#include <camera/NdkCameraManager.h>

void queryCameraLenses(ACameraManager* cameraManager) {
    ACameraIdList* cameraIdList = nullptr;
    camera_status_t status = ACameraManager_getCameraIdList(cameraManager, &cameraIdList);
    
    if (status == ACAMERA_OK) {
        for (int i = 0; i < cameraIdList->numCameras; ++i) {
            const char* cameraId = cameraIdList->cameraIds[i];
            
            // 获取相机特性
            ACameraMetadata* metadata = nullptr;
            status = ACameraManager_getCameraCharacteristics(cameraManager, cameraId, &metadata);
            
            if (status == ACAMERA_OK) {
                // 检查镜头方向（前置/后置）
                acamera_metadata_enum_android_lens_facing_t lensFacing;
                ACameraMetadata_const_entry entry;
                if (ACameraMetadata_getConstEntry(metadata, ACAMERA_LENS_FACING, &entry) == ACAMERA_OK) {
                    lensFacing = static_cast<acamera_metadata_enum_android_lens_facing_t>(entry.data.u8[0]);
                    __android_log_print(ANDROID_LOG_INFO, "CameraNDK", 
                        "Camera %s: Lens facing %d", cameraId, lensFacing);
                }
                
                // 检查物理镜头数量（多摄设备）
                if (ACameraMetadata_getConstEntry(metadata, ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_IDS, &entry) == ACAMERA_OK) {
                    __android_log_print(ANDROID_LOG_INFO, "CameraNDK",
                        "Camera %s has %d physical lenses", cameraId, entry.count);
                }
                
                ACameraMetadata_free(metadata);
            }
        }
        ACameraManager_deleteCameraIdList(cameraIdList);
    }
}

// 调用示例
ACameraManager* cameraManager = ACameraManager_create();
queryCameraLenses(cameraManager);
ACameraManager_delete(cameraManager);
```

#### **关键点**
- **`ACAMERA_LENS_FACING`**：判断镜头方向（`ACAMERA_LENS_FACING_FRONT` / `ACAMERA_LENS_FACING_BACK`）
- **`ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_IDS`**：获取物理镜头ID（多摄设备）

---

### **2. 从特定镜头获取图像（NDK）**
#### **步骤1：打开指定相机**
```cpp
ACameraDevice* cameraDevice = nullptr;
ACameraManager_openCamera(cameraManager, cameraId, &deviceStateCallbacks, &cameraDevice);
```

#### **步骤2：创建捕获会话**
```cpp
ACaptureSessionOutputContainer* outputs = nullptr;
ACaptureSessionOutput_create(window, &outputs);

ACameraCaptureSession* session = nullptr;
ACameraDevice_createCaptureSession(cameraDevice, &outputs, &sessionStateCallbacks, &session);
```

#### **步骤3：配置图像请求**
```cpp
ACaptureRequest* request = nullptr;
ACameraDevice_createCaptureRequest(cameraDevice, TEMPLATE_PREVIEW, &request);

// 添加目标输出表面（如ANativeWindow）
ANativeWindow* imageReaderWindow = ...; // 从ImageReader获取
ACaptureSessionOutput* output = nullptr;
ACaptureSessionOutput_create(imageReaderWindow, &output);
ACaptureRequest_addTarget(request, output);
```

#### **步骤4：开始连续捕获**
```cpp
ACameraCaptureSession_setRepeatingRequest(session, &request, 1, &captureCallbacks, nullptr);
```

---

### **3. 完整流程示例（获取后置镜头图像）**
```cpp
#include <android/native_window.h>
#include <camera/NdkCameraManager.h>
#include <camera/NdkCameraDevice.h>
#include <camera/NdkCameraCaptureSession.h>

// 1. 初始化相机管理器
ACameraManager* cameraManager = ACameraManager_create();

// 2. 查找后置相机ID
const char* backCameraId = nullptr;
ACameraIdList* cameraIdList = nullptr;
ACameraManager_getCameraIdList(cameraManager, &cameraIdList);

for (int i = 0; i < cameraIdList->numCameras; ++i) {
    ACameraMetadata* metadata = nullptr;
    ACameraManager_getCameraCharacteristics(cameraManager, cameraIdList->cameraIds[i], &metadata);
    
    acamera_metadata_enum_android_lens_facing_t facing;
    ACameraMetadata_const_entry entry;
    ACameraMetadata_getConstEntry(metadata, ACAMERA_LENS_FACING, &entry);
    facing = static_cast<acamera_metadata_enum_android_lens_facing_t>(entry.data.u8[0]);
    
    if (facing == ACAMERA_LENS_FACING_BACK) {
        backCameraId = cameraIdList->cameraIds[i];
        break;
    }
}

// 3. 打开相机
ACameraDevice* cameraDevice = nullptr;
ACameraManager_openCamera(cameraManager, backCameraId, &deviceCallbacks, &cameraDevice);

// 4. 创建ImageReader获取图像
AImageReader* imageReader = nullptr;
AImageReader_new(1920, 1080, AIMAGE_FORMAT_YUV_420_888, 3, &imageReader);
ANativeWindow* readerWindow = nullptr;
AImageReader_getWindow(imageReader, &readerWindow);

// 5. 创建捕获会话
ACaptureSessionOutputContainer* outputs = nullptr;
ACaptureSessionOutputContainer_create(&outputs);
ACaptureSessionOutput* sessionOutput = nullptr;
ACaptureSessionOutput_create(readerWindow, &sessionOutput);
ACaptureSessionOutputContainer_add(outputs, sessionOutput);

ACameraCaptureSession* session = nullptr;
ACameraDevice_createCaptureSession(cameraDevice, outputs, &sessionCallbacks, &session);

// 6. 创建捕获请求
ACaptureRequest* request = nullptr;
ACameraDevice_createCaptureRequest(cameraDevice, TEMPLATE_PREVIEW, &request);
ACaptureRequest_addTarget(request, sessionOutput);

// 7. 开始预览
ACameraCaptureSession_setRepeatingRequest(session, &request, 1, nullptr, nullptr);

// 8. 从ImageReader获取图像（回调中处理）
AImageReader_setImageListener(imageReader, &imageListener);
```

---

### **4. 关键注意事项**
1. **权限要求**：
   ```xml
   <uses-permission android:name="android.permission.CAMERA" />
   ```
   - Android 10+ 需要动态申请权限

2. **API 兼容性**：
   - NDK Camera API 需要 **Android 8.0 (API 24)+**
   - 多镜头支持需要 **Android 11 (API 30)+**

3. **多镜头设备**：
   - 通过 `ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_IDS` 获取物理镜头列表
   - 使用 `ACameraDevice_createCaptureRequest_withPhysicalIds` 指定物理镜头

4. **性能优化**：
   - 使用 `AImageReader` 直接获取YUV数据，避免Java层拷贝
   - 设置合适的 `AIMAGE_FORMAT`（如 `AIMAGE_FORMAT_YUV_420_888`）

---

### **5. 替代方案（Java层交互）**
如果 NDK 方案太复杂，可以通过 JNI 调用 Java 的 `Camera2 API`：
```java
// Java层代码
CameraManager manager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
String[] cameraIds = manager.getCameraIdList();
for (String id : cameraIds) {
    CameraCharacteristics characteristics = manager.getCameraCharacteristics(id);
    Integer facing = characteristics.get(CameraCharacteristics.LENS_FACING);
    if (facing != null && facing == CameraCharacteristics.LENS_FACING_BACK) {
        // 打开后置相机
    }
}
```

---

### **总结**
| 任务 | NDK API | 关键步骤 |
|------|---------|----------|
| **查询镜头数** | `ACameraManager_getCameraIdList` | 检查 `ACAMERA_LENS_FACING` |
| **获取图像** | `AImageReader` + `ACameraCaptureSession` | 配置目标输出表面 |
| **多镜头支持** | `ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_IDS` | 物理镜头ID列表 |

建议优先使用 **NDK Camera API**（Android 11+）以获得最佳性能，低版本设备可通过 JNI 调用 Java API 实现兼容。
=======================================================
# 4.为什么工程上选择VINS而不是ORB-SLAM？

本人做无人机自主导航，发现很多公司在工程上是用VINS（VINS-Mono或VINS-Fusion）做里程计，而不是ORB-SLAM，但是据我了解ORB-SLAM比VINS效果更好，这是为什么呢？
https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
https://github.com/QingSimon/VINS-Mono-code-annotation.git


https://github.com/HKUST-Aerial-Robotics/VINS-Fusion.git
https://github.com/kuankuan-yue/VINS-FUSION-leanrning.git

=========================================================

# 5.VIO 算法

VIO即**视觉惯性里程计（Visual-Inertial Odometry）**，是融合相机视觉信息与惯性测量单元（IMU）数据，实时估算设备位姿、速度、运动轨迹等状态的核心算法，常作为SLAM系统的基础模块，解决GPS失效场景下的定位导航问题，广泛应用于无人机、机器人、AR/VR等设备。以下是其核心内容的详细介绍：
1. **核心优势：视觉与IMU的互补融合**
    单独的视觉或IMU导航均存在明显缺陷，VIO通过融合二者实现优势互补，具体对比如下：
    |模块|单独使用的缺陷|在VIO中的作用|
    | ---- | ---- | ---- |
    |视觉（相机）|尺度不确定、单目纯旋转无法估计、快速运动易丢失特征|校正IMU的零偏误差，抑制位姿漂移，提供精准的环境特征约束|
    |IMU|零偏导致累计漂移、低精度设备积分位姿易发散|提供高频运动响应，补充视觉帧间的运动信息，同时解决视觉的尺度模糊问题|
2.  **主流分类方式**
    VIO有两种核心分类维度，不同分类对应不同的技术路线和性能特点：
    - **按数据融合方式分**
        1.  **松耦合**：先分别通过视觉里程计（VO）和IMU积分得到各自的位姿结果，再用卡尔曼滤波等算法对两个结果做后处理融合。融合过程不改变视觉和IMU的原始参数，计算量小，但精度和鲁棒性较弱，典型算法如SSF、MSF。
        2.  **紧耦合**：将图像特征、IMU测量值直接纳入同一状态方程进行联合优化，融合过程会同步修正IMU零偏、视觉尺度等参数。虽计算量更大，但精度和鲁棒性显著更优，是当前主流方案，典型算法如VINS-Mono、ORB-SLAM3。
    -  **按核心求解框架分**
        1.  **基于滤波**：以扩展卡尔曼滤波（EKF）及其改进算法为核心，如多状态约束卡尔曼滤波（MSCKF）。通过IMU预测位姿，再用视觉特征校正预测结果，适合实时性要求高的场景，典型代表为OpenVINS。
        2.  **基于优化**：将位姿估计转化为非线性最小二乘问题，通过优化滑动窗口内的帧间约束降低误差，如基于图优化、L-M算法等。精度更高，适合对定位精度要求高的场景，典型代表为ORB-SLAM3、Basalt。
3.  **核心工作流程**
    VIO的工作流程围绕“数据采集 - 预处理 - 融合优化 - 状态输出”展开，具体步骤如下：
    1.  **数据采集**：相机以30帧/秒以上的帧率采集环境图像，IMU以数百赫兹的高频输出三轴加速度和角速度数据。
    2.  **预处理**：视觉端通过ORB等算法提取图像角点等特征，生成描述子并完成帧间特征匹配；IMU端进行预积分运算，计算相邻帧间的运动增量，同时初步估计零偏误差。
    3.  **初始化**：通过单目视觉SFM（运动恢复结构）估计帧间位姿和路标点，再与IMU预积分结果对齐，求解出尺度、IMU零偏等关键初始参数。
    4.  **融合优化**：滤波类方法通过IMU预测位姿，结合视觉特征更新状态；优化类方法通过滑动窗口优化，最小化视觉重投影误差和IMU积分误差。
    5.  **状态输出**：实时输出设备的位置、姿态、速度和运动轨迹，为后续地图构建等提供基础数据。
4.  **经典开源算法**
    目前有多个成熟的开源VIO算法，适配不同场景需求，核心代表如下：
    |算法|核心框架|特点|
    | ---- | ---- | ---- |
    |VINS-Mono|紧耦合+滑动窗口优化|香港科技大学开源，适配单目+IMU，支持IMU零偏估计和外参在线标定，鲁棒性强，适合消费级设备|
    |ORB-SLAM3|特征点法+图优化（G2O库）|支持视觉、视觉 - 惯性等多种模式，通过多地图关联和全局BA优化提升精度，精度高但计算量较大|
    |OpenVINS|特征点+MSCKF|基于多状态约束卡尔曼滤波，采用观测压缩等技术，实时性优，适合对延迟敏感的场景|
    |Basalt|特征点法+L-M优化|设计两级SLAM系统，采用QR分解边缘化实现并行计算，不依赖第三方优化库，效率高于多数非滤波类算法|
    |DM-VIO|稀疏直接法+最小二乘|采用延迟边缘化策略，精度表现优异，但对光照变化较敏感|