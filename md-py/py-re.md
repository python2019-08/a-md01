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