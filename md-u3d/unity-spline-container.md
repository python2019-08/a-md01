# 1.unity的spline container如何用-gAI

Unity 的 Spline Container 是官方 Splines 插件（2022.1+ 推荐）的核心组件，用于创建和管理样条曲线。
以下是快速上手指南：
## 1. 基础创建与编辑
(1)添加组件：在 Hierarchy 中新建空物体，添加 Spline Container 组件。

(2)绘制曲线：
在 Scene 视图左侧工具栏点击 Spline Tool 图标（或按快捷键 U）。
    在场景中点击以放置锚点 (Knot)。
    通过拖动切线柄（Tangent）来调整曲线弧度。
(3)模式切换：点击组件上的 Edit Spline 按钮可进入节点编辑模式。


## 2. 常用功能模块
单有曲线通常不够，你需要以下辅助组件来让它发挥作用：
> Spline Instantiator：沿路径自动生成预制体（如路灯、树木）。
> Spline Extrude：沿路径拉伸网格（如制作道路、管道）。
> Spline Animate：让物体沿着曲线移动。
> 
## 3. 脚本调用 (C#)
如果你需要通过代码控制，请先引用命名空间：
```cs
using UnityEngine.Splines;

public class SplineTest : MonoBehaviour {
    public SplineContainer splineContainer;

    void Start() {
        // 获取曲线长度
        float length = splineContainer.CalculateLength();
        
        // 获取曲线上某一点的位置 (0-1 之间进度)
        Vector3 position = splineContainer.EvaluatePosition(0.5f);
        
        // 获取曲线上某一点的切线方向
        Vector3 tangent = splineContainer.EvaluateTangent(0.5f);
    }
}
```

## 4. 关键优势
> 非破坏性：支持在 Inspector 面板 随时修改形状。
> 高性能：底层基于 Unity 的 Jobs System 和 Burst Compiler 优化。
> 多曲线支持：一个 Container 可以包含多条独立的 Splines（通过 Splines 列表管理）。

你可以查看 Unity 官方 Splines 示例项目 学习更高级的案例。
你是打算用它来做物体的移动路径（如过山车），还是用来生成场景模型（如围栏或道路）？