# 1.  action='store_true' 的意思
```py
parser.add_argument('--overwrite', action='store_true', help='是否覆盖已存在的文件') 
```
这里action='store_true' 的意思?

在argparse模块中，`action='store_true'` 是一种常用的参数配置方式，用于处理布尔类型的命令行选项。具体来说：

1. **参数效果**  
   当你在命令行中指定了这个选项（例如 `--overwrite`），对应的变量会被赋值为 `True`；如果不指定，变量默认为 `False`。

2. **示例说明**  
   对于你的脚本中的 `--overwrite` 选项：
   - 如果你运行命令 `python image_resizer.py --input in.jpg --output out.jpg --overwrite`，  
     则 `args.overwrite` 的值为 `True`，表示允许覆盖已存在的文件。
   - 如果你不使用 `--overwrite` 选项，  
     则 `args.overwrite` 的值默认为 `False`，脚本不会覆盖已存在的文件。

3. **等价写法**  
   `action='store_true'` 实际上是一种简写，等价于：
   ```python
   parser.add_argument('--overwrite', 
                       dest='overwrite',  # 存储到args.overwrite变量
                       action='store_const', 
                       const=True,        # 指定为True
                       default=False,     # 默认值为False
                       help='是否覆盖已存在的文件')
   ```

4. **适用场景**  
   这种方式适用于只需开关控制的选项，例如：
   - 是否强制覆盖文件（`--force`, `--overwrite`）
   - 是否显示详细信息（`--verbose`）
   - 是否启用调试模式（`--debug`）

5. **代码中的作用**  
   在你的图片调整脚本中，`args.overwrite` 用于控制是否覆盖已存在的输出文件：
   ```python
   if not overwrite and os.path.exists(output_path):
       print(f"文件 {output_path} 已存在，跳过处理")
       return
   ```

总结：`action='store_true'` 是argparse中处理布尔开关选项的简洁方式，让你可以通过命令行轻松控制脚本的行为模式。

===============================================================
===============================================================
# 2.除了'store_true'，argparse模块中还有哪些常用的action参数？
在`argparse`模块中，`action`参数控制着命令行参数如何被解析并存储到结果中。除了常用的`store_true`，还有许多其他实用的`action`选项，下面是一些常见的类型及其使用场景：


### 1. **store**（默认行为）
存储参数值到结果中，可指定参数类型。
```python
parser.add_argument('--name', action='store', type=str)  # 等同于 parser.add_argument('--name')
```
- **示例**：`--name "Alice"` → `args.name` 存储为 `"Alice"`


### 2. **store_const**
存储预定义的常量值，而非用户输入的值。
```python
parser.add_argument('--version', action='store_const', const='1.0.0')
```
- **示例**：`--version` → `args.version` 存储为 `"1.0.0"`


### 3. **store_true / store_false**
专门用于布尔类型参数，分别存储`True`和`False`。
```python
parser.add_argument('--verbose', action='store_true')    # 默认False，指定则为True
parser.add_argument('--quiet', action='store_false')     # 默认True，指定则为False
```
- **示例**：`--verbose` → `args.verbose` 为 `True`


### 4. **append**
将多次出现的参数值收集到列表中。
```python
parser.add_argument('--files', action='append')
```
- **示例**：`--files a.txt --files b.txt` → `args.files` 为 `['a.txt', 'b.txt']`


### 5. **append_const**
将预定义的常量追加到列表中。
```python
parser.add_argument('--debug', action='append_const', const='DEBUG')
```
- **示例**：`--debug --debug` → `args.debug` 为 `['DEBUG', 'DEBUG']`


### 6. **count**
统计参数出现的次数，常用于调整日志级别等场景。
```python
parser.add_argument('-v', '--verbose', action='count')
```
- **示例**：`-vvv` → `args.verbose` 为 `3`


### 7. **help**
显示帮助信息并退出程序（自动添加到所有解析器）。
```python
parser.add_argument('-h', '--help', action='help')
```


### 8. **version**
显示程序版本信息并退出。
```python
parser.add_argument('--version', action='version', version='%(prog)s 1.0')
```
- **示例**：`--version` → 输出 `your_program 1.0`


### 9. **extend**（Python 3.8+）
类似`append`，但允许多值参数合并为一个列表。
```python
parser.add_argument('--files', action='extend', nargs='+')
```
- **示例**：`--files a.txt b.txt --files c.txt` → `args.files` 为 `['a.txt', 'b.txt', 'c.txt']`


### 10. **自定义Action类**
通过继承`argparse.Action`创建自定义行为。
```python
class UpperCaseAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, values.upper())

parser.add_argument('--name', action=UpperCaseAction)
```
- **示例**：`--name "alice"` → `args.name` 存储为 `"ALICE"`


### 常用组合示例
```python
parser = argparse.ArgumentParser()

# 存储字符串
parser.add_argument('--input', help='输入文件路径')

# 存储整数
parser.add_argument('--size', type=int, help='指定大小')

# 布尔开关
parser.add_argument('--force', action='store_true', help='强制覆盖')

# 计数选项
parser.add_argument('-v', '--verbose', action='count', default=0, help='增加日志级别')

# 多值列表
parser.add_argument('--paths', action='append', help='添加路径')

# 版本信息
parser.add_argument('--version', action='version', version='1.0.0')
```


### 总结
| Action参数       | 作用                                                         |
|------------------|--------------------------------------------------------------|
| `store`          | 默认行为，存储参数值                                         |
| `store_const`    | 存储预定义常量                                               |
| `store_true`/`store_false` | 存储布尔值（True/False）                            |
| `append`         | 将多次参数值收集到列表                                       |
| `append_const`   | 将常量追加到列表                                             |
| `count`          | 统计参数出现次数                                             |
| `help`           | 显示帮助信息并退出                                           |
| `version`        | 显示版本信息并退出                                           |
| `extend`         | 合并多值参数到一个列表（Python 3.8+）                       |
| 自定义类         | 实现任意解析逻辑                                             |

合理使用这些`action`参数可以让你的命令行工具更加灵活和强大！