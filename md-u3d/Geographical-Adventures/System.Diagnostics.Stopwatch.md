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