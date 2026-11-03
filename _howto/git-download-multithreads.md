# 方案1：aria2c（推荐，支持断点续传，GitHub下载最稳）
安装
```bash
sudo apt update
sudo apt install aria2
```
下载命令（AWSIM-Demo.zip）
```bash
aria2c -c -x8 -s8 --file-allocation=none \
https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip
```
参数说明：
- `-c`：断点续传（断网之后可以接着下，非常重要）
- `-x 8`：每个服务器最大连接数
- `-s 8`：文件分成8段并行下载，github不要开16，容易被限流
- `-k 10M` 分块大小，大文件更友好
- `--file-allocation=none`：避免预分配大文件卡住

如果你想指定保存目录：
```bash
mkdir -p  ~/awsim_download

aria2c -c -x8  -s8         -d ~/awsim_download --file-allocation=none \
https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip 

aria2c -c -x 8 -s 8 -k 10M -d ~/awsim_download --file-allocation=none \
https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip 

aria2c -c -x 4 -s 4 -k 10M                     --file-allocation=none \
https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.0/Shinjuku.unitypackage
```
  

# 方案2：axel（轻量多线程）
安装
```bash
sudo apt install axel
```
下载：
```bash
axel -n 8 [https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip](https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip)
```
- `-n 8` 8线程

# ⚠️ GitHub release 常见坑（重点）
github的release会302跳转，**aria2c原生可以自动跟随跳转，wget单线程经常限速**；
如果速度很慢：
1. 可以搭配国内GitHub加速镜像；
2. 线程不要开到16以上，github会直接拒绝连接；
3. 不要用普通wget，wget是单线程：
```bash
# wget（不推荐，单线程慢，仅做对比）
wget -c [https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip](https://github.com/autowarefoundation/AWSIM/releases/download/v2.0.1/AWSIM-Demo.zip)
```

# 下载完解压
```bash
unzip AWSIM-Demo.zip
```

# 补充小提示（AWSIM）
AWSIM v2.0.1 Linux包解压后，直接给执行权限运行，和Autoware Universe配合非常适合调试mapless_autoware。

需要我给你一个github加速版本的aria2命令吗？