# 1.System.Diagnostics.Stopwatch.StartNew

`System.Diagnostics.Stopwatch.StartNew()` 是 C# 中 `System.Diagnostics` 命名空间下 `Stopwatch` 类的一个静态方法，其作用是创建一个新的 `Stopwatch` 实例，并且立即启动计时。下面为你详细介绍：

### 基本用法
该方法通常用于精确测量代码块的执行时间。以下是一个简单示例：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        // 创建并启动一个新的 Stopwatch 实例
        Stopwatch stopwatch = Stopwatch.StartNew();

        // 模拟一些耗时操作
        for (int i = 0; i < 1000000; i++)
        {
            // 这里可以是需要计时的代码逻辑
        }

        // 停止计时
        stopwatch.Stop();

        // 获取经过的时间
        TimeSpan elapsedTime = stopwatch.Elapsed;

        // 输出经过的时间
        Console.WriteLine($"代码执行耗时: {elapsedTime.TotalMilliseconds} 毫秒");
    }
}
```
在上述代码里，`Stopwatch.StartNew()` 创建了一个新的 `Stopwatch` 实例并启动计时。接着，代码执行了一个循环作为耗时操作。之后调用 `stopwatch.Stop()` 停止计时，最后通过 `stopwatch.Elapsed` 属性获取经过的时间，并将其以毫秒为单位输出。

### 方法解释
- **返回值**：该方法返回一个新的 `Stopwatch` 实例，此实例的 `IsRunning` 属性为 `true`，表示计时已经开始。
- **优点**：使用 `StartNew()` 方法可以简化代码，避免先创建 `Stopwatch` 实例再调用 `Start()` 方法的步骤。

### 常用属性
- **`Elapsed`**：获取 `Stopwatch` 实例从启动到当前所经过的时间，返回一个 `TimeSpan` 对象。
- **`ElapsedMilliseconds`**：获取 `Stopwatch` 实例从启动到当前所经过的毫秒数。
- **`ElapsedTicks`**：获取 `Stopwatch` 实例从启动到当前所经过的计时器刻度数。

### 性能注意事项
- `Stopwatch` 类使用系统的高分辨率性能计数器（如果可用），能够提供非常精确的计时，其精度通常比 `DateTime` 类更高。
- 若要多次测量不同代码块的执行时间，可重复使用同一个 `Stopwatch` 实例，通过调用 `Reset()` 方法重置计时，然后再次调用 `Start()` 方法开始新的计时。

### 代码示例扩展
以下是一个多次测量不同代码块执行时间的示例：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        Stopwatch stopwatch = Stopwatch.StartNew();

        // 第一个代码块
        for (int i = 0; i < 1000000; i++)
        {
            // 这里可以是第一个需要计时的代码逻辑
        }
        stopwatch.Stop();
        Console.WriteLine($"第一个代码块执行耗时: {stopwatch.ElapsedMilliseconds} 毫秒");

        // 重置计时器
        stopwatch.Reset();
        stopwatch.Start();

        // 第二个代码块
        for (int i = 0; i < 2000000; i++)
        {
            // 这里可以是第二个需要计时的代码逻辑
        }
        stopwatch.Stop();
        Console.WriteLine($"第二个代码块执行耗时: {stopwatch.ElapsedMilliseconds} 毫秒");
    }
}
```
在这个示例中，使用同一个 `Stopwatch` 实例测量了两个不同代码块的执行时间，通过 `Reset()` 方法重置计时，然后再次启动计时。 

<+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
# 2.除了StartNew()方法，Stopwatch类还有哪些常用方法？

在 C# 中，`System.Diagnostics.Stopwatch` 类提供了多个用于测量时间间隔的方法，除了 `StartNew()` 方法，还有以下一些常用方法：

### 1. `Start()`
- **功能**：启动 `Stopwatch` 实例或继续已停止的 `Stopwatch` 实例的计时。
- **示例代码**：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        Stopwatch stopwatch = new Stopwatch();
        stopwatch.Start();
        // 执行一些操作
        for (int i = 0; i < 1000000; i++) { }
        stopwatch.Stop();
        Console.WriteLine($"操作耗时: {stopwatch.ElapsedMilliseconds} 毫秒");
    }
}
```

### 2. `Stop()`
- **功能**：停止 `Stopwatch` 实例的计时。停止计时后，可以通过 `Elapsed`、`ElapsedMilliseconds` 等属性获取已经记录的时间。
- **示例代码**：参考上面 `Start()` 方法的示例，在执行完需要计时的操作后调用 `Stop()` 停止计时。

### 3. `Reset()`
- **功能**：将 `Stopwatch` 实例的计时重置为零。如果 `Stopwatch` 正在运行，调用 `Reset()` 会停止计时并将已记录的时间清零。
- **示例代码**：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        Stopwatch stopwatch = new Stopwatch();
        stopwatch.Start();
        // 执行一些操作
        for (int i = 0; i < 1000000; i++) { }
        stopwatch.Stop();
        Console.WriteLine($"第一次操作耗时: {stopwatch.ElapsedMilliseconds} 毫秒");

        stopwatch.Reset();
        stopwatch.Start();
        // 执行另一些操作
        for (int i = 0; i < 2000000; i++) { }
        stopwatch.Stop();
        Console.WriteLine($"第二次操作耗时: {stopwatch.ElapsedMilliseconds} 毫秒");
    }
}
```

### 4. `Restart()`
- **功能**：将 `Stopwatch` 实例的计时重置为零，然后立即开始新的计时。它相当于先调用 `Reset()` 再调用 `Start()`。
- **示例代码**：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        Stopwatch stopwatch = new Stopwatch();
        stopwatch.Start();
        // 执行一些操作
        for (int i = 0; i < 1000000; i++) { }
        stopwatch.Stop();
        Console.WriteLine($"第一次操作耗时: {stopwatch.ElapsedMilliseconds} 毫秒");

        stopwatch.Restart();
        // 执行另一些操作
        for (int i = 0; i < 2000000; i++) { }
        stopwatch.Stop();
        Console.WriteLine($"第二次操作耗时: {stopwatch.ElapsedMilliseconds} 毫秒");
    }
}
```

### 5. `IsHighResolution`（静态属性）
- **功能**：获取一个指示当前系统是否支持高分辨率性能计数器的值。如果系统支持高分辨率性能计数器，则返回 `true`；否则返回 `false`。
- **示例代码**：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        if (Stopwatch.IsHighResolution)
        {
            Console.WriteLine("系统支持高分辨率性能计数器");
        }
        else
        {
            Console.WriteLine("系统不支持高分辨率性能计数器");
        }
    }
}
```

### 6. `Frequency`（静态属性）
- **功能**：获取高分辨率性能计数器的频率（如果系统支持），以每秒的刻度数表示。该属性用于将 `ElapsedTicks` 属性的值转换为实际的时间值。
- **示例代码**：
```csharp
using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        long frequency = Stopwatch.Frequency;
        Console.WriteLine($"高分辨率性能计数器的频率: {frequency} 刻度/秒");
    }
}
```

这些方法和属性可以帮助你方便地进行时间测量和性能分析。 

====================================================
# 2.Mathf.SmoothDamp

`Mathf.SmoothDamp` 是 Unity 引擎中用于平滑过渡的数学函数，常用于相机跟随、物体移动或数值插值等需要自然过渡的场景。以下是详细解析：


### **核心功能**
平滑地将当前值从 **`current`** 过渡到 **`target`**，并在到达目标时减少过冲（overshoot），最终稳定在目标值。

**特点**：
- 模拟阻尼弹簧效果，速度会随接近目标而逐渐降低。
- 可自定义过渡时间（通过 `smoothTime` 参数）。
- 支持限制最大速度，避免极端情况下的过度移动。


### **函数原型**
```csharp
public static float SmoothDamp(
    float current,        // 当前值
    float target,         // 目标值
    ref float currentVelocity,  // 当前速度（需作为引用传递）
    float smoothTime,     // 平滑时间（越大越慢，越小越快）
    float maxSpeed = float.PositiveInfinity,  // 最大速度限制
    float deltaTime = Time.deltaTime  // 时间增量（默认使用Unity的帧间隔）
);
```


### **关键参数解析**
1. **`currentVelocity`**  
   - 必须作为 **引用参数**（`ref`）传递，用于存储当前速度状态。
   - 通常在类中定义为成员变量，或在循环外初始化。

2. **`smoothTime`**  
   - 控制平滑效果的时间，单位为秒。
   - 较大值会使过渡更缓慢、平滑；较小值会使过渡更快，接近直接插值。

3. **`maxSpeed`**  
   - 限制最大速度，防止在距离目标过远时速度过快。
   - 默认无限制（`float.PositiveInfinity`）。


### **常见应用场景**
#### **1. 相机平滑跟随**
```csharp
public Transform target;     // 目标物体
public float smoothTime = 0.3f;  // 平滑时间
private float yVelocity = 0.0f;  // 当前速度（必须为类成员变量）

void Update() {
    // 平滑跟随目标的Y轴位置
    float newPosition = Mathf.SmoothDamp(
        transform.position.y,  // 当前位置
        target.position.y,     // 目标位置
        ref yVelocity,         // 当前速度（引用传递）
        smoothTime             // 平滑时间
    );
    
    transform.position = new Vector3(
        transform.position.x,
        newPosition,
        transform.position.z
    );
}
```

#### **2. 数值平滑过渡**
```csharp
public float targetValue = 100f;  // 目标值
public float smoothTime = 0.5f;   // 平滑时间
private float currentValue = 0f;  // 当前值
private float valueVelocity = 0f; // 当前速度

void Update() {
    // 平滑调整音量/进度等值
    currentValue = Mathf.SmoothDamp(
        currentValue,
        targetValue,
        ref valueVelocity,
        smoothTime
    );
}
```


### **与其他插值方法的对比**
| 方法               | 特点                                                                 |
|--------------------|----------------------------------------------------------------------|
| `Mathf.Lerp`       | 线性插值，速度恒定，可能产生机械感。                                  |
| `Mathf.SmoothStep` | 非线性插值，两端速度较慢，中间较快，但无法自定义过渡时间。           |
| `Mathf.SmoothDamp` | 基于物理阻尼模型，速度自动调整，可自定义过渡时间，适合需要自然感的场景。 |


### **使用注意事项**
1. **速度变量需持久化**  
   `currentVelocity` 必须在多次调用间保持状态（通常作为类成员变量），否则会导致跳跃。

2. **帧率影响**  
   需传入正确的 `deltaTime`（通常使用 `Time.deltaTime`），否则在不同帧率下表现不一致。

3. **避免频繁更改目标值**  
   频繁修改 `target` 会导致平滑效果中断，建议在目标稳定后再使用。

4. **3D 向量平滑**  
   对于位置、旋转等向量值，可使用 `Vector3.SmoothDamp` 或 `Quaternion.Slerp` 配合 `SmoothDamp` 实现。


### **示例：平滑相机跟随**
```csharp
public class CameraFollow : MonoBehaviour {
    public Transform target;
    public float smoothTime = 0.3f;
    public Vector3 offset;  // 相机与目标的偏移量
    
    private Vector3 velocity = Vector3.zero;

    void LateUpdate() {
        // 计算目标位置（含偏移量）
        Vector3 targetPosition = target.position + offset;
        
        // 平滑跟随
        transform.position = Vector3.SmoothDamp(
            transform.position,
            targetPosition,
            ref velocity,
            smoothTime
        );
        
        // 相机朝向目标
        transform.LookAt(target);
    }
}
```

通过调整 `smoothTime`，可以控制相机跟随的“弹性”效果，使游戏体验更自然。

=========================================================
=========================================================
# 3.Graphics.DrawMeshInstancedIndirect

在Ubuntu系统中，修改root密码通常有两种方法，一种是通过具有sudo权限的普通用户直接修改，另一种是在忘记所有用户密码时通过GRUB菜单进入恢复模式修改。具体操作如下：

### Unity 的 Graphics.DrawMeshInstancedIndirect 函数详解

`Graphics.DrawMeshInstancedIndirect` 是 Unity 引擎中用于高效渲染大量相同网格（Mesh）实例的高级 API，特别适合实现植被、粒子系统、城市建筑等需要重复绘制相同模型的场景。以下是详细解析：


### **核心功能**
该函数允许通过 **GPU Instancing**（GPU 实例化）技术，在单次 GPU 调用中渲染多个相同网格的不同实例，显著提升性能。与传统的逐网格渲染相比，它减少了 CPU-GPU 通信开销和状态切换成本。


### **函数原型**
```csharp
public static void DrawMeshInstancedIndirect(
    Mesh mesh,                  // 要渲染的网格
    int submeshIndex,           // 子网格索引（通常为0）
    Material material,          // 材质
    Bounds bounds,              // 实例的边界框（用于视锥体剔除）
    ComputeBuffer argsBuffer,   // 包含绘制参数的计算缓冲区
    int argsOffset = 0,         // 参数缓冲区的偏移量
    MaterialPropertyBlock properties = null,  // 材质属性块（可选）
    ShadowCastingMode castShadows = ShadowCastingMode.On,  // 阴影模式
    bool receiveShadows = true, // 是否接收阴影
    int layer = 0,              // 渲染层级
    Camera camera = null,       // 相机（用于剔除，默认为主相机）
    LightProbeUsage lightProbeUsage = LightProbeUsage.BlendProbes,  // 光照探针用法
    LightProbeProxyVolume lightProbeProxyVolume = null  // 光照探针代理体积
);
```


### **关键参数解析**
1. **argsBuffer**  
   - 一个包含 5 个 `uint` 值的计算缓冲区（`ComputeBuffer`），格式为：
     ```
     [0]: 顶点数量
     [1]: 实例数量
     [2]: 起始顶点索引
     [3]: 起始实例索引
     [4]: 起始位置偏移
     ```
   - 通常通过 Compute Shader 或 C# 代码初始化。

2. **bounds**  
   - 所有实例的总体边界框，用于视锥体剔除。Unity 会根据此边界框判断是否需要渲染这些实例。

3. **properties**  
   - 用于传递每个实例的自定义属性（如颜色、缩放、位置偏移等），通过数组或缓冲区存储。


### **使用步骤**

#### **1. 创建参数缓冲区**
```csharp
// 初始化参数缓冲区
ComputeBuffer argsBuffer = new ComputeBuffer(
    1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments
);

// 设置绘制参数（例如渲染1000个实例）
uint[] args = new uint[5] { 0, 1000, 0, 0, 0 };
if (mesh != null) {
    args[0] = (uint)mesh.GetIndexCount(0);  // 索引数量
    args[2] = (uint)mesh.GetIndexStart(0);  // 起始顶点索引
    args[4] = (uint)mesh.GetBaseVertex(0);  // 起始位置偏移
}
argsBuffer.SetData(args);
```

#### **2. 创建实例数据缓冲区**
```csharp
// 创建存储实例数据的缓冲区（例如位置、颜色）
ComputeBuffer positionsBuffer = new ComputeBuffer(
    maxInstances, sizeof(float) * 4  // 每个实例一个 Vector4
);

// 填充实例数据
Vector4[] positions = new Vector4[maxInstances];
for (int i = 0; i < maxInstances; i++) {
    positions[i] = new Vector4(
        Random.Range(-10f, 10f),
        0,
        Random.Range(-10f, 10f),
        Random.Range(0.5f, 1.5f)  // 缩放
    );
}
positionsBuffer.SetData(positions);
```

#### **3. 配置材质**
```csharp
// 在材质中设置实例数据缓冲区
material.SetBuffer("positionBuffer", positionsBuffer);

// 在 Shader 中使用实例数据
// 例如：
// StructuredBuffer<float4> positionBuffer;
// float4 pos = positionBuffer[instanceID];
```

#### **4. 调用 DrawMeshInstancedIndirect**
```csharp
void Update() {
    // 每帧调用绘制函数
    Graphics.DrawMeshInstancedIndirect(
        mesh, 
        0, 
        material, 
        new Bounds(Vector3.zero, new Vector3(100, 100, 100)), 
        argsBuffer
    );
}
```


### **Shader 实现注意事项**
1. **启用 GPU Instancing**  
   在 Shader 中添加 `#pragma multi_compile_instancing` 指令：
   ```glsl
   Shader "Custom/InstancedShader" {
       Properties { ... }
       SubShader {
           Tags { "RenderType"="Opaque" }
           Pass {
               CGPROGRAM
               #pragma vertex vert
               #pragma fragment frag
               #pragma multi_compile_instancing  // 启用实例化
               
               // 声明实例化属性
               UNITY_INSTANCING_BUFFER_START(Props)
                   UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
                   UNITY_DEFINE_INSTANCED_PROP(float, _Scale)
               UNITY_INSTANCING_BUFFER_END(Props)
               
               // 顶点着色器中使用实例ID获取属性
               float4 vert(appdata v, uint instanceID : SV_InstanceID) : SV_POSITION {
                   float4 pos = UnityObjectToClipPos(v.vertex);
                   float scale = UNITY_ACCESS_INSTANCED_PROP(Props, _Scale);
                   pos.xyz *= scale;
                   return pos;
               }
               ENDCG
           }
       }
   }
   ```

2. **使用 ComputeBuffer 传递数据**  
   对于大量数据（如位置、旋转），通过 `StructuredBuffer` 在 Shader 中接收：
   ```glsl
   StructuredBuffer<float4> positionBuffer;  // 包含位置和缩放
   StructuredBuffer<float4> colorBuffer;     // 包含颜色
   
   float4 vert(appdata v, uint instanceID : SV_InstanceID) {
       float4 pos = UnityObjectToClipPos(v.vertex);
       float4 worldPos = positionBuffer[instanceID];
       float4 color = colorBuffer[instanceID];
       // ...
   }
   ```


### **性能优化建议**
1. **减少状态切换**  
   尽量使用相同材质的实例，避免频繁切换材质。

2. **合并相似网格**  
   若模型结构相似但略有不同（如不同树木），可考虑合并为一个网格。

3. **使用剔除**  
   通过 Compute Shader 预先剔除不可见的实例，减少渲染调用。

4. **内存管理**  
   及时释放不再使用的缓冲区：
   ```csharp
   void OnDestroy() {
       if (argsBuffer != null) argsBuffer.Release();
       if (positionsBuffer != null) positionsBuffer.Release();
   }
   ```


### **与其他渲染方法的对比**
| 方法                             | 适用场景               | 性能特点                       |
|----------------------------------|------------------------|--------------------------------|
| `Graphics.DrawMesh`              | 少量网格               | 每网格一次 DrawCall             |
| `Graphics.DrawMeshInstanced`     | 中等数量实例           | 一次 DrawCall 渲染多个实例      |
| `Graphics.DrawMeshInstancedIndirect` | 大量实例（10,000+） | 零 CPU-GPU 数据传输，完全 GPU 控制 |


### **常见应用场景**
- 植被系统（草、树、花）
- 粒子效果
- 程序化生成的城市建筑
- 人群模拟
- 地形细节（岩石、鹅卵石）

通过合理使用 `Graphics.DrawMeshInstancedIndirect`，可以在保持视觉效果的同时显著提升场景性能，特别适合大型开放世界或程序化生成的环境。

===============================================
# 4. Compass.CalculateNorth(Vector3 pos)

```c#
Vector3 CalculateNorth(Vector3 pos)
{
    pos = pos.normalized;
    Vector3 posNorth = GeoMaths.CoordinateToPoint(northMagneticPole.ConvertToRadians());
    Vector3 greatCircleNormal = Vector3.Cross(posNorth, pos);
    return Vector3.Cross(pos, greatCircleNormal).normalized;
}
```
### 代码解析：计算地球上某点的北方方向向量

这段代码实现了一个计算地球上任意点的"北方"方向向量的函数。这个计算在地理信息系统(GIS)、游戏开发(如3D地球模拟)和导航应用中非常有用。

### 核心逻辑分析

1. **输入处理**
   - 首先将输入的位置向量 `pos` 归一化，使其成为单位向量(长度为1)
   - 这是因为在球面计算中，通常使用单位向量表示球面上的点

2. **确定北极点**
   - `northMagneticPole` 是一个表示北极磁极点的坐标(可能是经纬度)
   - 通过 `ConvertToRadians()` 将角度转换为弧度
   - 使用 `GeoMaths.CoordinateToPoint()` 将经纬度坐标转换为3D空间中的向量

3. **计算大圆法向量**
   - 使用向量叉乘 `Vector3.Cross(posNorth, pos)` 计算包含北极点和当前点的大圆的法向量
   - 这个法向量垂直于包含这两点的平面

4. **计算北方方向**
   - 再次使用叉乘 `Vector3.Cross(pos, greatCircleNormal)` 计算垂直于当前位置向量和大圆法向量的向量
   - 这个向量指向的方向就是地理上的"北方"
   - 最后归一化结果向量，确保其长度为1

### 应用场景

- **3D地球模拟**：在游戏或GIS应用中，正确显示指南针或方向指示
- **地理信息系统**：计算两点之间的最短路径(大圆航线)
- **导航应用**：确定用户在地球上的朝向

### 可能的优化

1. **缓存北极点向量**：`northMagneticPole` 是固定的，可以预先计算并缓存转换后的向量

2. **精度考虑**：在浮点数计算中，多次归一化可能会引入微小误差

3. **异常处理**：当 `pos` 与 `posNorth` 共线时(例如在北极点)，叉乘结果为零向量，需要特殊处理

4. **性能优化**：如果频繁调用，可以考虑使用更高效的算法或查表法

这个函数巧妙地利用了向量叉乘的几何性质，简洁地实现了地理方向的计算。

===============================================
# 5.IInputActionCollection2

`IInputActionCollection2` 是 Unity 新输入系统（Input System）中的一个接口，用于管理和访问输入操作（Input Actions）的集合。这个接口提供了一种统一的方式来处理游戏中的各种输入，包括键盘、鼠标、游戏手柄等设备的输入事件。


### **主要功能**
1. **访问输入操作**：通过 `FindAction()` 方法查找和获取特定的输入操作。
2. **启用/禁用输入**：通过 `Enable()` 和 `Disable()` 方法控制整个输入集合的状态。
3. **输入事件处理**：通过回调函数响应输入事件。
4. **设备自动映射**：支持多种输入设备的自动映射和切换。


### **基本用法**
1. **创建输入操作资产**：在 Unity 中创建 `.inputactions` 文件，定义各种输入操作。
2. **生成 C# 类**：Unity 会自动根据 `.inputactions` 文件生成对应的 C# 类，该类实现了 `IInputActionCollection2` 接口。
3. **在代码中使用**：实例化生成的类，注册回调函数处理输入事件。


### **示例代码**
假设你有一个名为 `PlayerControls.inputactions` 的输入资产，Unity 会生成一个对应的 `PlayerControls` 类：

```csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{
    private PlayerControls playerControls;

    private void Awake()
    {
        // 实例化生成的输入类
        playerControls = new PlayerControls();
    }

    private void OnEnable()
    {
        // 启用输入操作集合
        playerControls.Enable();

        // 注册移动输入的回调
        playerControls.Player.Move.performed += OnMovePerformed;
        playerControls.Player.Move.canceled += OnMoveCanceled;

        // 注册跳跃输入的回调
        playerControls.Player.Jump.performed += OnJumpPerformed;
    }

    private void OnDisable()
    {
        // 禁用输入操作集合
        playerControls.Disable();

        // 取消注册回调
        playerControls.Player.Move.performed -= OnMovePerformed;
        playerControls.Player.Move.canceled -= OnMoveCanceled;
        playerControls.Player.Jump.performed -= OnJumpPerformed;
    }

    private void OnMovePerformed(InputAction.CallbackContext context)
    {
        // 获取移动输入值
        Vector2 moveInput = context.ReadValue<Vector2>();
        // 处理移动逻辑
        Debug.Log($"Move input: {moveInput}");
    }

    private void OnMoveCanceled(InputAction.CallbackContext context)
    {
        // 移动输入取消时的逻辑
        Debug.Log("Move input canceled");
    }

    private void OnJumpPerformed(InputAction.CallbackContext context)
    {
        // 跳跃输入的逻辑
        Debug.Log("Jump!");
    }
}
```


### **关键方法**
- **`FindAction(string actionName)`**：根据名称查找输入操作。
- **`Enable()`** 和 **`Disable()`**：启用或禁用整个输入集合。
- **`inputAction.performed += callback`**：注册输入操作触发时的回调。
- **`inputAction.canceled += callback`**：注册输入操作取消时的回调。


### **输入操作类型**
Unity 新输入系统支持三种输入操作类型：
1. **Value**：连续输入（如移动摇杆、鼠标位置）。
2. **Button**：离散输入（如按键、点击）。
3. **PassThrough**：直接传递原始输入数据。


### **优势**
- **跨平台支持**：统一处理键盘、鼠标、手柄等输入设备。
- **动态设备切换**：支持在运行时无缝切换输入设备。
- **可视化配置**：通过 `.inputactions` 文件可视化配置输入映射。
- **组合操作**：支持多键组合（如 Ctrl+S）和多设备绑定（如键盘和手柄都能触发同一操作）。


### **注意事项**
- 需要在 Unity 中安装 **Input System Package**（通过 Package Manager）。
- 生成的输入类名称默认为输入资产文件名，可在 Inspector 中修改。
- 建议在 `OnEnable()` 和 `OnDisable()` 中启用/禁用输入，避免内存泄漏。

通过 `IInputActionCollection2` 接口，Unity 新输入系统提供了更灵活、可扩展的输入处理方式，适合现代游戏开发的需求。

=============================================================
# 6. ResolutionSettingsHelper.GetRatio

```c#
public static Vector2Int GetRatio(int width, int height)
	{
		int gcd = Seb.Maths.GreatestCommonDivisor(width, height);
		int aspectW = width / gcd;
		int aspectH = height / gcd;
		Vector2Int aspect = new Vector2Int(aspectW, aspectH);
		return aspect;
	}
```

这段代码实现了一个计算图像或屏幕宽高比的函数，通过求最大公约数（GCD）来将宽高比化简为最简整数比。我来解析其功能和实现原理：


### **代码功能解析**
这个静态方法 `GetRatio` 接收图像或屏幕的宽度和高度，返回一个表示最简宽高比的 `Vector2Int`：

1. **计算最大公约数（GCD）**：
   ```csharp
   int gcd = Seb.Maths.GreatestCommonDivisor(width, height);
   ```
   - 使用 `Seb.Maths.GreatestCommonDivisor` 方法计算宽度和高度的最大公约数。
   - 例如，对于 1920×1080 的分辨率，GCD 为 120。

2. **化简宽高比**：
   ```csharp
   int aspectW = width / gcd;
   int aspectH = height / gcd;
   ```
   - 将宽度和高度分别除以 GCD，得到最简整数比。
   - 例如，1920÷120 = 16，1080÷120 = 9，结果为 16:9。

3. **返回结果**：
   ```csharp
   Vector2Int aspect = new Vector2Int(aspectW, aspectH);
   return aspect;
   ```
   - 将化简后的宽高比封装为 `Vector2Int` 返回。


### **最大公约数算法（假设实现）**
`Seb.Maths.GreatestCommonDivisor` 可能使用 **欧几里得算法（辗转相除法）** 实现：
```csharp
public static int GreatestCommonDivisor(int a, int b)
{
    while (b != 0)
    {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}
```


### **使用示例**
```csharp
// 示例 1：1920x1080 屏幕
Vector2Int aspect1 = GetRatio(1920, 1080);
Debug.Log($"Aspect ratio: {aspect1.x}:{aspect1.y}"); // 输出：16:9

// 示例 2：1280x720 屏幕
Vector2Int aspect2 = GetRatio(1280, 720);
Debug.Log($"Aspect ratio: {aspect2.x}:{aspect2.y}"); // 输出：16:9

// 示例 3：800x600 屏幕
Vector2Int aspect3 = GetRatio(800, 600);
Debug.Log($"Aspect ratio: {aspect3.x}:{aspect3.y}"); // 输出：4:3
```


### **优化建议**
1. **输入验证**：
   - 添加对非正数输入的检查（如 `width <= 0` 或 `height <= 0`），避免除以零或返回无效结果。

2. **性能优化**：
   - 对于高频调用，可考虑缓存常见分辨率的结果（如 16:9、4:3）。

3. **扩展功能**：
   - 可以添加一个重载方法，直接返回字符串格式的宽高比（如 `"16:9"`）。

```csharp
public static string GetRatioString(int width, int height)
{
    Vector2Int ratio = GetRatio(width, height);
    return $"{ratio.x}:{ratio.y}";
}
```


### **常见应用场景**
- **屏幕适配**：根据设备宽高比动态调整UI布局。
- **图像缩放**：保持图片原始宽高比进行缩放。
- **游戏相机**：根据宽高比调整视场（FOV）或裁剪策略。

通过这个函数，可以方便地获取任何分辨率的最简宽高比，为游戏开发中的屏幕适配和UI布局提供基础支持。

=============================================
# 7.UnityEngine.RefreshRate
这个 `RefreshRate` 结构体是 Unity 新输入系统中的一个重要组件，用于精确表示显示器的刷新率。它采用分数形式（分子/分母）而非简单的整数，以支持更高精度的刷新率值（如 120.1 Hz）。


### **结构设计解析**
1. **分数表示法**：
   - `numerator`（分子）：刷新率的分子部分。
   - `denominator`（分母）：刷新率的分母部分。
   - 例如，120.1 Hz 可表示为 `1201/10`。

2. **接口实现**：
   - `IEquatable<RefreshRate>`：支持结构体之间的等值比较。
   - `IComparable<RefreshRate>`：支持结构体之间的排序比较。

3. **精度优势**：
   - 避免浮点数精度问题，确保刷新率计算的准确性。
   - 适用于需要精确控制帧率的场景（如专业显示器或VR设备）。


### **常用操作示例**
1. **创建实例**：
   ```csharp
   // 120 Hz
   var refreshRate1 = new RefreshRate { numerator = 120, denominator = 1 };
   
   // 120.1 Hz
   var refreshRate2 = new RefreshRate { numerator = 1201, denominator = 10 };
   ```

2. **等值比较**：
   ```csharp
   bool isEqual = refreshRate1.Equals(refreshRate2);
   ```

3. **排序比较**：
   ```csharp
   int comparison = refreshRate1.CompareTo(refreshRate2);
   // 结果: -1 (小于)、0 (等于)、1 (大于)
   ```


### **实际应用场景**
- **高刷新率显示器适配**：
  ```csharp
  // 获取当前显示器刷新率
  RefreshRate currentRate = Screen.currentResolution.refreshRateRatio;
  
  // 设置垂直同步
  QualitySettings.vSyncCount = 1;
  
  // 设置目标帧率（匹配刷新率）
  if (currentRate.denominator > 0)
  {
      float exactRate = (float)currentRate.numerator / currentRate.denominator;
      Application.targetFrameRate = Mathf.RoundToInt(exactRate);
  }
  ```

- **VR/AR 设备优化**：
  - VR 头显通常需要精确的刷新率（如 90 Hz、120 Hz）。
  - 使用 `RefreshRate` 可避免因浮点数误差导致的渲染问题。


### **与传统整数表示法的对比**
| 表示方式 | 120 Hz | 120.1 Hz | 优势 |
|----------|--------|----------|------|
| **整数** | 120 | 120（舍入误差） | 简单直观 |
| **分数** | 120/1 | 1201/10 | 精确无损 |


### **Unity 中的关联 API**
- `Screen.currentResolution.refreshRateRatio`：获取当前显示器的刷新率（分数形式）。
- `Display.displays[i].systemRefreshRate`：获取特定显示器的系统刷新率（浮点数）。
- `Application.targetFrameRate`：设置游戏目标帧率。


### **注意事项**
1. **性能考虑**：
   - 高刷新率（如 240 Hz）会增加 GPU 负载，需优化渲染性能。
   - 在移动设备上，建议使用 `Application.targetFrameRate = -1` 配合 VSync 以平衡性能和续航。

2. **跨平台兼容性**：
   - 在某些平台（如 WebGL），刷新率控制可能受限。
   - 移动设备可能不支持所有刷新率选项。

3. **UI 适配**：
   - 高刷新率显示器可能需要更平滑的动画和过渡效果。


### **总结**
`RefreshRate` 结构体通过分数形式提供了高精度的刷新率表示，适用于需要精确控制帧率的场景。在开发高性能游戏或适配专业显示器时，使用该结构体可以避免浮点数误差，确保渲染与显示同步。