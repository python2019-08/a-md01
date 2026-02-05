# 1.bazel编译C++程序的步骤

## 1.1 编译C++程序的步骤
我们使用bazel编译C++程序通常需要以下几个步骤：
> 1. 安装bazel
> 2. 创建一个工作空间（workspace），并在工作空间下编写C++代码和BUILD文件
> 3. 使用bazel编译

下面我们详细说明。

### 步骤1：安装bazel
可以参考官方文档：  https://bazel.build/install
 
### 步骤2：创建工作空间
假设我们有一个简单的C++项目，目录结构如下：
```
bazel01/
    MODULE.bazel
    MODULE.bazel.lock
    hello-world
        BUILD
        hello-world.cc
```    
 

其中，WORKSPACE文件可以是空的，或者包含外部依赖的配置。对于简单的项目，我们可以先使用空文件。

* hello-world.cc的内容：
```cpp
#include <iostream>

int main() {
  std::cout << "Hello, world!" << std::endl;
  return 0;
}

```

* **BUILD文件的内容**：
```
load("@rules_cc//cc:defs.bzl", "cc_binary")

cc_binary(
    name = "hello_bin",  # 建议改名，不要和目录 hello-world 重名，避免 Bazel 混淆
    srcs = ["hello-world.cc"],
)
```

* **MODULE.bazel**：
```
bazel_dep(name = "rules_cc", version = "0.0.17")
```

### 步骤3：编译
在my_project目录下，运行：
```sh
bazel build //hello-world:hello_bin
```

### 步骤4：运行
编译完成后，可执行文件位于bazel-bin目录下，可以通过以下命令运行：
```sh
$ ./bazel-bin/hello_bin
Hello, world!
```

### 步骤5：编译库并使用
如果需要编译一个库，并使用这个库，可以看下面的例子：

假设我们有**一个库文件**：
```
bazel01
├── lib
│   ├── BUILD        <-- 检查这里有没有 load 和 cc_library
│   ├── hello-time.cc
│   └── hello-time.h
├── hello-world
│   ├── BUILD        <-- 检查这里有没有 load 和 cc_binary
│   └── hello-world.cc
├── MODULE.bazel
└── MODULE.bazel.lock
```

* **lib/hello-time.h**:
```cpp
#ifndef LIB_HELLO_TIME_H_
#define LIB_HELLO_TIME_H_

void print_localtime();

#endif
```

* **lib/hello-time.cc**:
```cpp
#include "lib/hello-time.h"
#include <iostream>
#include <ctime>

void print_localtime() {
  std::time_t result = std::time(nullptr);
  std::cout << std::asctime(std::localtime(&result));
}
```

* **lib/BUILD**:
```
load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "hello-time",  # 确保这里的名字是 hello-time
    srcs = ["hello-time.cc"],
    hdrs = ["hello-time.h"],
    visibility = ["//visibility:public"], # 必须加上这句，否则 hello-world 没权调用它
)
```

* **hello-world/BUILD**:
```
load("@rules_cc//cc:defs.bzl", "cc_binary")

cc_binary(
    name = "hello_bin",
    srcs = ["hello-world.cc"],
    deps = [
        "//lib:hello-time", # 引用 lib 目录下的 hello-time 目标
    ],
)
```
* **hello-world.cc**:
```cpp
#include "lib/hello-time.h"
#include <iostream>

int main() {
  std::cout << "Hello, world!" << std::endl;
  print_localtime();
  return 0;
}
```
然后，同样使用 bazel build //hello-world:hello_bin  进行编译。

* 注意：在BUILD文件中，我们使用cc_library来定义库，cc_binary来定义可执行文件。deps中指定依赖的库。
如果项目有多个文件，可以在srcs中列出，或者使用glob函数，例如：srcs = glob(["*.cc"])。
以上是简单的bazel编译C++程序的步骤。更复杂的项目可能需要更多的配置，例如引入外部依赖、使用不同的编译选项等。

===================================================

# 2.Bazel 编译 C++ 程序完整指南

# Bazel 编译 C++ 程序完整指南

Bazel 是 Google 开源的构建工具，以其高性能、可伸缩性和支持多语言构建而著称。以下是详细的使用指南。

## 🏗️ Bazel 项目结构

### 1. 基本项目结构
```
my_project/
├── WORKSPACE              # 工作空间根目录标记
├── BUILD                  # 根目录构建文件
├── .bazelrc              # Bazel 配置文件
├── .bazelversion         # 指定 Bazel 版本
├── src/
│   ├── main/
│   │   ├── BUILD
│   │   ├── hello.cc
│   │   └── lib/
│   │       ├── BUILD
│   │       ├── math.cc
│   │       └── math.h
│   └── test/
│       ├── BUILD
│       └── hello_test.cc
└── third_party/          # 第三方依赖
```

## 📁 核心配置文件

### 1. WORKSPACE 文件
工作空间根配置文件，定义外部依赖：

```python
# 指定 Bazel 版本约束
workspace(name = "my_project")

# 加载 Bazel 内置规则
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# 下载外部依赖（示例：Google Test）
http_archive(
    name = "com_google_googletest",
    urls = ["https://github.com/google/googletest/archive/...zip"],
    strip_prefix = "googletest-...",
)

# 加载外部依赖
load("@com_google_googletest//:deps.bzl", "gtest_deps")
gtest_deps()
```

### 2. .bazelrc 配置文件
```python
# 全局配置
build --cxxopt='-std=c++17'
build --copt='-O2'
build --compilation_mode=opt
build --experimental_repo_remote_exec

# 不同平台的编译选项
build:linux --copt='-D_LINUX'
build:windows --copt='-D_WINDOWS'
build:macos --copt='-D_MACOS'

# 测试配置
test --test_output=all
```

## 🏗️ BUILD 文件编写

### 1. 最简单的 C++ 程序
```python
# 可执行文件
cc_binary(
    name = "hello_world",      # 目标名称
    srcs = ["hello.cc"],       # 源文件
    copts = ["-std=c++17"],    # 编译选项
    deps = [                   # 依赖
        "//src/lib:math",      # 内部依赖
        "@com_google_absl//absl/strings",  # 外部依赖
    ],
)
```

### 2. 静态库
```python
cc_library(
    name = "math",
    srcs = ["math.cc"],
    hdrs = ["math.h"],         # 头文件
    visibility = ["//visibility:public"],  # 可见性
    deps = [],
)
```

### 3. 动态库
```python
cc_binary(
    name = "libmath.so",
    srcs = ["math.cc"],
    linkshared = True,         # 生成动态库
    linkstatic = False,
)
```

## 🔧 编译命令详解

### 1. 基本构建命令
```bash
# 构建指定目标
bazel build //src/main:hello_world

# 构建特定配置
bazel build //src/main:hello_world --config=debug
bazel build //src/main:hello_world --config=optimized

# 并行构建（使用8个线程）
bazel build //src/main:hello_world --jobs=8
```

### 2. 运行和测试
```bash
# 直接运行（构建+执行）
bazel run //src/main:hello_world

# 运行测试
bazel test //src/test:hello_test

# 查看详细的测试输出
bazel test //src/test:hello_test --test_output=all
```

### 3. 清理和查询
```bash
# 清理构建产物
bazel clean

# 清理但保留外部依赖
bazel clean --expunge

# 查询依赖关系
bazel query "deps(//src/main:hello_world)"
bazel query "kind(cc_library, //...)"
```

## 📦 依赖管理

### 1. 外部依赖（WORKSPACE）
```python
# 1. 从 GitHub 下载
http_archive(
    name = "com_google_absl",
    urls = ["https://github.com/abseil/abseil-cpp/archive/...tar.gz"],
    strip_prefix = "abseil-cpp-...",
)

# 2. 从 Git 仓库获取
git_repository(
    name = "com_github_nlohmann_json",
    remote = "https://github.com/nlohmann/json",
    commit = "v3.10.5",  # 特定版本
)

# 3. 本地依赖
local_repository(
    name = "my_lib",
    path = "/path/to/local/lib",
)
```

### 2. 多平台支持
```python
# 条件编译
cc_library(
    name = "platform_utils",
    srcs = select({
        "@platforms//os:linux": ["linux_utils.cc"],
        "@platforms//os:windows": ["windows_utils.cc"],
        "@platforms//os:macos": ["macos_utils.cc"],
    }),
    hdrs = ["platform_utils.h"],
)
```

## 🧪 测试配置

### 1. Google Test 集成
```python
# BUILD 文件
cc_test(
    name = "math_test",
    srcs = ["math_test.cc"],
    deps = [
        ":math",  # 被测试的库
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
    size = "small",  # 测试规模: small, medium, large, enormous
    timeout = "short",  # 超时时间
)
```

### 2. 测试命令
```bash
# 运行所有测试
bazel test //...

# 运行特定测试
bazel test //src/test:math_test

# 运行失败的测试
bazel test //... --test_strategy=exclusive

# 测试覆盖率
bazel coverage //src/test:math_test
```

## 🎯 高级配置

### 1. 自定义工具链
```python
# 在 WORKSPACE 中
register_toolchains("//toolchains:my_cpp_toolchain")

# toolchains/BUILD
toolchain(
    name = "my_cpp_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    toolchain = ":my_toolchain_impl",
    exec_compatible_with = ["@platforms//cpu:x86_64"],
    target_compatible_with = ["@platforms//os:linux"],
)
```

### 2. 配置文件组
```python
# 在 .bazelrc 中定义配置
build:debug --compilation_mode=dbg
build:debug --copt=-g
build:debug --strip=never

build:release --compilation_mode=opt
build:release --copt=-O3
build:release --strip=always

# 使用配置
bazel build //:target --config=debug
```

## 🔄 实际示例

### 完整项目示例
```
example_project/
├── WORKSPACE
├── BUILD
├── src/
│   ├── main/
│   │   ├── BUILD
│   │   └── main.cc
│   ├── lib/
│   │   ├── BUILD
│   │   ├── calculator.cc
│   │   └── calculator.h
│   └── test/
│       ├── BUILD
│       └── calculator_test.cc
└── third_party/
    └── BUILD
```

**src/main/BUILD:**
```python
cc_binary(
    name = "calculator_app",
    srcs = ["main.cc"],
    deps = [
        "//src/lib:calculator",
        "@com_google_absl//absl/strings",
    ],
)
```

**src/lib/BUILD:**
```python
cc_library(
    name = "calculator",
    srcs = ["calculator.cc"],
    hdrs = ["calculator.h"],
    visibility = ["//visibility:public"],
)
```

**src/test/BUILD:**
```python
cc_test(
    name = "calculator_test",
    srcs = ["calculator_test.cc"],
    deps = [
        "//src/lib:calculator",
        "@com_google_googletest//:gtest_main",
    ],
)
```

## 📊 常用命令速查表

| 命令 | 功能 | 常用选项 |
|------|------|----------|
| `bazel build` | 构建目标 | `--config`, `--jobs`, `--compilation_mode` |
| `bazel run` | 构建并运行 | `--run_under` |
| `bazel test` | 运行测试 | `--test_output`, `--cache_test_results` |
| `bazel query` | 查询构建图 | `kind()`, `deps()`, `rdeps()` |
| `bazel clean` | 清理构建 | `--expunge` |
| `bazel info` | 显示信息 | 各种子命令 |
| `bazel fetch` | 下载依赖 | `--experimental_repo_remote_exec` |

## 🐛 常见问题解决

1. **依赖下载失败**：
   ```bash
   # 设置代理
   export https_proxy=http://127.0.0.1:7890
   export http_proxy=http://127.0.0.1:7890
   
   # 或使用镜像
   build --repository_cache=~/.bazel_cache
   ```

2. **编译速度慢**：
   ```bash
   # 使用远程缓存
   build --remote_cache=http://your-cache-server
   
   # 增加并行度
   build --jobs=16
   
   # 使用 RAM 磁盘
   build --output_user_root=/dev/shm/bazel
   ```

3. **内存不足**：
   ```bash
   # 限制内存使用
   build --local_ram_resources=4096
   build --local_cpu_resources=4
   ```

4. **查看详细日志**：
   ```bash
   bazel build //... --subcommands  # 显示每个子命令
   bazel build //... --explain=log.txt  # 解释构建决策
   bazel build //... --verbose_failures  # 详细错误信息
   ```

## 🎯 Bazel 与 CMake 对比

| 特性 | Bazel | CMake |
|------|-------|-------|
| 构建速度 | ⚡️ 极快（增量构建优秀） | 中等 |
| 依赖管理 | ✅ 内置，支持版本锁定 | ❌ 需要外部工具 |
| 多语言支持 | ✅ 优秀 | ✅ 良好 |
| 学习曲线 | 📈 较陡峭 | 📈 中等 |
| 跨平台 | ✅ 优秀 | ✅ 优秀 |
| 远程缓存 | ✅ 原生支持 | ❌ 需要外部工具 |

希望这份指南能帮助你掌握 Bazel 编译 C++ 程序！