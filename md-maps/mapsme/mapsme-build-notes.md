# 1. building android on ubuntu

## 1.1 下载android-ndk-r27c-linux.zip 
(1) 到官网 https://developer.android.google.cn/ndk/downloads/?hl=zh-cn下载 android-ndk-r27c-linux.zip ;
(2) 把 android-ndk-r27c-linux.zip 解压到 ~/programs/android-ndk-r27c-linux/
(3) 在 ~/.bashrc 末尾添加环境变量：
 export ANDROID_NDK=/home/abel/programs/android-ndk-r27c-linux/

## 1.1 run configure.sh
```sh
cd /home/abel/zdev/cpp/mapsme-organicmaps2024-1112/
./configure.sh
```

 ## 1.2 cmake配置阶段命令
 ```sh
  cmake -S. -Bbuild  -D CMAKE_CXX_FLAGS="-fexceptions -frtti"  -D CMAKE_C_FLAGS="-fno-function-sections -fno-data-sections -Wno-extern-c-compat" -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DOS=$osName  -DSKIP_TESTS=ON  -DSKIP_TOOLS=ON -DUSE_PCH=$pchFlag -DNJOBS=$njobs -DENABLE_VULKAN_DIAGNOSTICS=$enableVulkanDiagnostics -DENABLE_TRACE=$enableTrace -DCMAKE_SYSTEM_NAME="Android" --trace  > dd.txt 2>&1
 ```

## 1.3 cmake构建阶段命令
```sh
cmake --build build
```


# 2.附：ubuntu内使用cmake(clang)交叉编译android so库设置脚本：

geniusNMRobot专家 已于 2024-12-24 16:07:52 修改
原文链接：https://blog.csdn.net/geniusChinaHN/article/details/144694178
 
【Cmake】利用NDK进行Android的交叉编译_cmake 使用ndk-CSDN博客

其实交叉编译的步骤，和一般情况下CMake的编译的步骤很类似：

两者之间的不同完全在于：编译工具链的不同。而这个不同，体现在**cmake ..的时候需要添加-D的编译变量和参数**。
 

下表介绍在将CMake和NDK搭配使用时，可以配置的部分变量：

编译参数          | 说明
-----------------|---
ANDROID_PLATFORM | 指定目标Android平台的名称，如android-18指定Android 4.3(API级别18)
ANDROID_STL      | 指定CMake应使用的STL，默认c++_static
ANDROID_PIE      | 指定是否使用位置独立的可执行文件(PIE)。Android动态链接器在Android 4.1(API级别16)及更高级别上支持PIE，可设置为On、OFF
ANDROID_CPP_FEATURES | 指定CMake编译原生库时需使用的特定C++功能，可设置为rtti(运行时类型信息)、exceptions(C++异常)
ANDROID_ALLOW_UNDEFINED_SYMBOLS | 指定CMake在构建原生库时，如果遇到未定义的引用，是否会引发未定义的符号错误。默认FALSE
ANDROID_ARM_NEON | 指定CMake是否应构建支持NEON的原生库。API级别为23或更高级别时，默认值为true，否则为false
ANDROID_DISABLE_FORMAT_STRING_CHECKS | 指定是否在编译源代码时保护格式字符串。启用保护后，如果在printf样式函数中使用非常量格式字符串，则编译器会引发错误。默认false


下表介绍在Android进行交叉编译时，可以使用的具体构建参数，将有助于调试CMake构建问题：

编译参数     | 说明
------------|---
ANDROID_ABI | 目标ABI，可设置为armeabi-v7a、arm64-v8a、x86、x86_64，默认armeabi
ANDROID_NDK | 安装的NDK根目录的绝对路径
CMAKE_TOOLCHAIN_FILE | 进行交叉编译的android.toolchain.cmake文件的路径，默认在$NDK/build/cmake/目录
ANDROID_TOOLCHAIN | CMake使用的编译器工具链，默认为clang
CMAKE_BUILD_TYPE | 配置构建类型，可设置为Release、Debug
ANDROID_NATIVE_API_LEVEL | CMake进行编译的Android API级别
CMAKE_LIBRARY_OUTPUT_DIRECTORY | 构建LIBRARY目标文件之后，CMake存放这些文件的位置


看着编译的变量和参数都不少，那如何来抉择呢？

其实，一般情况下，只需要配置**ANDROID_ABI、ANDROID_NDK、CMAKE_TOOLCHAIN_FILE、ANDROID_PLATFORM**四个变量即可。

ANDROID_ABI是CPU架构，ANDROID_NDK是NDK的根目录，CMAKE_TOOLCHAIN_FILE是工具链文件，ANDROID_PLATFORM是支持的最低Android平台。 

比如：这是一个编译的脚本------特别注意的是android studio自动生成的cmakelists.txt不用特别管

这个是我们自己编写的sh脚本-----把一下文件保存为 install.sh,然后执行就好了

```sh 
#编写编译脚本：
 
#/bin/bash
 
export ANDROID_NDK=/opt/env/android-ndk-r14b
 
rm -r build
mkdir build && cd build 
 
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="armeabi-v7a" \
    -DANDROID_NDK=$ANDROID_NDK \
    -DANDROID_PLATFORM=android-22 \
 
 
make && make install
 
cd ..
```

#这个是我自己改的脚本：注意了----这个脚本已经全部设置好了
 
```sh  
#/bin/bash
 
export ANDROID_NDK=/home/actorsun/Android/Sdk/ndk/28.0.12674087
 
rm -r build
mkdir build && cd build 
 
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI="armeabi-v7a" \
    -DANDROID_NDK=$ANDROID_NDK \
    -DANDROID_PLATFORM=android-34 \
 
 
make && make install
 
cd ..
```
啊，，，，我居然编译成功了：：：： 
                        
