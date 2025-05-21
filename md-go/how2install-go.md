# Linux下 Go语言环境安装
linux下使用Go语言开发时，需要安装Go语言环境。安装主要过程为下载Go语言安装包，解压到工作目录中，配置环境并检验是否安装成功。

# 1，下载Go语言安装包
安装包下载地址：
https://golang.google.cn/dl/.（Go语言英文网)
https://studygolang.com/dl. （Go语言中文网)

# 2，将二进制包解压至 /usr/local目录
// 解压安装包
tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz
12
# 3，配置环境变量
运行命令 vim /etc/profile，在文件中添加一下环境变量
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin 
 
保存profile文件并运行命令 source /etc/profile，重新加载环境配置

## 注： my setting：
export GOROOT=/home/gumaoqiang/opt/go/
export GOPATH=/home/gumaoqiang/stu/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# 4，运行命令检验是否安装成功
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