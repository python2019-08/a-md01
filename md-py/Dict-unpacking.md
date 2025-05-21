# 1.Dict unpacking

你遇到的 `SyntaxError: invalid syntax` 错误是因为在 Python 中，双星号 `**` 用于字典解包操作，通常在函数调用或者合并字典等特定场景下使用，不能直接像你这样在变量赋值语句中使用。

以下是 `**` 字典解包的正确使用场景示例：

## 1.1. **在函数调用中使用字典解包**：
```python
def func(a, b):
    print(f"a 的值是: {a}, b 的值是: {b}")

my_dict = {"a": 10, "b": 20}
func(**my_dict)
```
在这个例子中，`**my_dict` 将字典 `my_dict` 解包，字典的键值对作为关键字参数传递给函数 `func`。

## 1.2. **合并字典**：
```python
dict1 = {"key1": "value1"}
dict2 = {"key2": "value2"}
new_dict = {**dict1, **dict2}
print(new_dict)
```
这里使用 `**` 解包两个字典，并将它们合并成一个新的字典 `new_dict`。

如果你想将字典赋值给一个变量，正确的做法是直接赋值，不需要使用 `**`：
```python
xx = {"ddd": 122, "d2": 22}
print(xx)
```
这样，变量 `xx` 就会被赋值为一个包含键值对 `{"ddd": 122, "d2": 22}` 的字典。 