# 1.C# raw string

在C#里，原始字符串字面量（raw string literal）是从C# 11开始引入的新特性，它能让你轻松处理多行字符串、包含特殊字符的字符串，而无需进行转义。下面是关于原始字符串字面量的详细介绍：

### 基本语法
原始字符串字面量以三个双引号 `"""` 开头和结尾，中间可以包含任意字符，包括换行符和特殊字符，无需转义。

### 示例代码
```csharp
using System;

class Program
{
    static void Main()
    {
        // 原始字符串字面量示例
        string rawString = """
            This is a multi-line string.
            It can contain special characters like " without escaping.
            Even backslashes \ don't need to be escaped.
            """;

        Console.WriteLine(rawString);

        // 包含双引号的原始字符串
        string stringWithQuotes = """
            He said, "Hello, world!"
            """;

        Console.WriteLine(stringWithQuotes);
    }
}
```

### 代码解释
1. **多行字符串**：在原始字符串字面量里，换行符会被原样保留，这样就能方便地表示多行文本。
2. **特殊字符**：像双引号 `"` 和反斜杠 `\` 这类特殊字符，无需进行转义。
3. **嵌套双引号**：如果字符串中需要嵌套双引号，也无需额外处理。

### 注意事项
- 原始字符串字面量开头和结尾的三个双引号必须单独占一行。
- 可以在开头和结尾的三个双引号后面添加更多的双引号，以此来避免字符串内部包含三个连续双引号时产生冲突。例如：
```csharp
string complexString = """"
    This string contains """ within it.
    """";
```

借助原始字符串字面量，你能够更简洁、直观地处理复杂的字符串。 

<-------------------------------------------------------------------->
<-------------------------------------------------------------------->
# 2.逐字字符串字面量（verbatim string literal）

## 2.1 question
```csharp
asset = InputActionAsset.FromJson(@"{
    ""name"": ""Player Action"",
}")这里，@“”是raw string马
```

## 2.2 answer
在C#中，`@""` 表示的是逐字字符串字面量（verbatim string literal），这和你前面提到的原始字符串字面量（raw string literal，C# 11引入，以三个双引号 `"""` 开头和结尾）不是同一回事，但它们的作用有相似之处，都是为了简化字符串处理，减少转义字符的使用。

### 逐字字符串字面量的特点
- **无需转义特殊字符**：在逐字字符串中，像反斜杠 `\` 这样的特殊字符无需转义。例如，要表示文件路径 `C:\Users\Documents`，使用普通字符串需要写成 `"C:\\Users\\Documents"`，而使用逐字字符串则可以写成 `@"C:\Users\Documents"`。
- **支持多行字符串**：逐字字符串可以跨越多行，换行符会被原样保留。例如：
```csharp
string multiLine = @"This is a
multi - line
string.";
```

### 代码示例中的情况
在你给出的代码 `asset = InputActionAsset.FromJson(@"{
    ""name"": ""Player Action"",
}")` 里，`@""` 把其中的字符串当作逐字字符串处理。在这个字符串中，因为要表示JSON格式，所以双引号 `"` 还是需要转义，但反斜杠等其他字符就无需转义了。如果不使用逐字字符串，那么字符串中的反斜杠也需要进行转义，代码会变得更复杂。

### 总结
`@""` 是逐字字符串字面量，而不是原始字符串字面量。虽然它们都能减少转义字符的使用，但语法和引入版本有所不同。 

<-------------------------------------------------------------------->
<-------------------------------------------------------------------->
# 3.public partial class @PlayerAction里@的作用是？

## 3.1question
unity脚本
```csharp
public partial class @PlayerAction: IInputActionCollection2, IDisposable
```
这里@的作用是？
## 3.2answer
在C#里，`@` 符号在标识符（像类名、方法名、变量名等）前面使用时，其作用是把该标识符当作合法的C#标识符。C#有一系列的保留关键字（例如 `class`、`public`、`int` 等），正常情况下不能把这些关键字用作标识符。不过，当在关键字前面加上 `@` 符号时，就能将其当作普通的标识符来用。

在你给出的代码 `public partial class @PlayerAction: IInputActionCollection2, IDisposable` 中，`@` 符号用在 `PlayerAction` 前面，可能是因为 `PlayerAction` 这个名字在某些情况下和C#的保留关键字冲突，或者在特定的代码生成规则里需要使用这样的命名方式。但在大多数情形下，`PlayerAction` 并非C#的保留关键字，所以此处使用 `@` 可能是为了避免潜在的命名冲突或者遵循特定的命名规范。

下面是一个简单的示例，用以说明 `@` 符号的用法：

```csharp
// 使用 @ 符号将关键字作为标识符
class @class
{
    public int @int;
    public void @void()
    {
        // 方法体
    }
}

class Program
{
    static void Main()
    {
        @class myClass = new @class();
        myClass.@int = 10;
        myClass.@void();
    }
}
```

在这个示例中，`@class`、`@int` 和 `@void` 都被当作普通的标识符来使用。不过，在实际的编程里，建议尽量避免使用 `@` 符号来处理保留关键字，因为这样会让代码的可读性变差。 

<-------------------------------------------------------------------->
<-------------------------------------------------------------------->
# 4. C# 中类的可见性

在 C# 中，类的可见性（访问修饰符）决定了类在程序中的可访问范围。合理使用访问修饰符有助于封装代码、控制依赖关系和提高安全性。以下是 C# 中类的主要可见性修饰符及其使用规则：


### **1. `public`（公共）**
- **可见范围**：任何代码都可以访问。
- **适用场景**：作为公共 API 的一部分，允许外部程序集引用。
- **示例**：
  ```csharp
  public class MyPublicClass {
      // 公共类可以被任何地方访问
  }
  ```


### **2. `internal`（内部）**
- **可见范围**：同一程序集（Assembly）内可见，外部程序集无法访问。
- **适用场景**：封装项目内部的实现细节，隐藏不希望被外部依赖的类。
- **示例**：
  ```csharp
  internal class MyInternalClass {
      // 只能在当前项目中访问
  }
  ```


### **3. `private`（私有）**
- **可见范围**：仅在包含它的类或结构体内部可见。
- **适用场景**：嵌套类（Nested Class）中使用，隐藏内部实现。
- **示例**：
  ```csharp
  public class OuterClass {
      private class MyPrivateClass {
          // 只能在 OuterClass 内部访问
      }
  }
  ```


### **4. `protected`（受保护）**
- **可见范围**：仅在当前类或其派生类中可见。
- **适用场景**：基类希望派生类能够访问其内部类，但对外部隐藏。
- **示例**：
  ```csharp
  public class BaseClass {
      protected class MyProtectedClass {
          // 可在 BaseClass 及其派生类中访问
      }
  }

  public class DerivedClass : BaseClass {
      void AccessProtectedClass() {
          var obj = new MyProtectedClass(); // 合法
      }
  }
  ```


### **5. `protected internal`（受保护的内部）**
- **可见范围**：同一程序集内的任何代码，或不同程序集的派生类。
- **示例**：
  ```csharp
  protected internal class MyProtectedInternalClass {
      // 同一程序集或派生类可访问
  }
  ```


### **6. `private protected`（私有受保护）**
- **可见范围**：同一程序集内的派生类，且必须通过包含它的类访问。
- **示例**：
  ```csharp
  public class BaseClass {
      private protected class MyPrivateProtectedClass {
          // 仅在同一程序集的派生类中通过 BaseClass 访问
      }
  }
  ```


### **使用规则**
1. **顶级类**（非嵌套类）只能使用 `public` 或 `internal`，默认为 `internal`。
2. **嵌套类**可以使用所有修饰符，其可见性受限于外部类的可见性。
3. **访问修饰符的限制顺序**：`private` < `private protected` < `protected` < `internal` < `protected internal` < `public`。


### **示例：嵌套类的可见性**
```csharp
public class OuterClass {
    // 公共嵌套类，外部可访问
    public class PublicNestedClass { }

    // 内部嵌套类，同一程序集可访问
    internal class InternalNestedClass { }

    // 私有嵌套类，仅 OuterClass 可访问
    private class PrivateNestedClass { }

    // 受保护嵌套类，OuterClass 及其派生类可访问
    protected class ProtectedNestedClass { }
}
```


### **最佳实践**
- **最小化可见性**：默认使用 `internal`，仅对必要的类使用 `public`。
- **避免过度暴露**：通过接口（`interface`）或抽象类隐藏具体实现。
- **文档注释**：为 `public` 类添加 XML 注释，说明其用途和限制。

通过合理设置类的可见性，可以提高代码的可维护性和安全性，减少不必要的依赖关系。

================================================
# 5.$"{action.actionMap}_{action.name}_{bindingIndex}"

这是 C# 中的 **字符串内插（String Interpolation）** 语法，从 C# 6.0 版本开始引入。它提供了一种更简洁、直观的方式来构建字符串，比传统的字符串格式化（如 `string.Format()`）或字符串连接（如 `+` 操作符）更易读。


### **语法结构**
字符串内插的基本形式是在字符串前加一个 `$` 符号，然后在字符串中使用 `{}` 包裹变量或表达式。例如：
```csharp
string name = "Alice";
int age = 30;
string message = $"Hello, {name}! You are {age} years old.";
// 输出: "Hello, Alice! You are 30 years old."
```


### **分析示例 `$"{action.actionMap}_{action.name}_{bindingIndex}"`**
这个表达式将三个值组合成一个字符串：
1. `action.actionMap`：表示 `action` 对象的 `actionMap` 属性。
2. `action.name`：表示 `action` 对象的 `name` 属性。
3. `bindingIndex`：一个变量（可能是整数）。

三个值之间用下划线 `_` 连接，例如：
- 如果 `action.actionMap = "Player"`，`action.name = "Jump"`，`bindingIndex = 0`，
- 则结果为 `"Player_Jump_0"`。


### **优势**
1. **更简洁**：无需显式调用 `ToString()` 或使用占位符。
2. **更易读**：直接在字符串中嵌入变量名，逻辑清晰。
3. **支持表达式**：可以在 `{}` 中使用任意 C# 表达式。


### **进阶用法**
1. **格式化数值**：
   ```csharp
   double price = 9.99;
   string formatted = $"Price: ${price:F2}"; // 输出: "Price: $9.99"
   ```

2. **嵌套表达式**：
   ```csharp
   string product = "Apple";
   int count = 3;
   string result = $"I have {count} {(count == 1 ? "item" : "items")} ({product}).";
   // 输出: "I have 3 items (Apple)."
   ```

3. **与对象属性结合**：
   ```csharp
   var person = new { Name = "Bob", Age = 25 };
   string info = $"Name: {person.Name}, Age: {person.Age}";
   ```


### **性能**
字符串内插在编译时会被转换为 `string.Format()` 或 `StringBuilder`，性能与传统方法相近，但代码更简洁。


### **兼容性**
- 需要 C# 6.0 或更高版本。
- 在 Unity 中，需要 Unity 2018.3 或更高版本支持。


### **与传统方法对比**
**传统方法**：
```csharp
string oldStyle = string.Format("{0}_{1}_{2}", action.actionMap, action.name, bindingIndex);
// 或
string concatenated = action.actionMap + "_" + action.name + "_" + bindingIndex;
```

**字符串内插**：
```csharp
string interpolated = $"{action.actionMap}_{action.name}_{bindingIndex}";
```

通过字符串内插，可以更清晰地表达字符串构建的逻辑，减少错误并提高代码可读性。