
# 1.using(var chk=new EditorGUI.ChangeCheckScope())是什么 用法

在C#中，`using(var chk = new EditorGUI.ChangeCheckScope())` 这种用法涉及到两个重要的概念：`using` 语句和 `EditorGUI.ChangeCheckScope` 类。下面为你详细解释：

### 1. `using` 语句
`using` 语句是C#里用于确保对象能被正确释放资源的语法糖。当对象实现了 `IDisposable` 接口时，就可以运用 `using` 语句，它会在代码块结束时自动调用对象的 `Dispose` 方法。

以下是一个简单示例：
```csharp
using System.IO;

class Program
{
    static void Main()
    {
        using (var fileStream = new FileStream("test.txt", FileMode.Open))
        {
            // 使用 fileStream 进行操作
        } // 这里 fileStream 的 Dispose 方法会被自动调用
    }
}
```
在上述代码中，`FileStream` 实现了 `IDisposable` 接口，`using` 语句保证了 `fileStream` 在代码块结束时释放其占用的资源。

### 2. `EditorGUI.ChangeCheckScope` 类
`EditorGUI.ChangeCheckScope` 是Unity编辑器脚本API中的一个类，它主要用于检测编辑器界面中某些属性的更改情况。当你进入 `ChangeCheckScope` 代码块时，它会记录当前状态，当代码块结束时，它会检查状态是否发生了改变。

下面是一个简单的使用示例：
```csharp
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(MyScript))]
public class MyScriptEditor : Editor
{
    public override void OnInspectorGUI()
    {
        using (var chk = new EditorGUI.ChangeCheckScope())
        {
            // 绘制自定义的Inspector界面
            DrawDefaultInspector();

            if (chk.changed)
            {
                // 如果属性发生了改变，这里可以执行相应的操作
                Debug.Log("属性发生了改变！");
            }
        }
    }
}
```
在上述代码里，`using (var chk = new EditorGUI.ChangeCheckScope())` 创建了一个作用域，在这个作用域内绘制了默认的Inspector界面。当代码块结束时，通过检查 `chk.changed` 属性来判断界面中的属性是否有更改。若有更改，就会输出相应的日志信息。

### 总结
`using(var chk = new EditorGUI.ChangeCheckScope())` 的作用是创建一个作用域，用于检测在这个作用域内编辑器界面属性是否发生了更改。在代码块结束时，通过检查 `chk.changed` 属性就可以得知属性是否有变化，从而执行相应的操作。 


<=============================================================================>
# 2.error: can't add script. the script is an editor script

当你遇到 “can't add script. the script is an editor script” 这个提示时，意味着你尝试将一个编辑器脚本添加到游戏对象上，而编辑器脚本是不能直接添加到游戏对象的，因为它的设计用途是在Unity编辑器中扩展功能，并非运行在游戏运行时。下面为你详细分析并给出解决办法：

### 原因分析
在Unity里，脚本可以分为两类：
- **运行时脚本**：继承自 `MonoBehaviour`，可挂载到游戏对象上，在游戏运行期间执行。
- **编辑器脚本**：通常位于 `Assets/Editor` 文件夹下，继承自 `Editor` 或使用 `[CustomEditor]` 特性，用于在Unity编辑器中自定义Inspector面板、创建自定义工具等。

### 解决办法

#### 1. 确认脚本类型
要先确认脚本是否为编辑器脚本。编辑器脚本一般有如下特征：
- 位于 `Assets/Editor` 文件夹下。
- 继承自 `Editor` 类，或者使用了 `[CustomEditor]` 特性。

示例编辑器脚本：
```csharp
using UnityEditor;
using UnityEngine;

// 自定义编辑器脚本，用于编辑 MyScript 类
[CustomEditor(typeof(MyScript))]
public class MyScriptEditor : Editor
{
    public override void OnInspectorGUI()
    {
        // 绘制自定义的Inspector界面
        DrawDefaultInspector();
    }
}

// 运行时脚本
public class MyScript : MonoBehaviour
{
    public int myVariable;
}
```
在这个例子中，`MyScriptEditor` 是编辑器脚本，`MyScript` 是运行时脚本。

#### 2. 添加正确的脚本
如果你想给游戏对象添加脚本，要选择运行时脚本（继承自 `MonoBehaviour`）。
- **创建运行时脚本**：创建一个新的C#脚本，让它继承自 `MonoBehaviour`。
```csharp
using UnityEngine;

public class MyRuntimeScript : MonoBehaviour
{
    void Start()
    {
        Debug.Log("Runtime script started!");
    }
}
```
- **添加脚本到游戏对象**：在Unity编辑器中，选中游戏对象，在Inspector面板中点击 “Add Component” 按钮，然后选择 `MyRuntimeScript`。

#### 3. 使用编辑器脚本的正确方式
编辑器脚本用于自定义Inspector面板或创建自定义工具，不能直接添加到游戏对象上。可以通过以下方式使用编辑器脚本：
- **自定义Inspector面板**：使用 `[CustomEditor]` 特性为运行时脚本创建自定义Inspector界面。
- **创建自定义工具**：在 `Assets/Editor` 文件夹下创建脚本，使用 `MenuItem` 特性创建自定义菜单选项。
```csharp
using UnityEditor;
using UnityEngine;

public class MyCustomTool
{
    [MenuItem("Tools/My Custom Tool")]
    static void DoSomething()
    {
        Debug.Log("Custom tool executed!");
    }
}
```
在这个例子中，`MyCustomTool` 脚本会在Unity编辑器的 “Tools” 菜单下添加一个 “My Custom Tool” 选项，点击该选项会执行 `DoSomething` 方法。

通过以上步骤，你就能正确区分和使用运行时脚本与编辑器脚本，避免出现 “can't add script. the script is an editor script” 的错误。 