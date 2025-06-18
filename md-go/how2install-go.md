# 1.Linux下 Go语言环境安装
linux下使用Go语言开发时，需要安装Go语言环境。安装主要过程为下载Go语言安装包，解压到工作目录中，配置环境并检验是否安装成功。

## 1.1，下载Go语言安装包
安装包下载地址：
https://golang.google.cn/dl/.（Go语言英文网)
https://studygolang.com/dl. （Go语言中文网)

## 1.2，将二进制包解压至 /usr/local目录
// 解压安装包
tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz
12
## 1.3，配置环境变量
运行命令 vim /etc/profile，在文件中添加一下环境变量
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin 
 
保存profile文件并运行命令 source /etc/profile，重新加载环境配置

### 注： my setting：
export GOROOT=/home/abner/opt/go/
export GOPATH=/home/abner/stu/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
## 1.4，运行命令检验是否安装成功
// 方法1：
go version

// 方法2：或编辑test.go 文件，进行检验
```go
package main

import "fmt"

func main() {
   fmt.Println("Hello, World!")
}
```

```sh
go run test.go
```

========================================================
# 2.Linux系统：Ubuntu上安装postman的详细教程

前端白袍  于 2024-10-12 16:53:37                         
原文链接：https://blog.csdn.net/qq_44776454/article/details/142881681


Ubuntu系统版本：23.04

以下是在Ubuntu上安装Postman的详细步骤：

(1)打开终端，使用以下命令下载Postman的安装包：
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
 
(2)解压下载的安装包：
tar -xvf postman.tar.gz
 
(3)移动解压后的文件夹到 /opt 目录下：
sudo mv Postman /opt
 
(4)创建一个符号链接以便可以直接在终端中运行Postman：
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
 
(5)创建一个桌面启动器图标：
sudo nano /usr/share/applications/postman.desktop
 
(6)在打开的文件中，复制并粘贴以下内容：
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
 
(7)按 Ctrl + X 保存并退出nano编辑器。
(8)现在，您可以在应用程序菜单中找到并打开Postman，或者在终端中运行 postman 命令启动Postman。
以此完成以上步骤，您就成功在Ubuntu上安装了Postman。 



[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/home/abner/programs/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
 