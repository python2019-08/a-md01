# 1.CMake 中，macro 和 function 对变量作用域的处理

<!-- DoubaoAI -->

在 CMake 中，`macro` 和 `function` 对变量作用域的处理**截然不同**：

- **`function` 中的变量**：默认是局部作用域，仅在函数内部有效（除非使用 `PARENT_SCOPE` 显式传递到父作用域）。
- **`macro` 中的变量**：默认是**全局/父作用域**的，宏内部定义的变量会直接修改调用者作用域中的同名变量，**没有局部作用域的默认隔离**。

## 例子
```
macro(test_macro)
  set(var "宏内部的值")  # 直接修改父作用域的变量
  message("tt...宏内: ${var}")  # 输出：宏内: 宏内部的值
endmacro()

set(var "外部初始值")
test_macro()
message("tt...宏外: ${var}")  # 输出：宏外: 宏内部的值（被宏修改了）

macro(test_macro)
  # 使用临时变量名（避免污染外部）
  set(local_var "宏内部的临时值")
  message("tt...宏内:local_var= ${local_var}")  # 输出：宏内: 宏内部的临时值

  # 如需传递到外部，显式用 PARENT_SCOPE
  set(export_var "需要导出的值" PARENT_SCOPE)
endmacro()

set(export_var "外部初始值")
test_macro()
message("tt...宏外(临时变量无影响): local_var=${local_var}")  # 输出：宏外(临时变量无影响): （空）
message("tt...宏外(导出变量): export_var=${export_var}")        # 输出：宏外(导出变量): 需要导出的值
```

运行 后

```sh
$ cmake -S. -B build 

tt...宏内: 宏内部的值
tt...宏外: 宏内部的值
tt...宏内:local_var= 宏内部的临时值
CMake Warning (dev) at CMakeLists.txt:42 (set):
  Cannot set "export_var": current scope has no parent.
Call Stack (most recent call first):
  CMakeLists.txt:46 (test_macro)
This warning is for project developers.  Use -Wno-dev to suppress it.

tt...宏外(临时变量无影响): local_var=宏内部的临时值
tt...宏外(导出变量): export_var=外部初始值
```
从运行结果和警告信息来看，主要涉及 CMake 宏（`macro`）的作用域特性和 `PARENT_SCOPE` 的使用限制，具体分析如下：


### 1. 第一个宏 `test_macro` 的行为（符合预期）
```cmake
macro(test_macro)
  set(var "宏内部的值")  # 直接修改父作用域变量
  message("tt...宏内: ${var}")
endmacro()

set(var "外部初始值")
test_macro()
message("tt...宏外: ${var}")
```
- **结果**：宏内修改的 `var` 直接影响了外部变量，输出为 `宏内部的值`。
- **原因**：`macro` 没有局部作用域，`set(var ...)` 直接操作父作用域的变量（这是 `macro` 的默认行为）。


### 2. 第二个宏 `test_macro` 的警告和异常结果分析
```cmake
macro(test_macro)
  set(local_var "宏内部的临时值")  # 看似“临时变量”
  message("tt...宏内:local_var= ${local_var}")
  
  set(export_var "需要导出的值" PARENT_SCOPE)  # 警告来源
endmacro()

set(export_var "外部初始值")
test_macro()
message("tt...宏外(临时变量无影响): local_var=${local_var}")
message("tt...宏外(导出变量): export_var=${export_var}")
```

#### （1）警告 `Cannot set "export_var": current scope has no parent`
- **原因**：`PARENT_SCOPE` 用于将变量传递到“父作用域”，但如果宏在**最顶层作用域**（如直接在 `CMakeLists.txt` 根目录）调用，当前作用域没有父级，因此 `PARENT_SCOPE` 无效。
- **后果**：`set(export_var ... PARENT_SCOPE)` 执行失败，`export_var` 仍保持外部初始值（`外部初始值`）。


#### （2）`local_var` 在宏外可见（不符合预期）
- **结果**：宏外输出 `local_var=宏内部的临时值`，说明 `local_var` 没有被隔离。
- **原因**：`macro` 本质是**文本替换**，没有真正的局部作用域。宏内部的 `set(local_var ...)` 会直接在调用者的作用域中创建变量（即使变量名不同，也会污染外部）。  
  这与 `function` 不同：`function` 会创建独立作用域，内部变量默认不可见。


### 总结：`macro` 与 `function` 的核心差异
| 现象                | 原因分析                                                                 |
|---------------------|--------------------------------------------------------------------------|
| 宏内变量污染外部    | `macro` 无局部作用域，所有变量操作都在调用者作用域中执行（类似文本替换） |
| `PARENT_SCOPE` 警告 | 当宏在最顶层作用域调用时，没有父级作用域，`PARENT_SCOPE` 无效            |
| 临时变量无法隔离    | `macro` 不能像 `function` 那样自动隔离内部变量，必须手动避免命名冲突      |


### 解决方案
如果需要变量隔离和作用域控制，**优先使用 `function` 而非 `macro`**：
```cmake
function(test_func)
  set(local_var "函数内部的临时值")  # 局部变量，自动隔离
  message("tt...函数内:local_var= ${local_var}")
  
  set(export_var "需要导出的值" PARENT_SCOPE)  # 正确传递到父作用域
endfunction()

set(export_var "外部初始值")
test_func()
message("tt...函数外(临时变量无影响): local_var=${local_var}")  # 空（正确隔离）
message("tt...函数外(导出变量): export_var=${export_var}")        # 输出：需要导出的值（正确传递）
```

`function` 会创建独立作用域，内部变量默认局部，`PARENT_SCOPE` 也能正常工作，更适合需要变量隔离的场景。而 `macro` 适合简单的文本替换，不适合复杂逻辑。