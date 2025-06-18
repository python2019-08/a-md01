# 1.作者：杨夕
链接：https://zhuanlan.zhihu.com/p/679884390
来源：知乎
发布于 2024-01-26 09:04


腾讯大模型算法实习生面试题关于小编：小编是过年某985研二，过完年打算找大厂实习 offer，本文章主要记录了本小菜研找实习的坎坷历程，欢迎大佬们给建议！！！应聘岗位：腾讯大模型算法实习生 面试轮数：第一轮 整体面试感觉：偏难面试过程回顾1. 自我介绍在自我介绍环节，我清晰地阐述了个人基本信息、教育背景、工作经历和技能特长，展示了自信和沟通能力。2. 技术问题回答2.1 分布式训练框架都了解哪些，能不能简单介绍一下?2.2 你了解 deepspeed，那介绍zero1，2，3分别是什么，分析训练时候显存占用？参考：【图解分布式训练（八）—— ZeRO 学习】 https://github.com/km1994/LLMs_interview_notes#图解分布式训练八-zero-学习2.3 说一下 Transformer 的架构和其内部细节？【必考题】建议 把 【Transformer常见面试篇】(https://github.com/km1994/NLP-Interview-Notes#Transformer常见面试篇) 里面的题目都刷一遍！！！2.4 介绍大模型推理过程中，可以通过调节哪些参数提高性能?参考：【大模型（LLMs）推理面】 https://github.com/km1994/LLMs_interview_notes#大模型llms推理面2.5 你既然做过 RAG，能不能介绍一下 RAG，大模型在里面主要是起到什么作用?参考：https://github.com/km1994/LLMs_interview_note#基于llm向量库的文档对话-经验面-12.6 大模型训练的三种并行是什么?通讯开销比?模型并行，数据并行，流水线并行参考：https://github.com/km1994/LLMs_interview_notes#大模型llms分布式训练面2.7 手撕代码。给一个md维度的矩阵，m代表样本数量，d是样本的维度。请使用不超过mm复杂度的代码求解其亮亮的欧式距离?3. Leetcode 题具体题意记不清了，但是类似 【289. 生命游戏】题目内容根据 百度百科 ， 生命游戏 ，简称为 生命 ，是英国数学家约翰·何顿·康威在 1970 年发明的细胞自动机。给定一个包含 m × n 个格子的面板，每一个格子都可以看成是一个细胞。每个细胞都具有一个初始状态：1 即为 活细胞 （live），或 0 即为 死细胞 （dead）。每个细胞与其八个相邻位置（水平，垂直，对角线）的细胞都遵循以下四条生存定律：如果活细胞周围八个位置的活细胞数少于两个，则该位置活细胞死亡；如果活细胞周围八个位置有两个或三个活细胞，则该位置活细胞仍然存活；如果活细胞周围八个位置有超过三个活细胞，则该位置活细胞死亡；如果死细胞周围正好有三个活细胞，则该位置死细胞复活；下一个状态是通过将上述规则同时应用于当前状态下的每个细胞所形成的，其中细胞的出生和死亡是同时发生的。给你 m x n 网格面板 board 的当前状态，返回下一个状态。示例 1：输入：board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
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
                    
个人本次面试总结整体感受非常nice，面试官是一个很好看的小姐姐，所以整体氛围很好。而且之前 看过 【关于AiGC那些你不知道的事】（https://wx.zsxq.com/dweb2/index/group/51112141255244），很多问题都是原题，所以回答起来会游刃有余一些。致谢LLMs 千面郎君 更新版 https://mp.weixin.qq.com/s/C6NdO_Ebj3DQx2AVAAgQRQLLMs九层妖塔 https://mp.weixin.qq.com/s/Eh0tY1zx2FqXQqIGa2dIBA
                    
                    