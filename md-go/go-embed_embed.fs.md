# go embed包 初学习 

https://blog.csdn.net/qq_41407687/article/details/132054026?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-132054026-blog-132814241.235^v43^pc_blog_bottom_relevance_base4&spm=1001.2101.3001.4242.1&utm_relevant_index=2 


 
#### go embed包 初学习 

## 1. embed包 诞生的历史

### 1.1 出现的问题

很多从其他语言转过来 Go 语言的同学会问到，或是踩到一个坑。就是以为 Go语言所打包的二进制文件中会包含[配置文件]的联同编译和打包。

结果往往一把二进制文件挪来挪去，就无法把应用程序运行起来了。因为无法读取到静态文件的资源。

无法将静态资源编译打包进二进制文件的话，通常会有两种解决方法：

``` 
第一种是识别这类静态资源，是否需要跟着程序走。
第二种就是考虑将其打包进二进制文件中
```

第二种情况的话，Go以前是不支持的，大家就会去借助各种花式的开源库，例如：[go-bindata/go-bindata](https://github.com/go-bindata/go-bindata)来实现，

第三方包的数量繁多，对于开发选择增加了开发者的心智负担，需要go官方处理这个问题

#### 1.1.1 embed包 诞生

Go编译的程序非常适合部署，如果没有通过CGO引用其它的库的话，我们一般编译出来的可执行二进制文件都是单个的文件，非常适合复制和部署。在实际使用中，除了二进制文件，可能还需要一些配置文件，或者静态文件，比如[html模板]、静态的图片、CSS、[javascript]等文件，如何这些文件也能打进到二进制文件中，那就太美妙，我们只需复制、按照单个的可执行文件即可。

一些开源的项目很久以前就开始做这方面的工作，比如[gobuffalo/packr](https://github.com/gobuffalo/packr)、[markbates/pkger](https://github.com/markbates/pkger)、 [rakyll/statik](https://github.com/rakyll/statik)、[knadh/stuffbin](https://github.com/knadh/stuffbin)等等，但是不管怎么说这些都是第三方提供的功能，如果Go官方能内建支持就好了。2019末一个提案被提出[issue#35950](https://github.com/golang/go/issues/35950),期望Go官方编译器支持嵌入静态文件。后来Russ
Cox专门写了一个设计文档 [Go command support for embedded static assets](https://go.googlesource.com/proposal/+/master/design/draft-embed.md)
并最终实现了它。

## 2.embed包 使用

hello.txt 内容

``` 
hello word gopher!! 
```

main.go文件

```go
package main

import (
    _ "embed"
    "fmt"
)

//go:embed hello.txt
var info string

func main() {
    fmt.Println(info)
} 
```

打印内容

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main.go
hello word gopher!! 
```

通过 //go:embed 指令 嵌套 hello.txt 文件内容，把hello.txt里面的内容
嵌套在 下面声明的 info 字符串变量中，打印 info 变量内为hello.txt 的内容
hello word gopher!!

Go 能够允许嵌入的变量类型有如下三种：

 
 | 变量类型  | 说明 
-|-------- -|----
 | []byte   | 用于存储二进制形式的数据，比如图片、富媒体等
 | string   | 用于存储 UTF-8 编码的字符串。
 | embed.FS | 用于嵌入多个文件和目录的结构。
 

#####  embed 嵌入变量  []byte 字节切片

```go
package main

import (
    _ "embed"
    "fmt"
)

//go:embed hello.txt
var info []byte

func main() {

    //输出的字节内容
    fmt.Println(info)
    //[]byte 转成string方式输出
    fmt.Println(string(info))

} 
```

输出打印

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main.go
[104 101 108 108 111 32 119 111 114 100 32 103 111 112 104 101 114 33 33]
hello word gopher!! 
```

#### 使用 embed.FS (用于嵌入多个文件和目录的结构)

main1,go

```go
package main

import (
    "embed"
    "fmt"
)

//go:embed hello.txt hello2.txt public static/*
var f embed.FS

func main() {

    data, error := f.ReadFile("hello.txt")

    fmt.Println("\nReadFile hello.txt\n", string(data), error)

    data1, error1 := f.ReadFile("static/1.txt")

    fmt.Println("\nReadFile static/1.txt\n", string(data1), error1)

    dir, error := f.ReadDir("static")
    fmt.Println("\nReadDir static\n", dir, error)

    data2, error2 := f.Open("static")
    fmt.Println("\nOpen static\n", data2, error2)

} 
```

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main1.go

ReadFile hello.txt        
 hello word gopher!! <nil>

ReadFile static/1.txt      
 this is statis 1.txt <nil>

ReadDir static
 [0x96aba8 0x96abd8] <nil>

Open static
 &{0x96ab48 [{static/1.html  [28 79 59 189 103 3 227 235 101 4 11 55 102 144 70 2
19]} {static/1.txt this is statis 1.txt [232 249 104 174 107 128 13 4 161 54 167 
245 137 117 177 185]}] 0} <nil> 
```

1.//go:embed 指令 支持多行 或者 空格间隔 多嵌入的方式\
2. //go:embed 可以直接写 目录名 嵌套所有目录的内容不包括点符号 .和下划线 \_ 目录名嵌套同样不支持空目录嵌套，可以使用目录/\*的方式贪婪嵌套所有文件推荐使用 目录/\* 贪婪的模式进行匹配嵌套

3.go emebd 禁止嵌入如 .git.svn 这些目录，官方认为这些目录不属于 package
的一部分，如果嵌入则会在编译时报错。可参见 Go源码src/cmd/go/internal/load/pkg.go#L2091-2107

```go
// isBadEmbedName reports whether name is the base name of a file that
// can't or won't be included in modules and therefore shouldn't be treated
// as existing for embedding.
func isBadEmbedName(name string) bool {
    if err := module.CheckFilePath(name); err != nil {
        return true
    }
    switch name {
    // Empty string should be impossible but make it bad.
    case "":
        return true
    // Version control directories won't be present in module.
    case ".bzr", ".hg", ".git", ".svn":
        return true
    }
    return false
} 
```

embed.FS 也能调各类文件系统的接口，其实本质是 embed.FS 实现了 io/fs接口。

只读属性

在 embed 所提供的 FS 中，我们可以发现其都是打开和只读方法：

```go
    type FS 
        func (f FS) Open(name string) (fs.File, error) 
        func (f FS) ReadDir(name string) ([]fs.DirEntry, error) 
        func (f FS) ReadFile(name string) ([]byte, error) 
```

只读不写的设计说明在 embed.FS多个goroutine中使用它是安全的
同时也安全地将类型FS的值分配给彼此

## 3. 注意正确使用

1.  //go:embed 嵌套的内容路径必须是
    当前路径或当前子目录，嵌套的文件目录必须存在，不支持嵌套上级目录的文件\
    (1) 文件不存在情况

```go
package main

import (
    _ "embed"
    "fmt"
)

//go:embed hello1.txt
var info string

func main() {
    fmt.Println(info) 
```

打印报错

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main.go
main.go:8:12: pattern hello1.txt: no matching files found
```

\(2\) 嵌套上级目录文件

```go
package main

import (
    _ "embed"
    "fmt"
)

//go:embed ../embed-package-learn/hello.txt
var info string

func main() {
    fmt.Println(info)
} 
```

打印报错

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main.go
main.go:8:12: pattern ../embed-package-learn/hello.txt: invalid pattern syntax 
```

2.  //go:embed 必选在包级别变量声明，不能在函数中声明 //go:embed

```go
package main

import (
    _ "embed"
    "fmt"
)

func main() {
    //go:embed hello.txt
    var info string
    fmt.Println(info)
} 
```

打印报错

```sh
PS D:\coder\go-coder\package-learn\embed-package-learn> go run .\main.go
# command-line-arguments
.\main.go:9:4: go:embed cannot apply to var inside func
```

##  补充更多

更多详细内容还是看官网练习比较好
[go官网embed链接](https://pkg.go.dev/embed#example-package){rel="nofollow"}

连接教程还都是 英文的，对于咱们英语小白来说
粘贴出来到翻译网站翻译或截图翻译，阅读效率还真是低下，我用的是[谷歌浏览器]{.words-blog
.hl-git-1 tit="谷歌浏览器"
pretit="谷歌浏览器"}，谷歌浏览器自带的翻译插件支持
整个页面自动翻译，现在被墙了，其他浏览器翻译插件 要不
不好用，要不还要收费，花钱是不可能的，推荐一个腾讯浏览器翻译插件，自己测试阅读英文网站，嘎嘎好使\
腾讯翻译浏览器插件下载地址
[https://www.chajianxw.com/product-tool/44019.html](https://www.chajianxw.com/product-tool/44019.html){rel="nofollow"}

##  引用的链接

[转载自：简书-大地缸 Go1 16新特性一文快速上手 Go
Embed](https://www.jianshu.com/p/1d35bdf66199){rel="nofollow"}\
[转载自：简书-大地缸 Go Embed
简明教程](https://www.jianshu.com/p/a923060d7b98/){rel="nofollow"}\
[转载自：Light Cube - 道理我都懂，但 go embed
究竟该怎么用？](https://github.red/go-embed/){rel="nofollow"}
 