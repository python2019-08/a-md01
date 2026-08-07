

# 2.适合 rtx 3060ti 显卡的高斯泼溅 的简化版本

对于 RTX 3060 Ti 这种 8GB 显存的显卡，运行原生 3D Gaussian Splatting (3DGS) 确实比较吃力（官方推荐通常为 24GB）。 
你可以使用以下简化版框架或优化策略来降低显存压力：
## 1. 推荐的“简化版”框架
### 1.1gsplat (Nerfstudio 版)
 https://github.com/nerfstudio-project/gsplat
 
 这是目前最流行的工业级优化实现。相比原版代码，它通过改进 CUDA 内核，可节省高达 4 倍的内存，并在渲染速度上提升约 15%。它更适合在 8GB 显存的消费级显卡上训练中小型场景。
 
* 安装方式

你可以直接通过 pip 快速安装稳定版：
```bash
pip install gsplat
```

或者从源码安装以获取最新特性：
```bash
pip install git+https://github.com/nerfstudio-project/gsplat.git
```

提示：在 RTX 3060 Ti 上运行建议配合 Nerfstudio 使用，并使用 --pipeline.model.num-downscales 2 参数对输入图像进行下采样，以确保训练过程更加稳定。

### 1.2LiteGS：
 一种高性能框架，系统性地优化了 3DGS 训练管线，旨在减少显存开销并加速训练（最高加速 13.4 倍）。
### 1.3 Reduced 3DGS 
专门针对显存占用进行的研究，通过剪枝（Pruning）和量化技术，可将磁盘占用减少约 27 倍，并显著降低显存消耗。 

## 2. 针对 8GB 显存的操作技巧
如果直接运行代码依然报“显存溢出 (OOM)”，请尝试以下手段：
* 降低输入分辨率：在训练脚本中使用参数（如 --resolution 4 或 --resolution 8）将输入图像下采样。这是最直接有效的减压方式。
* 控制高斯点数量：限制稠密化（Densification）的迭代次数或调整阈值，防止高斯点云数量爆炸。
* 启用裁剪 (Culling)：在渲染时启用视锥体裁剪，只加载视野内的点，可减少渲染时的显存瞬间占用。 


=========================================
# 3.如何使用gsplat
想要在 RTX 3060 Ti 上高效运行 gsplat，通常有两种主流方式：作为开发者直接调用其 CUDA 算子，或者作为创作者在 Nerfstudio 框架中使用。
以下是针对你的显卡环境最推荐的两种路径：

## 路径一：作为 Nerfstudio 插件使用（最推荐，简单直观）
这是最成熟的方案，gsplat 已作为 Splatfacto 方法的核心引擎集成在其中。

1.安装环境（建议在 Anaconda 环境下）：
```bash
pip install torch torchvision
pip install nerfstudio
# 安装 gsplat
pip install gsplat
```

2.准备数据：
你需要先用 COLMAP 对照片进行预处理。

3.开始训练：
针对 3060 Ti 的 8GB 显存，建议加上下采样参数：
```bash
ns-train splatfacto --data path/to/your/data --pipeline.model.num-downscales 2
```

num-downscales 2 会将图像缩小，显著降低训练初期的显存占用。
## 路径二：使用其自带的示例脚本（适合研究算法）
如果你想直接运行 gsplat 仓库里的原生代码（不依赖整个 Nerfstudio）：

1.克隆并安装：
```bash
git clone https://github.com
cd gsplat
pip install -e .
```

2.运行训练示例：
gsplat 提供了一个轻量级的训练脚本，可以直接读取 COLMAP 数据集：
```bash
python examples/simple_trainer.py --data_dir <path/to/colmap_output> --result_dir <path/to/save>
```

## 3060 Ti 运行建议
开启 Web 界面：Nerfstudio 默认开启 Vuer 交互界面，你可以实时看到高斯点从模糊变清晰的过程。
显存监控：训练时建议开启任务管理器，若显存溢出，请在 simple_trainer.py 中减小 refine_stop_iter（停止加密的迭代次数）或调低 densify_grad_thresh（分裂阈值）。

===========================================================================
# 4.# gsplat 的使用步骤
要在 RTX 3060 Ti 上跑通 gsplat，最稳妥且适合 8GB 显存的路径是配合 Nerfstudio 使用。以下是完整的全流程步骤：

## 第一步：环境配置（建议使用 Conda）
首先确保你安装了 NVIDIA Driver 和 CUDA Toolkit。

```bash
# 1. 创建并激活虚拟环境
conda create --name gsplat_env python=3.9
conda activate gsplat_env

# 2. 安装 PyTorch (根据你的 CUDA 版本选择)
pip install torch torchvision --index-url https://download.pytorch.org

# 3. 安装 gsplat (核心库)
pip install gsplat

# 4. 安装 Nerfstudio (集成框架)
pip install nerfstudio
```
> 请谨慎使用此类代码。

## 第二步：准备数据
高斯泼溅不能直接读照片，需要经过 COLMAP 处理。
将照片放入一个文件夹（如 data/my_scene/images）。
运行 Nerfstudio 的数据处理脚本：

```bash
ns-process-data images --data data/my_scene/images --output-dir data/my_scene/processed
```
> 请谨慎使用此类代码。

此过程会自动调用 COLMAP 计算相机位置（即类似 OpenMVG 的功能）。

## 第三步：开始训练 (关键优化)
针对 RTX 3060 Ti (8GB)，直接训练容易爆显存，必须使用下采样参数：

```bash
ns-train splatfacto \
  --data data/my_scene/processed \
  --pipeline.model.num-downscales 2 \
  --vis viewer
```
> 请谨慎使用此类代码。

- splatfacto: 这是 Nerfstudio 中基于 gsplat 的方法名。
- num-downscales 2: 必选。将图像缩小 4 倍（2的平方），极大缓解 8GB 显存压力。
- --vis viewer: 启动网页端可视化界面。

## 第四步：查看结果
命令行会输出一个 URL（通常是 http://localhost:7007）。
在浏览器打开它，你可以实时看到高斯点如何被“泼”出来并逐渐精细化。
训练完成后，使用 ns-render 脚本即可导出视频或 3D 模型。

## 针对 3060 Ti 的进阶微调
如果训练过程中显存依然紧张，可以尝试：
- 关闭可视化：改用 --vis tensorboard（训练完再看）。
- 限制点数：在训练命令后添加 --pipeline.model.max-res 1024 限制最大分辨率。

你目前安装好 CUDA 环境了吗？如果安装过程中遇到 nvcc 报错，我可以帮你排查。

### 总结
1. 8GB 显存的 RTX 3060 Ti 运行 gsplat 建议搭配 Nerfstudio，核心是通过 Conda 配置专属虚拟环境并安装依赖库；
2. 数据需经 COLMAP 预处理，训练时必须添加 `num-downscales 2` 参数缓解显存压力；
3. 显存仍紧张时可关闭实时可视化或限制最大分辨率，训练结果可通过网页查看并导出视频/3D 模型。

