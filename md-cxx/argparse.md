# 1.C++ argparse 方案完整教程
C++ 没有标准库自带命令行解析，主流两套方案：
1. **argparse-cpp**：仿 Python `argparse`，语法最简单，推荐新手
2. **CLI11**：工业级、性能更好、功能更强，大型项目首选
3. 原生 `argc/argv`：极简场景手动解析

## 一、仿 Python 风格：argparse-cpp
### 1. 仓库与引入
开源仓库：https://github.com/p-ranav/argparse
仅头文件库，直接复制 `argparse.hpp` 到项目即可，无需编译链接。

### 2. 完整示例代码
```cpp
// https://github.com/p-ranav/argparse
#include <argparse/argparse.hpp>
#include <iostream>

int main(int argc, char *argv[]) {
    // 1. 创建解析器，程序名+描述
    argparse::ArgumentParser parser("demo", "C++ argparse 示例程序");

    // 2. 添加参数
    // ① 必选位置参数
    parser.add_argument("input")
        .help("输入文件路径")
        .required();

    // ② 可选参数 -o / --output
    parser.add_argument("-o", "--output")
        .help("输出文件路径，默认 out.txt")
        .default_value(std::string("out.txt"));

    // ③ 布尔开关 --verbose，不传false，传true
    parser.add_argument("--verbose")
        .help("开启详细日志")
        .default_value(false)
        .implicit_value(true);

    // ④ 整数参数 --count
    parser.add_argument("--count")
        .help("循环次数")
        .scan<'i', int>()  // 解析为int
        .default_value(5);

    // ⑤ 多值参数 --files 可传多个文件
    parser.add_argument("--files")
        .help("多个文件列表")
        .nargs(argparse::nargs_pattern::any);

    // 3. 解析命令行，自动处理-h/--help
    try {
        parser.parse_args(argc, argv);
    } catch (const std::runtime_error& err) {
        std::cerr << err.what() << std::endl;
        std::cerr << parser;
        return 1;
    }

    // 4. 获取解析后的参数
    std::string input_path = parser.get<std::string>("input");
    std::string output_path = parser.get<std::string>("output");
    bool verbose = parser.get<bool>("verbose");
    int loop_cnt = parser.get<int>("count");
    auto file_list = parser.get<std::vector<std::string>>("files");

    // 打印参数
    std::cout << "输入文件：" << input_path << "\n";
    std::cout << "输出文件：" << output_path << "\n";
    std::cout << "详细日志：" << (verbose ? "开启" : "关闭") << "\n";
    std::cout << "循环次数：" << loop_cnt << "\n";
    std::cout << "附加文件列表：";
    for (auto& f : file_list) std::cout << f << " ";
    std::cout << "\n";

    return 0;
}
```

### 3. 编译运行
#### 编译命令(gcc/clang)
```bash
g++ main.cpp -o demo -std=c++17
```
要求 C++17 及以上标准。

#### 调用示例
```bash
# 查看帮助（自动生成）
./demo -h

# 完整传参
./demo data.txt -o res.txt --verbose --count 10 --files a.jpg b.png
```

## 二、工业级替代：CLI11（更推荐大型项目）
  https://github.com/CLIUtils/CLI11.git

### 优势
- 体积更小、编译更快、无依赖
- 支持子命令、分组、校验、浮点数、枚举
- 语法简洁，很多开源C++项目使用

### 极简示例
```cpp
// https://github.com/CLIUtils/CLI11.git
#include <CLI/CLI.hpp>
#include <iostream>

int main(int argc, char** argv) {
    CLI::App app{"CLI11 命令行解析示例"};

    std::string input;
    app.add_option("input", input, "输入文件")->required();

    std::string output = "out.txt";
    app.add_option("-o,--output", output, "输出文件");

    bool verbose = false;
    app.add_flag("--verbose", verbose, "详细日志");

    int count = 5;
    app.add_option("--count", count, "循环次数");

    // 解析
    CLI11_PARSE(app, argc, argv);

    std::cout << input << " " << output << " " << count << std::endl;
    return 0;
}
```
编译：`g++ main.cpp -o demo -std=c++11`，最低支持C++11。

## 三、原生 argc/argv 手动解析（无第三方库）
适合极小工具，不引入任何依赖：
```cpp
#include <iostream>
#include <string>

int main(int argc, char* argv[]) {
    std::string input, output = "out.txt";
    bool verbose = false;

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--verbose") {
            verbose = true;
        } else if (arg == "-o" || arg == "--output") {
            if (i + 1 < argc) output = argv[++i];
        } else {
            input = arg; // 位置参数
        }
    }

    if (input.empty()) {
        std::cerr << "用法：./demo 输入文件 [-o 输出文件] [--verbose]" << std::endl;
        return 1;
    }
    return 0;
}
```

## 四、argparse-cpp 常用API速查
1. `.required()`：参数必填
2. `.default_value(值)`：默认值
3. `.implicit_value(true)`：开关参数，传参=true，不传=false
4. `.scan<'i', int>()`：指定解析类型：`i`int、`f`float、`s`string
5. `.nargs(数量)`：多参数，`any`任意多个，`1`单个，`+`至少一个
6. `.help("说明文本")`：帮助文案
7. `parser.get<T>("参数名")`：读取参数

## 五、选型建议
1. 想要**完全复刻Python argparse写法**、快速上手：**argparse-cpp**（C++17+）
2. 大型工程、追求编译速度、兼容C++11、需要子命令：**CLI11**
3. 超小型工具、禁止引入第三方库：原生 `argc/argv` 手动解析

需要我给你一份**带子命令（类似git add/git commit）** 的完整 argparse-cpp 示例吗？

===============================================
# 2.FindArgparse.cmake 及其使用
你提供的 FindArgparse.cmake 是一个传统的自定义模块文件，用于在指定路径中寻找 argparse/argparse.hpp 头文件并设置包含路径变量。
为了让这个模块在现代 CMake 中达到工业级、更健壮的标准，它目前存在几个硬伤（例如：缺乏版本/成功状态断言、缺乏现代的 Target 导出、硬编码了相对路径 ../argparse 导致切换编译目录时易失效）。
以下是为你优化后的完整现代版 FindArgparse.cmake，以及如何在主工程中正确调用它的教程：
------------------------------
## 1. 优化后的 FindArgparse.cmake（推荐替换）
现代 CMake 提倡使用 Imported Target（导入目标），这样后续引用时只需一行 target_link_libraries，无需再手动管理 ${Argparse_INCLUDE_DIRS} 变量。
```cmake
# =============================================================================
# FindArgparse.cmake - 查找 argparse 库的 CMake 模块
# =============================================================================

# 1. 定义推荐的查找路径（保留并规范化你的自定义路径）
set(_argparse_include_path
        "${CMAKE_CURRENT_SOURCE_DIR}/../argparse" # 转换为绝对路径更安全
        "${CMAKE_CURRENT_SOURCE_DIR}/../../../argparse"
        ~/Library/Frameworks
        /Library/Frameworks
        /usr/local/include
        /usr/include
        /opt/local
        /opt
)

# 2. 执行路径查找
find_path(Argparse_INCLUDE_DIR argparse/argparse.hpp
    PATH_SUFFIXES include
    PATHS ${_argparse_include_path}
)

# 3. 引入标准包装模块，用于自动处理 REQUIRED 和 QUIET 参数，并输出成功提示
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Argparse
    REQUIRED_VARS Argparse_INCLUDE_DIR
)

# 4. 导出变量（向后兼容传统写法）
if(Argparse_FOUND)
    set(Argparse_INCLUDE_DIRS "${Argparse_INCLUDE_DIR}")
    
    # 5. 创建现代 CMake 目标 (Target) - 核心优化
    if(NOT TARGET argparse::argparse)
        add_library(argparse::argparse INTERFACE IMPORTED)
        set_target_properties(argparse::argparse PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${Argparse_INCLUDE_DIR}"
        )
    endif()
endif()
```

------------------------------
## 2. 在主 CMakeLists.txt 中调用的完整示例
既然你的 FindArgparse.cmake 放在 3rd/osmium/osmium_mytest/cmake/ 目录下，你需要在主配置文件中显式告诉 CMake 去哪里找这个模块。
假设你的主 3rd/osmium/osmium_mytest/CMakeLists.txt 结构如下：
```cmake
cmake_minimum_required(VERSION 3.12)
project(osmium_mytest CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. 关键：让 CMake 知道去哪里找你的 FindArgparse.cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# 2. 调用查找脚本（REQUIRED 表示找不到就报错拦截）
find_package(Argparse REQUIRED)

# 3. 添加你的业务可执行程序
add_executable(my_osmium_tool main.cpp)

# 4. 现代 CMake 链接方式（自动继承头文件包含路径，无需写 include_directories）
target_link_libraries(my_osmium_tool PRIVATE argparse::argparse)

```

