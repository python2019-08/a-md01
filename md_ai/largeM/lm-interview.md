# 1.作者：杨夕
链接：https://zhuanlan.zhihu.com/p/679884390
来源：知乎
发布于 2024-01-26 09:04


腾讯大模型算法实习生面试题关于小编：小编是过年某985研二，过完年打算找大厂实习 offer，本文章主要记录了本小菜研找实习的坎坷历程，欢迎大佬们给建议！！！

应聘岗位：腾讯大模型算法实习生 

面试轮数：
第一轮 整体面试感觉：偏难
面试过程回顾 
# 1. 自我介绍在自我介绍环节
   我清晰地阐述了个人基本信息、教育背景、工作经历和技能特长，展示了自信和沟通能力。
# 2. 技术问题回答

## 2.1 分布式训练框架都了解哪些，能不能简单介绍一下?
分布式训练框架是用于在多设备（GPU/CPU）或多节点集群上加速机器学习模型训练的工具，核心解决大规模数据、大模型的训练效率和扩展性问题。以下是一些主流框架的简单介绍：


### 1. **TensorFlow (Google)**
- **特点**：最早支持分布式训练的框架之一，灵活性高，支持多种分布式策略。
- **分布式模式**：
  - **数据并行**：将数据拆分到多个设备，每个设备训练完整模型，通过参数服务器（Parameter Server）同步参数。
  - **模型并行**：将模型层拆分到不同设备（适用于超大规模模型）。
- **优势**：生态成熟，支持静态图（Graph Execution）和动态图（Eager Execution），适合生产环境。
- **适用场景**：中小型团队、多模态任务、工业级部署。


### 2. **PyTorch (Meta)**
- **特点**：动态图优先，易用性强，分布式训练API简洁，深受学术界青睐。
- **分布式模式**：
  - 基于 `torch.distributed` 模块，支持数据并行（如 `DistributedDataParallel`）和模型并行（`nn.DataParallel` 简化版）。
  - 支持多种通信后端（NCCL、Gloo等），多节点训练配置简单。
- **优势**：调试方便，动态计算图适合快速迭代，与科研场景契合。
- **适用场景**：研究实验、快速原型开发、大模型训练（如结合DeepSpeed）。


### 3. **DeepSpeed (Microsoft)**
- **特点**：基于PyTorch的优化框架，专注于**超大规模模型训练**（千亿/万亿参数）。
- **核心技术**：
  - **ZeRO（Zero Redundancy Optimizer）**：优化内存使用，减少参数冗余，支持更大批次训练。
  - **混合精度训练**、**模型并行+数据并行混合策略**。
- **优势**：极致优化内存和算力，能在有限资源下训练超大规模模型（如GPT类模型）。
- **适用场景**：大语言模型（LLM）、推荐系统等超大模型训练。


### 4. **Megatron-LM (NVIDIA)**
- **特点**：专为Transformer类大模型设计，基于PyTorch，强调高效并行策略。
- **核心技术**：
  - **张量并行（Tensor Parallelism）**：将模型层的张量拆分到不同设备，突破单卡内存限制。
  - 与NVIDIA GPU深度适配，利用NVLink和InfiniBand加速通信。
- **优势**：针对Transformer优化，支持万亿参数模型（如GPT-3类模型）。
- **适用场景**：大语言模型、多模态基础模型训练。


### 5. **Horovod (Uber)**
- **特点**：跨框架分布式训练工具，支持TensorFlow、PyTorch、MXNet等。
- **核心思想**：基于MPI（Message Passing Interface）的通信模式，简化多框架分布式配置。
- **优势**：一次编写，多框架兼容，适合混合使用多种框架的团队。
- **适用场景**：多框架并存的企业级训练、大规模数据并行任务。


### 6. **MXNet (Apache)**
- **特点**：轻量级框架，支持动态图和静态图，分布式训练API简洁。
- **分布式模式**：基于参数服务器或AllReduce，支持数据并行和模型并行。
- **优势**：内存效率高，适合资源受限场景，生态相对轻量化。
- **适用场景**：中小型模型训练、移动端部署结合的场景。


### 7. **Colossal-AI (THUDM)**
- **特点**：国产分布式训练框架，基于PyTorch，专注高效并行和易用性。
- **核心技术**：
  - 支持多种并行策略（数据、模型、张量、流水线并行等）的自动组合。
  - 提供“一键式”分布式训练接口，降低大模型训练门槛。
- **优势**：针对中文场景优化，文档友好，适合国内团队。
- **适用场景**：大模型训练入门、多模态任务、科研与工业结合。


### 总结
- **中小模型/快速迭代**：优先选 **PyTorch**（灵活）或 **TensorFlow**（生态全）。
- **超大规模模型**：**DeepSpeed**（内存优化）或 **Megatron-LM**（Transformer专用）。
- **跨框架兼容**：**Horovod**。
- **国产场景**：**Colossal-AI**。

选择时需结合模型大小、团队技术栈、硬件资源（GPU数量/通信带宽）等因素，核心目标是平衡训练效率、易用性和扩展性。



2.2 你了解 deepspeed，那介绍zero1，2，3分别是什么，分析训练时候显存占用？

参考：【图解分布式训练（八）—— ZeRO 学习】 https://github.com/km1994/LLMs_interview_notes#图解分布式训练八-zero-学习



2.3 说一下 Transformer 的架构和其内部细节？【必考题】建议 把 【Transformer常见面试篇】(https://github.com/km1994/NLP-Interview-Notes#Transformer常见面试篇) 里面的题目都刷一遍！！！
2.4 介绍大模型推理过程中，可以通过调节哪些参数提高性能?参考：【大模型（LLMs）推理面】 https://github.com/km1994/LLMs_interview_notes#大模型llms推理面
2.5 你既然做过 RAG，能不能介绍一下 RAG，大模型在里面主要是起到什么作用?参考：https://github.com/km1994/LLMs_interview_note#基于llm向量库的文档对话-经验面-1
2.6 大模型训练的三种并行是什么?通讯开销比?模型并行，数据并行，流水线并行参考：https://github.com/km1994/LLMs_interview_notes#大模型llms分布式训练面
2.7 手撕代码。给一个md维度的矩阵，m代表样本数量，d是样本的维度。请使用不超过mm复杂度的代码求解其亮亮的欧式距离?
3. Leetcode 题具体题意记不清了，但是类似 【289. 生命游戏】题目内容根据 百度百科 ， 生命游戏 ，简称为 生命 ，是英国数学家约翰·何顿·康威在 1970 年发明的细胞自动机。给定一个包含 m × n 个格子的面板，每一个格子都可以看成是一个细胞。每个细胞都具有一个初始状态：1 即为 活细胞 （live），或 0 即为 死细胞 （dead）。每个细胞与其八个相邻位置（水平，垂直，对角线）的细胞都遵循以下四条生存定律：如果活细胞周围八个位置的活细胞数少于两个，则该位置活细胞死亡；如果活细胞周围八个位置有两个或三个活细胞，则该位置活细胞仍然存活；如果活细胞周围八个位置有超过三个活细胞，则该位置活细胞死亡；如果死细胞周围正好有三个活细胞，则该位置死细胞复活；下一个状态是通过将上述规则同时应用于当前状态下的每个细胞所形成的，其中细胞的出生和死亡是同时发生的。给你 m x n 网格面板 board 的当前状态，返回下一个状态。示例 1：输入：board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
输出：[[0,0,0],[1,0,1],[0,1,1],[0,1,0]]示例 2：输入：board = [[1,1],[1,0]]
输出：[[1,1],[1,1]]题目解答class Solution:
    def gameOfLife(self, board: List[List[int]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """

        neighbors = [(1,0), (1,-1), (0,-1), (-1,-1), (-1,0), (-1,1), (0,1), (1,1)]

        rows = len(board)
        cols = len(board[0])

        # 从原数组复制一份到 copy_board 中
        copy_board = [[board[row][col] for col in range(cols)] for row in range(rows)]

        # 遍历面板每一个格子里的细胞
        for row in range(rows):
            for col in range(cols):

                # 对于每一个细胞统计其八个相邻位置里的活细胞数量
                live_neighbors = 0
                for neighbor in neighbors:

                    r = (row + neighbor[0])
                    c = (col + neighbor[1])

                    # 查看相邻的细胞是否是活细胞
                    if (r < rows and r >= 0) and (c < cols and c >= 0) and (copy_board[r][c] == 1):
                        live_neighbors += 1

                # 规则 1 或规则 3        
                if copy_board[row][col] == 1 and (live_neighbors < 2 or live_neighbors > 3):
                    board[row][col] = 0
                # 规则 4
                if copy_board[row][col] == 0 and live_neighbors == 3:
                    board[row][col] = 1
                    
个人本次面试总结整体感受非常nice，面试官是一个很好看的小姐姐，所以整体氛围很好。
而且之前 看过 【关于AiGC那些你不知道的事】（https://wx.zsxq.com/dweb2/index/group/51112141255244），很多问题都是原题，所以回答起来会游刃有余一些。

致谢
LLMs 千面郎君 更新版 https://mp.weixin.qq.com/s/C6NdO_Ebj3DQx2AVAAgQRQLLMs
九层妖塔 https://mp.weixin.qq.com/s/Eh0tY1zx2FqXQqIGa2dIBA
                    
                    