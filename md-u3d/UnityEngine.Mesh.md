# 1.UnityEngine.Mesh

`UnityEngine.Mesh` 是 Unity 引擎中用于表示 3D 模型的核心类，它包含了模型的顶点、三角形、法线、纹理坐标等信息。下面为你详细介绍其相关内容：

### 基本用途
- **定义模型形状**：通过设置 顶点位置和三角形索引，`Mesh` 类能定义 3D 模型的几何形状。
- **渲染模型**：Unity 的渲染系统会依据 `Mesh` 类提供的数据来渲染 3D 模型。

### 常用属性和方法

#### 属性
- **`vertices`**：这是一个 `Vector3` 数组，用来存储网格的所有顶点位置。
- **`triangles`**：这是一个 `int` 数组，用来定义由顶点构成的三角形。
- **`normals`**：这是一个 `Vector3` 数组，存储每个顶点的法线向量，用于光照计算。
- **`uv`**：这是一个 `Vector2` 数组，存储每个顶点的纹理坐标。

#### 方法
- **`SetVertices`**：设置网格的顶点。
- **`SetTriangles`**：设置网格的三角形。
- **`SetNormals`**：设置网格的法线。
- **`SetUVs`**：设置网格的纹理坐标。

### 简单示例代码
下面是一个简单的 Unity C# 脚本示例，展示了如何创建一个简单的平面网格：

```csharp
using UnityEngine;

public class MeshExample : MonoBehaviour
{
    void Start()
    {
        // 创建一个新的 Mesh 对象
        Mesh mesh = new Mesh();

        // 定义顶点
        Vector3[] vertices = new Vector3[4];
        vertices[0] = new Vector3(0, 0, 0);
        vertices[1] = new Vector3(1, 0, 0);
        vertices[2] = new Vector3(0, 0, 1);
        vertices[3] = new Vector3(1, 0, 1);

        // 定义三角形
        int[] triangles = new int[6] { 0, 2, 1, 2, 3, 1 };

        // 设置顶点和三角形
        mesh.vertices = vertices;
        mesh.triangles = triangles;

        // 计算法线
        mesh.RecalculateNormals();

        // 获取 MeshFilter 组件并设置 Mesh
        MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
        meshFilter.mesh = mesh;

        // 添加 MeshRenderer 组件
        gameObject.AddComponent<MeshRenderer>();
    }
}
```

### 代码解释
1. **创建 `Mesh` 对象**：借助 `new Mesh()` 来创建一个新的 `Mesh` 对象。
2. **定义顶点和三角形**：构建 `Vector3` 数组以存储顶点位置，构建 `int` 数组以定义三角形。
3. **设置顶点和三角形**：利用 `mesh.vertices` 和 `mesh.triangles` 属性来设置顶点和三角形。
4. **计算法线**：调用 `mesh.RecalculateNormals()` 方法来自动计算法线。
5. **添加组件**：添加 `MeshFilter` 组件并将其 `mesh` 属性设置为新创建的 `Mesh` 对象，同时添加 `MeshRenderer` 组件以渲染网格。

通过这些步骤，你就可以在 Unity 中创建并渲染一个简单的平面网格。 
