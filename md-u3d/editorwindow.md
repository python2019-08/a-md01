# 1.EditorWindow

在Unity中，`EditorWindow` 是一个非常重要的类，它允许开发者创建自定义的编辑器窗口，用于扩展Unity编辑器的功能。以下将从定义、创建步骤、生命周期、常见用途几个方面进行详细介绍：

### 定义
`EditorWindow` 类是Unity编辑器脚本API的一部分，继承自 `ScriptableObject`。通过创建 `EditorWindow` 的子类，开发者可以自定义窗口的外观和功能，以满足特定的开发需求。

### 创建自定义 `EditorWindow` 的步骤

#### 1. 创建脚本文件
在Unity项目的 `Assets/Editor` 文件夹下创建一个新的C#脚本文件（因为编辑器脚本需要放在 `Editor` 文件夹中才能被Unity识别）。

#### 2. 继承 `EditorWindow` 类
在脚本中创建一个类，继承自 `EditorWindow`，并实现相应的方法。

#### 3. 添加菜单选项
使用 `MenuItem` 属性为自定义窗口添加一个菜单项，以便在Unity编辑器的菜单中打开该窗口。

以下是一个简单的示例代码：
```csharp
using UnityEditor;
using UnityEngine;

public class MyCustomWindow : EditorWindow
{
    // 添加菜单项，点击该菜单项会打开自定义窗口
    [MenuItem("Window/My Custom Window")]
    public static void ShowWindow()
    {
        // 获取或创建自定义窗口实例
        MyCustomWindow window = GetWindow<MyCustomWindow>("My Custom Window");
        window.Show();
    }

    // 绘制窗口内容的方法
    private void OnGUI()
    {
        // 在窗口中显示一个标签
        GUILayout.Label("This is my custom window!", EditorStyles.boldLabel);

        // 创建一个按钮，点击按钮会在控制台输出信息
        if (GUILayout.Button("Click me!"))
        {
            Debug.Log("Button clicked!");
        }
    }
}
```
在上述示例中，通过 `[MenuItem("Window/My Custom Window")]` 为自定义窗口添加了一个菜单项，点击该菜单项会调用 `ShowWindow` 方法来打开窗口。`OnGUI` 方法用于绘制窗口的内容，这里显示了一个标签和一个按钮。

### `EditorWindow` 的生命周期方法

#### 1. `OnEnable`
当窗口被启用时调用，通常用于初始化窗口的状态和数据。

#### 2. `OnGUI`
用于绘制窗口的用户界面，会在窗口需要重绘时被频繁调用。

#### 3. `OnDisable`
当窗口被禁用时调用，通常用于清理资源和保存数据。

#### 4. `OnDestroy`
当窗口被销毁时调用，用于进行最后的清理工作。

### `EditorWindow` 的常见用途

#### 1. 自定义工具
创建自定义的编辑器工具，例如批量处理资源、生成特定的游戏对象等，提高开发效率。

#### 2. 数据管理
创建窗口来管理游戏中的数据，如配置文件、关卡数据等，方便开发者进行数据的编辑和查看。

#### 3. 调试和监控
创建窗口用于调试和监控游戏运行时的状态，例如查看角色的属性、性能指标等。

通过使用 `EditorWindow`，开发者可以根据自己的需求扩展Unity编辑器的功能，使开发过程更加高效和便捷。 

<----------------------------------------------------------------------->
<----------------------------------------------------------------------->
# 2.unity的Editor子类必须放到 Assets/Editor目录下吗

在 Unity 里，`Editor` 子类并非一定要放在 `Assets/Editor` 目录下，但把它们放在这个目录是比较推荐的做法，下面详细说明相关情况。

### 放在 `Assets/Editor` 目录的原因
- **仅在编辑器模式下编译**：Unity 会把 `Assets/Editor` 目录里的脚本仅在编辑器模式下进行编译。这就意味着这些脚本不会被包含在最终的游戏构建里，从而减小了游戏包体的大小。
- **代码组织清晰**：把所有和编辑器扩展相关的代码都放在 `Assets/Editor` 目录下，能让项目结构更加清晰，便于维护和管理。

### 不放在 `Assets/Editor` 目录的情况
- **使用条件编译**：要是你不想把 `Editor` 子类脚本放在 `Assets/Editor` 目录下，也可以通过条件编译来保证这些脚本仅在编辑器模式下被编译。例如：
```csharp
#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

public class MyEditorScript : Editor
{
    // 编辑器脚本代码
}
#endif
```
在这段代码中，`#if UNITY_EDITOR` 和 `#endif` 之间的代码只会在 Unity 编辑器中编译，不会包含在游戏构建中。

### 总结
虽然 `Editor` 子类不一定要放在 `Assets/Editor` 目录下，但为了项目的清晰性、可维护性以及避免不必要的代码被打包进游戏，建议你把所有的编辑器脚本都放在这个目录里。 
<----------------------------------------------------------------------->
<----------------------------------------------------------------------->
# 3.unity编程，为什么要创建Editor的子类？MonoBehavior子类的public 成员足够了吧

在 Unity 编程中，创建 `Editor` 子类和使用 `MonoBehaviour` 子类的 `public` 成员有着不同的用途和优势，二者不可相互替代，下面为你详细分析创建 `Editor` 子类的原因：

### 自定义 Inspector 面板
`MonoBehaviour` 子类的 `public` 成员确实可以在 Inspector 面板中显示，方便开发者在编辑器中进行参数调整。但默认的 Inspector 显示效果比较基础，只能展示简单的属性列表。而创建 `Editor` 子类，你可以对 Inspector 面板进行高度自定义，实现更丰富的交互和显示效果。
- **分组显示**：可以将相关的属性分组展示，让 Inspector 面板更加清晰易读。
- **添加自定义控件**：例如添加按钮、滑动条等控件，方便开发者在编辑器中执行特定的操作，而不仅仅是修改属性值。

### 执行编辑器特定操作
`MonoBehaviour` 主要用于处理游戏运行时的逻辑，而 `Editor` 子类则专注于编辑器模式下的操作。
- **自动化工具**：可以创建自定义的编辑器工具，如批量处理资源、生成特定的游戏对象等，提高开发效率。
- **数据验证和预处理**：在保存场景或构建游戏之前，对数据进行验证和预处理，确保数据的正确性和一致性。

### 可视化调试和辅助工具
`Editor` 子类可以创建可视化的调试工具和辅助工具，帮助开发者更好地理解和调试游戏。
- **绘制自定义 gizmos**：在场景视图中绘制自定义的图形和标记，用于显示游戏对象的信息或辅助调试。
- **创建自定义窗口**：可以创建自定义的编辑器窗口，用于显示游戏数据、调试信息或进行特定的操作。

### 示例代码
以下是一个简单的示例，展示了如何创建一个 `Editor` 子类来自定义 Inspector 面板：

```csharp
using UnityEngine;
using UnityEditor;

// 自定义的 MonoBehaviour 脚本
public class MyScript : MonoBehaviour
{
    public int myInt;
    public float myFloat;
}

// 自定义的 Editor 脚本
[CustomEditor(typeof(MyScript))]
public class MyScriptEditor : Editor
{
    public override void OnInspectorGUI()
    {
        // 获取目标脚本实例
        MyScript myScript = (MyScript)target;

        // 显示自定义的 Inspector 界面
        GUILayout.Label("自定义 Inspector 面板");
        myScript.myInt = EditorGUILayout.IntField("整数属性", myScript.myInt);
        myScript.myFloat = EditorGUILayout.FloatField("浮点数属性", myScript.myFloat);

        // 添加一个按钮
        if (GUILayout.Button("执行操作"))
        {
            // 执行特定的操作
            Debug.Log("按钮被点击，执行操作！");
        }

        // 应用修改
        if (GUI.changed)
        {
            EditorUtility.SetDirty(target);
        }
    }
}
```

在这个示例中，`MyScript` 是一个普通的 `MonoBehaviour` 脚本，而 `MyScriptEditor` 是一个自定义的 `Editor` 脚本，用于自定义 `MyScript` 的 Inspector 面板。通过 `[CustomEditor(typeof(MyScript))]` 特性，将 `MyScriptEditor` 与 `MyScript` 关联起来。在 `OnInspectorGUI` 方法中，我们可以自定义 Inspector 面板的显示内容和交互逻辑。

综上所述，创建 `Editor` 子类可以为 Unity 开发提供更多的灵活性和便利性，尤其是在编辑器工具开发和自定义界面方面，与 `MonoBehaviour` 子类的 `public` 成员相互补充，共同提升开发效率和用户体验。 