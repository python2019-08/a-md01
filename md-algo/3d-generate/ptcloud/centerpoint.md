# 1.CenterPoint 的使用方法 
你想了解 CenterPoint 的使用方法，核心是掌握「环境搭建→数据准备→模型训练/推理→适配点云场景」的完整流程。
CenterPoint 是基于点云的 3D 目标检测经典模型，特别适配你的**路面三维重建课题**（比如检测路面车辆、井盖、裂缝等目标），下面我会结合你的场景给出可直接落地的实操指南。

### 一、核心前提：环境搭建（适配你的 `img-modeling` 环境）
CenterPoint 依赖 MMDet3D（OpenMMLab 生态），需先在你已创建的 `img-modeling` 环境中安装全套依赖：

#### 1. 激活 conda 环境
```bash
conda activate img-modeling
```

#### 2. 安装基础依赖（适配 Python 3.10）
```bash
# 安装PyTorch（带CUDA加速，必须匹配CUDA版本）
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118

# 安装MMDet3D及依赖（CenterPoint核心依赖）
pip install openmim
mim install mmcv-full==1.7.1
mim install mmdet==2.28.2
mim install mmsegmentation==0.30.0
pip install mmdet3d==1.1.1

# 安装点云处理额外依赖
pip install numpy==1.24.3 scipy plyfile open3d==0.17.0 numba tensorboard
```

#### 3. 克隆 CenterPoint 官方仓库
```bash
git clone https://github.com/tianweiy/CenterPoint.git
cd CenterPoint
# 安装仓库依赖
pip install -r requirements.txt
python setup.py develop
```

### 二、快速上手：用预训练模型跑通示例（新手友好）
先跑通官方 KITTI 数据集示例，理解模型基本用法，再适配你的路面点云场景。

#### 1. 下载 KITTI 数据集（3D检测基准）
```bash
# 下载KITTI 3D检测数据集（需科学上网，或手动下载）
bash tools/data/kitti/download_kitti.sh
# 数据预处理（生成CenterPoint需要的格式）
python tools/data/kitti/process_kitti_data.py --root_path ./data/kitti --out_dir ./data/kitti/processed
```

#### 2. 下载预训练模型
从 [CenterPoint 官方模型库](https://github.com/tianweiy/CenterPoint/blob/master/MODEL_ZOO.md) 下载 KITTI 预训练权重（如 `centerpoint_voxel01_second_secfpn_8xb4-cyclic-20e_kitti-3d-car.pth`），放到 `./work_dirs/` 目录。

#### 3. 运行推理（单帧点云检测示例）
```bash
# 用预训练模型推理KITTI点云
python demo/pcd_demo.py \
    configs/centerpoint/centerpoint_voxel01_second_secfpn_8xb4-cyclic-20e_kitti-3d-car.py \
    work_dirs/centerpoint_voxel01_second_secfpn_8xb4-cyclic-20e_kitti-3d-car.pth \
    data/kitti/processed/velodyne/000001.bin \
    --out-dir ./demo_output
```
- 输出：`./demo_output` 下会生成检测结果可视化图，标注出车辆的 3D 框；
- 核心参数：
  - 第一个参数：模型配置文件（定义网络结构、数据格式）；
  - 第二个参数：预训练权重；
  - 第三个参数：输入点云文件（KITTI 是 .bin 格式，后续需转换你的路面点云）。

### 三、适配你的课题：处理路面点云（核心步骤）
你的场景是「手机重建的路面点云」（.ply/.pcd 格式），需将 CenterPoint 适配路面目标检测（如井盖、裂缝、坑洼等），关键步骤如下：

#### 1. 点云格式转换（适配 CenterPoint 输入）
CenterPoint 要求输入为 **N×4（x,y,z,intensity）** 的点云（前3列坐标，第4列强度），需转换你的路面点云：
```python
import open3d as o3d
import numpy as np

def convert_road_pcd_to_bin(ply_path, bin_path):
    """
    将路面.ply点云转换为CenterPoint支持的.bin格式（N×4）
    若点云无强度信息，默认填充1.0
    """
    # 加载路面点云
    pcd = o3d.io.read_point_cloud(ply_path)
    points = np.asarray(pcd.points)  # (N, 3) 坐标
    
    # 1. 点云预处理（降噪+裁剪，只保留路面区域）
    # 去除离群点
    cl, ind = pcd.remove_statistical_outlier(nb_neighbors=20, std_ratio=2.0)
    points = points[ind]
    # 裁剪路面范围（根据你的采集场景调整坐标范围）
    mask = (points[:, 0] > -5) & (points[:, 0] < 5) & \
           (points[:, 1] > -5) & (points[:, 1] < 5) & \
           (points[:, 2] > -0.5) & (points[:, 2] < 0.5)
    points = points[mask]
    
    # 2. 添加强度列（无强度则填充1.0）
    intensity = np.ones((points.shape[0], 1))  # 强度默认1.0
    points_with_intensity = np.hstack([points, intensity])  # (N, 4)
    
    # 3. 保存为.bin格式（float32）
    points_with_intensity = points_with_intensity.astype(np.float32)
    points_with_intensity.tofile(bin_path)
    
    return points_with_intensity

# 调用：转换你的10米路面点云
road_points = convert_road_pcd_to_bin("road_10m.ply", "road_10m.bin")
print(f"转换后点云形状：{road_points.shape}")  # (N, 4) 符合输入要求
```

#### 2. 修改配置文件（适配路面检测）
复制官方配置文件，修改为路面检测专用配置（以检测井盖为例）：
```python
# 新建 configs/centerpoint/centerpoint_road.py
_base_ = ['./centerpoint_voxel01_second_secfpn_8xb4-cyclic-20e_kitti-3d-car.py']

# 1. 修改类别（适配路面目标）
class_names = ['manhole', 'pothole', 'crack']  # 井盖、坑洼、裂缝
num_classes = len(class_names)

# 2. 修改点云范围（适配10米路面）
point_cloud_range = [-5, -5, -0.5, 5, 5, 0.5]  # xmin, ymin, zmin, xmax, ymax, zmax

# 3. 修改数据加载（指向你的路面数据集）
data_root = './data/road/'
train_dataloader = dict(
    dataset=dict(
        data_root=data_root,
        ann_file='train/annotations.json',
        pipeline=_base_.train_pipeline,
        classes=class_names,
        modality=dict(use_lidar=True, use_camera=False),
    )
)
val_dataloader = dict(
    dataset=dict(
        data_root=data_root,
        ann_file='val/annotations.json',
        classes=class_names,
    )
)

# 4. 修改模型输出类别数
model = dict(
    bbox_head=dict(
        num_classes=num_classes,
        anchor_generator=dict(
            ranges=[[-5, -5, -0.5, 5, 5, 0.5]],  # 匹配路面点云范围
            sizes=[[0.5, 0.5, 0.1]],  # 井盖尺寸（长×宽×高）
        )
    )
)
```

#### 3. 数据标注与训练（路面目标检测）
CenterPoint 训练需要标注数据，推荐用以下工具和流程：
1. **标注工具**：用 [Label3D](https://github.com/kujason/label3d) 标注路面点云，输出 JSON 格式标注文件；
2. **标注格式转换**：将 Label3D 标注转换为 MMDet3D 支持的格式（参考 `tools/data/kitti/process_kitti_data.py`）；
3. **启动训练**：
```bash
# 训练CenterPoint检测路面目标（单GPU）
python tools/train.py \
    configs/centerpoint/centerpoint_road.py \
    --work-dir ./work_dirs/road_detection \
    --gpu-id 0
```

#### 4. 推理与可视化（检测你的路面点云）
训练完成后，对新的路面点云做检测：
```python
from mmdet3d.apis import init_model, inference_detector
import open3d as o3d
import numpy as np

# 1. 初始化模型
config_file = 'configs/centerpoint/centerpoint_road.py'
checkpoint_file = 'work_dirs/road_detection/epoch_100.pth'
model = init_model(config_file, checkpoint_file, device='cuda:0')

# 2. 推理你的路面点云
pcd_path = 'road_10m.bin'
result, data = inference_detector(model, pcd_path)

# 3. 可视化检测结果
def visualize_road_detection(ply_path, result):
    # 加载原始点云
    pcd = o3d.io.read_point_cloud(ply_path)
    points = np.asarray(pcd.points)
    
    # 提取检测框（以井盖为例）
    pred_3d_boxes = result.pred_instances_3d.bboxes_3d.cpu().numpy()
    # 绘制3D框
    for box in pred_3d_boxes:
        # 转换box为Open3D的AxisAlignedBoundingBox
        min_bound = box[:3] - box[3:6]/2
        max_bound = box[:3] + box[3:6]/2
        aabb = o3d.geometry.AxisAlignedBoundingBox(min_bound, max_bound)
        aabb.color = (1, 0, 0)  # 红色框标注目标
        pcd.scene.add_geometry(aabb)
    
    # 可视化
    o3d.visualization.draw_geometries([pcd])

# 调用可视化
visualize_road_detection("road_10m.ply", result)
```

### 四、关键注意事项（避坑指南）
1. **点云范围**：CenterPoint 对输入点云范围敏感，必须根据你的10米路面调整 `point_cloud_range`（建议 x/y 范围 ±5 米，z 范围 ±0.5 米）；
2. **锚框尺寸**：需根据路面目标实际尺寸调整 `anchor_generator.sizes`（如井盖：0.5×0.5×0.1 米，坑洼：1×1×0.2 米）；
3. **数据量**：路面标注数据至少需要50+帧点云，否则模型过拟合，可先用 KITTI 预训练权重微调（迁移学习）；
4. **算力要求**：训练需 GPU 显存 ≥ 12GB（如 RTX 3060/3090），若显存不足，降低 `batch_size` 至 2/4。

### 总结
1. 核心流程：`环境搭建（MMDet3D）→ 点云格式转换（.ply→.bin）→ 修改配置文件 → 数据标注 → 训练/推理 → 可视化`；
2. 适配路面场景的关键：调整点云范围、锚框尺寸，补充路面目标标注数据；
3. 新手优先：先跑通 KITTI 示例，再替换成你的路面点云，用预训练权重微调（而非从零训练）。

如果需要，我可以帮你写一份**针对10米路面点云的CenterPoint完整配置+推理脚本**，直接替换点云路径就能检测路面目标（如井盖、坑洼），适配你的课题需求。