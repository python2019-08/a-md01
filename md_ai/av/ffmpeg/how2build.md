# 1. ffmpeg 源码如何在ubuntu上编译？使用vcpkg吗-gAI


在 Ubuntu 上编译 FFmpeg 源码，不建议首选 vcpkg。
虽然 vcpkg 可以跨平台管理库，但在 Linux 环境下，FFmpeg 依赖大量的系统底层驱动（如 ALSA, V4L2, VAAPI 等），使用 传统的 configure && make 结合 系统包管理器（APT） 是最稳妥、性能最高的方法。

以下是标准编译流程：
### 1. 安装基础编译环境
首先安装工具链和基础开发库：
```bash
sudo apt update
sudo apt install -y build-essential yasm cmake git pkg-config \
libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
libxcb-xfixes0-dev texinfo zlib1g-dev
```

### 2. 安装常用的第三方编解码库
FFmpeg 本身不包含专利编解码器（如 x264, x265），需要手动安装其开发版：
```bash
sudo apt install -y libx264-dev libx265-dev libnuma-dev libvpx-dev \
libfdk-aac-dev libmp3lame-dev libopus-dev
```

### 3. 下载源码并编译
```bash
# 克隆源码
git clone https://git.videolan.org
cd ffmpeg

# 配置编译选项 (这是最关键的一步)
./configure \
  --prefix="$HOME/ffmpeg_build" \
  --enable-gpl \
  --enable-nonfree \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libfdk-aac \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvpx \
  --enable-vaapi

# 多线程编译 (根据 CPU 核心数，如 -j8)
make -j$(nproc)

# 安装到指定目录
make install
```

### 4. 为什么不推荐在 Linux 上用 vcpkg 编译 FFmpeg？
* 硬连线依赖：FFmpeg 与 Linux 内核及硬件驱动（如 NVIDIA NVENC 或 Intel QSV）结合紧密。vcpkg 往往无法正确自动链接 Ubuntu 系统路径下的硬件加速库。
* 灵活性差：FFmpeg 有上百个编译开关（Flags）。使用官方编译方式，你可以通过 ./configure --help 极度精简或增强插件，而 vcpkg 的自定义程度较低。
* 路径冲突：vcpkg 编译出的二进制文件有时会与系统自带的 libavcodec 产生版本冲突，导致其他程序崩溃。

### 5. 什么时候该用 vcpkg？
如果你的项目是一个 跨平台 C++ 项目（需要在 Windows 和 Linux 上运行相同逻辑），且你希望将 FFmpeg 作为静态库集成到你的应用中，那么使用 vcpkg 的集成功能 会更方便管理依赖版本。

<!-- 你是打算修改 FFmpeg 源码来增加自定义滤镜，还是单纯想在自己的 C++ 代码里调用它的库？ -->

==================================================================

# 2. 单纯想在自己的 C++ 代码里调用FFmpeg的库？

既然你只是想在自己的 C++ 项目中调用 FFmpeg 的功能，那么你的核心需求是：方便地管理头文件路径和库链接。
针对 Ubuntu 环境，以下是三种按“推荐程度”排序的方案：

## 1. 最快方案：使用 APT 安装开发库（推荐）
如果你不需要极其特殊的编解码器（如实验性功能），直接用 Ubuntu 官方源提供的开发包。

* 安装：
```bash
sudo apt update
sudo apt install libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavdevice-dev libswresample-dev
```

* CMake 配置： 配合 PkgConfig 使用，这是 Linux 下处理 FFmpeg 的标准做法。
```cmake
find_package(PkgConfig REQUIRED)
pkg_check_modules(AVCODEC REQUIRED importlib libavcodec)
pkg_check_modules(AVFORMAT REQUIRED importlib libavformat)

add_executable(my_app main.cpp)
target_link_libraries(my_app ${AVCODEC_LIBRARIES} ${AVFORMAT_LIBRARIES})
```

## 2. 跨平台方案：使用 vcpkg
如果你希望这份代码在 Windows 和 Linux 上不改 CMakeLists 就能跑，vcpkg 就显现出优势了。

* 安装：

```bash
vcpkg install ffmpeg
```

优点： 自动处理所有依赖（如 x264, opus 等），并将库文件统一放在项目目录下，不污染系统。
缺点： 在 Linux 上第一次编译 vcpkg 版本的 FFmpeg 会非常慢（可能需要 20 分钟以上）。

## 3. 最强定制方案：源码手动编译（见上条回答）
只有当你需要开启某些特定功能（比如支持硬件加速 NVENC 或某些带专利的编码器）时才用此方案。编译后，你只需要在 CMake 中手动指定 include_directories 和 link_directories 指向你的安装目录即可。

## 💡 C++ 调用时的“头号大坑”
无论用哪种方案，FFmpeg 是用 C 语言编写的。在 C++ 中引入头文件时，必须包裹在 extern "C" 中，否则会报“找不到符号（Undefined Reference）”的链接错误：

```cpp
extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/avutil.h>
#include <libswscale/swscale.h>
}

int main() {
    // 现在的 FFmpeg 5.x/6.x 已不再需要 av_register_all()
    printf("FFmpeg Config: %s\n", avcodec_configuration());
    return 0;
}
```

==============================================
# 3.如果 打算修改 FFmpeg 源码来增加自定义滤镜呢

如果你打算通过修改源码来增加自定义滤镜（VF/AF Filter），情况就完全不同了。这种情况下，你不仅是用户，更是开发者。
以下是针对开发者（Developer）的专业路径建议：
## 1. 编译策略：必须使用「源码编译」
绝对不要用 vcpkg 或 APT。
因为你要修改源码并频繁重新编译验证，你需要一个完全受控的本地源码环境。建议参考我之前的源码编译步骤，但在 configure 时增加以下关键选项：
> --enable-debug：禁用优化并保留符号表，方便你用 GDB 调试。
> --disable-optimizations：加快编译速度，并确保单步调试时代码不乱跳。
> --disable-stripping：保留符号信息。

## 2. FFmpeg 滤镜开发的核心架构
FFmpeg 的滤镜系统称为 libavfilter。增加一个自定义滤镜（例如叫 my_filter）通常涉及三个动作：
* 创建文件：在 libavfilter/ 目录下创建 vf_my_filter.c。
* 编写结构体：你需要定义一个 AVFilter 结构体，其中最核心的函数指针是：
    query_formats：定义你的滤镜支持哪些像素格式（如 YUV420P, RGB24）。
    filter_frame：最核心逻辑，在这里处理每一帧图像的像素数据。
* 注册滤镜：
    在 libavfilter/allfilters.c 中添加你的滤镜声明（现代版本通常通过脚本自动扫描，但你可能需要手动在 libavfilter/Makefile 中添加一行 OBJS-$(CONFIG_MY_FILTER_FILTER) += vf_my_filter.o）。

## 3. 开发流程建议
> 1. 参考范例：找一个逻辑最简单的官方滤镜作为模板。
>     如果要处理色彩：参考 vf_negate.c（反色）。
>     如果要处理尺寸：参考 vf_crop.c（裁剪）。
>     如果要写文字/叠加：参考 vf_drawbox.c。
> 2.利用 libavutil：FFmpeg 提供了极其丰富的数学和内存工具（如 av_frame_get_buffer），尽量使用官方 API 以免内存泄漏。
> 3.增量编译：修改源码后，直接在源码根目录运行 make -j$(nproc)。由于你只改了 libavfilter，编译会非常快（通常几秒钟内完成）。

## 4. 调试方法
* 命令行测试：使用编译出来的 ./ffmpeg_g（带调试信息的二进制）：
```bash
./ffmpeg_g -i input.mp4 -vf "my_filter=param1=value1" output.mp4
```

* GDB 挂载：
```bash
gdb --args ./ffmpeg_g -i in.mp4 -vf "my_filter" out.mp4
```
在你的 vf_my_filter.c 的 filter_frame 函数处打断点。

## 5. 文档支持
FFmpeg 源码里自带的 doc/writing_filters.txt 是你的圣经，它详细记录了滤镜的生命周期和必须遵循的规范。
你是打算做一个简单的像素处理（如滤镜调色），还是涉及复杂的跨帧计算（如运动估算）？ 我可以为你提供一份简单的滤镜代码骨架。

======================================================

# 4.在 Android Studio 中集成 FFmpeg 的两种方式
 
自 2025 年 1 月起主流的 FFmpegKit 已宣布退休，目前推荐根据项目深度选择以下集成方案：

## 1. 快速方案：使用开源封装库（推荐初学者）
如果你只需执行简单的音视频指令（如剪辑、转码、水印），可以直接引用第三方维护的 Java/Kotlin 封装库。这些库已预编译好 .so 文件，省去了复杂的 NDK 配置。

### 推荐库：Mobile-FFmpeg (Taner Sener)
虽然 FFmpegKit 停更，但其前身 Mobile-FFmpeg 在许多项目中仍被广泛参考。

#### 集成步骤
在项目的 build.gradle 中添加依赖：
```gradle
implementation 'com.arthenica:mobile-ffmpeg-full:4.4'
```
> ⚠️ 请谨慎使用此类代码

#### 调用方式
通过 Java 直接执行 FFmpeg 命令：
```java
FFmpeg.execute("-i input.mp4 -ss 00:00:05 -t 00:00:10 -c copy output.mp4");
```
> ⚠️ 请谨慎使用此类代码

## 2. 深度方案：手动 NDK 编译集成（推荐进阶开发）
如果你需要深度定制（如通过 C++ 调用底层 API 实现高性能滤镜或直播流处理），则需要手动集成 FFmpeg 动态库 (.so) 和头文件。

### 准备工作
> 1. 下载/编译库文件：针对不同架构（arm64-v8a, armeabi-v7a 等）编译出的 .so 文件及相关的 include 文件夹。
> 2. 创建项目：在 Android Studio 中创建 Native C++ 项目模板。

### 配置步骤
1. **导入文件**：将 .so 文件放入 `src/main/jniLibs`，将头文件放入 `src/main/cpp/include`。
2. **配置 CMakeLists.txt**：告知 Android Studio 如何链接这些库：
```cmake
add_library(avcodec SHARED IMPORTED)
set_target_properties(avcodec PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/jniLibs/${ANDROID_ABI}/libavcodec.so)
# 对 avformat, avutil 等重复上述操作，最后链接到 native-lib
target_link_libraries(native-lib avcodec avformat avutil ...)
```
> ⚠️ 请谨慎使用此类代码
3. **JNI 调用**：在 `native-lib.cpp` 中引入 FFmpeg 头文件并编写 JNI 接口代码。

## 3. 方案对比
| 维度       | 开源封装库 (Java/Kotlin)                | 手动 NDK 集成 (C/C++)                  |
|------------|-----------------------------------------|----------------------------------------|
| 上手难度   | 极低，像写命令行一样简单                | 较高，需了解 JNI 和 CMake              |
| 性能       | 一般（存在进程间通信/命令解析开销）     | 极高（直接操作底层内存）               |
| 包体积     | 较大（通常包含所有编解码器）            | 可控（可按需裁剪编译）                 |
| 适用场景   | 简单的短视频处理、转码                  | 直播推流、专业级编辑器、实时滤镜       |
```

### 总结
1. 格式优化：将原文本的层级结构梳理为「标题+二级标题+三级标题」，代码块添加了正确的语法标识（gradle/java/cmake），并优化了表格排版使其更易读；
2. 细节增强：补充了文件路径标识（如 `src/main/jniLibs`）、添加了警告提示样式、统一了格式规范；
3. 可读性提升：修正了原文本的错别字（「步奏」→「步骤」），拆分了冗长段落，让整体结构更清晰。