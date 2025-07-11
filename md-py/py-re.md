# 1.python 的 re.sub

在Python中，`re.sub()`是正则表达式模块`re`提供的一个强大函数，用于在字符串中替换匹配正则表达式的文本。它的灵活性使其成为处理文本替换任务的常用工具。


### **基本语法**
```python
re.sub(pattern, repl, string, count=0, flags=0)
```
- **`pattern`**：正则表达式模式，用于匹配需要替换的文本。
- **`repl`**：替换文本，可以是字符串或函数。
- **`string`**：需要处理的原始字符串。
- **`count`**（可选）：最多替换的次数，默认值为`0`表示全部替换。
- **`flags`**（可选）：正则表达式标志，如`re.IGNORECASE`、`re.DOTALL`等。


### **常见用法示例**

#### 1. **替换固定字符串**
```python
import re

text = "Hello, World! Hello, Python!"
new_text = re.sub(r'Hello', 'Hi', text)
print(new_text)  # 输出: "Hi, World! Hi, Python!"
```

#### 2. **使用正则表达式分组**
通过`\1`、`\2`等引用正则表达式中的分组：
```python
text = "2023-05-18"
# 交换年和日的位置
new_text = re.sub(r'(\d{4})-(\d{2})-(\d{2})', r'\3-\2-\1', text)
print(new_text)  # 输出: "18-05-2023"
```

#### 3. **使用函数动态替换**
当`repl`为函数时，每次匹配都会调用该函数并传入匹配对象：
```python
def double_number(match):
    num = int(match.group(0))
    return str(num * 2)

text = "a1b2c3"
new_text = re.sub(r'\d+', double_number, text)
print(new_text)  # 输出: "a2b4c6"
```

#### 4. **忽略大小写替换**
使用`re.IGNORECASE`标志：
```python
text = "Hello, hello, HELLO"
new_text = re.sub(r'hello', 'Hi', text, flags=re.IGNORECASE)
print(new_text)  # 输出: "Hi, Hi, Hi"
```


### **高级技巧**

#### 1. **替换HTML标签**
```python
html = "<p>Hello <b>World</b>!</p>"
plain_text = re.sub(r'<[^>]+>', '', html)
print(plain_text)  # 输出: "Hello World!"
```

#### 2. **替换重复字符**
压缩多个连续空格为单个空格：
```python
text = "Hello   World!   Python"
new_text = re.sub(r'\s+', ' ', text)
print(new_text)  # 输出: "Hello World! Python"
```

#### 3. **替换特定位置的文本**
结合`count`参数限制替换次数：
```python
text = "aabbaabbaabb"
# 只替换前两个 'aa'
new_text = re.sub(r'aa', 'AA', text, count=2)
print(new_text)  # 输出: "AABBAABBaabb"
```


### **注意事项**
1. **正则表达式转义**：特殊字符（如`.`、`*`、`(`等）需要使用`\`转义。
2. **贪婪匹配**：默认情况下，正则表达式是贪婪的（尽可能匹配更多字符），可使用`?`改为非贪婪模式。
3. **替换字符串中的反斜杠**：如果`repl`中需要使用反斜杠，建议使用原始字符串（如`r'\n'`）。


### **更多资源**
- [Python官方文档：re.sub()](https://docs.python.org/3/library/re.html#re.sub)
- [正则表达式在线测试工具](https://regex101.com/)

希望这些示例能帮助你掌握`re.sub()`的用法！如果有具体的替换需求，可以提供更多细节，我会进一步解答。

==============================================
# 2. 什么是 捕获组 ？什么是 非捕获组？

在正则表达式中，**捕获组**（Capturing Group）和**非捕获组**（Non-Capturing Group）是两种不同的分组方式，它们的主要区别在于是否会保存匹配的文本以供后续使用。以下是详细解释：


### **1. 捕获组（Capturing Group）**
捕获组是用圆括号 `()` 包围的正则表达式部分。它的作用是：
- **匹配并保存**该部分的文本
- **编号分组**，方便后续引用（如通过 `$1`, `$2` 或 `\1`, `\2` 等方式）
- **用于提取或替换**操作

#### **示例**：
```python
import re

text = "Hello, World! 2023"
pattern = r"(\w+), (\w+)"  # 两个捕获组

match = re.search(pattern, text)
if match:
    print(match.group(0))  # 完整匹配：Hello, World
    print(match.group(1))  # 第一个捕获组：Hello
    print(match.group(2))  # 第二个捕获组：World
```

#### **捕获组的编号规则**：
- `group(0)`：整个匹配的文本
- `group(1)`：第一个括号内的内容
- `group(2)`：第二个括号内的内容
- 以此类推...


### **2. 非捕获组（Non-Capturing Group）**
非捕获组使用 `(?:...)` 语法，它的作用是：
- **仅匹配**该部分的文本，但**不保存**匹配结果
- **不参与编号**，节省内存和提高效率
- **用于逻辑分组**，例如定义多选分支或量词范围

#### **示例**：
```python
import re

text = "Color: red, colour: blue"
pattern = r"(?:colou?r): (\w+)"  # 非捕获组 + 捕获组

matches = re.findall(pattern, text)
print(matches)  # ['red', 'blue']（仅返回捕获组的内容）
```

#### **为什么需要非捕获组？**
- **性能优化**：避免保存不需要的文本，减少内存占用。
- **简化编号**：当分组较多时，避免编号混乱。
- **逻辑清晰**：明确区分“需要提取的内容”和“仅用于匹配的逻辑”。


### **3. 捕获组 vs 非捕获组对比**
| **特性**              | **捕获组 `(...)`**       | **非捕获组 `(?:...)`**     |
|-----------------------|--------------------------|---------------------------|
| 是否保存匹配结果      | ✅ 是                    | ❌ 否                     |
| 是否参与编号          | ✅ 是（从 1 开始）       | ❌ 否                     |
| 能否被后续引用        | ✅ 能（如 `$1`, `\1`）   | ❌ 不能                   |
| 语法                  | `(pattern)`              | `(?:pattern)`             |
| 典型用途              | 提取内容、替换操作       | 逻辑分组、多选分支        |


### **4. 其他分组语法**
除了捕获组和非捕获组，正则表达式还有一些特殊分组语法：

#### **4.1 正向预查（Positive Lookahead）**
- **语法**：`(?=pattern)`
- **作用**：匹配后面紧跟 `pattern` 的位置，但不消耗字符。

```python
text = "apple.jpg, banana.png"
pattern = r"\w+(?=\.jpg)"  # 匹配 .jpg 前的单词
print(re.findall(pattern, text))  # ['apple']
```

#### **4.2 负向预查（Negative Lookahead）**
- **语法**：`(?!pattern)`
- **作用**：匹配后面不紧跟 `pattern` 的位置。

```python
text = "apple.jpg, banana.png"
pattern = r"\w+(?!\.jpg)"  # 匹配后面不是 .jpg 的单词
print(re.findall(pattern, text))  # ['banana']
```


### **总结**
- **捕获组**：用 `(...)` 定义，用于提取和保存匹配的文本。
- **非捕获组**：用 `(?:...)` 定义，仅用于逻辑分组，不保存结果。
- **选择原则**：如果需要后续引用分组内容，用捕获组；否则用非捕获组提升性能。

理解分组语法能让你更精准地控制正则表达式的匹配和提取逻辑！