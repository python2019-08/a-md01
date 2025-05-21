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
