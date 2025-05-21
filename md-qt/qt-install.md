# 1.  Ubuntu24.04 qt installation
ref: 
 《【Ubuntu QT 环境搭建】超详细 Qt6.5 安装和使用教程教学丨小白专用丨零基础入门丨C++ QT开发环境丨IDE》
  https://www.bilibili.com/video/BV14JxYe8EGi/?vd_source=4212b105520112daf65694a1e5944e23

《2025 Ubuntu24.04 最新开发环境 VSCode + CMake Qt6.8.1 开发 初学者环境搭建 案例详解 音视频开发》
    https://www.bilibili.com/video/BV1nD6mY1Exj/?vd_source=4212b105520112daf65694a1e5944e23


## 1.1 安装 编译链工具
```sh
sudo apt-get install build-essential

sudo apt-get install automake autoconf autogen

sudo apt-get install cmake
 ```

## 1.2. 安装 vscode
 vscode官网下载地址：  https://code.visualstudio.com/

```sh
sudo dpkg -i  ./code_1.99.3-1744761595_amd64.deb
```

### 1.2.1 安装vscode的扩展插件
* (1) C/C++ 
* (2) cmake 
      cmake tools (?)

## 1.3 安装qt
(1) 下载qt安装器
https://mirrors.tuna.tsinghua.edu.cn/qt/archive/online_installers/  路径下，选择4.9版本的qt安装器：

https://mirrors.tuna.tsinghua.edu.cn/qt/archive/online_installers/4.9/qt-online-installer-linux-x64-4.9.0.run

(2) 安装qt的依赖
```sh
sudo apt-get install libxcb-cursor0 libxcb-cursor-dev 
sudo apt-get install libgl1-mesa-dev 
 ```

(3)安装qt
```sh
chmod u+x  qt-online-installer-linux-x64-4.9.0.run 
# ./qt-online-installer-linux-x64-4.9.0.run  --mirror https://mirrors.ustc.edu.cn/qtproject 
./qt-online-installer-linux-x64-4.9.0.run --mirror https://mirrors.tuna.tsinghua.edu.cn/qt/
 ```

## 1.4 安装视频相关开发包（可选）
### 1.4.1 安装视频采集开发包 libv4l-dev 

```sh
sudo apt-get install libv4l-dev 
 ```

### 1.4.2  libx264-dev  

```sh
sudo apt-get install libx264-dev 
 ```

### 1.4.3  libalsa-ocaml-dev  

```sh
sudo apt-get install  libalsa-ocaml-dev
 ``` 

### 1.4.4 ubuntu自带的 摄像头软件Cheese
在app center中安装 Cheese,或者
```sh
sudo apt-get install cheese
```

### 1.4.5 二进制hex工具 bless-unofficial
bless：二进制查看工具，类似win下的UltraEdit

在app center中安装 bless-unofficial,或者
```sh
sudo apt-get install bless
```