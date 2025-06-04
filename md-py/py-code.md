# 1.os.listdir AND glob.glob

这个 `FileNotFoundError` 错误是因为你在调用 `os.listdir()` 函数时，传入的路径参数并不是一个有效的目录路径，而是一个可能包含文件名通配符（`*`）的类似文件名的字符串。

`os.listdir()` 函数的作用是列出指定目录中的所有文件和子目录，它需要传入一个有效的目录路径。而你传入的 `"./【时长3小时】50首非常好听的经典钢琴曲、古典钢琴曲，值得循环播放*.mp4"` 看起来更像是一个具体的文件名（并且包含了通配符 `*`），而不是一个目录路径，所以会导致找不到该路径的错误。

以下是一些可能的解决方法：

1. **确认路径是否正确**：如果你想列出某个目录下的所有文件和子目录，确保传入 `os.listdir()` 的参数是一个存在的目录路径。例如，如果你的文件都在 `"./music_files"` 目录下，你应该这样调用：
```python
import os

mp4PathArr = os.listdir("./music_files")
for item in mp4PathArr:
    print(item)
```

2. **处理文件名通配符**：如果你想使用通配符来匹配文件名，可以使用 `glob` 模块。例如，如果你想获取当前目录下所有以 `.mp4` 结尾的文件，可以这样写：
```python
import glob

mp4_files = glob.glob("./【时长3小时】50首非常好听的经典钢琴曲、古典钢琴曲，值得循环播放*.mp4")
for file in mp4_files:
    print(file)
```

`glob.glob()` 函数会返回所有匹配给定模式的文件路径列表，这样就可以正确处理包含通配符的文件名了。

根据你的具体需求，选择合适的方法来解决这个问题。 

===================================================
# 2.用python代码 实现 获取当前py文件所在绝对路径

在Python中，你可以使用`os`或`pathlib`模块来获取当前Python文件的绝对路径。这两种方法都很常用，下面我为你提供这两种实现方式：

```py
import os
from pathlib import Path

# 方法一：使用os模块
def get_current_path_with_os():
    # 获取当前文件的绝对路径
    current_path = os.path.abspath(__file__)
    return current_path

# 方法二：使用pathlib模块
def get_current_path_with_pathlib():
    # 获取当前文件的绝对路径
    current_path = Path(__file__).resolve()
    return current_path

# 方法三：获取当前文件所在目录的绝对路径
def get_current_dir_path():
    # 使用os模块
    current_dir = os.path.dirname(os.path.abspath(__file__))
    # 或者使用pathlib模块
    # current_dir = Path(__file__).resolve().parent
    return current_dir

if __name__ == "__main__":
    print("当前文件的绝对路径 (os模块):", get_current_path_with_os())
    print("当前文件的绝对路径 (pathlib模块):", get_current_path_with_pathlib())
    print("当前文件所在目录的绝对路径:", get_current_dir_path())

```

### 代码说明

- **os模块实现**：使用`os.path.abspath(__file__)`获取当前文件的绝对路径。这是传统的实现方式，兼容性较好。

- **pathlib模块实现**：使用`Path(__file__).resolve()`获取当前文件的绝对路径。`pathlib`是Python 3.4引入的面向对象的路径操作模块，代码更加简洁直观。

- **获取目录路径**：如果你需要获取当前文件所在的目录路径，可以使用`os.path.dirname()`或`Path().parent`。

### 使用建议

- 如果你使用Python 3.4及以上版本，推荐使用`pathlib`模块，它提供了更现代、面向对象的API。
- 如果你需要兼容Python 2或旧版Python 3，使用`os.path`模块更合适。

这两种方法都能可靠地获取当前Python文件的绝对路径，选择哪种取决于你的项目需求和个人偏好。