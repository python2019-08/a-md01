Go语言入门教程，Golang入门教程（非常详细）

<http://c.biancheng.net/golang/>

<https://www.kancloud.cn/imdszxs/golang/1535582>

<https://www.xinbaoku.com/archive/2DHvuPFr.html>

# 目录

[目录 [1](#目录)](\l)

[13.网络编程 [6](#网络编程)](\l)

[13.1 Go语言Socket编程详解 [7](#go语言socket编程详解)](\l)

[13.1.1什么是 Socket [7](#什么是-socket)](\l)

[13.1.2Socket 如何通信 [8](#socket-如何通信)](\l)

[13.1.3网络应用的设计模式 [9](#网络应用的设计模式)](\l)

[13.1.4TCP Socket [10](#tcp-socket)](\l)

[13.1.5TCP server [11](#tcp-server)](\l)

[13.1.6TCP client [13](#tcp-client)](\l)

[13.1.7控制 TCP 连接 [15](#控制-tcp-连接)](\l)

[13.1.8UDP Socket [15](#udp-socket)](\l)

[13.1.9总结 [17](#总结)](\l)

[13.2Go语言Dial()函数：建立网络连接
[18](#go语言dial函数建立网络连接)](\l)

[13.3Go语言ICMP协议：向主机发送消息
[22](#go语言icmp协议向主机发送消息)](\l)

[13.3.1ICMP 协议介绍 [22](#icmp-协议介绍)](\l)

[13.3.2ICMP消息类型 [22](#icmp消息类型)](\l)

[13.3.3ICMP 的报文格式 [23](#icmp-的报文格式)](\l)

[13.3.4常见的 ICMP 报文 [24](#常见的-icmp-报文)](\l)

[13.3.5ICMP 的应用 - ping [25](#icmp-的应用---ping)](\l)

[13.3.6ICMP 的应用 - Traceroute [26](#icmp-的应用---traceroute)](\l)

[13.4Go语言TCP协议 [27](#go语言tcp协议)](\l)

[13.4.1TCP 协议简介 [27](#tcp-协议简介)](\l)

[13.4.2TCP 三次握手 [28](#tcp-三次握手)](\l)

[13.4.3TCP 四次挥手 [28](#tcp-四次挥手)](\l)

[13.5Go语言DialTCP()：网络通信 [30](#go语言dialtcp网络通信)](\l)

[13.6Go语言HTTP客户端实现简述 [32](#go语言http客户端实现简述)](\l)

[13.6.1基本方法 [33](#基本方法)](\l)

[13.6.2高级封装 [39](#高级封装)](\l)

[13.7Go语言服务端处理HTTP、HTTPS请求
[46](#go语言服务端处理httphttps请求)](\l)

[13.7.1处理 HTTP 请求 [46](#处理-http-请求)](\l)

[13.7.2处理 HTTPS 请求 [48](#处理-https-请求)](\l)

[13.8Go语言RPC协议：远程过程调用 [49](#go语言rpc协议远程过程调用)](\l)

[13.8.1什么是 RPC [50](#什么是-rpc)](\l)

[13.8.2Go语言中如何实现 RPC 的 [51](#go语言中如何实现-rpc-的)](\l)

[13.8.3net/rpc 包 [51](#netrpc-包)](\l)

[13.8.4net/rpc/jsonrpc 库 [52](#netrpcjsonrpc-库)](\l)

[13.9如何设计优雅的RPC接口 [54](#如何设计优雅的rpc接口)](\l)

[13.9.1认识 RPC（远程调用） [54](#认识-rpc远程调用)](\l)

[13.9.2远程调用的优势 [55](#远程调用的优势)](\l)

[13.9.3远程调用的缺点 [55](#远程调用的缺点)](\l)

[13.9.4RPC 结构拆解 [56](#rpc-结构拆解)](\l)

[13.9.5RPC 接口设计 [57](#rpc-接口设计)](\l)

[13.10 Go语言解码未知结构的JSON数据
[57](#go语言解码未知结构的json数据)](\l)

[13.10.1类型转换规则 [57](#类型转换规则)](\l)

[13.10.2访问解码后数据 [58](#访问解码后数据)](\l)

[13.10.3JSON 的流式读写 [59](#json-的流式读写)](\l)

[13.11Go语言如何搭建网站程序 [60](#go语言如何搭建网站程序)](\l)

[13.11.1 net/http 包简介 [60](#nethttp-包简介)](\l)

[13.12Go语言开发一个简单的相册网站
[62](#go语言开发一个简单的相册网站)](\l)

[13.12.1新建工程 [62](#新建工程)](\l)

[13.12.2使用 net/http 包提供网络服务
[62](#使用-nethttp-包提供网络服务)](\l)

[13.12.3渲染网页模板 [66](#渲染网页模板)](\l)

[13.12.4模板缓存 [70](#模板缓存)](\l)

[13.12.5错误处理 [72](#错误处理)](\l)

[13.12.6巧用闭包避免程序运行时出错崩溃
[73](#巧用闭包避免程序运行时出错崩溃)](\l)

[13.12.7动态请求和静态资源分离 [74](#动态请求和静态资源分离)](\l)

[13.12.8重构 [76](#重构)](\l)

[13.12.9更多资源 [80](#更多资源)](\l)

[13.13 ~~Go语言~~ 数据库（Database）相关操作
[80](#go语言-数据库database相关操作)](\l)

[13.13.1从 database/sql 讲起 [81](#从-databasesql-讲起)](\l)

[13.13.2提高生产效率的 ORM 和 SQL Builder
[82](#提高生产效率的-orm-和-sql-builder)](\l)

[13.13.3脆弱的数据库 [84](#脆弱的数据库)](\l)

[13.14示例：并发时钟服务器 [85](#示例并发时钟服务器)](\l)

[13.15Go语言router请求路由 [87](#go语言router请求路由)](\l)

[13.15.1 httprouter [87](#httprouter)](\l)

[13.15.2原理 [89](#原理)](\l)

[13.15.3压缩字典树创建过程 [91](#压缩字典树创建过程)](\l)

[13.16 ~~Go语言~~ middleware：Web中间件
[96](#go语言-middlewareweb中间件)](\l)

[13.16.1为什么使用中间件 [96](#为什么使用中间件)](\l)

[13.16.2使用中间件剥离非业务逻辑 [98](#使用中间件剥离非业务逻辑)](\l)

[13.16.3更优雅的中间件写法 [100](#更优雅的中间件写法)](\l)

[13.16.4哪些事情适合在中间件中做 [100](#哪些事情适合在中间件中做)](\l)

[13.17 Go语言常见大型Web项目分层（MVC架构）
[102](#go语言常见大型web项目分层mvc架构)](\l)

[13.18 Go语言Cookie的设置与读取 [107](#go语言cookie的设置与读取)](\l)

[13.18.1设置 Cookie [107](#设置-cookie)](\l)

[13.18.2读取 Cookie [108](#读取-cookie)](\l)

[13.19 Go语言获取IP地址和域名解析
[108](#go语言获取ip地址和域名解析)](\l)

[13.19.1 IP 地址类型 [108](#ip-地址类型)](\l)

[13.19.2IPMask 地址类型 [109](#ipmask-地址类型)](\l)

[13.19.3域名解析 [110](#域名解析)](\l)

[13.20 Go语言TCP网络程序设计 [111](#go语言tcp网络程序设计)](\l)

[13.20.1 TCPAddr 地址结构体 [111](#tcpaddr-地址结构体)](\l)

[13.20.2TCPConn 对象 [112](#tcpconn-对象)](\l)

[13.20.3TCP 服务器设计 [112](#tcp-服务器设计)](\l)

[13.20.4TCP 客户机设计 [113](#tcp-客户机设计)](\l)

[13.20.5 使用 Goroutine 实现并发服务器
[114](#使用-goroutine-实现并发服务器)](\l)

[13.21 Go语言UDP网络程序设计 [115](#go语言udp网络程序设计)](\l)

[13.21.1 UDPAddr 地址结构体 [116](#udpaddr-地址结构体)](\l)

[13.21.2 UDPConn 对象 [116](#udpconn-对象)](\l)

[13.21.3 UDP 服务器设计 [116](#udp-服务器设计)](\l)

[13.21.4 UDP 客户机设计 [117](#udp-客户机设计)](\l)

[13.22 Go语言IP网络程序设计 [119](#go语言ip网络程序设计)](\l)

[13.22.1IPAddr 地址结构体 [119](#ipaddr-地址结构体)](\l)

[13.22.2IPConn 对象 [119](#ipconn-对象)](\l)

[13.22.3IP 服务器设计 [120](#ip-服务器设计)](\l)

[13.22.4IP 客户机设计 [121](#ip-客户机设计)](\l)

[13.22.5Ping 程序设计 [122](#ping-程序设计)](\l)

[13.23 Go语言是如何使得Web工作的 [124](#go语言是如何使得web工作的)](\l)

[13.23.1 web 工作方式的几个概念 [124](#web-工作方式的几个概念)](\l)

[13.23.2 分析 http 包运行机制 [124](#分析-http-包运行机制)](\l)

[13.24 Go语言session的创建和管理 [127](#go语言session的创建和管理)](\l)

[13.24.1 session 创建过程 [127](#session-创建过程)](\l)

[13.24.2 Go 实现 session 管理 [128](#go-实现-session-管理)](\l)

[13.24.3session 存储 [132](#session-存储)](\l)

[13.24.4预防 session 劫持 [133](#预防-session-劫持)](\l)

[13.24.5session 劫持防范 [135](#session-劫持防范)](\l)

[13.25 Go语言Ratelimit服务流量限制
[136](#go语言ratelimit服务流量限制)](\l)

[13.25.1常⻅的流量限制⼿段 [138](#常的流量限制段)](\l)

[13.25.2原理 [140](#原理-1)](\l)

[13.25.3服务瓶颈和 QoS [141](#服务瓶颈和-qos)](\l)

[13.26 Go语言WEB框架(Gin)详解 [142](#go语言web框架gin详解)](\l)

[13.26.1 Gin 实际应用 [142](#gin-实际应用)](\l)

# 13.网络编程

Go语言网络编程

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Go语言在编写 web 应用方面非常得力。因为目前它还没有 GUI（Graphic User
Interface 图形化用户界面）的框架，通过文本或者模板展现的 html 界面是目前
Go 编写应用程序的唯一方式。

本章我们将全面介绍如何使用 Go语言开发网络程序。Go语言标准库里提供的 net
包，支持基于 IP 层、TCP/UDP 层及更高层面（如
HTTP、FTP、SMTP）的网络操作，其中用于 IP 层的称为 Raw Socket。

## 13.1 Go语言Socket编程详解

大部分底层网络的编程都离不开socket编程，HTTP 编程、Web 开发、IM
通信、视频流传输的底层都是 socket 编程。

### 13.1.1什么是 Socket

网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个
socket。

建立网络通信连接至少要一对端口号（socket），socket
本质是编程接口（API），对 TCP/IP 的封装，TCP/IP
也要提供可供程序员做网络开发所用的接口，这就是 Socket 编程接口。

可以将 HTTP 比作轿车，它提供了封装或者显示数据的具体形式；那么 Socket
就是发动机，它提供了网络通信的能力。

Socket 的英文意思是"孔"或"插座"，作为 BSD UNIX
的进程通信机制，取后一种意思，通常也称作"套接字"，用于描述 IP
地址和端口，是一个通信链的句柄，可以用来实现不同虚拟机或不同计算机之间的通信。

每种服务都打开一个
Socket，并绑定到一个端口上，不同的端口对应于不同的服务。Socket
正如其英文意思那样，像一个多孔插座。插座是用来给插头提供一个接口让其通电的，此时我们就可以将插座当做一个服务端，不同的插头当做客户端。

常用的 Socket 类型有两种，分别是流式 Socket（SOCK_STREAM）和数据报式
Socket（SOCK_DGRAM）：

-   流式是一种面向连接的 Socket，针对于面向连接的 TCP 服务应用；

-   数据报式 Socket 是一种无连接的 Socket，对应于无连接的 UDP 服务应用。

### 13.1.2Socket 如何通信

网络中的进程之间如何通过 Socket
通信呢？首要解决的问题是如何唯一标识一个进程，否则通信无从谈起！在本地可以通过进程
PID 来唯一标识一个进程，但是在网络中这是行不通的。

其实 TCP/IP 协议族已经帮我们解决了这个问题，网络层的"ip
地址"可以唯一标识网络中的主机，而传输层的"协议+端口"可以唯一标识主机中的应用程序（进程）。这样利用三元组（ip
地址，协议，端口）就可以标识网络的进程了，网络中需要互相通信的进程，就可以利用这个标志在他们之间进行交互。请看下面这个
TCP/IP 协议结构图：

![IMG_256](media/image1.png){width="5.208333333333333in"
height="3.2083333333333335in"}\
图：七层网络协议图

使用 TCP/IP 协议的应用程序通常采用应用编程接口：UNIX BSD
的套接字（socket）和 UNIX System V 的
TLI（已经被淘汰），来实现网络进程之间的通信。

就目前而言，几乎所有的应用程序都是采用
socket，而现在又是网络时代，网络中进程通信是无处不在，这就是为什么说"一切皆
Socket"。

### 13.1.3网络应用的设计模式

#### 1) C/S模式

传统的网络应用设计模式，客户机（Client）/服务器（Server）模式，需要在通讯两端各自部署客户机和服务器来完成数据通信。

![IMG_257](media/image2.png){width="4.973611111111111in"
height="1.6979166666666667in"}\
图：C/S模式

#### 2) B/S模式

浏览器（Browser）/服务器（Server）模式，只需在一端部署服务器，而另外一端使用每台
PC 都默认配置的浏览器即可完成数据的传输。

![IMG_258](media/image3.png){width="5.344444444444444in"
height="1.101388888888889in"}\
图：B/S模式

#### 优缺点

对于 C/S
模式来说，其优点明显。客户端位于目标主机上可以保证性能，将数据缓存至客户端本地，从而提高数据传输效率。一般来说客户端和服务器程序由一个开发团队创作，所以他们之间所采用的协议相对灵活。

可以在标准协议的基础上根据需求裁剪及定制，例如腾讯所采用的通信协议，即为
ftp 协议的修改剪裁版。

因此，传统的网络应用程序及较大型的网络应用程序都首选 C/S
模式进行开发。例如知名的网络游戏魔兽世界，3D 画面，数据量庞大，使用 C/S
模式可以提前在本地进行大量数据的缓存处理，从而提高观感。

C/S
模式的缺点也较突出。由于客户端和服务器都需要有一个开发团队来完成开发。工作量将成倍提升，开发周期较长。另外，从用户角度出发，需要将客户端安插至用户主机上，对用户主机的安全性构成威胁。这也是很多用户不愿使用
C/S 模式应用程序的重要原因。

B/S 模式相比 C/S 模式而言，由于 B/S
模式没有独立的客户端，使用标准浏览器作为客户端，其工作开发量较小，只需开发服务器端即可。另外由于其采用浏览器显示数据，因此移植性非常好，不受平台限制。例如早期的偷菜游戏，在各个平台上都可以完美运行。

B/S
模式的缺点也较明显。由于使用第三方浏览器，因此网络应用支持受限；另外没有客户端放到对方主机上，缓存数据不尽如人意，从而传输数据量受到限制，应用的观感大打折扣；第三，必须与浏览器一样，采用标准
http 协议进行通信，协议选择不灵活。

因此在开发过程中，模式的选择由上述各自的特点决定，根据实际需求选择应用程序设计模式。

### 13.1.4TCP Socket

Go语言的 net 包中有一个 **TCPConn** 类型，可以用来建立 TCP 客户端和 TCP
服务器端间的通信通道，TCPConn 类型里有两个主要的函数：

func (c \*TCPConn) Write(b \[\]byte) (n int, err os.Error)\
func (c \*TCPConn) Read(b \[\]byte) (n int, err os.Error)

TCPConn 可以用在客户端和服务器端来读写数据。

还有我们需要知道一个 TCPAddr 类型，它表示一个 TCP
的地址信息，其定义如下：

type TCPAddr struct {

IP IP

Port int

}

在Go语言中通过 ResolveTCPAddr 可以获取一个 TCPAddr 类型，ResolveTCPAddr
的函数定义如下：

func ResolveTCPAddr(net, addr string) (\*TCPAddr, os.Error)

参数说明如下：

-   net 参数是 \"tcp4\"、\"tcp6\"、\"tcp\" 中的任意一个，分别表示
    TCP(IPv4-only)，TCP(IPv6-only) 或者 TCP(IPv4,IPv6) 中的任意一个；

-   addr 表示域名或者 IP 地址，例如 \"c.biancheng.net:80\" 或者
    \"127.0.0.1:22\"。

### 13.1.5TCP server

我们可以通过 net
包来创建一个服务器端程序，在服务器端我们需要绑定服务到指定的非激活端口，并监听此端口，当有客户端请求到达的时候可以接收到来自客户端连接的请求。

net 包中有相应功能的函数，函数定义如下：

func ListenTCP(net string, laddr \*TCPAddr) (l \*TCPListener, err
os.Error)\
func (l \*TCPListener) Accept() (c Conn, err os.Error)

ListenTCP 函数会在本地 TCP 地址 laddr 上声明并返回一个
\*TCPListener，net 参数必须是 \"tcp\"、\"tcp4\"、\"tcp6\"，如果 laddr
的端口字段为 0，函数将选择一个当前可用的端口，可以用 Listener 的 Addr
方法获得该端口。

下面我们实现一个简单的时间同步服务：

[package main]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"log\"]{.mark}

[    \"net\"]{.mark}

[    \"os\"]{.mark}

[    \"time\"]{.mark}

[)]{.mark}

[func echo(conn \*net.TCPConn) {]{.mark}

[    tick := time.Tick(5 \* time.Second) // 五秒的心跳间隔]{.mark}

[    for now := range tick {]{.mark}

[        n, err := conn.Write( \[\]byte(now.String()) )]{.mark}

[        if err != nil {]{.mark}

[            log.Println(err)]{.mark}

[            conn.Close()]{.mark}

[            return]{.mark}

[        }]{.mark}

[        fmt.Printf(\"send %d bytes to %s\\n\", n,
conn.RemoteAddr())]{.mark}

[    }]{.mark}

[}]{.mark}

[func main() {]{.mark}

[    address := net.TCPAddr{]{.mark}

[        IP:   net.ParseIP(\"127.0.0.1\"), //
把字符串IP地址转换为net.IP类型]{.mark}

[        Port: 8000,]{.mark}

[    }]{.mark}

[    listener, err := net.ListenTCP(\"tcp4\", &address) //
创建TCP4服务器端监听器]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(err) // Println +]{.mark}

[        os.Exit(1)]{.mark}

[    }]{.mark}

[    for {]{.mark}

[        conn, err := listener.AcceptTCP()]{.mark}

[        if err != nil {]{.mark}

[            log.Fatal(err) // 错误直接退出]{.mark}

[        }]{.mark}

[        fmt.Println(\"remote address:\", conn.RemoteAddr())]{.mark}

[        go echo(conn)]{.mark}

[    }]{.mark}

[}]{.mark}

上面的服务端程序运行起来之后，它将会一直在那里等待，直到有客户端请求到达。

### 13.1.6TCP client

Go语言可以通过 net 包中的 DialTCP 函数来建立一个 TCP 连接，并返回一个
TCPConn
类型的对象，当连接建立时服务器端也会同时创建一个同类型的对象，此时客户端和服务器段通过各自拥有的
TCPConn 对象来进行数据交换。

一般而言，客户端通过 TCPConn
对象将请求信息发送到服务器端，读取服务器端响应的信息；服务器端读取并解析来自客户端的请求，并返回应答信息。这个连接会在客户端或服务端任何一端关闭之后失效，不然这连接可以一直使用。

建立连接的函数定义如下：

func DialTCP(net string, laddr, raddr \*TCPAddr) (c \*TCPConn, err
os.Error)

参数说明如下：

-   net 参数是 \"tcp4\"、\"tcp6\"、\"tcp\" 中的任意一个，分别表示
    TCP(IPv4-only)、TCP(IPv6-only) 或者 TCP(IPv4,IPv6) 的任意一个；

-   laddr 表示本机地址，一般设置为 nil；

-   raddr 表示远程的服务地址。

接下来通过一个简单的例子，模拟一个基于 HTTP 协议的客户端请求去连接一个
Web 服务端，要写一个简单的 http 请求头，格式类似如下：

\"HEAD / HTTP/1.0\\r\\n\\r\\n\"

客户端代码如下所示：

[package main]{.mark}

[import (]{.mark}

[    \"log\"]{.mark}

[    \"net\"]{.mark}

[    \"os\"]{.mark}

[)]{.mark}

[func main() {]{.mark}

[    if len(os.Args) != 2 {]{.mark}

[        log.Fatalf(\"Usage: %s host:port\", os.Args\[0\])]{.mark}

[    }]{.mark}

[    service := os.Args\[1\]]{.mark}

[    tcpAddr, err := net.ResolveTCPAddr(\"tcp4\", service)]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(err)]{.mark}

[    }]{.mark}

[    conn, err := net.DialTCP(\"tcp4\", nil, tcpAddr)]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(err)]{.mark}

[    }]{.mark}

[    n, err := conn.Write(\[\]byte(\"HEAD /
HTTP/1.1\\r\\n\\r\\n\"))]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(err)]{.mark}

[    }]{.mark}

[    log.Fatal(n)]{.mark}

[}]{.mark}

在 CMD
窗口中运行前面的服务端程序，正如前面所说的，服务端程序只是占用当前的窗口并没有任何输出内容。

go run main.go

重新打开一个 CMD 窗口运行上面的客户端程序，运行结果如下所示：

go run client.go 127.0.0.1:8000\
2019/12/31 10:49:10 19\
exit status 1

### 13.1.7控制 TCP 连接

TCP 有很多连接控制函数，我们平常用到比较多的有如下几个函数：

func DialTimeout(net, addr string, timeout time.Duration) (Conn, error)

设置建立连接的超时时间，客户端和服务器端都适用，当超过设置时间时，连接自动关闭。

func (c \*TCPConn) SetReadDeadline(t time.Time) error\
func (c \*TCPConn) SetWriteDeadline(t time.Time) error

用来设置写入/读取一个连接的超时时间，当超过设置时间时，连接自动关闭。

func (c \*TCPConn) SetKeepAlive(keepalive bool) os.Error

设置客户端是否和服务器端保持长连接，可以降低建立 TCP
连接时的握手开销，对于一些需要频繁交换数据的应用场景比较适用。

### 13.1.8UDP Socket

Go语言包中处理 UDP Socket 和 TCP Socket
不同的地方就是在服务器端处理多个客户端请求数据包的方式不同，UDP
缺少了对客户端连接请求的 Accept 函数，其他基本几乎一模一样，只有 TCP
换成了 UDP 而已。

UDP 的几个主要函数如下所示：

func ResolveUDPAddr(net, addr string) (\*UDPAddr, os.Error)\
func DialUDP(net string, laddr, raddr \*UDPAddr) (c \*UDPConn, err
os.Error)\
func ListenUDP(net string, laddr \*UDPAddr) (c \*UDPConn, err os.Error)\
func (c \*UDPConn) ReadFromUDP(b \[\]byte) (n int, addr \*UDPAddr, err
os.Error\
func (c \*UDPConn) WriteToUDP(b \[\]byte, addr \*UDPAddr) (n int, err
os.Error)

一个 UDP 的客户端代码如下所示，我们可以看到不同的就是 TCP 换成了 UDP
而已：

[package main]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"net\"]{.mark}

[    \"os\"]{.mark}

[)]{.mark}

[func main() {]{.mark}

[    if len(os.Args) != 2 {]{.mark}

[        fmt.Fprintf(os.Stderr, \"Usage: %s host:port\",
os.Args\[0\])]{.mark}

[        os.Exit(1)]{.mark}

[    }]{.mark}

[    service := os.Args\[1\]]{.mark}

[    udpAddr, err := net.ResolveUDPAddr(\"udp4\", service)]{.mark}

[    checkError(err)]{.mark}

[    conn, err := net.DialUDP(\"udp\", nil, udpAddr)]{.mark}

[    checkError(err)]{.mark}

[    \_, err = conn.Write( \[\]byte(\"anything\") )]{.mark}

[    checkError(err)]{.mark}

[    var buf \[512\]byte]{.mark}

[    n, err := conn.Read( buf\[0:\] )]{.mark}

[    checkError(err)]{.mark}

[fmt.Println(string( buf\[0:n\]) )]{.mark}

[    os.Exit(0)]{.mark}

[}]{.mark}

[func checkError(err error) {]{.mark}

[    if err != nil {]{.mark}

[        fmt.Fprintf(os.Stderr, \"Fatal error \", err.Error())]{.mark}

[        os.Exit(1)]{.mark}

[    }]{.mark}

[}]{.mark}

我们再来看一下 UDP 服务器端如何来处理：

[package main]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"net\"]{.mark}

[    \"os\"]{.mark}

[    \"time\"]{.mark}

[)]{.mark}

[func main() {]{.mark}

[    service := \":1200\"]{.mark}

[    udpAddr, err := net.ResolveUDPAddr(\"udp4\", service)]{.mark}

[    checkError(err)]{.mark}

[    conn, err := net.ListenUDP(\"udp\", udpAddr)]{.mark}

[checkError(err)]{.mark}

[    for {]{.mark}

[        handleClient(conn)]{.mark}

[    }]{.mark}

[}]{.mark}

[func handleClient(conn \*net.UDPConn) {]{.mark}

[    var buf \[512\]byte]{.mark}

[    \_, addr, err := conn.ReadFromUDP(buf\[0:\])]{.mark}

[    if err != nil {]{.mark}

[        return]{.mark}

[    }]{.mark}

[    daytime := time.Now().String()]{.mark}

[    conn.WriteToUDP(\[\]byte(daytime), addr)]{.mark}

[}]{.mark}

[func checkError(err error) {]{.mark}

[    if err != nil {]{.mark}

[        fmt.Fprintf(os.Stderr, \"Fatal error \", err.Error())]{.mark}

[        os.Exit(1)]{.mark}

[    }]{.mark}

[}]{.mark}

运行结果如下：

go run client.go 127.0.0.1:1200\
2019-12-31 10:59:32.4184669 +0800 CST m=+13.865767901

### 13.1.9总结

通过对 TCP 和 UDP Socket 编程的描述和实现，可见Go语言已经完备地支持了
Socket
编程，而且使用起来相当的方便。Go语言提供了很多函数，通过这些函数可以很容易就编写出高性能的
Socket 应用。

## 13.2Go语言Dial()函数：建立网络连接

Go语言中 Dial() 函数用于创建网络连接，函数原型如下：

func Dial(network, address string) (Conn, error) {

var d Dialer

return d.Dial(network, address)

}

参数说明如下：

-   network 参数表示传入的网络协议（比如 tcp、udp 等）；

-   address 参数表示传入的 IP
    地址或域名，而端口号是可选的，如果需要指定的话，以:的形式跟在地址或域名的后面即可。如果连接成功，该函数返回连接对象，否则返回
    error。

实际上，Dial() 函数是对 DialTCP()、DialUDP()、DialIP()、DialUnix()
函数的封装：

func DialTCP(net string, laddr, raddr \*TCPAddr) (c \*TCPConn, err
error)\
func DialUDP(net string, laddr, raddr \*UDPAddr) (c \*UDPConn, err
error)\
func DialIP(netProto string, laddr, raddr \*IPAddr) (c \*IPConn, err
error)\
func DialUnix(net string, laddr, raddr \*UnixAddr) (c \*UnixConn, err
error)

我们来看一下几种常见协议的调用方式。

#### 1) TCP 连接

conn, err := net.Dial(\"tcp\", \"192.168.10.10:80\")

#### 2) UDP 连接：

conn, err := net.Dial(\"udp\", \"192.168.10.10:8888\")

#### 3) ICMP 连接（使用协议名称）：

conn, err := net.Dial(\"ip4:icmp\", \"c.biancheng.net\")

提示：ip4 表示 IPv4，相应的 ip6 表示 IPv6。

#### 4) ICMP 连接（使用协议编号）：

conn, err := net.Dial(\"ip4:1\", \"10.0.0.3\")

提示：我们可以通过以下链接查看协议编号的含义：

https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xml。

目前，Dial() 函数支持如下几种网络协议：tcp、tcp4（仅限
IPv4）、tcp6（仅限 IPv6）、udp、udp4（仅限 IPv4）、udp6（仅限
IPv6）、ip、ip4（仅限 IPv4）、ip6（仅限 IPv6）、unix、unixgram 和
unixpacket。

在成功建立连接后，我们就可以进行数据的发送和接收，发送数据时使用连接对象
conn 的 Write() 方法，接收数据时使用 Read() 方法。

下面通过一个简单的示例程序给大家演示下Go语言中网络编程的实现。

【示例】通过建立 TCP 连接来实现简单的 HTTP 协议，通过向网络主机发送 HTTP
Head 请求，读取网络主机返回的信息：

[package main]{.mark}

[import (    ]{.mark}

[    \"bytes\"    ]{.mark}

[    \"fmt\"    ]{.mark}

[    \"io\"    ]{.mark}

[    \"net\"    ]{.mark}

[    \"os\"]{.mark}

[)]{.mark}

[func main() {    ]{.mark}

[   if len(os.Args) != 2 {        ]{.mark}

[      fmt.Fprintf(os.Stderr,]{.mark}

[         \"Usage: %s host:port\", os.Args\[0\])        ]{.mark}

[      os.Exit(1)    ]{.mark}

[   }    ]{.mark}

[   // 从参数中读取主机信息    ]{.mark}

[   service := os.Args\[1\]    ]{.mark}

[   // 建立网络连接    ]{.mark}

[   conn, err := net.Dial(\"tcp\", service)    ]{.mark}

[   // 连接出错则打印错误消息并退出程序    ]{.mark}

[   checkError(err)    ]{.mark}

[   // 调用返回的连接对象提供的 Write 方法发送请求    ]{.mark}

[   \_, err = conn.Write(\[\]byte(\"HEAD / HTTP/1.0\\r\\n\\r\\n\"))  
 ]{.mark}

[   checkError(err)  ]{.mark}

[   // 通过连接对象提供的 Read 方法读取所有响应数据    ]{.mark}

[   result, err := readFully(conn)    ]{.mark}

[   checkError(err)    ]{.mark}

[   // 打印响应数据    ]{.mark}

[   fmt.Println(string(result))    os.Exit(0)]{.mark}

[}]{.mark}

[func checkError(err error) {    ]{.mark}

[   if err != nil {        ]{.mark}

[      fmt.Fprintf(os.Stderr, \"Fatal error: %s\", err.Error())      
 ]{.mark}

[      os.Exit(1)    ]{.mark}

[   }]{.mark}

[}]{.mark}

[]{.mark}

[func readFully(conn net.Conn) (\[\]byte, error) {    ]{.mark}

[   // 读取所有响应数据后主动关闭连接    ]{.mark}

[   defer conn.Close()    ]{.mark}

[   result := bytes.NewBuffer(nil)]{.mark}

[]{.mark}

[   var buf \[512\]byte    ]{.mark}

[   for {        ]{.mark}

[      n, err := conn.Read(buf\[0:\])        ]{.mark}

[      result.Write(buf\[0:n\])        ]{.mark}

[     ]{.mark}

[]{.mark}

[      if err != nil {            ]{.mark}

[         if err == io.EOF {                ]{.mark}

[            break            ]{.mark}

[         }            ]{.mark}

[         return nil, err        ]{.mark}

[      }    ]{.mark}

[   }    ]{.mark}

[]{.mark}

[   return result.Bytes(), nil]{.mark}

[}]{.mark}

运行结果如下：

go run client.go c.biancheng.net:80\
HTTP/1.1 400 Bad Request\
Server: Tengine\
Date: Tue, 31 Dec 2019 05:20:58 GMT\
Content-Type: text/html\
Content-Length: 265\
Connection: close\
X-Tengine-Error: empty host\
Via: kunlun10.cn1481\[,0\]\
Timing-Allow-Origin: \*\
EagleId: 3df09a1e15777696586488636e

对于 80 端口，还可以通过 http 进行替代：

go run client.go c.biancheng.net:http\
HTTP/1.1 400 Bad Request\
Server: Tengine\
Date: Tue, 31 Dec 2019 05:21:18 GMT\
Content-Type: text/html\
Content-Length: 265\
Connection: close\
X-Tengine-Error: empty host\
Via: kunlun9.cn1481\[,0\]\
Timing-Allow-Origin: \*\
EagleId: 3df09a1d15777696783788939e

可以看到，通过Go语言编写的网络程序整体实现代码非常简单清晰，就是建立连接、发送数据、接收数据，不需要我们关注底层不同协议通信的细节。

## 13.3Go语言ICMP协议：向主机发送消息

ICMP
是用来对网络状况进行反馈的协议，可以用来侦测网络状态或检测网络错误。

### 13.3.1ICMP 协议介绍

ICMP（Internet Control Message Protocol）因特网控制报文协议。它是 IPv4
协议族中的一个子协议，用于 IP
主机、路由器之间传递控制消息。控制消息是网络是否畅通、主机是否可达、路由是否可用等网络本身的消息。这些控制消息虽然不传输用户数据，但是对于用户数据的传递起着重要的作用。

ICMP
协议是一种面向无连接的协议，用于传输出错报告控制信息，它是一个非常重要的协议，对于网络安全具有极其重要的意义。ICMP
属于网络层协议，主要用于在主机与路由器之间传递控制信息，包括报告错误、交换受限控制和状态信息等。当遇到
IP 数据无法访问目标、IP
路由器无法按当前的传输速率转发数据包等情况时，会自动发送 ICMP 消息。

ICMP 是 TCP/IP 模型中网络层的重要成员，与 IP 协议、ARP 协议、RARP 协议及
IGMP 协议共同构成 TCP/IP 模型中的网络层。ping 和 tracert
是两个常用网络管理命令，ping 用来测试网络可达性，tracert
用来显示到达目的主机的路径。ping 和 tracert 都利用 ICMP
协议来实现网络功能，它们是把网络协议应用到日常网络管理的典型实例。

从技术角度来说，ICMP
就是一个"错误侦测与回报机制"，其目的就是让我们能够检测网络的连线状况﹐也能确保连线的准确性。当路由器在处理一个数据包的过程中发生了意外，可以通过
ICMP 向数据包的源端报告有关事件。

其功能主要有：侦测远端主机是否存在，建立及维护路由资料，重导资料传送路径（ICMP
重定向），资料流量控制。ICMP
在沟通之中，主要是透过不同的类别（Type）与代码（Code）让机器来识别不同的连线状况。

ICMP
协议大致可以分为两类，一种是查询报文，一种是差错报文。其中查询报文有以下几种用途：

-   ping 查询；

-   子网掩码查询（用于无盘工作站在初始化自身的时候初始化子网掩码）；

-   时间戳查询（可以用来同步时间）。

而差错报文则产生在数据传送发生错误的时候。

### 13.3.2ICMP消息类型

ICMP 报告无法传送数据报的错误，且无法帮助对这些错误进行疑难解答。例如
IPv4 不能将数据报传送到目标主机，路由器或目标主机上的 ICMP
会向主机发送一条"无法到达目标"消息。

下表为最常见的 ICMP 消息。

  -------------------------------------------------------------------------------------------------------
  **ICMP         **用途说明**
  消息类型**     
  -------------- ----------------------------------------------------------------------------------------
  回显请求       Ping 工具通过发送 ICMP 回显消息检查特定节点的 IPv4 连接以排查网络问题，类型值为 0

  回显应答       节点发送回显答复消息响应 ICMP 回显消息，类型值为 8

  重定向         路由器发送"重定向"消息，告诉发送主机到目标 IPv4 地址更好的路由，类型值为 5

  源抑制         路由器发送"源结束"消息，告诉发送主机它们的 IPv4
                 数据报将被丢弃，因为路由器上发生了拥塞，于是发送主机将以较低的频度发送数据报，类型值为 4

  超时           这个消息有两种用途。当超过 IP 生存期时向发送系统发出错误信息；如果分段的 IP
                 数据报没有在某种期限内重新组合，这个消息将通知发送系统，类型值为 11

  无法到达目标   路由器和目标主机发送"无法到达目标"消息，通知发送主机它们的数据无法传送，类型值为 3
  -------------------------------------------------------------------------------------------------------

其中无法到达目标消息中可以细分为一下几项

  --------------------------------------------------------------------------------
  **无法到达目标消息**   **说明**
  ---------------------- ---------------------------------------------------------
  不能访问主机           路由器找不到目标的 IPv4
                         地址的路由时发送"不能访问主机"消息

  无法访问协议           目标 IPv4 节点无法将 IPv4 报头中的"协议"字段与当前使用的
                         IPv4 客户端协议相匹配时会发送"无法访问协议"消息

  无法访问端口           IPv4 节点在 UDP 报头中的"目标端口"字段与使用该 UDP
                         端口的应用程序相匹配时发送"无法访问端口"消息

  需要分段但设置了 DF    当必须分段但发送节点在 IPv4
                         报头中设置了"不分段（DF）"标志时，IPv4
                         路由器会发送"需要分段但设置了 DF"消息
  --------------------------------------------------------------------------------

ICMP 协议只是试图报告错误，并对特定的情况提供反馈，但最终并没有使 IPv4
成为一个可靠的协议。ICMP 消息是以未确认的 IPv4
数据报传送的，它们自己也不可靠。

### 13.3.3ICMP 的报文格式

ICMP 报文包含在 IP 数据报中，IP 报头在 ICMP 报文的最前面。一个 ICMP
报文包括 IP 报头（至少 20 字节）、ICMP 报头（至少八字节）和 ICMP
报文（属于 ICMP 报文的数据部分）。当 IP 报头中的协议字段值为 1
时，就说明这是一个 ICMP 报文。

ICMP 报头如下图所示：

![IMG_256](media/image4.png){width="5.776388888888889in"
height="2.8986111111111112in"}\
图：ICMP 报头

各字段说明：

-   类型：占一字节，标识 ICMP 报文的类型，目前已定义了 14
    种，从类型值来看 ICMP 报文可以分为两大类。第一类是取值为 1\~127
    的差错报文，第二类是取值 128 以上的信息报文。

-   代码：占一字节，标识对应 ICMP 报文的代码。它与类型字段一起共同标识了
    ICMP 报文的详细类型。

-   校验和：这是对包括 ICMP 报文数据部分在内的整个 ICMP
    数据报的校验和，以检验报文在传输过程中是否出现了差错。其计算方法与在我们介绍
    IP 报头中的校验和计算方法是一样的。

-   标识：占两字节，用于标识本 ICMP 进程，但仅适用于回显请求和应答 ICMP
    报文，对于目标不可达 ICMP 报文和超时 ICMP 报文等，该字段的值为 0。

### 13.3.4常见的 ICMP 报文

#### 相应请求

我们日常进行的 Ping 操作中就包括了相应请求（类型字段值为
8）和应答（类型字段值为 0）ICMP
报文。一台主机向一个节点发送一个类型字段值为 8 的 ICMP
报文，如果途中没有异常（如果没有被路由丢弃，目标不回应 ICMP
或者传输失败），则目标返回类型字段值为 0 的 ICMP
报文，说明这台主机存在。

#### 目标不可达，源抑制和超时报文

这三种报文的格式是一样的。目标不可到达报文（类型值为
3）在路由器或者主机不能传递数据时使用。例如我们要连接对方一个不存在的系统端口（端口号小于
1024）时，将返回类型字段值 3、代码字段值为 3 的 ICMP 报文。

常见的不可到达类型还有网络不可到达（代码字段值为
0）、主机不可达到（代码字段值为 1）、协议不可到达（代码字段值为
2）等等。

源抑制报文（类型字段值为 4，代码字段值为
0）则充当一个控制流量的角色，通知主机减少数据报流量。由于 ICMP
没有回复传输的报文，所以只要停止该报文，主机就会逐渐恢复传输速率。最后，无连接方式网络的问题就是数据报回丢失，或者长时间在网络游荡而找不到目标，或者拥塞导致主机在规定的时间内无法重组数据报分段，这时就要触发
ICMP 超时报文的产生。

超时报文（类型字段值为 11）的代码域有两种取值，代码字段值为 0
表示传输超时；代码字段值为 1 表示分段重组超时。

#### 时间戳请求

时间戳请求报文（类型值字段 13）和时间戳应答报文（类型值字段
14）用于测试两台主机之间数据报来回一次的传输时间。传输时，主机填充原始时间戳，接受方收到请求后填充接受时间戳后以类型值字段
14 的报文格式返回，发送方计算这个时间差。有些系统不响应这种报文。

### 13.3.5ICMP 的应用 - ping

ping 可以说是 ICMP 的最著名的应用，当我们某一个网站上不去的时候，通常会
ping 一下这个网站。ping 会回显出一些有用的信息，一般的信息如下：

Reply from 10.4.24.1: bytes=32 time\<1ms TTL=255\
Reply from 10.4.24.1: bytes=32 time\<1ms TTL=255\
Reply from 10.4.24.1: bytes=32 time\<1ms TTL=255\
Reply from 10.4.24.1: bytes=32 time\<1ms TTL=255

Ping statistics for 10.4.24.1:\
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),\
Approximate round trip times in milli-seconds:\
    Minimum = 0ms, Maximum = 0ms, Average = 0ms

ping 这个单词源自声纳定位，而这个程序的作用也确实如此，它利用 ICMP
协议包来侦测另一个主机是否可达。原理是用类型码为 0 的 ICMP
发请求，受到请求的主机则用类型码为 8 的 ICMP 回应。

ping
程序来计算间隔时间，并计算有多少个包被送达。用户就可以判断网络大致的情况。我们可以看到，ping
给出来了传送的时间和 TTL 的数据。

ping 还给我们一个看主机到目的主机的路由的机会。这是因为 ICMP 的 ping
请求数据报在每经过一个路由器的时候，路由器都会把自己的 ip
放到该数据报中。而目的主机则会把这个 ip 列表复制到回应 ICMP
数据包中发回给主机。

package mainimport ( \"fmt\" \"net\" \"os\")func checkSum(msg \[\]byte)
uint16 { sum := 0 len := len(msg) for i := 0; i \< len-1; i += 2 { sum
+= int(msg\[i\])\*256 + int(msg\[i+1\]) } if len%2 == 1 { sum +=
int(msg\[len-1\]) \* 256 // notice here,why \*256? } sum = (sum \>\>
16) + (sum & 0xffff) sum += (sum \>\> 16) var answer uint16 =
uint16(\^sum) return answer}func checkError(err error) { if err != nil {
fmt.Fprint(os.Stderr, \"Fatal error:\", err.Error()) os.Exit(1) }}func
main() { if len(os.Args) != 2 { fmt.Println(\"Usage: \", os.Args\[0\],
\"host\") os.Exit(1) } service := os.Args\[1\] conn, err :=
net.Dial(\"ip4:icmp\", service) checkError(err) var msg \[512\]byte
msg\[0\] = 8 msg\[1\] = 0 msg\[2\] = 0 msg\[3\] = 0 msg\[4\] = 0
msg\[5\] = 13 msg\[6\] = 0 msg\[7\] = 37 msg\[8\] = 99 len := 9 check :=
checkSum(msg\[0:len\]) msg\[2\] = byte(check \>\> 8) msg\[3\] =
byte(check & 0xff) fmt.Println(msg\[0:len\]) \_, err =
conn.Write(msg\[0:len\]) checkError(err) \_, err = conn.Read(msg\[0:\])
checkError(err) fmt.Println(msg\[0 : 20+len\]) fmt.Println(\"Got
response\") if msg\[20+5\] == 13 { fmt.Println(\"Identifier matches\") }
if msg\[20+7\] == 37 { fmt.Println(\"Sequence matches\") } if
msg\[20+8\] == 99 { fmt.Println(\"Custom data matches\") } os.Exit(0)}

运行结果如下：

go run main.go c.biancheng.net\
\[8 0 148 205 0 13 0 37 99\]\
\[69 0 0 29 14 113 0 0 46 1 225 215 61 240 154 116 192 168 3 139 0 0 156
205 0 13 0 37 99\]\
Got response\
Identifier matches\
Sequence matches\
Custom data matches

但是，无论如何 ip
头所能纪录的路由列表是非常的有限。如果要观察路由，我们还是需要使用更好的工具，就是要讲到的
Traceroute（windows 下面的名字叫做 tracert）。

### 13.3.6ICMP 的应用 - Traceroute

Traceroute
是用来侦测主机到目的主机之间所经路由情况的重要工具，也是最便利的工具。前面说到，尽管
ping 工具也可以进行侦测，但是因为 ip 头的限制，ping
不能完全的记录下所经过的路由器。所以 Traceroute 正好就填补了这个缺憾。

Traceroute 的原理是非常有意思的，它接受到目的主机的 IP
后，首先给目的主机发送一个 TTL=1（还记得 TTL 是什么吗？）的
UDP（后面就知道 UDP
是什么了）数据包，而经过的第一个路由器收到这个数据包以后，就自动把 TTL
减 1，而 TTL 变为 0
以后，路由器就把这个包给抛弃了，并同时产生一个主机不可达的 ICMP
数据报给主机。

主机收到这个数据报以后再发一个 TTL=2 的 UDP
数据报给目的主机，然后刺激第二个路由器给主机发 ICMP
数据报。如此往复直到到达目的主机，这样 traceroute 就拿到了所有的路由器
ip。从而避开了 ip 头只能记录有限路由 IP 的问题。

TCP 和 UDP
协议有一个端口号定义，而普通的网络程序只监控少数的几个号码较小的端口，比如说
80、23 等等。而 traceroute 发送的是端口号 \>30000 的 UDP
报，所以到达目的主机的时候，目的主机只能发送一个端口不可达的 ICMP
数据报给主机。

## 13.4Go语言TCP协议

TCP 是机器与机器间传输信息的基础协议，本节我们就来为大家介绍一下 TCP
协议。

### 13.4.1TCP 协议简介

TCP 传输控制协议（Transmission Control
Protocol）是一种面向连接的、可靠的、基于字节流的传输层通信协议，TCP
协议主要是为了在不可靠的互联网络上提供可靠的端到端字节流而专门设计的一个传输协议。

互联网络与单个网络有很大的不同，因为互联网络的不同部分可能有截然不同的拓扑结构、带宽、延迟、数据包大小和其他参数。TCP
的设计目标是能够动态地适应互联网络的这些特性，而且具备面对各种故障时的健壮性。

不同主机的应用层之间经常需要可靠的、像管道一样的连接，但是 IP
层不提供这样的流机制，而是提供不可靠的包交换。

应用层向 TCP 层发送用于网间传输的、用 8 位字节表示的数据流，然后 TCP
把数据流分区成适当长度的报文段（通常受该计算机连接的网络的数据链路层的最大传输单元（MTU）的限制）。之后
TCP 把结果包传给 IP 层，由它来通过网络将包传送给接收端实体的 TCP 层。

TCP
为了保证不发生丢包，就给每个包一个序号，同时序号也保证了传送到接收端实体的包的按序接收。然后接收端实体对已成功收到的包发回一个相应的确认（ACK），如果发送端实体在合理的往返时延（RTT）内未收到确认，那么对应的数据包就被假设为已丢失将会被进行重传。TCP
用一个校验和函数来检验数据是否有错误，在发送和接收时都要计算校验和。

每台支持 TCP 的机器都有一个 TCP 传输实体，TCP
实体可以是一个库过程、一个用户进程或者内核的一部分。在所有这些情形下，它管理
TCP 流以及与 IP 层之间的接口。

TCP 传输实体接受本地进程的用户数据流，将它们分割成不超过
64KB（实际上去掉 IP 和 TCP 头，通常不超过 1460
数据字节）的分段，每个分段以单独的 IP 数据报形式发送。当包含 TCP
数据的数据报到达一台机器时，它们被递交给 TCP 传输实体，TCP
传输实体重构出原始的字节流。

IP
层并不保证数据报一定被正确地递交到接收方，也不指示数据报的发送速度有多快。正是
TCP
负责既要足够快地发送数据报，以便使用网络容量，但又不能引起网络拥塞，而且
TCP
超时后，要重传没有递交的数据报。即使被正确递交的数据报，也可能存在错序的问题，这也是
TCP 的责任，它必须把接收到的数据报重新装配成正确的顺序。简而言之，TCP
必须提供可靠性的良好性能，这正是大多数用户所期望的而 IP
又没有提供的功能。

TCP 数据包主要包括：

-   SYN 包：请求建立连接的数据包；

-   ACK 包：回应数据包，表示接收到了对方的某个数据包；

-   PSH 包：正常数据包；

-   FIN 包：通讯结束包；

-   RST 包：重置连接，导致 TCP 协议发送 RST 包的原因：

-   SYN 数据段指定的目的端口处没有接收进程在等待；

-   TCP 协议想放弃一个已经存在的连接；

-   TCP 接收到一个数据段，但是这个数据段所标识的连接不存在；

-   接收到 RST 数据段的 TCP
    协议立即将这条连接非正常地断开，并向应用程序报告错误。

-   URG 包：紧急指针。

### 13.4.2TCP 三次握手

所谓三次握手（Three-Way Handshake）即建立 TCP 连接，就是指建立一个 TCP
连接时，需要客户端和服务端总共发送 3
个包以确认连接的建立，三次握手大致流程如下：

#### 第一次握手

客户端向服务器发出连接请求报文，这时报文首部中的同部位
SYN=1，同时随机生成初始序列号 seq=x，此时 TCP 客户端进程进入了
SYN-SENT（同步已发送状态）状态。

TCP 规定 SYN 报文段（SYN=1
的报文段）不能携带数据，但需要消耗掉一个序号。这是三次握手中的开始，表示客户端想要和服务端建立连接。

#### 第二次握手

TCP 服务器收到请求报文后，如果同意连接，则发出确认报文。确认报文中应该
ACK=1、SYN=1，确认号是 ack=x+1，同时也要为自己随机初始化一个序列号
seq=y，此时 TCP 服务器进程进入了 SYN-RCVD（同步收到）状态。

这个报文也不能携带数据，但是同样要消耗一个序号，这个报文带有
SYN（建立连接）和 ACK（确认）标志，询问客户端是否准备好。

#### 第三次握手

TCP 客户进程收到确认后，还要向服务器给出确认，确认报文的
ACK=1、ack=y+1，此时 TCP 连接建立，客户端进入
ESTABLISHED（已建立连接）状态。

TCP 规定 ACK
报文段可以携带数据，但是如果不携带数据则不消耗序号，这里客户端表示我已经准备好。

完成三次握手后，客户端与服务器即开始传送数据。

### 13.4.3TCP 四次挥手

所谓四次挥手（Four-Way-Wavehand）即终止 TCP 连接，就是指断开一个 TCP
连接时，需要客户端和服务端总共发送 4 个包以确认连接的断开。

在socket编程中，这一过程由客户端或服务器任一方执行 close
来触发，大致流程如下：

#### 第一次挥手

TCP 发送一个 FIN（结束），用来关闭客户到服务端的连接。

客户端进程发出连接释放报文，并且停止发送数据。释放数据报文首部
FIN=1，其序列号为
seq=u（等于前面已经传送过来的数据的最后一个字节的序号加
1），此时客户端进入 FIN-WAIT-1（终止等待 1）状态。

TCP 规定，FIN 报文段即使不携带数据，也要消耗一个序号。

#### 第二次挥手

服务端收到这个 FIN，它发回一个 ACK（确认），确认收到序号并为收到的序号
+1，和 SYN 相同一个 FIN 将占用一个序号。

服务器收到连接释放报文，发出确认报文
ACK=1、ack=u+1，并且带上自己的序列号 seq=v，此时服务端就进入了
CLOSE-WAIT（关闭等待）状态。

TCP
服务器通知高层的应用进程，客户端向服务器的方向就释放了，这时候处于半关闭状态，即客户端已经没有数据要发送了，但是服务器若发送数据，客户端依然要接受。这个状态还要持续一段时间，也就是整个
CLOSE-WAIT 状态持续的时间。

客户端收到服务器的确认请求后，此时客户端就进入 FIN-WAIT-2（终止等待
2）状态，等待服务器发送连接释放报文（在这之前还需要接受服务器发送的最后的数据）。

#### 第三次挥手

服务端发送一个 FIN（结束）到客户端，服务端关闭客户端的连接。

服务器将最后的数据发送完毕后，就向客户端发送连接释放报文
FIN=1、ack=u+1，由于在半关闭状态，服务器很可能又发送了一些数据，假设此时的序列号为
seq=w，那么服务器就进入了 LAST-ACK（最后确认）状态，等待客户端的确认。

#### 第四次挥手

客户端发送 ACK（确认）报文确认，并将确认的序号 +1，这样关闭完成。

客户端收到服务器的连接释放报文后，必须发出确认
ACK=1、ack=w+1，而自己的序列号是 seq=u+1，此时客户端就进入了
TIME-WAIT（时间等待）状态。

注意此时 TCP 连接还没有释放，必须经过
2∗∗MSL（最长报文段寿命）的时间后，当客户端撤销相应的 TCB 后，才进入
CLOSED 状态。

服务器只要收到了客户端发出的确认，立即进入 CLOSED 状态。同样撤销 TCB
后，就结束了这次的 TCP 连接。可以看到服务器结束 TCP
连接的时间要比客户端早一些。

#### 为什么建立连接是三次握手，而关闭连接却是四次挥手

这是因为服务端在 LISTEN 状态下，收到建立连接请求的 SYN 报文后，把 ACK 和
SYN 放在一个报文里发送给客户端。

而关闭连接时，当收到对方的 FIN
报文时，仅仅表示对方不再发送数据了但是还能接收数据，己方也未必将全部数据都发送给了对方，所以己方可以立即
close，也可以发送一些数据给对方后，再发送 FIN
报文给对方来表示同意现在关闭连接，因此己方 ACK 和 FIN 一般都会分开发送。

下面我们通过一个示例演示建立 TCP 链接来实现初步的 HTTP
协议，具体代码如下：

package mainimport ( \"net\" \"os\" \"bytes\" \"fmt\")func main() { if
len(os.Args) != 2 { fmt.Fprintf(os.Stderr, \"Usage: %s host:port\",
os.Args\[0\]) os.Exit(1) } service := os.Args\[1\] conn, err :=
net.Dial(\"tcp\", service) checkError(err) \_, err =
conn.Write(\[\]byte(\"HEAD / HTTP/1.0\\r\\n\\r\\n\")) checkError(err)
result, err := readFully(conn) checkError(err)
fmt.Println(string(result)) os.Exit(0)}func checkError(err error) { if
err != nil { fmt.Fprintf(os.Stderr, \"Fatal error: %s\", err.Error())
os.Exit(1) }}func readFully(conn net.Conn) (\[\]byte, error) { defer
conn.Close() result := bytes.NewBuffer(nil) var buf \[512\]byte for { n,
err := conn.Read(buf\[0:\]) result.Write(buf\[0:n\]) if err != nil { if
err == io.EOF { break } return nil, err } } return result.Bytes(), nil}

执行这段程序并查看执行结果：

go run main.go baidu.com:80\
HTTP/1.1 200 OK\
Date: Thu, 02 Jan 2020 05:19:13 GMT\
Server: Apache\
Last-Modified: Tue, 12 Jan 2010 13:48:00 GMT\
ETag: \"51-47cf7e6ee8400\"\
Accept-Ranges: bytes\
Content-Length: 81\
Cache-Control: max-age=86400\
Expires: Fri, 03 Jan 2020 05:19:13 GMT\
Connection: Close\
Content-Type: text/html

## 13.5Go语言DialTCP()：网络通信

实际上，在前面《Dial()函数》一节中介绍的 Dial() 函数其实是对
DialTCP()、DialUDP()、DialIP() 和 DialUnix()
的封装。我们也可以直接调用这些函数，它们的功能是一致的。这些函数的原型如下：

func DialTCP(net string, laddr, raddr \*TCPAddr) (c \*TCPConn, err
error)\
func DialUDP(net string, laddr, raddr \*UDPAddr) (c \*UDPConn, err
error)\
func DialIP(netProto string, laddr, raddr \*IPAddr) (\*IPConn, error)\
func DialUnix(net string, laddr, raddr \*UnixAddr) (c \*UnixConn, err
error)

之前基于 TCP 发送的 HTTP 请求，读取服务器信息并返回 HTTP Head
的示例程序也可以使用下面的方式实现：

[package main]{.mark}

[import (    ]{.mark}

[    \"net\"    ]{.mark}

[    \"os\"    ]{.mark}

[    \"fmt\"    ]{.mark}

[    \"io/ioutil\"]{.mark}

[)]{.mark}

[func main() {    ]{.mark}

[    if len(os.Args) != 2 {        ]{.mark}

[        fmt.Fprintf(os.Stderr, \"Usage: %s host:port\", os.Args\[0\])  
     ]{.mark}

[        os.Exit(1)    ]{.mark}

[    }    ]{.mark}

[   ]{.mark}

[    service := os.Args\[1\]    ]{.mark}

[    tcpAddr, err := net.ResolveTCPAddr(\"tcp4\", service)    ]{.mark}

[    checkError(err)    ]{.mark}

[   ]{.mark}

[    conn, err := net.DialTCP(\"tcp\", nil, tcpAddr)    ]{.mark}

[    checkError(err)    ]{.mark}

[   ]{.mark}

[    \_, err = conn.Write(\[\]byte(\"HEAD / HTTP/1.0\\r\\n\\r\\n\"))  
 ]{.mark}

[    checkError(err)    ]{.mark}

[   ]{.mark}

[    result, err := ioutil.ReadAll(conn)    ]{.mark}

[    checkError(err)    ]{.mark}

[    fmt.Println(string(result))    ]{.mark}

[    os.Exit(0)]{.mark}

[}]{.mark}

[func checkError(err error) {    ]{.mark}

[    if err != nil {        ]{.mark}

[        fmt.Fprintf(os.Stderr,]{.mark}

[            \"Fatal error: %s\", err.Error()]{.mark}

[            )        ]{.mark}

[        os.Exit(1)    ]{.mark}

[    }]{.mark}

[}]{.mark}

与之前使用 Dail() 的例子相比，有两个不同点：

-   net.ResolveTCPAddr() 用于解析地址和端口号；

-   net.DialTCP() 用于建立链接。

提示：这两个函数在 Dial() 函数中都得到了封装。

运行结果如下：

go run main.go baidu.com:80\
HTTP/1.1 200 OK\
Date: Fri, 03 Jan 2020 01:17:50 GMT\
Server: Apache\
Last-Modified: Tue, 12 Jan 2010 13:48:00 GMT\
ETag: \"51-47cf7e6ee8400\"\
Accept-Ranges: bytes\
Content-Length: 81\
Cache-Control: max-age=86400\
Expires: Sat, 04 Jan 2020 01:17:50 GMT\
Connection: Close\
Content-Type: text/html

此外，net
包中还包含了一系列的工具函数，合理地使用这些函数可以更好地保障程序的质量。

验证 IP 地址有效性的函数如下：

func net.ParseIP()

创建子网掩码的函数如下：

func IPv4Mask(a, b, c, d byte) IPMask

获取默认子网掩码的函数如下：

func (ip IP) DefaultMask() IPMask

根据域名查找 IP 的函数如下：

func ResolveIPAddr(net, addr string) (\*IPAddr, error)\
func LookupHost(name string) (cname string, addrs \[\]string, err error)

## 13.6Go语言HTTP客户端实现简述

HTTP（HyperText Transfer
Protocol，超文本传输协议）是互联网上应用最为广泛的一种网络协议，定义了客户端和服务端之间请求与响应的传输标准。

Go语言标准库内建提供了 net/http 包，涵盖了 HTTP
客户端和服务端的具体实现。使用 net/http 包，我们可以很方便地编写 HTTP
客户端或服务端的程序。

### 13.6.1基本方法

net/http 包提供了最简洁的 HTTP
客户端实现，无需借助第三方网络通信库（比如
libcurl）就可以直接使用最常见的 GET 和 POST 方式发起 HTTP 请求。

具体来说，我们可以通过 net/http 包里面的 **Client 类**提供的如下方法发起
HTTP 请求：

func (c \*Client) Get(url string) (r \*Response, err error)\
func (c \*Client) Post(url string, bodyType string, body io.Reader) (r
\*Response, err error)\
func (c \*Client) PostForm(url string, data url.Values) (r \*Response,
err error)\
func (c \*Client) Head(url string) (r \*Response, err error)\
func (c \*Client) Do(req \*Request) (resp \*Response, err error)

下面就来简单介绍一下这几个方法的使用。

#### 1) http.Get()

要请求一个资源，只需调用 http.Get() 方法（等价于
http.DefaultClient.Get()）即可，示例代码如下：

[package main]{.mark}

[]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"io/ioutil\"]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[]{.mark}

[func main() {]{.mark}

[    resp, err := http.Get(\"http://c.biancheng.net\")]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(err)]{.mark}

[    }]{.mark}

[    defer resp.Body.Close()]{.mark}

[    body, err := ioutil.ReadAll(resp.Body)]{.mark}

[    fmt.Println(string(body))]{.mark}

[}]{.mark}

上面这段代码请求一个网站首页，并将其网页内容打印出来，如下所示：

\...\...

\...\...

##### 1.1）底层调用

其实通过 http.Get 发起请求时，默认调用的是上述 http.Client 缺省对象上的
Get 方法：

func Get(url string) (resp \*Response, err error) {\
    return DefaultClient.Get(url)\
}

而 DefaultClient 默认指向的正是 http.Client 的实例对象：

var DefaultClient = &Client{}

它是 net/http 包公开属性，当我们在 http 上调用 Get、Post、PostForm、Head
方法时，最终调用的都是该对象上的对应方法。

##### 1.2）返回值

http.Get() 方法的返回值有两个，分别是一个响应对象和一个 error
对象，如果请求过程中出现错误，则 error
对象不为空，否则可以通过响应对象获取状态码、响应头、响应实体等信息，响应对象所属的类是
http.Response。

可以通过查看 API 文档或者源码了解该类型的具体信息，一般我们可以通过
resp.Body 获取响应实体，通过 resp.Header 获取响应头，通过
resp.StatusCode 获取响应状态码。

获取响应成功后记得调用 resp.Body 上的 Close 方法结束网络请求释放资源。

#### 2) http.Post()

要以 POST 的方式发送数据，也很简单，只需调用 http.Post()
方法并依次传递下面的 3 个参数即可：

-   请求的目标 URL

-   将要 POST 数据的资源类型（MIMEType）

-   数据的比特流（\[\]byte 形式）

下面的示例代码演示了如何上传一张图片：

[resp, err := http.Post(\"http://c.biancheng.net/upload\",]{.mark}

[\"image/jpeg\", &buf)]{.mark}

[if err != nil {]{.mark}

[    fmt.Println(err)]{.mark}

[}]{.mark}

[defer resp.Body.Close()]{.mark}

[]{.mark}

[body, err := ioutil.ReadAll(resp.Body)]{.mark}

[if err != nil {]{.mark}

[    fmt.Println(err)]{.mark}

[}]{.mark}

[fmt.Println(string(body))]{.mark}

其中 &buf 为图片的资源。

#### 3) http.PostForm()

http.PostForm()
方法实现了标准编码格式为"application/x-www-form-urlencoded"的**表单提交**，下面的示例代码模拟了
HTML 表单向后台提交信息的过程：

[package main]{.mark}

[]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"io/ioutil\"]{.mark}

[    \"net/http\"]{.mark}

[    \"net/url\"]{.mark}

[)]{.mark}

[]{.mark}

[func main() {]{.mark}

[    resp, err := http.PostForm(\"http://www.baidu.com\",]{.mark}

[        url.Values{\"wd\": {\"golang\"}})]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(err)]{.mark}

[    }]{.mark}

[defer resp.Body.Close()]{.mark}

[]{.mark}

[    body, err := ioutil.ReadAll(resp.Body)]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(err)]{.mark}

[    }]{.mark}

[    fmt.Println(string(body))]{.mark}

[}]{.mark}

注意：POST 请求参数需要通过 url.Values 方法进行编码和封装。

#### 4) http.Head()

HTTP 的 Head 请求表示只请求目标 URL
的响应头信息，不返回响应实体。可以通过 net/http 包的 http.Head()
方法发起 Head 请求，该方法和 http.Get() 方法一样，只需要传入目标 URL
参数即可。

下面的示例代码请求一个网站首页的 HTTP Header 信息：

[package main]{.mark}

[]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[]{.mark}

[func main() {]{.mark}

[    resp, err := http.Head(\"http://c.biancheng.net\")]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(\"Request Failed: \", err.Error())]{.mark}

[        return]{.mark}

[    }]{.mark}

[    defer resp.Body.Close()]{.mark}

[    // 打印头信息]{.mark}

[    for key, value := range resp.Header {]{.mark}

[        fmt.Println(key, \":\", value)]{.mark}

[    }]{.mark}

[}]{.mark}

运行结果如下：

go run main.go\
X-Swift-Savetime : \[Thu, 02 Jan 2020 02:12:51 GMT\]\
X-Swift-Cachetime : \[31104000\]\
Content-Type : \[text/html\]\
\...\...\
Via : \[cache12.l2cn2178\[13,200-0,M\], cache10.l2cn2178\[14,0\],
kunlun9.cn1481\[0,200-0,H\], kunlun8.cn1481\[1,0\]\]\
X-Cache : \[HIT TCP_MEM_HIT dirn:11:355030002\]

通过 http.Head() 方法返回的响应实体 resp.Body 值为空。

#### 5) (\*http.Client).Do()

下面我们再来看一下 http.Client 类的 Do 方法。

在多数情况下，http.Get()、http.Post() 和 http.PostForm()
就可以满足需求，但是如果我们发起的 HTTP
请求需要更多的自定义请求信息，比如：

-   设置自定义 User-Agent，而不是默认的 Go http package；

-   传递 Cookie 信息；

-   发起其它方式的 HTTP 请求，比如 PUT、PATCH、DELETE 等。

此时可以通过 http.Client 类提供的 Do()
方法来实现，使用该方法时，就不再是通过缺省的 DefaultClient 对象调用
http.Client 类中的方法了，而是需要我们手动实例化 Client
对象并传入添加了自定义请求头信息的请求对象来发起 HTTP 请求：

[package main]{.mark}

[]{.mark}

[import (]{.mark}

[    \"fmt\"]{.mark}

[    \"io\"]{.mark}

[    \"net/http\"]{.mark}

[    \"os\"]{.mark}

[)]{.mark}

[]{.mark}

[func main() {]{.mark}

[    // 初始化客户端请求对象]{.mark}

[    req, err := http.NewRequest(\"GET\",]{.mark}

[        \"http://c.biancheng.net\", nil)]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(err)]{.mark}

[        return]{.mark}

[}]{.mark}

[    // 添加自定义请求头]{.mark}

[req.Header.Add(\"Custom-Header\", \"Custom-Value\")]{.mark}

[]{.mark}

[]{.mark}

[    // 其它请求头配置]{.mark}

[    client := &http.Client{]{.mark}

[        // 设置客户端属性]{.mark}

[    }]{.mark}

[    resp, err := client.Do(req)]{.mark}

[    if err != nil {]{.mark}

[        fmt.Println(err)]{.mark}

[        return]{.mark}

[    }]{.mark}

[defer resp.Body.Close()]{.mark}

[]{.mark}

[    io.Copy(os.Stdout, resp.Body)]{.mark}

[}]{.mark}

运行结果如下：

\...\...

\...\...

用于初始化请求对象的 http.NewRequest
方法需要传入三个参数，第一个是请求方法，第二个是目标
URL，第三个是请求实体，只有 POST、PUT、DELETE
之类的请求才需要设置请求实体，对于 HEAD、GET 而言，传入 nil 即可。

http.NewRequest 方法返回的第一个值就是请求对象实例 req，该实例所属的类是
http.Request，可以调用该类上的公开方法和属性对请求对象进行自定义配置，比如请求方法、URL、请求头等。

设置完成后，就可以将请求对象传入 client.Do() 方法发起 HTTP
请求，之后的操作和前面四个基本方法一样，http.Post、http.PostForm、http.Head、http.NewRequest
方法的底层实现及返回值和 http.Get 方法一样。

### 13.6.2高级封装

除了之前介绍的基本 HTTP 操作，Go语言标准库也暴露了比较底层的 HTTP
相关库，让开发者可以基于这些库灵活定制 HTTP 服务器和使用 HTTP 服务。

#### 1) 自定义 http.Client

前面我们使用的 http.Get()、http.Post()、http.PostForm() 和 http.Head()
方法其实都是在 http.DefaultClient 的基础上进行调用的，比如 http.Get()
等价于 http.Default-Client.Get()，依次类推。

http.DefaultClient 在字面上就向我们传达了一个信息，既然存在默认的
Client，那么 HTTP Client 大概是可以自定义的。实际上确实如此，在 net/http
包中，的确提供了 Client 类型。让我们来看一看 http.Client 类型的结构：

type Client struct {

    // Transport 用于确定HTTP请求的创建机制。

    // 如果为空，将会使用DefaultTransport

    Transport RoundTripper

    // CheckRedirect定义重定向策略。

    // 如果CheckRedirect不为空，客户端将在跟踪HTTP重定向前调用该函数。

    // 两个参数req和via分别为即将发起的请求和已经发起的所有请求，最早的

    // 已发起请求在最前面。

    //
如果CheckRedirect返回错误，客户端将直接返回错误，不会再发起该请求。

    // 如果CheckRedirect为空，Client将采用一种确认策略，将在10个连续

    // 请求后终止

    CheckRedirect func(req \*Request, via \[\]\*Request) error

    // 如果Jar为空，Cookie将不会在请求中发送，并会

    // 在响应中被忽略

    Jar CookieJar

}

在Go语言标准库中，http.Client 类型包含了 3 个公开数据成员：

Transport RoundTripper\
CheckRedirect func(req \*Request, via \[\]\*Request) error\
Jar CookieJar

其中 Transport 类型必须实现 http.RoundTripper 接口。Transport
指定了执行一个 HTTP 请求的运行机制，倘若不指定具体的
Transport，默认会使用 http.DefaultTransport，这意味着 http.Transport
也是可以自定义的。net/http 包中的 http.Transport 类型实现了
http.RoundTripper 接口。

CheckRedirect 函数指定处理重定向的策略。当使用 HTTP Client 的 Get()
或者是 Head() 方法发送 HTTP 请求时，若响应返回的状态码为 30x （比如 301
/ 302 / 303 / 307），HTTP Client 会在遵循跳转规则之前先调用这个
CheckRedirect 函数。

Jar 可用于在 HTTP Client 中设定 Cookie，Jar 的类型必须实现了
http.CookieJar 接口，该接口预定义了 SetCookies() 和 Cookies() 两个方法。

如果 HTTP Client 中没有设定 Jar，Cookie
将被忽略而不会发送到客户端。实际上，我们一般都用 http.SetCookie()
方法来设定 Cookie。

使用自定义的 http.Client 及其 Do() 方法，我们可以非常灵活地控制 HTTP
请求，比如发送自定义 HTTP Header 或是改写重定向策略等。创建自定义的 HTTP
Client 非常简单，具体代码如下：

[client := &http.Client {    ]{.mark}

[    CheckRedirect: redirectPolicyFunc,]{.mark}

[}]{.mark}

[resp, err := client.Get(\"http://example.com\")]{.mark}

[// \...]{.mark}

[req, err := http.NewRequest(\"GET\", \"http://example.com\",
nil)]{.mark}

[// \...]{.mark}

[req.Header.Add(\"User-Agent\", \"Our Custom User-Agent\")]{.mark}

[req.Header.Add(\"If-None-Match\", \`W/\"TheFileEtag\"\`)]{.mark}

[resp, err := client.Do(req)]{.mark}

[// \...]{.mark}

#### 2) 自定义 http.Transport

在 http.Client 类型的结构定义中，我们看到的第一个数据成员就是一个
http.Transport 对象，该对象指定执行一个 HTTP
请求时的运行规则。下面我们来看看 http.Transport 类型的具体结构：

[type Transport struct {]{.mark}

[    // Proxy指定用于针对特定请求返回代理的函数。]{.mark}

[    // 如果该函数返回一个非空的错误，请求将终止并返回该错误。]{.mark}

[    // 如果Proxy为空或者返回一个空的URL指针，将不使用代理]{.mark}

[    Proxy func(\*Request) (\*url.URL, error)]{.mark}

[    // Dial指定用于创建TCP连接的dail()函数。]{.mark}

[    // 如果Dial为空，将默认使用net.Dial()函数]{.mark}

[    Dial func(net, addr string) (c net.Conn, err error)]{.mark}

[    // TLSClientConfig指定用于tls.Client的TLS配置。]{.mark}

[    // 如果为空则使用默认配置]{.mark}

[    TLSClientConfig    \*tls.Config]{.mark}

[    DisableKeepAlives  bool]{.mark}

[    DisableCompression bool]{.mark}

[    //
如果MaxIdleConnsPerHost为非零值，它用于控制每个host所需要]{.mark}

[    //
保持的最大空闲连接数。如果该值为空，则使用DefaultMaxIdleConnsPerHost]{.mark}

[    MaxIdleConnsPerHost int]{.mark}

[    // \...]{.mark}

[}]{.mark}

在上面的代码中，我们定义了 http.Transport
类型中的公开数据成员，下面详细说明其中的各行代码。

Proxy func(\*Request) (\*url.URL, error)

Proxy 指定了一个代理方法，该方法接受一个 \*Request
类型的请求实例作为参数并返回一个最终的 HTTP 代理。如果 Proxy
未指定或者返回的 \*URL 为零值，将不会有代理被启用。

Dial func(net, addr string) (c net.Conn, err error)

Dial 指定具体的 dial() 方法来创建 TCP 连接。如果不指定，默认将使用
net.Dial() 方法。

TLSClientConfig \*tls.Config

SSL 连接专用，TLSClientConfig 指定 tls.Client 所用的 TLS
配置信息，如果不指定，也会使用默认的配置。

DisableKeepAlives bool

是否取消长连接，默认值为 false，即启用长连接。

DisableCompression bool

是否取消压缩（GZip），默认值为 false，即启用压缩。

MaxIdleConnsPerHost int

指定与每个请求的目标主机之间的最大非活跃连接（keep-alive）数量。如果不指定，默认使用
DefaultMaxIdleConnsPerHost 的常量值。

除了 http.Transport
类型中定义的公开数据成员以外，它同时还提供了几个公开的成员方法。

-   func(t \*Transport)
    CloseIdleConnections()。该方法用于关闭所有非活跃的连接。

-   func(t \*Transport) RegisterProtocol(scheme string, rt
    RoundTripper)。该方法可用于注册并启用一个新的传输协议，比如
    WebSocket 的传输协议标准（ws），或者 FTP、File 协议等。

-   func(t \*Transport) RoundTrip(req \*Request) (resp \*Response, err
    error)。用于实现 http.RoundTripper 接口。

自定义 http.Transport 也很简单，如下列代码所示：

[tr := &http.Transport{    ]{.mark}

[    TLSClientConfig: &tls.Config{RootCAs: pool},    ]{.mark}

[    DisableCompression: true,]{.mark}

[    }]{.mark}

[client := &http.Client{Transport: tr}]{.mark}

[resp, err := client.Get(\"https://example.com\")]{.mark}

Client 和 Transport 在执行多个 goroutine
的并发过程中都是安全的，但出于性能考虑，应当创建一次后反复使用。

#### 3) 灵活的 http.RoundTripper 接口

在前面的两小节中，我们知道 HTTP Client 是可以自定义的，而 http.Client
定义的第一个公开成员就是一个 http.Transport
类型的实例，且该成员所对应的类型必须实现 http.RoundTripper 接口。

下面我们来看看 http.RoundTripper 接口的具体定义：

[type RoundTripper interface {]{.mark}

[    // RoundTrip执行一个单一的HTTP事务，返回相应的响应信息。]{.mark}

[    //
RoundTrip函数的实现不应试图去理解响应的内容。如果RoundTrip得到一个响应，]{.mark}

[    //
无论该响应的HTTP状态码如何，都应将返回的err设置为nil。非空的err]{.mark}

[    // 只意味着没有成功获取到响应。]{.mark}

[    //
类似地，RoundTrip也不应试图处理更高级别的协议，比如重定向、认证和]{.mark}

[    // Cookie等。]{.mark}

[    //]{.mark}

[    // RoundTrip不应修改请求内容,
除非了是为了理解Body内容。每一个请求]{.mark}

[    // 的URL和Header域都应被正确初始化]{.mark}

[    RoundTrip(\*Request) (\*Response, error)]{.mark}

[}]{.mark}

从上述代码中可以看到，http.RoundTripper 接口很简单，只定义了一个名为
RoundTrip 的方法。任何实现了 RoundTrip() 方法的类型即可实现
http.RoundTripper 接口。前面我们看到的 http.Transport 类型正是实现了
RoundTrip() 方法继而实现了该接口。

http.RoundTripper 接口定义的 RoundTrip() 方法用于执行一个独立的 HTTP
事务，接受传入的 \\\*Request 请求值作为参数并返回对应的 \\\*Response
响应值，以及一个 error 值。

在实现具体的 RoundTrip() 方法时，不应该试图在该函数里边解析 HTTP
响应信息。若响应成功，error 的值必须为 nil，而与返回的 HTTP
状态码无关。若不能成功得到服务端的响应，error
必须为非零值。类似地，也不应该试图在 RoundTrip()
中处理协议层面的相关细节，比如重定向、认证或是 cookie 等。

非必要情况下，不应该在 RoundTrip()
中改写传入的请求体（\\\*Request），请求体的内容（比如 URL 和 Header
等）必须在传入 RoundTrip() 之前就已组织好并完成初始化。

通常，我们可以在默认的 http.Transport 之上包一层 Transport 并实现
RoundTrip() 方法，代码如下所示。

[package main]{.mark}

[import (]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[type OurCustomTransport struct {]{.mark}

[    Transport http.RoundTripper]{.mark}

[}]{.mark}

[func (t \*OurCustomTransport) transport() http.RoundTripper {]{.mark}

[    if t.Transport != nil {]{.mark}

[        return t.Transport]{.mark}

[    }]{.mark}

[    return http.DefaultTransport]{.mark}

[}]{.mark}

[func (t \*OurCustomTransport) RoundTrip(req \*http.Request)
(\*http.Response, error) {]{.mark}

[    // 处理一些事情 \...]{.mark}

[    // 发起HTTP请求]{.mark}

[    // 添加一些域到req.Header中]{.mark}

[    return t.transport().RoundTrip(req)]{.mark}

[}]{.mark}

[func (t \*OurCustomTransport) Client() \*http.Client {]{.mark}

[    return &http.Client{Transport: t}]{.mark}

[}]{.mark}

[func main() {]{.mark}

[    t := &OurCustomTransport{]{.mark}

[        //\...]{.mark}

[    }]{.mark}

[    c := t.Client()]{.mark}

[    resp, err := c.Get(\"http://example.com\")]{.mark}

[    // \...]{.mark}

[}]{.mark}

因为实现了 http.RoundTripper 接口的代码通常需要在多个 goroutine
中并发执行，因此我们必须确保实现代码的线程安全性。

#### 4) 设计优雅的 HTTP Client

综上示例讲解可以看到，Go语言标准库提供的 HTTP Client
是相当优雅的。一方面提供了极其简单的使用方式，另一方面又具备极大的灵活性。

Go语言标准库提供的 HTTP Client 被设计成上下两层结构。一层是上述提到的
http.Client
类及其封装的基础方法，我们不妨将其称为"业务层"。之所以称为业务层，是因为调用方通常只需要关心请求的业务逻辑本身，而无需关心非业务相关的技术细节，这些细节包括：

-   HTTP 底层传输细节

-   HTTP 代理

-   gzip 压缩

-   连接池及其管理

-   认证（SSL 或其他认证方式）

之所以 HTTP Client 可以做到这么好的封装性，是因为 HTTP Client
在底层抽象了 http.RoundTripper 接口，而 http.Transport
实现了该接口，从而能够处理更多的细节，我们不妨将其称为"传输层"。

HTTP Client 在业务层初始化 HTTP Method、目标
URL、请求参数、请求内容等重要信息后，经过"传输层"，"传输层"在业务层处理的基础上补充其他细节，然后再发起
HTTP 请求，接收服务端返回的 HTTP 响应。

## 13.7Go语言服务端处理HTTP、HTTPS请求

本节我们主要来介绍一下使用Go语言编写的 HTTP 服务端是如何处理 HTTP 和
HTTPS 请求的。

### 13.7.1处理 HTTP 请求

使用 net/http 包提供的 http.ListenAndServe()
方法，可以对指定的地址进行监听，开启一个 HTTP，服务端该方法的原型如下：

func ListenAndServe(addr string, handler Handler) error

该方法用于在指定的 TCP 网络地址 addr
进行监听，然后调用服务端处理程序来处理传入的连接请求。

ListenAndServe 方法有两个参数，其中第一个参数 addr
即监听地址，第二个参数表示服务端处理程序，通常为空。第二个参数为空时，意味着服务端调用
http.DefaultServeMux 进行处理，而服务端编写的业务逻辑处理程序
http.Handle() 或 http.HandleFunc() 默认注入 http.DefaultServeMux
中，代码如下所示：

[http.Handle(\"/foo\", fooHandler)]{.mark}

[http.HandleFunc(\"/bar\",]{.mark}

[    func(w http.ResponseWriter, r \*http.Request) {    ]{.mark}

[        fmt.Fprintf(w, \"Hello, %q\",
html.EscapeString(r.URL.Path))]{.mark}

[    }]{.mark}

[)]{.mark}

[]{.mark}

[log.Fatal(http.ListenAndServe(\":8080\", nil))]{.mark}

如果想更多地控制服务端的行为，可以自定义 http.Server，代码如下所示：

[s := &http.Server{    ]{.mark}

[    Addr: \":8080\",    ]{.mark}

[    Handler: myHandler,    ]{.mark}

[    ReadTimeout: 10 \* time.Second,    ]{.mark}

[    WriteTimeout: 10 \* time.Second,    ]{.mark}

[    MaxHeaderBytes: 1 \<\< 20,]{.mark}

[}]{.mark}

[log.Fatal(s.ListenAndServe())]{.mark}

下面通过一个简单的服务端示例来演示一下Go语言是如何处理 HTTP
请求的，代码如下所示：

[package main]{.mark}

[import (]{.mark}

[    \"io\"]{.mark}

[    \"log\"]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[]{.mark}

[func HelloServer(w http.ResponseWriter, req \*http.Request) {]{.mark}

[    io.WriteString(w, \"C语言中文网\\n\")]{.mark}

[}]{.mark}

[]{.mark}

[func main() {]{.mark}

[    http.HandleFunc(\"/hello\", HelloServer)]{.mark}

[    err := http.ListenAndServe(\":12345\", nil)]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(\"ListenAndServe: \", err)]{.mark}

[    }]{.mark}

[}]{.mark}

成功运行上面的代码会占用 12345
端口，我们可以使用浏览器访问http://localhost:12345/hello来查看运行结果，如下所示：

![IMG_256](media/image5.png){width="5.208333333333333in"
height="1.4458333333333333in"}

### 13.7.2处理 HTTPS 请求

net/http 包还提供 http.ListenAndServeTLS() 方法，用于处理 HTTPS
连接请求：

func ListenAndServeTLS(addr string, certFile string, keyFile string,
handler Handler) error

ListenAndServeTLS 函数和 ListenAndServe 函数的行为基本一致，区别在于
ListenAndServeTLS 函数只处理 HTTPS 请求。

此外，服务器上必须提供证书文件和对应的私钥文件，比如 certFile 对应 SSL
证书文件存放路径，keyFile
对应证书私钥文件路径。如果证书是由权威机构签发的，certFile
参数指定的路径必须是存放在服务器上的经由 CA 认证过的 SSL 证书。

开启 SSL 监听服务也很简单，如下列代码所示：

[http.Handle(\"/foo\", fooHandler)]{.mark}

[http.HandleFunc(\"/bar\",]{.mark}

[    func(w http.ResponseWriter, r \*http.Request) {    ]{.mark}

[        fmt.Fprintf(w, \"Hello, %q\",
html.EscapeString(r.URL.Path))]{.mark}

[    })]{.mark}

[   ]{.mark}

[log.Fatal(http.ListenAndServeTLS(\":10443\", \"cert.pem\", \"key.pem\",
nil))]{.mark}

或者是：

[ss := &http.Server{    ]{.mark}

[    Addr: \":10443\",    ]{.mark}

[    Handler: myHandler,    ]{.mark}

[    ReadTimeout: 10 \* time.Second,    ]{.mark}

[    WriteTimeout: 10 \* time.Second,    ]{.mark}

[    MaxHeaderBytes: 1 \<\< 20,]{.mark}

[}]{.mark}

[log.Fatal(ss.ListenAndServeTLS(\"cert.pem\", \"key.pem\"))]{.mark}

下面通过示例来演示一下Go语言时如何处理 HTTPS 请求的，代码如下所示：

[package main]{.mark}

[]{.mark}

[import (]{.mark}

[    \"log\"]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[]{.mark}

[func handler(w http.ResponseWriter, req \*http.Request) {]{.mark}

[    w.Header().Set(\"Content-Type\", \"text/plain\")]{.mark}

[    w.Write(\[\]byte(\"C语言中文网\\n\"))]{.mark}

[}]{.mark}

[]{.mark}

[func main() {]{.mark}

[    http.HandleFunc(\"/\", handler)]{.mark}

[    log.Printf(\"监听 1234 端口成功，可以通过 https://127.0.0.1:1234/
访问\")]{.mark}

[    err := http.ListenAndServeTLS(\":1234\", \"cert.pem\", \"key.pem\",
nil)]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(err)]{.mark}

[    }]{.mark}

[}]{.mark}

运行上面的程序需要用到 cert.pem 和 key.pem 这两个文件，可以使用
crypto/tls 包的 generate_cert.go 文件来生成 cert.pem 和 key.pem
这两个文件，运行结果如下：

## 13.8Go语言RPC协议：远程过程调用

RPC 协议构建于 TCP、UDP 或者是 HTTP
之上，允许开发人员直接调用另一台计算机上的程序，而开发人员无需额外地为这个调用过程编写网络通信相关代码，使得开发网络分布式类型的应用程序更加容易。

Go语言的标准库提供了 RPC 框架和不同的 RPC 实现。

### 13.8.1什么是 RPC

远程过程调用（Remote Procedure Call，简称
RPC）是一个计算机通信协议。该协议允许运行于一台计算机的程序调用另一台计算机的子程序，而开发人员无需额外地为这个交互作用编程。如果涉及的软件采用面向对象编程，那么远程过程调用亦可称作远程调用或远程方法调用。

通俗的来讲就是，RPC
允许跨机器、跨语言调用计算机程序。例如我们用Go语言写了一个获取用户信息的方法
getUserInfo，并把Go语言程序部署在阿里云服务器上面，另外我们还有一个部署在腾讯云上面的
php 项目，需要调用Go语言的 getUserInfo 方法获取用户信息，php 跨机器调用
Go 方法的过程就是 RPC 调用。

RPC 的工作流程如下图所示：

![IMG_256](media/image6.png){width="4.152083333333334in"
height="4.05625in"}\
图：远程过程调用流程图

流程说明如下：

-   \(1\) 调用客户端句柄，执行传送参数；

-   \(2\) 调用本地系统内核发送网络消息；

-   \(3\) 消息传送到远程主机；

-   \(4\) 服务器句柄得到消息并取得参数；

-   \(5\) 执行远程过程；

-   \(6\) 执行的过程将结果返回服务器句柄；

-   \(7\) 服务器句柄返回结果，调用远程系统内核；

-   \(8\) 消息传回本地主机；

-   \(9\) 客户句柄由内核接收消息；

-   \(10\) 客户接收句柄返回的数据。

### 13.8.2Go语言中如何实现 RPC 的

在Go语言中实现 RPC
非常简单，有封装好的官方包和一些第三方包提供支持。Go语言中 RPC 可以利用
tcp 或 http 来传递数据，可以对要传递的数据使用多种类型的编解码方式。

Go语言的 net/rpc 包使用 encoding/gob 进行编解码，支持 tcp 或 http
数据传输方式，由于其他语言不支持 gob 编解码方式，所以使用 net/rpc
包实现的 RPC 方法没办法进行跨语言调用。

此外，Go语言还提供了 net/rpc/jsonrpc 包实现 RPC 方法，JSON RPC 采用 JSON
进行数据编解码，因而支持跨语言调用。但目前的 jsonrpc 包是基于 tcp
协议实现的，暂时不支持使用 http 进行数据传输。

除了Go语言官方提供的 rpc 包，还有许多第三方包为在Go语言中实现 RPC
提供支持，大部分第三方 rpc 包的实现都是使用 protobuf
进行数据编解码，根据 protobuf 声明文件自动生成 rpc
方法定义与服务注册代码，所以在Go语言中可以很方便的进行 rpc 服务调用。

### 13.8.3net/rpc 包

rpc 包提供了通过网络或其他 I/O
连接对一个对象的导出方法的访问。服务端注册一个对象，使它作为一个服务被暴露，服务的名字是该对象的类型名。注册之后，对象的导出方法就可以被远程访问。服务端可以注册多个不同类型的对象（服务），但注册具有相同类型的多个对象是错误的。

只有满足如下标准的方法才能用于远程访问，其余方法会被忽略：

-   方法是可导出的；

-   方法有两个参数，都是导出类型或内建类型；

-   方法的第二个参数是指针类型；

-   方法只有一个 error 接口类型的返回值。

下面的示例演示了Go语言 net/rpc 包实现 RPC 方法，使用 http 作为 RPC
的载体，通过 net/http 包监听客户端连接请求。

服务端代码如下：

package mainimport ( \"errors\" \"fmt\" \"log\" \"net\" \"net/http\"
\"net/rpc\" \"os\")// 算数运算结构体type Arith struct {}//
算数运算请求结构体type ArithRequest struct { A int B int}//
算数运算响应结构体type ArithResponse struct { Pro int // 乘积 Quo int //
商 Rem int // 余数}// 乘法运算方法func (this \*Arith) Multiply(req
ArithRequest, res \*ArithResponse) error { res.Pro = req.A \* req.B
return nil}// 除法运算方法func (this \*Arith) Divide(req ArithRequest,
res \*ArithResponse) error { if req.B == 0 { return
errors.New(\"除以零\") } res.Quo = req.A / req.B res.Rem = req.A % req.B
return nil}func main() { rpc.Register(new(Arith)) // 注册rpc服务
rpc.HandleHTTP() // 采用http协议作为rpc载体 lis, err :=
net.Listen(\"tcp\", \"127.0.0.1:8080\") if err != nil {
log.Fatalln(\"致命错误: \", err) } fmt.Fprintf(os.Stdout, \"%s\",
\"开始连接\") http.Serve(lis, nil)}

服务端程序运行之后将会监听本地的 8080
端口，下面我们再来看一下客户端程序，用于连接服务端并实现 RPC
方法调用，完整代码如下：

package mainimport ( \"fmt\" \"log\" \"net/rpc\")//
算数运算请求结构体type ArithRequest struct { A int B int}//
算数运算响应结构体type ArithResponse struct { Pro int // 乘积 Quo int //
商 Rem int // 余数}func main() { conn, err := rpc.DialHTTP(\"tcp\",
\"127.0.0.1:8080\") if err != nil { log.Fatalln(\"连接错误: \", err) }
req := ArithRequest{11, 2} var res ArithResponse err =
conn.Call(\"Arith.Multiply\", req, &res) // 乘法运算 if err != nil {
log.Fatalln(\"算术误差: \", err) } fmt.Printf(\"%d \* %d = %d\\n\",
req.A, req.B, res.Pro) err = conn.Call(\"Arith.Divide\", req, &res) if
err != nil { log.Fatalln(\"算术误差: \", err) } fmt.Printf(\"%d / %d,
商是 %d, 余数是 %d\\n\", req.A, req.B, res.Quo, res.Rem)}

运行结果如下：

11 \* 2 = 22\
11 / 2, 商是 5, 余数是 1

### 13.8.4net/rpc/jsonrpc 库

上面的例子演示了使用 net/rpc 包实现 RPC
的过程，但是没办法在其他语言中调用上面例子所实现的 RPC 方法。

Go语言提供了 net/rpc/jsonrpc 包，用于提供基于 json 编码的 RPC
支持。在不指定编码协议时，默认采用 Go 特有的 gob
编码协议。但是其他语言一般不支持 Go 的 gob 协议，所以如果需要跨语言的
RPC 调用，需要采用通用的编码协议。

服务端部分的代码如下所示：

package mainimport ( \"errors\" \"fmt\" \"log\" \"net\" \"net/rpc\"
\"net/rpc/jsonrpc\" \"os\")// 算数运算结构体type Arith struct {}//
算数运算请求结构体type ArithRequest struct { A int B int}//
算数运算响应结构体type ArithResponse struct { Pro int // 乘积 Quo int //
商 Rem int // 余数}// 乘法运算方法func (this \*Arith) Multiply(req
ArithRequest, res \*ArithResponse) error { res.Pro = req.A \* req.B
return nil}// 除法运算方法func (this \*Arith) Divide(req ArithRequest,
res \*ArithResponse) error { if req.B == 0 { return
errors.New(\"除以零\") } res.Quo = req.A / req.B res.Rem = req.A % req.B
return nil}func main() { rpc.Register(new(Arith)) // 注册rpc服务 lis,
err := net.Listen(\"tcp\", \"127.0.0.1:8080\") if err != nil {
log.Fatalln(\"致命错误: \", err) } fmt.Fprintf(os.Stdout, \"%s\",
\"开始连接\") for { conn, err := lis.Accept() // 接收客户端连接请求 if
err != nil { continue } go func(conn net.Conn) { // 并发处理客户端请求
fmt.Fprintf(os.Stdout, \"%s\", \"新连接接入\\n\")
jsonrpc.ServeConn(conn) }(conn) }}

上述服务端程序启动后，将会监听本地的 8080 端口，并处理客户端的 tcp
连接请求。下面我们再来实现一个客户端程序来连接上述服务端并进行 RPC
调用，完整代码如下：

package mainimport ( \"fmt\" \"log\" \"net/rpc/jsonrpc\")//
算数运算请求结构体type ArithRequest struct { A int B int}//
算数运算响应结构体type ArithResponse struct { Pro int // 乘积 Quo int //
商 Rem int // 余数}func main() { conn, err := jsonrpc.Dial(\"tcp\",
\"127.0.0.1:8080\") if err != nil { log.Fatalln(\"连接错误: \", err) }
req := ArithRequest{11, 3} var res ArithResponse err =
conn.Call(\"Arith.Multiply\", req, &res) // 乘法运算 if err != nil {
log.Fatalln(\"算术误差: \", err) } fmt.Printf(\"%d \* %d = %d\\n\",
req.A, req.B, res.Pro) err = conn.Call(\"Arith.Divide\", req, &res) if
err != nil { log.Fatalln(\"算术误差: \", err) } fmt.Printf(\"%d / %d,
商是 %d, 余数是 %d\\n\", req.A, req.B, res.Quo, res.Rem)}

运行结果如下：

11 \* 3 = 33\
11 / 3, 商是 3, 余数是 2

## 13.9如何设计优雅的RPC接口

RPC
是一种方便的网络通信编程模型，由于和编程语言的高度结合，大大减少了处理网络数据的复杂度，让代码可读性也有可观的提高。但是
RPC
本身的构成却比较复杂，由于受到编程语言、网络模型、使用习惯的约束，有大量的妥协和取舍之处。

RPC 框架的讨论一直是各个技术交流群中的热点话题，例如阿里的
dubbo、新浪微博的 motan、谷歌的 grpc 以及不久前蚂蚁金服开源的 sofa
都是比较出名的 RPC 框架。

### 13.9.1认识 RPC（远程调用）

我们在各种操作系统、编程语言生态圈中，多少都会接触过"远程调用"的概念。一般来说，它们指的是用一行简单的代码，通过网络调用另外一个计算机上的某段程序。比如：

-   RMI（Remote Method
    Invoke）：调用远程的方法，"方法"一般是附属于某个对象上的，所以通常
    RMI 指对在远程的计算机上的某个对象，进行其方法函数的调用。

-   RPC（Remote Procedure
    Call）：远程过程调用，指的是对网络上另外一个计算机上的，某段特定的函数代码的调用。

远程调用本身是网络通信的一种概念，它的特点是把网络通信封装成一个类似函数的调用。网络通信在远程调用外，一般还有其他的几种概念：数据包处理、消息队列、流过滤、资源拉取等待，它们的差异如下表所示：

  -----------------------------------------------------------------------------------------------------------------------------------------------------
  **方案**     **编程方式**                                      **信息封装**                       **传输模型**                         **典型应用**
  ------------ ------------------------------------------------- ---------------------------------- ------------------------------------ --------------
  远程调用     调用函数、输入参数、获得返回值                    使用编程语言的变量、类型、函数     发出请求、获得响应                   JavaRMI

  数据包处理   调用                                              把通信内容构造成二进制的协议包     发送/接收                            UDP 编程
               Send()/Recv()，使用字节码数据、编解码、处理内容                                                                           

  消息队列     调用 Put()/Get()，使用"包"对象，处理其包含的内容  消息被封装成语言可用的对象或结构   对某队列存入一个消息或取出一个消息   ActiveMQ

  流过滤       读取一个流或写出一个流，对流中的单元包即刻处理    单元长度很小的统一数据结构         连接、发送/接收、处理                网络视频

  资源拉取     输入一个资源 ID，获得资源内容                     请求或响应都包含：头部和正文       请求后等待响应                       WWW
  -----------------------------------------------------------------------------------------------------------------------------------------------------

### 13.9.2远程调用的优势

#### 1) 屏蔽了网络层

因此在传输协议和编码协议上，我们可以选择不同的方案。比如 WebService
方案就是用的 HTTP 传输协议 +SOAP 编码协议，而 REST 的方案往往使用
HTTP+JSON 协议。

Facebook 的 Thrift 可以定制任何不同的传输协议和编码协议，可以用
TCP+Google Protocol Buffer 也可以用 UDP+JSON 等。

由于屏蔽了网络层，可以根据实际需要来独立的优化网络部分，而无需涉及业务逻辑的处理代码，这对于需要在各种网络环境下运行的程序来说，非常有价值。

#### 2) 函数映射协议

可以直接用编程语言来书写数据结构和函数定义，取代编写大量的编码协议格式和分包处理逻辑。对于那些业务逻辑非常复杂的系统，比如网络游戏，可以节省大量定义消息格式的时间。

函数调用模型非常容易学习，不需要学习通信协议和流程，让经验较浅的程序员也能很容易的开始使用网络编程。

### 13.9.3远程调用的缺点

#### 1) 增加了性能消耗

由于把网络通信包装成"函数"，需要大量额外的处理，比如需要预生产代码，或者使用反射机制。这些都是额外消耗
CPU 和内存的操作。而且为了表达复杂的数据类型，比如变长的类型
string/map/list，这些都要数据包中增加更多的描述性信息，则会占用更多的网络包长度。

#### 2) 不必要的复杂化

如果是为了某些特定的业务需求，比如传送一个固定的文件，那么应该用
HTTP/FTP 协议模型；如果为了做监控或者 IM
软件，用简单的消息编码收发会更快速高效；如果是为了做代理服务器，用流式的处理会很简单。另外，如果要做数据广播，那么消息队列会很容易做到，而远程调用这几乎无法完成。

因此，远程调用最适合是业务需求多变或者网络环境多变的场景。

### 13.9.4RPC 结构拆解

RPC 的结构如下图所示：

![IMG_256](media/image7.png){width="7.59375in"
height="3.5243055555555554in"}\
图：RPC 结构图

RPC 服务端通过 RpcServer 去导出（export）远程接口方法，而客户端通过
RpcClient
去引入（import）远程接口方法。客户端像调用本地方法一样去调用远程接口方法，RPC
框架提供接口的代理实现，实际的调用将委托给代理
RpcProxy，代理封装调用信息并将调用转交给 RpcInvoker 去实际执行。

在客户端的 RpcInvoker 通过连接器 RpcConnector 去维持与服务端的通道
RpcChannel，并使用 RpcProtocol
执行协议编码（encode）并将编码后的请求消息通过通道发送给服务端。

RPC 服务端接收器 RpcAcceptor 接收客户端的调用请求，同样使用 RpcProtocol
执行协议解码（decode），解码后的调用信息传递给 RpcProcessor
去控制处理调用过程，最后再委托调用给 RpcInvoker
去实际执行并返回调用结果。

RPC 各个组件的职责如下所示：

-   RpcServer：负责导出（export）远程接口

-   RpcClient：负责导入（import）远程接口的代理实现

-   RpcProxy：远程接口的代理实现

-   RpcInvoker：

-   客户方实现：负责编码调用信息和发送调用请求到服务方并等待调用结果返回

-   服务方实现：负责调用服务端接口的具体实现并返回调用结果

-   RpcProtocol：负责协议编/解码

-   RpcConnector：负责维持客户方和服务方的连接通道和发送数据到服务方

-   RpcAcceptor：负责接收客户方请求并返回请求结果

-   RpcProcessor：负责在服务方控制调用过程，包括管理调用线程池、超时时间等

-   RpcChannel：数据传输通道

### 13.9.5RPC 接口设计

Go语言的 net/rpc
很灵活，它在数据传输前后实现了编码解码器的接口定义。这意味着，开发者可以自定义数据的传输方式以及
RPC 服务端和客户端之间的交互行为。

RPC 提供的编码解码器接口如下：

type ClientCodec interface { WriteRequest(\*Request, interface{}) error
ReadResponseHeader(\*Response) error ReadResponseBody(interface{}) error
Close() error}type ServerCodec interface { ReadRequestHeader(\*Request)
error ReadRequestBody(interface{}) error WriteResponse(\*Response,
interface{}) error Close() error}

接口 ClientCodec 定义了 RPC 客户端如何在一个 RPC
会话中发送请求和读取响应。客户端程序通过 WriteRequest()
方法将一个请求写入到 RPC 连接中，并通过 ReadResponseHeader() 和
ReadResponseBody() 读取服务端的响应信息。当整个过程执行完毕后，再通过
Close() 方法来关闭该连接。

接口 ServerCodec 定义了 RPC 服务端如何在一个 RPC
会话中接收请求并发送响应。服务端程序通过 ReadRequestHeader() 和
ReadRequestBody() 方法从一个 RPC 连接中读取请求信息，然后再通过
WriteResponse() 方法向该连接中的 RPC
客户端发送响应。当完成该过程后，通过 Close() 方法来关闭连接。

通过实现上述接口，我们可以自定义数据传输前后的编码解码方式，而不仅仅局限于
Gob。

同样，可以自定义 RPC 服务端和客户端的交互行为。实际上，Go标准库提供的
net/rpc/json 包，就是一套实现了 rpc.ClientCodec 和 rpc.ServerCodec
接口的 JSON-RPC 模块。

## 13.10 Go语言解码未知结构的JSON数据

Go语言内置的 encoding/json 标准库提供了对 JSON
数据进行编解码的功能。在实际开发过程中，有时候我们可能并不知道要解码的
JSON数据结构是什么样子的，这个时候应该怎么处理呢？

如果要解码一段未知结构的 JSON，只需将这段 JSON
数据解码输出到一个空接口即可。关于 JSON
数据的编码和解码的详细介绍可以阅读《Json数据编码和解码》一节。

### 13.10.1类型转换规则

在前面介绍接口的时候，我们提到基于Go语言的面向对象特性，可以通过空接口来表示任何类型，这同样也适用于对未知结构的
JSON 数据进行解码，只需要将这段 JSON 数据解码输出到一个空接口即可。

在实际解码过程中，JSON 结构里边的数据元素将做如下类型转换：

-   布尔值将会转换为Go语言的 bool 类型；

-   数值会被转换为Go语言的 float64 类型；

-   字符串转换后还是 string 类型；

-   JSON 数组会转换为 \[\]interface{} 类型；

-   JSON 对象会转换为 map\[string\]interface{} 类型；

-   null 值会转换为 nil。

在Go语言标准库 encoding/json
中，可以使用map\[string\]interface{}和\[\]interface{}类型的值来分别存放未知结构的
JSON 对象或数组。

【示例 1】解析 JSON 数据，并将结果映射到空接口对象：

package mainimport ( \"encoding/json\" \"fmt\")func main() { u3 :=
\[\]byte(\`{\"name\": \"C语言中文网\", \"website\":
\"http://c.biancheng.net/\", \"course\": \[\"Golang\", \"PHP\",
\"JAVA\", \"C\"\]}\`) var user4 interface{} err := json.Unmarshal(u3,
&user4) if err != nil { fmt.Printf(\"JSON 解码失败：%v\\n\", err) return
} fmt.Printf(\"JSON 解码结果: %#v\\n\", user4)}

上述代码中，user4 被定义为一个空接口；json.Unmarshal() 函数将一个 JSON
对象 u3 解码到空接口 user4 中，最终 user4
将会是一个键值对的map\[string\]interface{}结构。

运行结果如下：

JSON 解码结果: map\[string\]interface {}{\"course\":\[\]interface
{}{\"Golang\", \"PHP\", \"JAVA\", \"C\"}, \"name\":\"C语言中文网\",
\"website\":\"http://c.biancheng.net/\"}

因为 u3 整体上是一个 JSON
对象，内部属性也会遵循上述类型的转化规则进行转换。

### 13.10.2访问解码后数据

要访问解码后的数据结构，需要先判断目标结构是否为预期的数据类型，然后我们可以通过
for 循环搭配 range 语句访问解码后的目标数据：

package mainimport ( \"encoding/json\" \"fmt\")func main() { u3 :=
\[\]byte(\`{\"name\": \"C语言中文网\", \"website\":
\"http://c.biancheng.net/\", \"course\": \[\"Golang\", \"PHP\",
\"JAVA\", \"C\"\]}\`) var user4 interface{} err := json.Unmarshal(u3,
&user4) if err != nil { fmt.Printf(\"JSON 解码失败：%v\\n\", err) return
} user5, ok := user4.(map\[string\]interface{}) if ok { for k, v :=
range user5 { switch v2 := v.(type) { case string: fmt.Println(k, \"is
string\", v2) case int: fmt.Println(k, \"is int\", v2) case bool:
fmt.Println(k, \"is bool\", v2) case \[\]interface{}: fmt.Println(k,
\"is an array:\") for i, iv := range v2 { fmt.Println(i, iv) } default:
fmt.Println(k, \"类型未知\") } } }}

运行结果如下：

name is string C语言中文网\
website is string http://c.biancheng.net/\
course is an array:\
0 Golang\
1 PHP\
2 JAVA\
3 C

虽然有些烦琐，但的确是一种解码未知结构的 JSON 数据的安全方式。

### 13.10.3JSON 的流式读写

Go语言内置的 encoding/json 包还提供了 Decoder 和 Encoder
两个类型，用于支持 JSON 数据的流式读写，并提供了 NewDecoder() 和
NewEncoder() 两个函数用于具体实现：

func NewDecoder(r io.Reader) \*Decoder\
func NewEncoder(w io.Writer) \*Encoder

【示例 2】从标准输入流中读取 JSON
数据，然后将其解码，最后再写入到标准输出流中：

package mainimport ( \"encoding/json\" \"log\" \"os\")func main() { dec
:= json.NewDecoder(os.Stdin) enc := json.NewEncoder(os.Stdout) for { var
v map\[string\]interface{} if err := dec.Decode(&v); err != nil {
log.Println(err) return } if err := enc.Encode(&v); err != nil {
log.Println(err) } }}

执行上面的代码，我们需要先输入 JSON 结构数据供标准输入流 os.Stdin
读取，读取到数据后，会通过 json.NewDecoder
返回的解码器对其进行解码，最后再通过 json.NewEncoder
返回的编码器将数据编码后写入标准输出流 os.Stdout 并打印出来：

go run main.go\
{\"name\": \"C语言中文网\", \"website\": \"http://c.biancheng.net/\",
\"course\": \[\"Golang\", \"PHP\", \"JAVA\", \"C\"\]}\
{\"course\":\[\"Golang\",\"PHP\",\"JAVA\",\"C\"\],\"name\":\"C语言中文网\",\"website\":\"http://c.biancheng.net/\"}

其中，第二行为我们输入的内容，第三行为输出内容。

使用 Decoder 和 Encoder 对数据流进行处理可以应用得更为广泛些，比如读写
HTTP 连接、WebSocket 或文件等，Go语言标准库中的 net/rpc/jsonrpc
就是一个应用了 Decoder 和 Encoder 的实际例子：

// NewServerCodec returns a new rpc.ServerCodec using JSON-RPC on
conn.func NewServerCodec(conn io.ReadWriteCloser) rpc.ServerCodec {
return &serverCodec{ dec: json.NewDecoder(conn), enc:
json.NewEncoder(conn), c: conn, pending:
make(map\[uint64\]\*json.RawMessage), }}

## 13.11Go语言如何搭建网站程序

本节我们来学习如何搭建一个简单的网站程序。

首先打开你最喜爱的编辑器，编写如下所示的几行代码，并将其保存为
hello.go。

[package main]{.mark}

[import (]{.mark}

[    \"io\"]{.mark}

[    \"log\"]{.mark}

[    \"net/http\"]{.mark}

[)]{.mark}

[func helloHandler(w http.ResponseWriter, r \*http.Request) {]{.mark}

[    io.WriteString(w, \"Hello, world!\")]{.mark}

[}]{.mark}

[func main() {]{.mark}

[    http.HandleFunc(\"/hello\", helloHandler)]{.mark}

[    err := http.ListenAndServe(\":8080\", nil)]{.mark}

[    if err != nil {]{.mark}

[        log.Fatal(\"ListenAndServe: \", err.Error())]{.mark}

[    }]{.mark}

[}]{.mark}

我们引入了 Go语言标准库中的 net/http 包，主要用于提供 Web
服务，响应并处理客户端（浏览器）的 HTTP请求。

同时，使用 io 包而不是 fmt
包来输出字符串，这样源文件编译成可执行文件后，体积要小很多，运行起来也更省资源。

接下来，让我们简单地了解 Go语言的 http 包在上述示例中所做的工作。

### 13.11.1 net/http 包简介

可以看到，我们在 main() 方法中调用了
http.HandleFunc()，该方法用于分发请求，即针对某一路径请求将其映射到指定的业务逻辑处理方法中。如果你有其他编程语言（比如
Ruby、Python或者PHP等）的 Web 开发经验，可以将其形象地理解为提供类似 URL
路由或者 URL 映射之类的功能。

在 hello.go 中，http.HandleFunc() 方法接受两个参数，第一个参数是 HTTP
请求的目标路径\"/hello\"，该参数值可以是字符串，也可以是字符串形式的正则表达式，第二个参数指定具体的回调方法，比如
helloHandler。

当我们的程序运行起来后，访问 http://localhost:8080/hello，程序就会去调用 helloHandler()
方法中的业务逻辑程序。

在上述例子中， helloHandler() 方法是 http.HandlerFunc 类型的实例，并传入
http.ResponseWriter 和 http.Request
作为其必要的两个参数。http.ResponseWriter 类型的对象用于包装处理 HTTP
服务端的响应信息。

我们将字符串\"Hello, world!\"写入类型为 http.ResponseWriter 的 w
实例中，即可将该字符串数据发送到 HTTP 客户端。第二个参数 r
\*http.Request 表示的是此次 HTTP
请求的一个数据结构体，即代表一个客户端，不过该示例中我们尚未用到它。

还看到，在 main() 方法中调用了
http.ListenAndServe()，该方法用于在示例中监听 8080
端口，接受并调用内部程序来处理连接到此端口的请求。如果端口监听失败，会调用
log.Fatal() 方法输出异常出错信息。

正如你所见，main() 方法中的短短两行即开启了一个 HTTP 服务，使用 Go语言的
net/http 包搭建一个 Web 是如此简单！当然，net/http
包的作用远不止这些，我们只用到其功能的一小部分。

试着编译并运行当前的这份 hello.go 源文件：

\$ go run hello.go

然后在浏览器访问 http://localhost:8080/hello，会看到如下图所示的界面。

![IMG_256](media/image8.png){width="4.295833333333333in"
height="2.317361111111111in"}\
图：浏览器的输出结果

## 13.12Go语言开发一个简单的相册网站

本节我们将综合之前介绍的网站开发相关知识，一步步介绍如何开发一个虽然简单但五脏俱全的相册网站。

### 13.12.1新建工程

首先创建一个用于存放工程源代码的目录并切换到该目录中去，随后创建一个名为
photoweb.go 的文件，用于后面编辑我们的代码：

\$ mkdir -p photoweb/uploads\
\$ cd photoweb\
\$ touch photoweb.go

我们的示例程序不是再造一个 Flickr
那样的网站或者比其更强大的图片分享网站，虽然我们可能很想这么玩。不过还是先让我们快速开发一个简单的网站小程序，暂且只实现以下最基本的几个功能：

-   支持图片上传；

-   在网页中可以查看已上传的图片；

-   能看到所有上传的图片列表；

-   可以删除指定的图片。

功能不多，也很简单。在大概了解上一节中的网页输出 Hello world
示例后，想必你已经知道可以引入 net/http
包来提供更多的路由分派并编写与之对应的业务逻辑处理方法，只不过会比输出一行
Hello, world! 多一些环节，还有些细节需要关注和处理。

### 13.12.2使用 net/http 包提供网络服务

接下来，我们继续使用 Go 标准库中的 net/http
包来一步步构建整个相册程序的网络服务。

#### 1) 上传图片

先从最基本的图片上传着手，具体代码如下所示。

package mainimport ( \"io\" \"log\" \"net/http\")func uploadHandler(w
http.ResponseWriter, r \*http.Request) { if r.Method == \"GET\" {
io.WriteString(w, \"\<form method=\\\"POST\\\" action=\\\"/upload\\\"
\"+ \" enctype=\\\"multipart/form-data\\\"\>\"+ \"Choose an image to
upload: \<input name=\\\"image\\\" type=\\\"file\\\" /\>\"+ \"\<input
type=\\\"submit\\\" value=\\\"Upload\\\" /\>\"+ \"\</form\>\") return
}}func main() { http.HandleFunc(\"/upload\", uploadHandler) err :=
http.ListenAndServe(\":8080\", nil) if err != nil {
log.Fatal(\"ListenAndServe: \", err.Error()) }}

可以看到，结合 main() 和 uploadHandler() 方法，针对 HTTP GET 方式请求
/upload 路径，程序将会往 http.ResponseWriter 类型的实例对象 w 中写入一段
HTML 文本，即输出一个 HTML 上传表单。

如果我们使用浏览器访问这个地址，那么网页上将会是一个可以上传文件的表单。光有上传表单还不能完成图片上传，服务端程序还必须有接收上传图片的相关处理。针对上传表单提交过来的文件，我们对
uploadHandler() 方法再添加些业务逻辑程序：

const ( UPLOAD_DIR = \"./uploads\")func uploadHandler(w
http.ResponseWriter, r \*http.Request) { if r.Method == \"GET\" {
io.WriteString(w, \"\<form method=\\\"POST\\\" action=\\\"/upload\\\"
\"+ \" enctype=\\\"multipart/form-data\\\"\>\"+ \"Choose an image to
upload: \<input name=\\\"image\\\" type=\\\"file\\\" /\>\"+ \"\<input
type=\\\"submit\\\" value=\\\"Upload\\\" /\>\"+ \"\</form\>\") return }
if r.Method == \"POST\" { f, h, err := r.FormFile(\"image\") if err !=
nil { http.Error(w, err.Error(), http.StatusInternalServerError) return
} filename := h.Filename defer f.Close() t, err :=
os.Create(UPLOAD_DIR + \"/\" + filename) if err != nil { http.Error(w,
err.Error(), http.StatusInternalServerError) return } defer t.Close() if
\_, err := io.Copy(t, f); err != nil { http.Error(w, err.Error(),
http.StatusInternalServerError) return } http.Redirect(w, r,
\"/view?id=\"+filename, http.StatusFound) }}

如果是客户端发起的 HTTP POST 请求，那么首先从表单提交过来的字段寻找名为
image 的文件域并对其接值，调用 r.FormFile() 方法会返回 3
个值，各个值的类型分别是 multipart.File、\*multipart.FileHeader 和
error。

如果上传的图片接收不成功，那么在示例程序中返回一个 HTTP
服务端的内部错误给客户端。如果上传的图片接收成功，则将该图片的内容复制到一个临时文件里。如果临时文件创建失败，或者图片副本保存失败，都将触发服务端内部错误。

如果临时文件创建成功并且图片副本保存成功，即表示图片上传成功，就跳转到查看图片页面。此外，我们还定义了两个
defer 语句，无论图片上传成功还是失败，当 uploadHandler()
方法执行结束时，都会先关闭临时文件句柄，继而关闭图片上传到服务器文件流的句柄。

别忘了在程序开头引入 io/ioutil 这个包，因为示例程序中用到了
ioutil.TempFile() 这个方法。

当图片上传成功后，我们即可在网页上查看这张图片，顺便确认图片是否真正上传到了服务端。接下来在网页中呈现这张图片。

#### 2) 在网页上显示图片

要在网页中显示图片，必须有一个可以访问到该图片的网址。在前面的示例代码中，图片上传成功后会跳转到
/view?id= 这样的网址，因此我们的程序要能够将对 /view
路径的访问映射到某个具体的业务逻辑处理方法。

首先，在 photoweb 程序中新增一个名为 viewHanlder() 的方法，其代码如下：

func viewHandler(w http.ResponseWriter, r \*http.Request) { imageId =
r.FormValue(\"id\") imagePath = UPLOAD_DIR + \"/\" + imageId
w.Header().Set(\"Content-Type\", \"image\") http.ServeFile(w, r,
imagePath)}

在上述代码中，我们首先从客户端请求中对参数进行接值。r.FormValue(\"id\")
即可得到客户端请求传递的图片唯一 ID，然后我们将图片 ID
结合之前保存图片用的目录进行组装，即可得到文件在服务器上的存放路径。

接着，调用 http.ServeFile()
方法将该路径下的文件从磁盘中读取并作为服务端的返回信息输出给客户端。同时，也将
HTTP 响应头输出格式预设为 image 类型。

这是一种比较简单的示意写法，实际上应该严谨些，准确解析出文件的 MimeType
并将其作为 Content-Type 进行输出，具体可参考 Go语言标准库中的
http.DetectContentType() 方法和 mime 包提供的相关方法。

完成 viewHandler() 的业务逻辑后，我们将该方法注册到程序的 main()
方法中，与 /view 路径访问形成映射关联。main() 方法的代码如下：

func main() { http.HandleFunc(\"/view\", viewHandler)
http.HandleFunc(\"/upload\", uploadHandler) err :=
http.ListenAndServe(\":8080\", nil) if err != nil {
log.Fatal(\"ListenAndServe: \", err.Error()) }}

这样当客户端（浏览器）访问 /view 路径并传递 id 参数时，即可直接以 HTTP
形式看到图片的内容。在网页上，将会呈现一张可视化的图片。

#### 3) 处理不存在的图片访问

理论上，只要是 uploads/
目录下有的图片，都能够访问到，但我们还是假设有意外情况，比如网址中传入的图片
ID 在 uploads/ 没有对应的文件，这时，我们的 viewHandler()
方法就显得很脆弱了。

不管是给出友好的错误提示还是返回 404
页面，都应该对这种情况作相应处理。我们不妨先以最简单有效的方式对其进行处理，修改
viewHandler() 方法，具体如下：

func viewHandler(w http.ResponseWriter, r \*http.Request) { imageId =
r.FormValue(\"id\") imagePath = UPLOAD_DIR + \"/\" + imageId if exists
:= isExists(imagePath);!exists { http.NotFound(w, r) return }
w.Header().Set(\"Content-Type\", \"image\") http.ServeFile(w, r,
imagePath)}func isExists(path string) bool { \_, err := os.Stat(path) if
err == nil { return true } return os.IsExist(err)}

同时，我们增加了 isExists() 辅助函数，用于检查文件是否真的存在。

#### 4) 列出所有已上传图片

应该有个入口，可以看到所有已上传的图片。对于所有列出的这些图片，我们可以选择进行查看或者删除等操作。下面假设在访问首页时列出所有上传的图片。

由于我们将客户端上传的图片全部保存在工程的 ./uploads
目录下，所以程序中应该有个名叫 listHandler()
的方法，用于在网页上列出该目录下存放的所有文件。暂时我们不考虑以缩略图的形式列出所有已上传图片，只需列出可供访问的文件名称即可。下面我们就来实现这个
listHandler() 方法：

func listHandler(w http.ResponseWriter, r \*http.Request) { fileInfoArr,
err := ioutil.ReadDir(\"./uploads\") if err != nil { http.Error(w,
err.Error(), http.StatusInternalServerError) return } var listHtml
string for \_, fileInfo := range fileInfoArr { imgid := fileInfo.Name
listHtml += \"\<li\>\<a
href=\\\"/view?id=\"+imgid+\"\\\"\>imgid\</a\>\</li\>\" }
io.WriteString(w, \"\<ol\>\"+listHtml+\"\</ol\>\")}

从上面的 listHandler() 方法中可以看到，程序先从 ./uploads
目录中遍历得到所有文件并赋值到 fileInfoArr 变量里。fileInfoArr
是一个数组，其中的每一个元素都是一个文件对象。

然后，程序遍历 fileInfoArr 数组并从中得到图片的名称，用于在后续的 HTML
片段中显示文件名和传入的参数内容。listHtml 变量用于在 for
循序中将图片名称一一串联起来生成一段 HTML，最后调用 io.WriteString()
方法将这段 HTML 输出返回给客户端。

然后在 photoweb. go 程序的 main() 方法中，我们将对首页的访问映射到
listHandler() 方法。main() 方法的代码如下：

func main() { http.HandleFunc(\"/\", listHandler)
http.HandleFunc(\"/view\", viewHandler) http.HandleFunc(\"/upload\",
uploadHandler) err := http.ListenAndServe(\":8080\", nil) if err != nil
{ log.Fatal(\"ListenAndServe: \", err.Error()) }}

这样在访问网站首页的时候，即可看到已上传的所有图片列表了。

不过，你是否注意到一个事实，我们在 photoweb.go 程序的 uploadHandler() 和
listHandler() 方法中都使用 io.WriteString() 方法输出 HTML。

正如你想到的那样，在业务逻辑处理程序中混杂 HTML
可不是什么好事情，代码多起来后会导致程序不够清晰，而且改动程序里边的
HTML 文本时，每次都要重新编译整个工程的源代码才能看到修改后的效果。

正确的做法是，应该将业务逻辑程序和表现层分离开来，各自单独处理。这时候，就需要使用网页模板技术了。

Go 标准库中的 html/template
包对网页模板有着良好的支持。接下来，让我们来了解如何在 photoweb.go
程序中用上 Go 的模板功能。

### 13.12.3渲染网页模板

使用 Go 标准库提供的 html/template 包，可以让我们将 HTML
从业务逻辑程序中抽离出来形成独立的模板文件，这样业务逻辑程序只负责处理业务逻辑部分和提供模板需要的数据，模板文件负责数据要表现的具体形式。

然后模板解析器将这些数据以定义好的模板规则结合模板文件进行渲染，最终将渲染后的结果一并输出，构成一个完整的网页。

下面我们把 photoweb.go 程序的 uploadHandler() 和 listHandler() 方法中的
HTML 文本 抽出，生成模板文件。

新建一个名为 upload.html 的文件，内容如下：

[\<!doctype html\>]{.mark}

[\<html\>]{.mark}

[\<head\>]{.mark}

[\<meta charset=\"utf-8\"\>]{.mark}

[\<title\>Upload\</title\>]{.mark}

[\</head\>]{.mark}

[\<body\>    ]{.mark}

[    \<form method=\"POST\" action=\"/upload\"
enctype=\"multipart/form-data\"\>        ]{.mark}

[    Choose an image to upload: \<input name=\"image\" type=\"file\" /\>
       ]{.mark}

[    \<input type=\"submit\" value=\"Upload\" /\>    ]{.mark}

[    \</form\>]{.mark}

[\</body\>]{.mark}

[\</html\>]{.mark}

然后新建一个名为 list.html 的文件，内容如下：

[\<!doctype html\>]{.mark}

[\<html\>]{.mark}

[\<head\>]{.mark}

[\<meta charset=\"utf-8\"\>\<title\>List\</title\>]{.mark}

[\</head\>]{.mark}

[\<body\>    ]{.mark}

[\<ol\>        ]{.mark}

[    {{range \$.images}}            ]{.mark}

[    \<li\>\<a
href=\"/view?id={{.\|urlquery}}\"\>{{.\|html}}\</a\>\</li\>      
 ]{.mark}

[    {{end}}    ]{.mark}

[\</ol\>]{.mark}

[\</body\>]{.mark}

[\</html\>]{.mark}

在上述模板中，双大括号 {{}} 是区分模板代码和 HTML
的分隔符，括号里边可以是要显示输出的数据，或者是控制语句，比如 if
判断式或者 range 循环体等。

range 语句在模板中是一个循环过程体，紧跟在 range 后面的必须是一个
array、slice 或 map 类型的变量。在 list.html 模板中，images 是一组
string 类型的切片。

在使用 range 语句遍历的过程中，.
即表示该循环体中的当前元素，.\|formatter 表示对当前这个元素的值以
formatter 方式进行格式化输出，比如 .\|urlquery}
即表示对当前元素的值进行转换以适合作为 URL 一部分，而 {{.\|html
表示对当前元素的值进行适合用于 HTML
显示的字符转化，比如\"\>\"会被转义成\"\>\"。

如果 range 关键字后面紧跟的是 map
这样的多维复合结构，循环体中的当前元素可以用 .key1.key2.keyN
这样的形式表示。

如果要更改模板中默认的分隔符，可以使用 template 包提供的 Delims() 方法。

在了解模板语法后，接着我们修改 photoweb.go 源文件，引入 html/template
包，并修改 uploadHandler() 和 listHandler() 方法，具体如下所示。

[package main]{.mark}

[import (    ]{.mark}

[    \"io\"    ]{.mark}

[    \"log\"    ]{.mark}

[    \"net/http\"    ]{.mark}

[    \"io/ioutil\"    ]{.mark}

[    \"html/template\"]{.mark}

[)]{.mark}

[func uploadHandler(w http.ResponseWriter, r \*http.Request) {  
 ]{.mark}

[    if r.Method == \"GET\" {        ]{.mark}

[        t, err := template.ParseFiles(\"upload.html\")        ]{.mark}

[        if err != nil {            ]{.mark}

[            http.Error(w, err.Error(),http.StatusInternalServerError)  
         ]{.mark}

[            return        ]{.mark}

[        }        ]{.mark}

[        t.Execute(w, nil)        ]{.mark}

[        return    ]{.mark}

[    }    ]{.mark}

[   ]{.mark}

[    if r.Method == \"POST\" {        ]{.mark}

[        // \...    ]{.mark}

[    }]{.mark}

[}]{.mark}

[func listHandler(w http.ResponseWriter, r \*http.Request) {    ]{.mark}

[    fileInfoArr, err := ioutil.ReadDir(\"./uploads\")    ]{.mark}

[   ]{.mark}

[    if err != nil {        ]{.mark}

[        http.Error(w, err.Error(),      
 http.StatusInternalServerError)        ]{.mark}

[        return    ]{.mark}

[    }    ]{.mark}

[   ]{.mark}

[    locals := make(map\[string\]interface{})    ]{.mark}

[    images := \[\]string{}    ]{.mark}

[    for \_, fileInfo := range fileInfoArr {        ]{.mark}

[        images = append(images, fileInfo.Name)    ]{.mark}

[    }    ]{.mark}

[    locals\[\"images\"\] = images t, err :=
template.ParseFiles(\"list.html\")    ]{.mark}

[    if err != nil {        ]{.mark}

[        http.Error(w, err.Error(),      
 http.StatusInternalServerError)        ]{.mark}

[        return    ]{.mark}

[    }    ]{.mark}

[    t.Execute(w, locals)]{.mark}

[}]{.mark}

在上面的代码中，template.ParseFiles()
函数将会读取指定模板的内容并且返回一个 \*template.Template 值。

t.Execute() 方法会根据模板语法来执行模板的渲染，并将渲染后的结果作为
HTTP 的返回数据输出。

在 uploadHandler() 方法和 listHandler() 方法中，均调用了
template.ParseFiles() 和 t.Execute() 这两个方法。根据 DRY（Don't Repeat
Yourself）原则，我们可以将模板渲染代码分离出来，单独编写一个处理函数，以便其他业务逻辑处理函数都可以使用。于是，我们可以定义一个名为
renderHtml() 的方法用来渲染模板：

[func renderHtml(w http.ResponseWriter,]{.mark}

[    tmpl string,  ]{.mark}

[    locals map\[string\]interface{} )err error {    ]{.mark}

[        t, err = template.ParseFiles(tmpl + \".html\")    ]{.mark}

[        if err != nil {        ]{.mark}

[            return    ]{.mark}

[        }    ]{.mark}

[        err = t.Execute(w, locals)]{.mark}

[}]{.mark}

有了 renderHtml() 这个通用的模板渲染方法，uploadHandler() 和
listHandler() 方法的代码可以再精简些，如下：

func uploadHandler(w http.ResponseWriter,

    r \*http.Request) {

    if r.Method == \"GET\" {

        if err := renderHtml(w, \"upload\", nil); err != nil {

            http.Error(w, err.Error(),

                http.StatusInternalServerError)

            return

        }

    }

    if r.Method == \"POST\" {

        // \...

    }

}

func listHandler(w http.ResponseWriter,

    r \*http.Request) {

    fileInfoArr, err := ioutil.ReadDir(\"./uploads\")

    if err != nil {

        http.Error(w, err.Error(), http.StatusInternalServerError)

        return

    }

    locals := make(map\[string\]interface{})

    images := \[\]string{}

    for \_, fileInfo := range fileInfoArr {

        images = append(images, fileInfo.Name)

    }

    locals\[\"images\"\] = images

    if err = renderHtml(w, \"list\", locals); err != nil {

        http.Error(w, err.Error(),

            http.StatusInternalServerError)

    }

}

当我们引入了 Go 标准库中的 html/template
包，实现了业务逻辑层与表现层分离后，对模板渲染逻辑去重，编写并使用通用模板渲染方法
renderHtml()，这让业务逻辑处理层的代码看起来确实要清晰简洁许多。

不过，直觉敏锐的你可能已经发现，无论是重构后的 uploadHandler() 还是
listHandler()
方法，每次调用这两个方法时都会重新读取并渲染模板。很明显，这很低效，也比较浪费资源，有没有一种办法可以让模板只加载一次呢？

答案是肯定的，聪明的你可能已经想到怎么对模板进行缓存了。

### 13.12.4模板缓存

对模板进行缓存，即指一次性预加载模板。我们可以在 photoweb
程序初始化运行的时候，将所有模板一次性加载到程序中。正好 Go
的包加载机制允许我们在 init() 函数中做这样的事情，init() 会在 main()
函数之前执行。

首先，我们在 photoweb 程序中声明并初始化一个全局变量
templates，用于存放所有模板内容：

templates := make(map\[string\]\*template.Template)

templates 是一个 map 类型的复合结构，map
的键（key）是字符串类型，即模板的名字，值（value）是 \*template.Template
类型。

接着，我们在 photoweb 程序的 init() 函数中一次性加载所有模板：

func init() {

    for \_, tmpl := range \[\]string{\"upload\", \"list\"} {

        t := template.Must(template.ParseFiles(tmpl + \".html\"))

        templates\[tmpl\] = t

    }

}

在上面的代码中，我们在 template.ParseFiles() 方法的外层强制使用
template.Must() 进行封装，template.Must()
确保了模板不能解析成功时，一定会触发错误处理流程。之所以这么做，是因为倘若模板不能成功加载，程序能做的唯一有意义的事情就是退出。

在 range 语句中，包含了我们希望加载的 upload.html 和 list.html
两个模板，如果我们想加载更多模板，只需往这个数组中添加更多元素即可。当然，最好的办法应该是将所有
HTML
模板文件统一放到一个子文件夹中，然后对这个模板文件夹进行遍历和预加载。

如果需要加载新的模板，只需在这个文件夹中新建模板即可。这样做的好处是不用反复修改代码即可重新编译程序，而且实现了业务层和表现层真正意义上的分离。

不妨让我们这样试试看！

首先创建一个名为 ./views 的目录，然后将当前目录下所有 html
文件移动到该目录下：

\$ mkdir ./views \$ mv \*.html ./views

接着适当地对 init()
方法中的代码进行改写，好让程序初始化时即可预加载该目录下的所有模板文件，如下列代码所示：

const (    

    TEMPLATE_DIR = \"./views\"

)

templates := make(map\[string\]\*template.Template)

func init() {    

    fileInfoArr, err := ioutil.ReadDir(TEMPLATE_DIR)    

    if err != nil {        

        panic(err)        

        return    

    }    

   

    var templateName, templatePath string    

    for \_, fileInfo := range fileInfoArr {        

        templateName = fileInfo.Name        

        if ext := path.Ext(templateName); ext != \".html\" {            

            continue        

        }        

       

        templatePath = TEMPLATE_DIR + \"/\" + templateName        

        log.Println(\"Loading template:\", templatePath)        

        t := template.Must(template.ParseFiles(templatePath))        

        templates\[tmpl\] = t    

    }

}

同时，别忘了对 renderHtml() 的代码进行相应的调整：

func renderHtml(w http.ResponseWriter,

    tmpl string,

    locals map\[string\]interface{}) (err error) {

    err = templates\[tmpl\].Execute(w, locals)

}

此时，renderHtml() 函数的代码也变得更为简洁。还好我们之前单独封装了
renderHtml()
函数，这样全局代码中只需更改这一个地方，这无疑是代码解耦的好处之一！

### 13.12.5错误处理

在前面的代码中，有不少地方对于出错处理都是直接返回 http.Error() 50x
系列的服务端内部错误。从 DRY
的原则来看，不应该在程序中到处使用一样的代码。我们可以定义一个名为
check() 的方法，用于统一捕获 50x 系列的服务端内部错误：

func check(err error) {

    if err != nil {

        panic(err)

    }

}

此时，我们可以将 photoweb 程序中出现的以下代码：

if err != nil {    

    http.Error(w,err.Error(),http.StatusInternalServerError)    

    return

}

统一替换为 check() 处理：

check(err)

错误处理虽然简单很多，但是也带来一个问题。由于发生错误触发错误处理流程必然会引发程序停止运行，这种改法有点像搬起石头砸自己的脚。

其实我们可以换一种思维方式。尽管我们从书写上能保证大多数错误都能得到相应的处理，但根据墨菲定律，有可能出问题的地方就一定会出问题，在计算机程序里尤其如此。如果程序中我们正确地处理了
99
个错误，但若有一个系统错误意外导致程序出现异常，那么程序同样还是会终止运行。

我们不能预计一个工程里边会出现多少意外的情况，但是不管什么意外，只要会触发错误处理流程，我们就有办法对其进行处理。如果这样思考，那么前面这种改法又何尝不是置死地而后生呢？

接下来，让我们了解如何处理 panic 导致程序崩溃的情况。

### 13.12.6巧用闭包避免程序运行时出错崩溃

Go
支持闭包。闭包可以是一个函数里边返回的另一个匿名函数，该匿名函数包含了定义在它外面的值。使用闭包，可以让我们网站的业务逻辑处理程序更安全地运行。

我们可以在 photoweb
程序中针对所有的业务逻辑处理函数（listHandler()、viewHandler() 和
uploadHandler()）再进行一次包装。

在如下的代码中，我们定义了一个名为 safeHandler()
的函数，该函数有一个参数并且返回一个值，传入的参数和返回值都是一个函数，且都是http.HandlerFunc类型，这种类型的函数有两个参数：http.ResponseWriter
和 \*http.Request。

函数规格同 photoweb
的业务逻辑处理函数完全一致。事实上，我们正是要把业务逻辑处理函数作为参数传入到
safeHandler()
方法中，这样任何一个错误处理流程向上回溯的时候，我们都能对其进行拦截处理，从而也能避免程序停止运行：

func safeHandler(fn http.HandlerFunc) http.HandlerFunc {

    return func(w http.ResponseWriter, r \*http.Request) {

        defer func() {

            if e, ok := recover().(error); ok {

                http.Error(w, err.Error(),

                    http.StatusInternalServerError)

                // 或者输出自定义的 50x 错误页面

                // w.WriteHeader(http.StatusInternalServerError)

                // renderHtml(w, \"error\", e)

                // logging

                log.Println(\"WARN: panic in %v - %v\", fn, e)

                log.Println(string(debug.Stack()))

            }

        }()

        fn(w, r)

    }

}

在上述这段代码中，我们巧妙地使用了 defer 关键字搭配 recover() 方法终结
panic 的肆行。safeHandler()
接收一个业务逻辑处理函数作为参数，同时调用这个业务逻辑处理函数。该业\
务逻辑函数执行完毕后，safeHandler() 中 defer 指定的匿名函数会执行。

倘若业务逻辑处理函数里边引发了 panic，则调用 recover()
对其进行检测，若为一般性的错误，则输出 HTTP 50x
出错信息并记录日志，而程序将继续良好运行。

要应用 safeHandler() 函数，只需在 main()
中对各个业务逻辑处理函数做一次包装，如下面的代码所示：

func main() {

    http.HandleFunc(\"/\", safeHandler(listHandler))

    http.HandleFunc(\"/view\", safeHandler(viewHandler))

    http.HandleFunc(\"/upload\", safeHandler(uploadHandler))

    err := http.ListenAndServe(\":8080\", nil)

    if err != nil {

        log.Fatal(\"ListenAndServe: \", err.Error())

    }

}

### 13.12.7动态请求和静态资源分离

你一定还有一个疑问，那就是前面的业务逻辑层都是动态请求，但若是针对静态资源（比如
CSS 和JavaScript等），是没有业务逻辑处理的，只需提供静态输出。在 Go
里边，这当然是可行的。

还记得前面我们在 viewHandler() 函数里边有用到 http.ServeFile()
这个方法吗？net/http 包提供的这个 ServeFile()
函数可以将服务端的一个文件内容读写到 http.Response-Writer
并返回给请求来源的 \*http.Request 客户端。

用前面介绍的闭包技巧结合这个 http.ServeFile()
方法，我们就能轻而易举地实现业务逻辑的动态请求和静态资源的完全分离。

假设我们有 ./public 这样一个存放 css/、js/、images/
等静态资源的目录，原则上所有如下的请求规则都指向该 ./public
目录下相对应的文件：

\[GET\] /assets/css/\*.css\
\[GET\] /assets/js/\*.js\
\[GET\] /assets/images/\*.js

然后，我们定义一个名为 staticDirHandler() 的方法，用于实现上述需求：

const (

    ListDir = 0x0001

)

func staticDirHandler(mux \*http.ServeMux,

    prefix string,

    staticDir string,

    flags int) {

    mux.HandleFunc(prefix,

        func(w http.ResponseWriter, r \*http.Request) {

            file := staticDir + r.URL.Path\[len(prefix)-1:\]

            if (flags & ListDir) == 0 {

                if exists := isExists(file); !exists {

                    http.NotFound(w, r)

                    return

                }

            }

            http.ServeFile(w, r, file)

        })

}

最后，我们需要稍微改动下 main() 函数：

func main() {

    mux := http.NewServeMux()

    staticDirHandler(mux, \"/assets/\", \"./public\", 0)

    mux.HandleFunc(\"/\", safeHandler(listHandler))

    mux.HandleFunc(\"/view\", safeHandler(viewHandler))

    mux.HandleFunc(\"/upload\", safeHandler(uploadHandler))

    err := http.ListenAndServe(\":8080\", mux)

    if err != nil {

        log.Fatal(\"ListenAndServe: \", err.Error())

    }

}

如此即完美实现了静态资源和动态请求的分离。

当然，我们要思考是否确实需要用 Go 来提供静态资源的访问。如果使用外部 Web
服务器（比如 Nginx 等），就没必要使用 Go
编写的静态文件服务了。在本机做开发时有一个程序内置的静态文件服务器还是很实用的。

### 13.12.8重构

经过前面对 photoweb 程序一一重整之后，整个工程的目录结构如下：

├── photoweb.go\
├── public\
    ├── css\
    ├── images\
    └── js\
├── uploads\
└── views\
    ├── list.html\
    └── upload.html

photoweb.go 程序的源码最终如下所示。

纯文本复制

package main

import (    

    \"io\"    

    \"log\"    

    \"path\"    

    \"net/http\"    

    \"io/ioutil\"    

    \"html/template\"    

    \"runtime/debug\"

)

const (    

    ListDir = 0x0001    

    UPLOAD_DIR = \"./uploads\"    

    TEMPLATE_DIR = \"./views\"

)

   

templates := make(map\[string\]\*template.Template)

func init() {  

    fileInfoArr, err := ioutil.ReadDir(TEMPLATE_DIR)    

    check(err)    

    var templateName, templatePath string    

    for \_, fileInfo := range fileInfoArr {        

        templateName = fileInfo.Name        

        if ext := path.Ext(templateName); ext != \".html\" {            

            continue        

        }        

        templatePath = TEMPLATE_DIR + \"/\" + templateName        

        log.Println(\"Loading template:\", templatePath)        

        t := template.Must(template.ParseFiles(templatePath))        

        templates\[tmpl\] = t    

    }

}

func check(err error) {    

    if err != nil {        

        panic(err)    

    }

}

func renderHtml(w http.ResponseWriter,

    tmpl string,

    locals map\[string\]interface{}) {

    err := templates\[tmpl\].Execute(w, locals)    

    check(err)

}

func isExists(path string) bool {

    \_, err := os.Stat(path)    

    if err == nil {        

        return true    

    }    

   

    return os.IsExist(err)

}

func uploadHandler(w http.ResponseWriter, r \*http.Request) {  

    if r.Method == \"GET\" {        

        renderHtml(w, \"upload\", nil);    

    }

    if r.Method == \"POST\" {        

        f, h, err := r.FormFile(\"image\")        

        check(err)    

        filename := h.Filename        

        defer f.Close()  

        t, err := ioutil.TempFile(UPLOAD_DIR, filename)        

        check(err)        

        defer t.Close()  

        \_, err := io.Copy(t, f)        

        check(err)        

        http.Redirect(w, r, \"/view?id=\"+filename, http.StatusFound)  
 

    }

}

func viewHandler(w http.ResponseWriter, r \*http.Request) {

    imageId = r.FormValue(\"id\")    

    imagePath = UPLOAD_DIR + \"/\" + imageId    

    if exists := isExists(imagePath);!exists {        

        http.NotFound(w, r)        

        return    

    }    

   

    w.Header().Set(\"Content-Type\", \"image\")    

    http.ServeFile(w, r, imagePath)

}

func listHandler(w http.ResponseWriter, r \*http.Request) {    

    fileInfoArr, err := ioutil.ReadDir(\"./uploads\")    

    check(err)    

    locals := make(map\[string\]interface{})    

    images := \[\]string{}    

    for \_, fileInfo := range fileInfoArr {        

        images = append(images, fileInfo.Name)    

    }    

   

    locals\[\"images\"\] = images    

    renderHtml(w, \"list\", locals)

}

func safeHandler(fn http.HandlerFunc) http.HandlerFunc {    

    return func(w http.ResponseWriter, r \*http.Request) {        

        defer func() {            

            if e, ok := recover().(error); ok {                

                http.Error(w, err.Error(),
http.StatusInternalServerError)

                // 或者输出自定义的50x错误页面                

                // w.WriteHeader(http.StatusInternalServerError)        
       

                // renderHtml(w, \"error\", e)  

                // logging                

                log.Println(\"WARN: panic in %v. - %v\", fn, e)        
       

                log.Println(string(debug.Stack()))            

            }      

        }()        

        fn(w, r)    

    }

}

func staticDirHandler(mux \*http.ServeMux, prefix string, s

    taticDir string, flags int){    

        mux.HandleFunc(prefix,

            func(w http.ResponseWriter, r \*http.Request) {        

            file := staticDir + r.URL.Path\[len(prefix)-1:\]        

            if (flags & ListDir) == 0 {            

                if exists := isExists(file); !exists {              

                     http.NotFound(w, r)                

                     return            

                     }        

                     }        

                     http.ServeFile(w, r, file)    

            }

        )

}

func main() {    

    mux := http.NewServeMux()    

    staticDirHandler(mux, \"/assets/\", \"./public\", 0)    

    mux.HandleFunc(\"/\", safeHandler(listHandler))    

    mux.HandleFunc(\"/view\", safeHandler(viewHandler))    

    mux.HandleFunc(\"/upload\", safeHandler(uploadHandler))    

    err := http.ListenAndServe(\":8080\", mux)    

   

    if err != nil {        

        log.Fatal(\"ListenAndServe: \", err.Error())    

    }

}

### 13.12.9更多资源

Go
的第三方库很丰富，无论是对于关系型数据库驱动还是非关系型的键值存储系统的接入，都有着良好的支持，而且还有丰富的
Go语言 Web 开发框架以及用于 Web
开发的相关工具包。可以访问 http://godashboard.appspot.com/project，了解更多第三方库的详细信息。

## 13.13 ~~Go语言~~ 数据库（Database）相关操作

本节将对 db/sql 官方标准库作一些简单分析，并介绍一些应用比较广泛的开源
ORM 和 SQL
Builder。并从企业级应用开发和公司架构的角度来分析哪种技术栈对于现代的企业级应用更为合适。

### 13.13.1从 database/sql 讲起

Go语言官方提供了 database/sql 包来给用户进行和数据库打交道的工作，实际上
database/sql 库就只是提供了一套操作数据库的接口和规范，例如抽象好的 SQL
预处理（prepare），连接池管理，数据绑定，事务，错误处理等等。官方并没有提供具体某种数据库实现的协议支持。

和具体的数据库，例如MySQL打交道，还需要再引入 MySQL 的驱动，像下面这样：

import \"database/sql\"\
import \_ \"github.com/go-sql-driver/mysql\"\
db, err := sql.Open(\"mysql\", \"user:password@/dbname\")\
import \_ \"github.com/go-sql-driver/mysql\"

这一句 import，实际上是调用了 mysql 包的 init 函数，做的事情也很简单：

func init() {\
    sql.Register(\"mysql\", &MySQLDriver{})\
}

在 sql 包的全局 map 里把 mysql 这个名字的 driver 注册上。实际上 Driver
在 sql 包中是一个接口：

type Driver interface {\
    Open(name string) (Conn, error)\
}

调用 sql.Open() 返回的 db 对象实际上就是这里的 Conn。

type Conn interface {\
    Prepare(query string) (Stmt, error)\
    Close() error\
    Begin() (Tx, error)\
}

也是一个接口。实际上如果你仔细地查看 database/sql/driver/driver.go
的代码会发现，这个文件里所有的成员全都是接口，对这些类型进行操作，实际上还是会调用具体的
driver 里的方法。

从用户的角度来讲，在使用 database/sql
包的过程中，能够使用的也就是这些接口里提供的函数。来看一个使用
database/sql 和 go-sql-driver/mysql 的完整的例子：

package mainimport ( \"database/sql\" \_
\"github.com/go-sql-driver/mysql\")func main() { // db 是一个 sql.DB
类型的对象 // 该对象线程安全，且内部已包含了一个连接池 //
连接池的选项可以在 sql.DB 的方法中设置，这里为了简单省略了 db, err :=
sql.Open(\"mysql\", \"user:password@tcp(127.0.0.1:3306)/hello\") if err
!= nil { log.Fatal(err) } defer db.Close() var ( id int name string )
rows, err := db.Query(\"select id, name from users where id = ?\", 1) if
err != nil { log.Fatal(err) } defer rows.Close() // 必须要把 rows
里的内容读完，或者显式调用 Close() 方法， // 否则在 defer 的
rows.Close() 执行之前，连接永远不会释放 for rows.Next() { err :=
rows.Scan(&id, &name) if err != nil { log.Fatal(err) } log.Println(id,
name) } err = rows.Err() if err != nil { log.Fatal(err) }}

如果大家想了解官方这个 database/sql
库更加详细的用法的话，可以参考 http://go-database-sql.org/ 。

包括该库的功能介绍、用法、注意事项和反直觉的一些实现方式（例如同一个
goroutine 内对 sql.DB
的查询，可能在多个连接上）都有涉及，本章中不再赘述。

通过上面的介绍，也许大家已经发现了一些问题。官方的 db
库提供的功能这么简单，我们每次去数据库里读取内容岂不是都要去写这么一套差不多的代码？或者如果我们的对象是结构体，把
sql.Rows
绑定到对象的工作就会变得更加得重复而无聊，所以社区才会有各种各样的 SQL
Builder 和 ORM 百花齐放。

### 13.13.2提高生产效率的 ORM 和 SQL Builder

在 Web 开发领域常常提到的 ORM 是什么？我们先看看万能的维基百科：

对象关系映射（英语：Object Relational Mapping，简称 ORM，或 O/RM，或
O/Rmapping），是一种程序设计技术，用于实现面向对象编程语言里不同类型系统的数据之间的转换。\
从效果上说，它其实是创建了一个可在编程语言里使用的"虚拟对象数据库"。

最为常见的 ORM 实际上做的是从 db
到程序的类或结构体这样的映射。所以你手边的程序可能是从 MySQL
的表映射你的程序内的类。我们可以先来看看其它的程序语言里的 ORM
写起来是怎么样的感觉：

\>\>\> from blog.models import Blog\
\>\>\> b = Blog(name=\'Beatles Blog\', tagline=\'All the latest Beatles
news.\')\
\>\>\> b.save()

完全没有数据库的痕迹，没错 ORM 的目的就是屏蔽掉 DB 层，实际上很多语言的
ORM
只要把你的类或结构体定义好，再用特定的语法将结构体之间的一对一或者一对多关系表达出来。那么任务就完成了。然后你就可以对这些映射好了数据库表的对象进行各种操作，例如
save，create，retrieve，delete。

至于 ORM 在背地里做了什么阴险的勾当，你是不一定清楚的。使用 ORM
的时候，我们往往比较容易有一种忘记了数据库的直观感受。举个例子，我们有个需求：向用户展示最新的商品列表，我们再假设，商品和商家是1:1的关联关系，我们就很容易写出像下面这样的代码：

\# 伪代码\
shopList := \[\]\
for product in productList {\
    shopList = append(shopList, product.GetShop)\
}

当然了，我们不能批判这样写代码的程序员是偷懒的程序员。因为 ORM
一类的工具在出发点上就是屏蔽
sql，让我们对数据库的操作更接近于人类的思维方式。这样很多只接触过 ORM
而且又是刚入行的程序员就很容易写出上面这样的代码。

这样的代码将对数据库的读请求放大了 N 倍。也就是说，如果你的商品列表有 15
个 SKU，那么每次用户打开这个页面，至少需要执行 1（查询商品列表）+
15（查询相关的商铺信息）次查询。这里 N 是 16。

如果你的列表页很大，比如说有 600 个条目，那么就至少要执行 1+600
次查询。如果说你的数据库能够承受的最大的简单查询是 12 万
QPS，而上述这样的查询正好是最常用的查询的话，实际上能对外提供的服务能力是多少呢？是
200 qps！互联网系统的忌讳之一，就是这种无端的读放大。

当然，也可以说这不是 ORM 的问题，如果手写 sql
还是可能会写出差不多的程序，那么再来看两个 demo：

o := orm.NewOrm()\
num, err :=
o.QueryTable(\"cardgroup\").Filter(\"Cards\_\_Card\_\_Name\",
cardName).All(&cardgroups)

很多 ORM 都提供了这种 Filter 类型的查询方式，不过实际上在某些 ORM
背后甚至隐藏了非常难以察觉的细节，比如生成的 SQL 语句会自动 limit
1000。\
也许喜欢 ORM 的读者读到这里会反驳了，你是没有认真阅读文档就瞎写。

是的，尽管这些 ORM 工具在文档里说明了 All 查询在不显式地指定 Limit
的话会自动 limit 1000，但对于很多没有阅读过文档或者看过 ORM
源码的人，这依然是一个非常难以察觉的"魔鬼"细节。

喜欢强类型语言的人一般都不喜欢语言隐式地去做什么事情，例如各种语言在赋值操作时进行的隐式类型转换然后又在转换中丢失了精度的勾当，一定让你非常的头疼。所以一个程序库背地里做的事情还是越少越好，如果一定要做，那也一定要在显眼的地方做。比如上面的例子，去掉这种默认的自作聪明的行为，或者要求用户强制传入
limit 参数都是更好的选择。

除了 limit 的问题，我们再看一遍这个下面的查询：

num, err :=
o.QueryTable(\"cardgroup\").Filter(\"Cards\_\_Card\_\_Name\",
cardName).All(&cardgroups)

可以看得出来这个 Filter 是有表 join
的操作么？当然了，有深入使用经验的用户还是会觉得这是在吹毛求疵。但这样的分析想证明的是，ORM
想从设计上隐去太多的细节。而方便的代价是其背后的运行完全失控。这样的项目在经过几任维护人员之后，将变得面目全非，难以维护。

当然，我们不能否认 ORM
的进步意义，它的设计初衷就是为了让数据的操作和存储的具体实现所剥离。但是在上了规模的公司的人们渐渐达成了一个共识，由于隐藏重要的细节，ORM
可能是失败的设计。其所隐藏的重要细节对于上了规模的系统开发来说至关重要。

相比 ORM 来说，SQL Builder 在 SQL
和项目可维护性之间取得了比较好的平衡。首先 sql builer 不像 ORM
那样屏蔽了过多的细节，其次从开发的角度来讲，SQL Builder
简单进行封装后也可以非常高效地完成开发，举个例子：

where := map\[string\]interface{} {\
    \"order_id \> ?\" : 0,\
    \"customer_id != ?\" : 0,\
}\
limit := \[\]int{0,100}\
orderBy := \[\]string{\"id asc\", \"create_time desc\"}\
orders := orderModel.GetList(where, limit, orderBy)

写 SQL Builder 的相关代码，或者读懂都不费劲。把这些代码脑内转换为 sql
也不会太费劲。所以通过代码就可以对这个查询是否命中数据库索引，是否走了覆盖索引，是否能够用上联合索引进行分析了。

说白了 SQL Builder 是 sql 在代码里的一种特殊方言，如果你们没有 DBA
但研发有自己分析和优化 sql 的能力，或者你们公司的 DBA 对于学习这样一些
sql 的方言没有异议。那么使用 SQL Builder
是一个比较好的选择，不会导致什么问题。

另外在一些本来也不需要 DBA 介入的场景内，使用 SQL Builder
也是可以的，例如要做一套运维系统，且将 MySQL
当作了系统中的一个组件，系统的 QPS 不高，查询不复杂等等。

一旦你做的是高并发的 OLTP
在线系统，且想在人员充足分工明确的前提下最大程度控制系统的风险，使用 SQL
Builder 就不合适了。

### 13.13.3脆弱的数据库

无论是 ORM 还是 SQL Builder
都有一个致命的缺点，就是没有办法进行系统上线的事前 sql 审核。虽然很多
ORM 和 SQL Builder 也提供了运行期打印 sql
的功能，但只在查询的时候才能进行输出。而 SQL Builder 和 ORM
本身提供的功能太过灵活。使得你不可能通过测试枚举出所有可能在线上执行的
sql。例如你可能用 SQL Builder 写出下面这样的代码：

where := map\[string\]interface{} {\
    \"product_id = ?\" : 10,\
    \"user_id = ?\" : 1232,\
}\
if order_id != 0 {\
    where\[\"order_id = ?\"\] = order_id\
}\
res, err := historyModel.GetList(where, limit, orderBy)

你的系统里有类似上述样例的大量 if
的话，就难以通过测试用例来覆盖到所有可能的 sql
组合了。这样的系统只要发布，就已经孕育了初期的巨大风险。

对于现在 7 乘 24
服务的互联网公司来说，服务不可用是非常重大的问题。存储层的技术栈虽经历了多年的发展，在整个系统中依然是最为脆弱的一环。系统宕机对于
24 小时对外提供服务的公司来说，意味着直接的经济损失。个中风险不可忽视。

从行业分工的角度来讲，现今的互联网公司都有专职的 DBA。大多数 DBA
并不一定有写代码的能力，去阅读 SQL Builder 的相关"拼
SQL"代码多多少少还是会有一点障碍。从 DBA
角度出发，还是希望能够有专门的事前 SQL 审核机制，并能让其低成本\
地获取到系统的所有 SQL 内容，而不是去阅读业务研发编写的 SQL Builder
的相关代码。

所以现如今，大型的互联网公司核心线上业务都会在代码中把 SQL
放在显眼的位置提供给 DBA 评审，举一个例子：

纯文本复制

const ( getAllByProductIDAndCustomerID = \`select \* from p_orders where
product_id in (:product_id) and customer_id=:customer_id\`)//
GetAllByProductIDAndCustomerID// \@param driver_id// \@param rate_date//
\@return \[\]Order, errorfunc GetAllByProductIDAndCustomerID(ctx
context.Context, productIDs \[\]uint64, customerID uint64) (\[\]Order,
error) { var orderList \[\]Order params := map\[string\]interface{}{
\"product_id\" : productIDs, \"customer_id\": customerID, } //
getAllByProductIDAndCustomerID 是 const 类型的 sql 字符串 sql, args, err
:= sqlutil.Named(getAllByProductIDAndCustomerID, params) if err != nil {
return nil, err } err = dao.QueryList(ctx, sqldbInstance, sql, args,
&orderList) if err != nil { return nil, err } return orderList, err}

像这样的代码，在上线之前把 DAO 层的变更集的 const 部分直接拿给 DBA
来进行审核，就比较方便了。代码中的 sqlutil.Named 是类似于 sqlx 中的
Named 函数，同时支持 where 表达式中的比较操作符和 in。

## 13.14示例：并发时钟服务器

网络是一个自然使用并发的领域，因为服务器通常一次处理很多来自客户端的连接，每一个客户端通常和其他客户端保持独立。本节介绍
net 包，它提供构建客户端和服务器程序的组件，这些程序通过 TCP、UDP 或者
UNIX 套接字进行通信。net/http 包就是在 net 包基础上构建的。

【示例】顺序时钟服务器，它以每秒钟一次的频率向客户端发送当前时间，代码如下所示：

// clock1 是一个定期报告时间的 TCP 服务器package mainimport ( \"io\"
\"log\" \"net\" \"time\")func main() { listener, err :=
net.Listen(\"tcp\", \"localhost:8000\") if err != nil { log.Fatal(err) }
for { conn, err := listener.Accept() if err != nil { log.Print(err)
//例如，连接中止 continue } handleConn(conn) // 一次处理一个连接 }}func
handleConn(c net.Conn) { defer c.Close() for { \_, err :=
io.WriteString(c, time.Now().Format(\"15:04:05\\n\")) if err != nil {
return //例如，连接断开 } time.Sleep(1 \* time.Second) }}

Listen 函数创建一个 net.Listener
对象，它在一个网络端口上监听进来的连接，这里是 TCP 端口
localhost:8000。监听器的 Accept 方法被阻塞，直到有连接请求进来，然后返回
net.Conn 对象来代表一个连接。

handleConn 函数处理一个完整的客户连接。在循环里，它将 time.Now()
获取的当前时间发送给客户端。因为 net.Conn 满足 io.Writer
接口，所以可以直接向它进行写入。

当写入失败时循环结束，很多时候是客户端断开连接，这时 handleconn
函数使用延迟的 Close
调用关闭自己这边的连接，然后继续等待下一个连接请求。

time.Time.Format
方法提供了格式化日期和时间信息的方式。它的参数是一个模板，指示如何格式化一个参考时间，具体如
Mon Jan 2 03:04:05PM 2006 UTC-0700 这样的形式。参考时间有 8
个部分（本周第几天、月、本月第几天，等等）。

它们可以以任意的组合和对应数目的格式化字符出现在格式化模板中，所选择的日期和时间将通过所选择的格式进行显示。这里只使用时间的小时、分钟和秒部分。time
包定义了许多标准时间格式的模板，如
time.RFC1123。相反，当解析一个代表时间的字符串的时候使用相同的机制。

为了连接到服务器，需要一个像 nc(\"netcat\")
这样的程序，以及一个用来操作网络连接的标准工具：

\$ go build gopl.io/ch8/clockl\
\$ ./clock1 &\
\$ nc localhost 8000\
13:58:54\
13:58:55\
13:58:56\
13:58:57\
\^C

客户端显示每秒从服务器发送的时间，直到使用 Control+C 快捷键中断它，UNIX
系统 shell 上面回显为 \^C。如果系统上没有安装 nc 或 netcat，可以使用
telnet 或者一个使用 net.Dial 实现的 Go 版的 netcat 来连接 TCP 服务器：

// netcat1是一个只读的 TCP 客户端程序package mainimport ( \"io\" \"log\"
\"net\" \"os\")func main() { conn, err : = net.Dial(\"tcp\",
\"localhost:8000\") if err != nil { log.Fatal(err) } defer conn.Close()
mustCopy(os.Stdout, conn)}func mustCopy(dst io.Writer, src io.Reader) {
if \_, err := io.Copy(dst, src); err != nil { log.Fatal(err) }}

这个程序从网络连接中读取，然后写到标准输出，直到到达 EOF
或者岀错。mustCopy
函数是这一节的多个例子中使用的一个实用程序。在不同的终端上同时运行两个客户端，一个显示在左边，一个在右边：

\$ go build gopl.io/ch8/netcat1\
\$ ./netcat1                 \
13:58:54                        \$ ./netcat1\
13:58:55                    \
13:58:56                    \
\^C                          \
                                    13:58:57\
                                    13:58:58\
                                    13:58:59\
                                    \^C

\$ killall clock1

killall 命令是 UNIX 的一个实用程序，用来终止所有指定名字的进程。

第二个客户端必须等到第一个结束才能正常工作，因为服务器是顺序的，一次只能处理一个客户请求。让服务器支持并发只需要一个很小的改变：在调用
handleconn 的地方添加一个 go 关键字，使它在自己的 goroutine 内执行。

for { conn, err := listener.Accept() if err != nil { log.Print(err)
//例如，连接中止 continue } go handleConn(conn) // 并发处理连接}

现在，多个客户端可以同时接收到时间：

\$ go build gopl.io/ch8/clock2\
\$ ./clock2 &\
\$ go build gopl.io/ch8/netcat1\
\$ ./netcat1\
14:02:54                       \$ ./netcat1\
14:02:55                       14:02:55\
14:02:56                       14:02:56\
14:02:57                       \^C\
14:02:58                  \
14:02:59                       \$ ./netcat1\
14:03:00                       14:03:00\
14:03:01                       14:03:01\
\^C                                14:03:02\
                                     \^C\
\$ killall clock2

## 13.15Go语言router请求路由

在常见的 Web 框架中，router 是必备的组件。Go语言圈子里 router
也时常被称为 http 的
multiplexer。通过前面几节的学习，我们已经知道了如何用 http
标准库中内置的 mux 来完成简单的路由功能了。如果开发 Web
系统对路径中带参数没什么兴趣的话，用 http 标准库中的 mux 就可以。

RESTful 是几年前刮起的 API 设计风潮，在 RESTful 中除了 GET 和 POST
之外，还使用了 HTTP 协议定义的几种其它的标准化语义。具体包括：

const (\
    MethodGet = \"GET\"\
    MethodHead = \"HEAD\"\
    MethodPost = \"POST\"\
    MethodPut = \"PUT\"\
    MethodPatch = \"PATCH\" // RFC 5789\
    MethodDelete = \"DELETE\"\
    MethodConnect = \"CONNECT\"\
    MethodOptions = \"OPTIONS\"\
    MethodTrace = \"TRACE\"\
)

来看看 RESTful 中常见的请求路径：

GET /repos/:owner/:repo/comments/:id/reactions\
POST /projects/:project_id/columns\
PUT /user/starred/:owner/:repo\
DELETE /user/starred/:owner/:repo

相信聪明的你已经猜出来了，这是 Github 官方文档中挑出来的几个 API
设计。RESTful 风格的 API 重度依赖请求路径。会将很多参数放在请求 URL
中。除此之外还会使用很多并不那么常见的 HTTP
状态码，不过本节只讨论路由，所以先略过不谈。

如果我们的系统也想要这样的 URL 设计，使用标准库的 mux 显然就力不从心了。

### 13.15.1 httprouter

较流行的开源 go Web 框架大多使用 httprouter，或是基于 httprouter
的变种对路由进行支持。前面提到的 github 的参数式路由在 httprouter
中都是可以支持的。

因为 httprouter
中使用的是显式匹配，所以在设计路由的时候需要规避一些会导致路由冲突的情况，例如：

conflict:\
GET /user/info/:name\
GET /user/:id\
no conflict:\
GET /user/info/:name\
POST /user/:id

简单来讲的话，如果两个路由拥有一致的 http 方法（指
GET/POST/PUT/DELETE）和请求路径前缀，且在某个位置出现了 A 路由是
wildcard（指 :id 这种形式）参数，B
路由则是普通字符串，那么就会发生路由冲突。路由冲突会在初始化阶段直接
panic：

panic: wildcard route \':id\' conflicts with existing children in\
path \'/user/:id\'\
goroutine 1 \[running\]:\
github.com/cch123/httprouter.(\*node).insertChild(0xc4200801e0,
0xc42004fc01, 0x126b177, 0x3, 0x126b171, 0x9, 0x127b668)\
/Users/caochunhui/go_work/src/github.com/cch123/httprouter/tree.go:256
+0x841\
github.com/cch123/httprouter.(\*node).addRoute(0xc4200801e0, 0x126b171,
0x9, 0x127b668)\
/Users/caochunhui/go_work/src/github.com/cch123/httprouter/tree.go:221
+0x22a\
github.com/cch123/httprouter.(\*Router).Handle(0xc42004ff38, 0x126a39b,
0x3, 0x126b171, 0x9, 0x127b668)\
/Users/caochunhui/go_work/src/github.com/cch123/httprouter/router.go:262
+0xc3\
github.com/cch123/httprouter.(\*Router).GET(0xc42004ff38, 0x126b171,
0x9, 0x127b668)\
/Users/caochunhui/go_work/src/github.com/cch123/httprouter/router.go:193
+0x5e\
main.main()\
/Users/caochunhui/test/go_web/httprouter_learn2.go:18 +0xaf\
exit status 2

还有一点需要注意，因为 httprouter
考虑到字典树的深度，在初始化时会对参数的数量进行限制，所以在路由中的参数数目不能超过
255，否则会导致 httprouter
无法识别后续的参数。不过这一点上也不用考虑太多，毕竟 URL
是人设计且给人来看的，相信没有长得夸张的 URL 能在一条路径中带有 200
个以上的参数。

除支持路径中的 wildcard 参数之外，httprouter 还可以支持 \*
号来进行通配，不过 \* 号开头的参数只能放在路由的结尾，例如下面这样：

Pattern: /src/\*filepath

/src/                                 filepath = \"\"\
/src/somefile.go              filepath = \"somefile.go\"\
/src/subdir/somefile.go   filepath = \"subdir/somefile.go\"

这种设计在 RESTful 中可能不太常见，主要是为了能够使用 httprouter
来做简单的 HTTP 静态文件服务器。

除了正常情况下的路由支持，httprouter
也支持对一些特殊情况下的回调函数进行定制，例如 404 的时候：

r := httprouter.New()\
r.NotFound = http.HandlerFunc(func(w http.ResponseWriter, r
\*http.Request) {\
    w.Write(\[\]byte(\"oh no, not found\"))\
})

或者内部 panic 的时候：

r.PanicHandler = func(w http.ResponseWriter, r \*http.Request, c
interface{}) {\
    log.Printf(\"Recovering from panic, Reason: %#v\", c.(error))\
    w.WriteHeader(http.StatusInternalServerError)\
    w.Write(\[\]byte(c.(error).Error()))\
}

目前开源界最为流行的 Web 框架 gin 使用的就是 httprouter 的变种。

### 13.15.2原理

httprouter 和众多衍生 router 使用的数据结构被称为压缩字典树（Radix
Tree）。大家可能没有接触过压缩字典树，但对字典树（Trie
Tree）应该有所耳闻。下图是一个典型的字典树结构：

![IMG_256](media/image9.png){width="3.94375in"
height="5.208333333333333in"}\
图：字典树

字典树常用来进行字符串检索，例如用给定的字符串序列建立字典树。对于目标字符串，只要从根节点开始深度优先搜索，即可判断出该字符串是否曾经出现过，时间复杂度为
O(n) ，n 可以认为是目标字符串的长度。

为什么要这样做？字符串本身不像数值类型可以进行数值比较，两个字符串对比的时间复杂度取决于字符串长度。如果不用字典树来完成上述功能，要对历史字符串进行排序，再利用二分查找之类的算法去搜索，时间复杂度只高不低。可认为字典树是一种空间换时间的典型做法。

普通的字典树有一个比较明显的缺点，就是每个字母都需要建立一个孩子节点，这样会导致字典树的层数比较深，压缩字典树相对好地平衡了字典树的优点和缺点。下图是典型的压缩字典树结构：

![IMG_257](media/image10.png){width="5.208333333333333in"
height="3.4305555555555554in"}\
图：压缩字典树

每个节点上不只存储一个字母了，这也是压缩字典树中"压缩"的主要含义。使用压缩字典树可以减少树的层数，同时因为每个节点上数据存储也比通常的字典树要多，所以程序的局部性较好（一个节点的
path 加载到 cache 即可进行多个字符的对比），从而对 CPU 缓存友好。

### 13.15.3压缩字典树创建过程

我们来跟踪一下 httprouter
中，一个典型的压缩字典树的创建过程，路由设定如下：

PUT /user/installations/:installation_id/repositories/:repository_id\
GET /marketplace_listing/plans/\
GET /marketplace_listing/plans/:id/accounts\
GET /search\
GET /status\
GET /support

补充路由：

GET /marketplace_listing/plans/ohyes

最后一条补充路由是我们臆想的，除此之外所有 API
路由均来自于 api.github.com。

#### root 节点创建

httprouter 的 Router 结构体中存储压缩字典树使用的是下述数据结构：

// 略去了其它部分的 Router struct\
type Router struct {\
    // \...\
    trees map\[string\]\*node\
    // \...\
}

trees 中的 key 即为 HTTP 1.1 的 RFC 中定义的各种方法，具体有：

GET\
HEAD\
OPTIONS\
POST\
PUT\
PATCH\
DELETE

每一种方法对应的都是一棵独立的压缩字典树，这些树彼此之间不共享数据。具体到我们上面用到的路由，PUT
和 GET 是两棵树而非一棵。

简单来讲，某个方法第一次插入的路由就会导致对应字典树的根节点被创建，我们按顺序，先是一个
PUT：

r := httprouter.New()\
r.PUT(\"/user/installations/:installation_id/repositories/:reposit\",
Hello)

这样 PUT 对应的根节点就会被创建出来。把这棵 PUT 的树画出来：

![IMG_258](media/image11.png){width="5.625in" height="4.25in"}\
图：插入路由之后的压缩字典树

radix 的节点类型为 \*httprouter.node
，为了说明方便，我们留下了目前关心的几个字段：

-   path：当前节点对应的路径中的字符串

-   wildChild：子节点是否为参数节点，即 wildcard node，或者说 :id
    这种类型的节点

-   nType：当前节点类型，有四个枚举值: 分别为
    static/root/param/catchAll。

static // 非根节点的普通字符串节点\
root // 根节点\
param // 参数节点，例如 :id\
catchAll // 通配符节点，例如 \*anyway

-   indices：子节点索引，当子节点为非参数类型，即本节点的 wildChild 为
    false 时，会将每个子节点的首字母放在该索引数组。说是数组，实际上是个
    string。

当然，PUT 路由只有唯一的一条路径。接下来，我们以后续的多条 GET
路径为例，讲解子节点的插入过程。

#### 子节点插入

当插入 GET /marketplace_listing/plans 时，类似前面 PUT 的过程，GET
树的结构如下图所示：

![IMG_259](media/image12.png){width="2.9138888888888888in"
height="1.3305555555555555in"}\
图：插入第一个节点的压缩字典树

因为第一个路由没有参数，path 都被存储到根节点上了。所以只有一个节点。

然后插入 GET /marketplace_listing/plans/:id/accounts
，新的路径与之前的路径有共同的前缀，且可以直接在之前叶子节点后进行插入，那么结果也很简单，插入后的树结构如下图所示：

![IMG_260](media/image13.png){width="5.208333333333333in"
height="4.135416666666667in"}\
图：插入第二个节点的压缩字典树

由于 :id 这个节点只有一个字符串的普通子节点，所以 indices
还依然不需要处理。

上面这种情况比较简单，新的路由可以直接作为原路由的子节点进行插入。实际情况不会这么美好。

#### 边分裂

接下来我们插入 GET /search，这时会导致树的边分裂，如下图所示。

![IMG_261](media/image14.png){width="6.016666666666667in"
height="4.472916666666666in"}\
图：插入第三个节点，导致边分裂

原有路径和新的路径在初始的 / 位置发生分裂，这样需要把原有的 root
节点内容下移，再将新路由 search 同样作为子节点挂在 root
节点之下。这时候因为子节点出现多个，root 节点的 indices
提供子节点索引，这时候该字段就需要派上用场了。\"ms\"
代表子节点的首字母分别为 m(marketplace) 和 s(search)。

我们一鼓作气，把 GET /status 和 GET /support
也插入到树中。这时候会导致在 search 节点上再次发生分裂，最终结果见下图：

![IMG_262](media/image15.png){width="5.6506944444444445in"
height="3.178472222222222in"}\
图：插入所有路由后的压缩字典树

#### 子节点冲突处理

在路由本身只有字符串的情况下，不会发生任何冲突。只有当路由中含有
wildcard（类似 :id）或者 catchAll
的情况下才可能冲突。这一点在前面已经提到了。

子节点的冲突处理很简单，分几种情况：

1.  在插入 wildcard 节点时，父节点的 children 数组非空且 wildChild
    被设置为 false。例如：GET /user/getAll 和 GET
    /user/:id/getAddr，或者 GET /user/\*aaa 和 GET /user/:id 。

2.  在插入 wildcard 节点时，父节点的 children 数组非空且 wildChild
    被设置为 true，但该父节点的 wildcard 子节点要插入的 wildcard
    名字不一样。例如：GET /user/:id/info 和 GET /user/:name/info。

3.  在插入 catchAll 节点时，父节点的 children 非空。例如：GET /src/abc
    和 GET /src/\*filename，或者 GET /src/:id 和 GET /src/\*filename 。

4.  在插入 static 节点时，父节点的 wildChild 字段被设置为 true。

5.  在插入 static 节点时，父节点的 children 非空，且子节点 nType 为
    catchAll。

6.  只要发生冲突，都会在初始化的时候 panic。例如，在插入我们臆想的路由
    GET /marketplace_listing/plans/ohyes 时，出现第 4
    种冲突情况：它的父节点 marketplace_listing/plans/ 的 wildChild
    字段为 true。

## 13.16 ~~Go语言~~ middleware：Web中间件

本节将对现在流行的 Web 框架中的中间件 (middleware)
技术原理进行分析，并介绍如何使用中间件技术将业务和非业务代码功能进行解耦。

### 13.16.1为什么使用中间件

先来看一段代码：

// middleware/hello.gopackage mainfunc hello(wr http.ResponseWriter, r
\*http.Request) { wr.Write(\[\]byte(\"hello\"))}func main() {
http.HandleFunc(\"/\", hello) err := http.ListenAndServe(\":8080\", nil)
\...}

这是一个典型的 Web
服务，挂载了一个简单的路由。我们的线上服务一般也是从这样简单的服务开始逐渐拓展开去的。

现在突然来了一个新的需求，我们想要统计之前写的 hello
服务的处理耗时，需求很简单，我们对上面的程序进行少量修改：

// middleware/hello_with_time_elapse.govar logger = log.New(os.Stdout,
\"\", 0)func hello(wr http.ResponseWriter, r \*http.Request) { timeStart
:= time.Now() wr.Write(\[\]byte(\"hello\")) timeElapsed :=
time.Since(timeStart) logger.Println(timeElapsed)}

这样便可以在每次接收到 http 请求时，打印出当前请求所消耗的时间。

完成了这个需求之后，我们继续进行业务开发，提供的 API
逐渐增加，现在我们的路由看起来是这个样子：

// middleware/hello_with_more_routes.go// 省略了一些相同的代码package
mainfunc helloHandler(wr http.ResponseWriter, r \*http.Request) { //
\...}func showInfoHandler(wr http.ResponseWriter, r \*http.Request) { //
\...}func showEmailHandler(wr http.ResponseWriter, r \*http.Request) {
// \...}func showFriendsHandler(wr http.ResponseWriter, r
\*http.Request) { timeStart := time.Now() wr.Write(\[\]byte(\"your
friends is tom and alex\")) timeElapsed := time.Since(timeStart)
logger.Println(timeElapsed)}func main() { http.HandleFunc(\"/\",
helloHandler) http.HandleFunc(\"/info/show\", showInfoHandler)
http.HandleFunc(\"/email/show\", showEmailHandler)
http.HandleFunc(\"/friends/show\", showFriendsHandler) // \...}

每一个 handler
里都有之前提到的记录运行时间的代码，每次增加新的路由我们也同样需要把这些看起来长得差不多的代码拷贝到我们需要的地方去。因为代码不太多，所以实施起来也没有遇到什么大问题。

渐渐的我们的系统增加到了 30 个路由和 handler 函数，每次增加新的
handler，我们的第一件工作就是把之前写的所有和业务逻辑无关的周边代码先拷贝过来。

接下来系统安稳地运行了一段时间，突然有一天，老板找到你，我们最近找人新开发了监控系统，为了系统运行可以更加可控，需要把每个接口运行的耗时数据主动上报到我们的监控系统里。给监控系统起个名字吧，叫
metrics。现在需要修改代码并把耗时通过 HTTP Post 的方式发给 metrics
系统了。我们来修改一下 helloHandler()：

func helloHandler(wr http.ResponseWriter, r \*http.Request) { timeStart
:= time.Now() wr.Write(\[\]byte(\"hello\")) timeElapsed :=
time.Since(timeStart) logger.Println(timeElapsed) // 新增耗时上报
metrics.Upload(\"timeHandler\", timeElapsed)}

修改到这里，本能地发现我们的开发工作开始陷入了泥潭。无论未来对我们的这个
Web
系统有任何其它的非功能或统计需求，我们的修改必然牵一发而动全身。只要增加一个非常简单的非业务统计，我们就需要去几十个
handler
里增加这些业务无关的代码。虽然一开始我们似乎并没有做错，但是显然随着业务的发展，我们的行事方式让我们陷入了代码的泥潭。

### 13.16.2使用中间件剥离非业务逻辑

我们来分析一下，一开始在哪里做错了呢？我们只是一步一步地满足需求，把我们需要的逻辑按照流程写下去呀？

实际上，我们犯的最大的错误是把业务代码和非业务代码揉在了一起。对于大多数的场景来讲，非业务的需求都是在
http
请求处理前做一些事情，并且在响应完成之后做一些事情。我们有没有办法使用一些重构思路把这些公共的非业务功能代码剥离出去呢？

回到刚开头的例子，我们需要给我们的 helloHandler()
增加超时时间统计，我们可以使用一种叫 function adapter 的方法来对
helloHandler() 进行包装：

func hello(wr http.ResponseWriter, r \*http.Request) {
wr.Write(\[\]byte(\"hello\"))}func timeMiddleware(next http.Handler)
http.Handler { return http.HandlerFunc(func(wr http.ResponseWriter, r
\*http.Request) { timeStart := time.Now() // next handler
next.ServeHTTP(wr, r) timeElapsed := time.Since(timeStart)
logger.Println(timeElapsed) })}func main() { http.Handle(\"/\",
timeMiddleware(http.HandlerFunc(hello))) err :=
http.ListenAndServe(\":8080\", nil) \...}

这样就非常轻松地实现了业务与非业务之间的剥离，魔法就在于这个
timeMiddleware 。可以从代码中看到，我们的 timeMiddleware()
也是一个函数，其参数为 http.Handler，http.Handler 的定义在 net/http
包中：

type Handler interface {\
    ServeHTTP(ResponseWriter, \*Request)\
}

任何方法实现了 ServeHTTP ，即是一个合法的
http.Handler，读到这里大家可能会有一些混乱，我们先来梳理一下 http 库的
Handler，HandlerFunc 和 ServeHTTP 的关系：

type Handler interface { ServeHTTP(ResponseWriter, \*Request)}type
HandlerFunc func(ResponseWriter, \*Request)func (f HandlerFunc)
ServeHTTP(w ResponseWriter, r \*Request) { f(w, r)}

实际上只要你的 handler 函数签名是：

func (ResponseWriter, \*Request)

那么这个 handler 和 http.HandlerFunc() 就有了一致的函数签名，可以将该
handler() 函数进行类型转换，转为 http.HandlerFunc。

而 http.HandlerFunc 实现了 http.Handler 这个接口。在 http 库需要调用的
handler 函数来处理 http 请求时，会调用 HandlerFunc() 的 ServeHTTP()
函数，可见一个请求的基本调用链是这样的：

h = getHandler() =\> h.ServeHTTP(w, r) =\> h(w, r)

上面提到的把自定义 handler 转换为 http.HandlerFunc()
这个过程是必须的，因为我们的 handler 没有直接实现 ServeHTTP
这个接口。上面的代码中我们看到的 HandleFunc( 注意 HandlerFunc 和
HandleFunc 的区别 ) 里也可以看到这个强制转换过程：

func HandleFunc(pattern string, handler func(ResponseWriter, \*Request))
{ DefaultServeMux.HandleFunc(pattern, handler)}// 调用func (mux
\*ServeMux) HandleFunc(pattern string, handler func(ResponseWriter,
\*Request)) { mux.Handle(pattern, HandlerFunc(handler))}

知道 handler 是怎么一回事，我们的中间件通过包装 handler，再返回一个新的
handler 就好理解了。

总结一下，我们的中间件要做的事情就是通过一个或多个函数对 handler
进行包装，返回一个包括了各个中间件逻辑的函数链。我们把上面的包装再做得复杂一些：

customizedHandler = logger(timeout(ratelimit(helloHandler)))

这个函数链在执行过程中的上下文可以用下图来表示。

![IMG_256](media/image16.png){width="8.333333333333334in"
height="6.583333333333333in"}\
图：请求处理过程

再直白一些，这个流程在进行请求处理的时候实际上就是不断地进行函数压栈再出栈，有一些类似于递归的执行流：

\[exec of logger logic\]                函数栈: \[\]\
\[exec of timeout logic\]              函数栈: \[logger\]\
\[exec of ratelimit logic\]             函数栈: \[timeout/logger\]\
\[exec of helloHandler logic\]      函数栈:
\[ratelimit/timeout/logger\]\
\[exec of ratelimit logic part2\]    函数栈: \[timeout/logger\]\
\[exec of timeout logic part2\]     函数栈: \[logger\]\
\[exec of logger logic part2\]       函数栈: \[\]

功能实现了，但在上面的使用过程中我们也看到了，这种函数套函数的用法不是很美观，同时也不具备什么可读性。

### 13.16.3更优雅的中间件写法

前面的讲解中解决了业务功能代码和非业务功能代码的解耦，但也提到了，看起来并不美观，如果需要修改这些函数的顺序，或者增删中间件还是有点费劲，本节我们来进行一些"写法"上的优化。

看一个例子：

r = NewRouter()\
r.Use(logger)\
r.Use(timeout)\
r.Use(ratelimit)\
r.Add(\"/\", helloHandler)

通过多步设置，我们拥有了和上一节差不多的执行函数链。胜在直观易懂，如果我们要增加或者删除中间件，只要简单地增加删除对应的
Use() 调用就可以了。非常方便。

从框架的角度来讲，怎么实现这样的功能呢？也不复杂：

type middleware func(http.Handler) http.Handlertype Router struct {
middlewareChain \[\] middleware mux map\[string\] http.Handler}func
NewRouter() \*Router{ return &Router{}}func (r \*Router) Use(m
middleware) { r.middlewareChain = append(r.middlewareChain, m)}func (r
\*Router) Add(route string, h http.Handler) { var mergedHandler = h for
i := len(r.middlewareChain) - 1; i \>= 0; i\-- { mergedHandler =
r.middlewareChain\[i\](mergedHandler) } r.mux\[route\] = mergedHandler}

注意代码中的 middleware
数组遍历顺序，和用户希望的调用顺序应该是\"相反\"的。应该不难理解。

### 13.16.4哪些事情适合在中间件中做

以较流行的开源 Go语言框架 chi 为例：

compress.go\
    =\> 对 http 的响应体进行压缩处理\
heartbeat.go\
    =\> 设置一个特殊的路由，例如
/ping，/healthcheck，用来给负载均衡一类的前置服务进行探活\
logger.go\
    =\> 打印请求处理处理日志，例如请求处理时间，请求路由\
profiler.go\
    =\> 挂载 pprof 需要的路由，如 /pprof、/pprof/trace 到系统中\
realip.go\
    =\> 从请求头中读取 X-Forwarded-For 和 X-Real-IP，将 http.Request
中的 RemoteAddr 修改为得到的 RealIP\
requestid.go\
    =\> 为本次请求生成单独的
requestid，可一路透传，用来生成分布式调用链路，也可用于在日志中串连单次请求的所有逻辑\
timeout.go\
    =\> 用 context.Timeout 设置超时时间，并将其通过 http.Request
一路透传下去\
throttler.go\
    =\> 通过定长大小的 channel 存储 token，并通过这些 token
对接口进行限流

每一个 Web
框架都会有对应的中间件组件，如果大家有兴趣，也可以向这些项目贡献有用的中间件，只要合理一般项目的维护人也愿意合并你的
Pull Request。

比如开源界很火的 gin
这个框架，就专门为用户贡献的中间件开了一个仓库，如下图所示：

![IMG_257](media/image17.png){width="6.25in"
height="5.120138888888889in"}\
图：gin 的中间件仓库

如果大家去阅读 gin 的源码的话，可能会发现 gin 的中间件中处理的并不是
http.Handler ，而是一个叫 gin.HandlerFunc 的函数类型，和本节中讲解的
http.Handler 签名并不一样。不过实际上 gin 的 handler
也只是针对其框架的一种封装，中间件的原理与本节中的说明是一致的。

## 13.17 Go语言常见大型Web项目分层（MVC架构）

流行的 Web 框架大多数是 MVC 框架，MVC 这个概念最早由 Trygve Reenskaug 在
1978 年提出，为了能够对 GUI 类型的应用进行方便扩展，将程序划分为：

-   控制器（Controller）：负责转发请求，对请求进行处理。

-   视图（View）：界面设计人员进行图形界面设计。

-   模型（Model）：程序员编写程序应有的功能（实现算法等等）、数据库专家进行数据管理和数据库设计（可以实现具体的功能）。

随着时代的发展，前端也变成了越来越复杂的工程，为了更好地工程化，现在更为流行的一般是前后分离的架构。可以认为前后分离是把
V 层从 MVC 中抽离单独成为项目。这样一个后端项目一般就只剩下 M 和 C
层了。前后端之间通过 ajax
来交互，有时候要解决跨域的问题，但也已经有了较为成熟的方案。下图所示的是一个前后分离的系统的简易交互图。

![IMG_256](media/image18.png){width="5.511111111111111in"
height="2.5388888888888888in"}\
图：前后分离交互图

图里的 Vue 和 React
是现在前端界比较流行的两个框架，因为我们的重点不在这里，所以前端项目内的组织我们就不强调了。事实上，即使是简单的项目，业界也并没有完全遵守
MVC 框架提出者对于 M 和 C 所定义的分工。

有很多公司的项目会在 Controller 层塞入大量的逻辑，在 Model
层就只管理数据的存储。这往往来源于对于 model
层字面含义的某种擅自引申理解。认为字面意思，这一层就是处理某种建模，而模型是什么？就是数据呗！

这种理解显然是有问题的，业务流程也算是一种"模型"，是对真实世界用户行为或者既有流程的一种建模，并非只有按格式组织的数据才能叫模型。不过按照
MVC 的创始人的想法，我们如果把和数据打交道的代码还有业务流程全部塞进 MVC
里的 M 层的话，这个 M 层又会显得有些过于臃肿。

对于复杂的项目，一个 C 和一个 M 层显然是不够用的，现在比较流行的纯后端
API 模块一般采用下述划分方法：

1.  

Controller，与上述类似，服务入口，负责处理路由，参数校验，请求转发。

2.  
3.  

Logic/Service，逻辑（服务）层，一般是业务逻辑的入口，可以认为从这里开始，所有的请求参数一定是合法的。业务逻辑和业务流程也都在这一层中。常见的设计中会将该层称为
Business Rules。

4.  
5.  

DAO/Repository，这一层主要负责和数据、存储打交道。将下层存储以更简单的函数、接口形式暴露给
Logic 层来使用。负责数据的持久化工作。

6.  

每一层都会做好自己的工作，然后用请求当前的上下文构造下一层工作所需要的结构体或其它类型参数，然后调用下一层的函数。在工作完成之后，再把处理结果一层层地传出到入口，如下图所示。

![IMG_257](media/image19.png){width="5.042361111111111in"
height="2.1215277777777777in"}\
图：请求处理流程

划分为 CLD 三层之后，在 C 层之前我们可能还需要同时支持多种协议。thrift
、gRPC 和 http
并不是一定只选择其中一种，有时我们需要支持其中的两种，比如同一个接口，我们既需要效率较高的
thrift，也需要方便 debug 的 http 入口。

即除了 CLD 之外，还需要一个单独的 protocol
层，负责处理各种交互协议的细节。这样请求的流程会变成下图所示的样子。

![IMG_258](media/image20.png){width="3.1222222222222222in"
height="3.1069444444444443in"}\
图：多协议示意图

这样我们 Controller 中的入口函数就变成了下面这样：

func CreateOrder(ctx context.Context, req \*CreateOrderStruct) (\
    \*CreateOrderRespStruct, error,\
) {\
    // \...\
}

CreateOrder 有两个参数，ctx 用来传入 trace_id
一类的需要串联请求的全局参数，req
里存储了我们创建订单所需要的所有输入信息。返回结果是一个响应结构体和错误。可以认为，我们的代码运行到
Controller 层之后，就没有任何与"协议"相关的代码了。在这里你找不到
http.Request ，也找不到 http.ResponseWriter，也找不到任何与 thrift 或者
gRPC 相关的字眼。

在协议 (Protocol) 层，处理 http 协议的大概代码如下：

// 在协议层中定义type CreateOrderRequest struct { OrderID int64
\`json:\"order_id\"\` // \...}// 在控制器中定义type CreateOrderParams
struct { OrderID int64}func HTTPCreateOrderHandler(wr
http.ResponseWriter, r \*http.Request) { var req CreateOrderRequest var
params CreateOrderParams ctx := context.TODO() // 将数据绑定到 req
bind(r, &req) // 绑定到独立于协议的映射协议 map(req, params)
logicResp,err := controller.CreateOrder(ctx, &params) if err != nil {}
// \...}

理论上我们可以用同一个请求结构体组合上不同的
tag，来达到一个结构体来给不同的协议复用的目的。不过遗憾的是在 thrift
中，请求结构体也是通过 IDL 生成的，其内容在自动生成的 ttypes.go
文件中，我们还是需要在 thrift 的入口将这个自动生成的结构体映射到我们
logic 入口所需要的结构体上。gRPC 也是类似。这部分代码还是需要的。

大家可能已经可以看出来了，协议细节处理这一层实际上有大量重复劳动，每一个接口在协议这一层的处理，无非是把数据从协议特定的结构体（例如
http.Request，thrift
的被包装过了）读出来，再绑定到我们协议无关的结构体上，再把这个结构体映射到
Controller 入口的结构体上，这些代码实际上长得都差不多。

差不多的代码都遵循着某种模式，那么我们可以对这些模式进行简单的抽象，用代码生成的方式，把繁复的协议处理代码从工作内容中抽离出去。

先来看看 HTTP 对应的结构体、thrift
对应的结构体和我们协议无关的结构体分别长什么样子：

// http 请求结构体type CreateOrder struct { OrderID int64
\`json:\"order_id\" validate:\"required\"\` UserID int64
\`json:\"user_id\" validate:\"required\"\` ProductID int
\`json:\"prod_id\" validate:\"required\"\` Addr string \`json:\"addr\"
validate:\"required\"\`}// thrift 请求结构体type FeatureSetParams struct
{ DriverID int64 \`thrift:\"driverID,1,required\"\` OrderID int64
\`thrift:\"OrderID,2,required\"\` UserID int64
\`thrift:\"UserID,3,required\"\` ProductID int
\`thrift:\"ProductID,4,required\"\` Addr string
\`thrift:\"Addr,5,required\"\`}// controller input structtype
CreateOrderParams struct { OrderID int64 UserID int64 ProductID int Addr
string}

我们需要通过一个源结构体来生成我们需要的 HTTP 和 thrift
入口代码。再观察一下上面定义的三种结构体，实际上我们只要能用一个结构体生成
thrift 的 IDL，以及 HTTP 服务的"IDL（实际上就是带 json 或 form 相关 tag
的结构体定义）"就可以了。这个初始的结构体我们可以把结构体上的 HTTP 的
tag 和 thrift 的 tag 揉在一起：

type FeatureSetParams struct { DriverID int64
\`thrift:\"driverID,1,required\" json:\"driver_id\"\` OrderID int64
\`thrift:\"OrderID,2,required\" json:\"order_id\"\` UserID int64
\`thrift:\"UserID,3,required\" json:\"user_id\"\` ProductID int
\`thrift:\"ProductID,4,required\" json:\"prod_id\"\` Addr string
\`thrift:\"Addr,5,required\" json:\"addr\"\`}

然后通过代码生成把 thrift 的 IDL 和 HTTP
的请求结构体都生成出来，如下图所示

![IMG_259](media/image21.png){width="7.291666666666667in"
height="3.5381944444444446in"}\
图：通过 Go 代码定义结构体生成项目入口

至于用什么手段来生成，可以通过 Go语言内置的 Parser 读取文本文件中的 Go
源代码，然后根据 AST 来生成目标代码，也可以简单地把这个源结构体和
Generator 的代码放在一起编译，让结构体作为 Generator
的输入参数（这样会更简单一些），都是可以的。

当然这种思路并不是唯一选择，我们还可以通过解析 thrift 的 IDL，生成一套
HTTP 接口的结构体。如果你选择这么做，那整个流程就变成了下图所示。

![IMG_260](media/image22.png){width="8.333333333333334in"
height="2.375in"}\
图：也可以从 thrift 生成其它部分

看起来比之前的图顺畅一点，不过如果选择了这么做，就需要自行对 thrift 的
IDL 进行解析，也就是相当于可能要手写一个 thrift 的 IDL 的
Parser，虽然现在有 Antlr 或者 peg 能帮你简化这些 Parser
的书写工作，但在"解析"的这一步我们不希望引入太多的工作量，所以量力而行即可。

既然工作流已经成型，我们可以琢磨一下怎么让整个流程对用户更加友好。比如在前面的生成环境引入
Web 页面，只要让用户点点鼠标就能生成 SDK，这些就靠大家自己去探索了。

虽然我们成功地使自己的项目在入口支持了多种交互协议，但是还有一些问题没有解决。本节中所叙述的分层没有将中间件作为项目的分层考虑进去。如果我们考虑中间件的话，请求的流程是什么样的？见下图所示。

![IMG_261](media/image23.png){width="4.166666666666667in"
height="4.070833333333334in"}\
图：加入中间件后的控制流

之前我们学习的中间件是和 HTTP 协议强相关的，遗憾的是在 thrift
中看起来没有和 HTTP
中对等的解决这些非功能性逻辑代码重复问题的中间件。所以我们在图上写
thrift stuff 。这些 stuff 可能需要你手写去实现，然后每次增加一个新的
thrift 接口，就需要去写一遍这些非功能性代码。

这也是很多企业项目所面临的真实问题，遗憾的是开源界并没有这样方便的多协议中间件解决方案。当然了，前面我们也说过，很多时候我们给自己保留的
HTTP
接口只是用来做调试，并不会暴露给外人用。这种情况下，这些非功能性的代码只要在
thrift 的代码中完成即可。

## 13.18 Go语言Cookie的设置与读取

Web 开发中一个很重要的议题就是如何做好用户整个浏览过程的控制，因为 HTTP
协议是无状态的，所以用户的每一次请求都是无状态的，不知道在整个
Web 操作过程中哪些连接与该用户有关。应该如何来解决这个问题呢？Web
里面经典的解决方案是 Cookie 和 Session。

Cookie 机制是一种客户端机制，把用户数据保存在客户端，而 Session
机制是一种服务器端的机制，服务器使用一种类似于散列表的结构来保存信息，每一个网站访客都会被分配给一个唯一的标识符，即
sessionID。

sessionID 的存放形式无非两种：要么经过 URL 传递，要么保存在客户端的
Cookie 里。当然，也可以将 Session
保存到数据库里，这样会更安全，但效率方面会有所下降。本节主要介绍
Go语言使用 Cookie 的方法。

## 13.18.1设置 Cookie

Go语言中通过 net/http 包中的 SetCookie 来设置 Cookie：

http.SetCookie(w ResponseWriter, cookie \*Cookie)

w 表示需要写入的 response，cookie 是一个
struct，让我们来看看对象是怎样的：

type Cookie str、uct { Name string Value string Path string Domain
string Expires time.Time RawExpires string // MaxAge=0 意味着没有指定
Max-Age 的值 // MaxAge\<0 意味着现在就删除 Cookie，等价于 Max-Age=0 //
MaxAge\>0 意味着 Max-Age 属性存在并以秒为单位存在 MaxAge int Secure bool
HttpOnly bool Raw string Unparsed \[\]string // 未解析的 attribute-value
属性位对}

下面来看一个如何设置 Cookie 的例子：

expiration := time.Now()expiration := expiration.AddDate(1, 0, 0)cookie
:= http.Cookie{Name: \"username\", Value: \"zuolan\", Expires:
expiration}http.SetCookie(w, &Cookie)

## 13.18.2读取 Cookie

上面的例子演示了如何设置 Cookie 数据，这里演示如何读取 Cookie：

cookie, \_ := r.Cookie(\"username\")fmt.Fprint(w, cookie)

还有另外一种读取方式：

for \_, cookie := range r.Cookies() { fmt.Fprint(w, cookie.Name)}

可以看到通过 request 获取 Cookie 非常方便。

## 13.19 Go语言获取IP地址和域名解析

主机地址是网络通信最重要的数据之一，net
包中定义了三种类型的主机地址数据类型：IP、IPMask 和
IPAddr，它们分别用来存储协议相关的网络地址。

### 13.19.1 IP 地址类型

在 net 包中，IP 地址类型被定义成一个 byte 型数组，即若干个 8
位组，格式如下：

type IP \[\]byte

在 net 包中，有几个函数可以将 IP 地址类型作为函数的返回类型，比如
ParseIP() 函数，该函数原型定义如下：

func ParseIP(s string) IP

ParseIP() 函数的主要作用是分析 IP 地址的合法性，如果是一个合法的 IP
地址，ParseIP() 函数将返回一个 IP 地址对象。如果是一个非法 IP
地址，ParseIP() 函数将返回 nil。

还可以使用 IP 对象的 String() 方法将 IP 地址转换成字符串格式，String()
方法的原型定义如下：

func (ip IP) String() string

如果是 IPv4 地址，String() 方法将返回一个点分十进制格式的 IP
地址，如"192.168.0.1"。如果是 IPv6 地址，String()
方法将返回使用":"分隔的地址形式，如"2000:0:0:0:0:0:0:1"。另外注意一个特例，对于地址"0:0:0:0:0:0:0:1"的返回结果是省略格式"::1"。

【示例 1】IP 地址类型。

import( \"fmt\" \"net\" \"os\")func main() { if len(os.Args) != 2 {
fmt.Fprintf(os.Stderr, \"Usage: %s ip.addr\\n\", os.Args\[0\])
os.Exit(1) } addr := os.Args\[1\] ip := net.ParseIP(addr) if ip == nil {
fmt.Println(\"Invalid address\") } else { fmt.Println(\"The address
is\", ip.String()) } os.Exit(0)}

编译并运行该程序，测试过程如下：

从键盘输入：192.168.0.1\
输出结果为：The address is 192.168.0.1\
从键盘输入：192.168.0.256\
输出结果为：Inval id address\
从键盘输入：0:0:0:0:0:0:0:1\
输出结果为：::1

### 13.19.2IPMask 地址类型

在 Go语言中，为了方便子网掩码操作与计算，net 包中还提供了 IPMask
地址类型。在前面讲过，子网掩码地址其实就是一个特殊的 IP 地址，所以
IPMask 类型也是一个 byte 型数组，格式如下：

type IPMask \[\]byte

函数 IPv4Mask() 可以通过一个 32 位 IPv4
地址生成子网掩码地址，调用成功后返回一个 4
字节的十六进制子网掩码地址。IPv4Mask() 函数原型定义如下：

func IPv4Mask(a, b, c, d byte) IPMask

另外，还可以使用主机地址对象的 DefaultMask()
方法获取主机默认子网掩码地址，DefaultMask() 方法原型定义如下：

func (ip IP) DefaultMask() IPMask

要注意的是，只有 IPv4 地址才有默认子网掩码。如果不是 IPv4
地址，DefaultMask() 方法将返回 nil。不管是通过调用 IPv4Mask()
函数，还是执行 DefaultMask()
方法，获取的子网掩码地址都是十六进制格式的。例如，子网掩码地址"255.255.255.0"的十六进制格式是"ffffffOO"。

主机地址对象还有一个 Mask() 方法，执行 Mask() 方法后，会返回 IP
地址与子网掩码地址相"与"的结果，这个结果即是主机所处的网络的"网络地址"。Mask()
方法原型定义如下：

func (ip IP) Mask(mask IPMask) IP

还可以通过子网掩码对象的 Size() 方法获取掩码位数 (ones) 和掩码总长度
(bits)，如果是一个非标准的子网掩码地址，则 Size()
方法将返回"0,0"。Size() 方法的原型定义如下：

func (m IPMask) Size() (ones, bits int)

【示例 2】子网掩码地址。

// 子网掩码地址package mainimport( \"fmt\" \"net\" \"os\")func main() {
if len(os.Args) != 2 { fmt.Fprintf(os.Stderr, \"Usage: %s ip.addr\\n\",
os.Args\[0\]) os.Exit(1) } dotaddr := os.Args\[1\] addr :=
net.ParseIP(dotaddr) if addr == nil { fmt.Println(\"Invalid address\") }
mask := addr.DefaultMask() fmt.Println(\"Subnet mask is: \",
mask.String()) network := addr.Mask(mask) fmt.Println(\"Network address
is: \", network.String()) ones, bits := mask.Size() fmt.Println(\"Mask
bits: \", ones, \"Total bits: \", bits) os.Exit(0)}

编译并运行该程序，结果如下所示：

PS D:\\code\> go run .\\main.go 192.168.0.1\
                     Subnet mask is:  ffffff00\
                     Network address is:  192.168.0.0\
                     Mask bits:  24 Total bits:  32

### 13.19.3域名解析

在 net 包中，许多函数或方法调用后返回的是一个指向 IPAddr
结构体的指针，结构体 IPAddr 内只定义了一个 IP 类型的字段，格式如下：

type IPAddr struct {\
    IP IP\
)

IPAddr 结构体的主要作用是用于域名解析服务 (DNS)，例如，函数
ResolveIPAddr() 可以通过主机名解析主机网络地址。ResolveIPAddr()
函数原型定义如下：

func ResolveIPAddr(net, addr string) (\*IPAddr, error)

在调用 ResolveIPAddr() 函数时，参数 net
表示网络类型，可以是"ip"、"ip4"或"ip6"，参数 addr 可以是 IP
地址或域名，如果是 IPv6 地址则必须使用"\[\]"括起来。ResolveIPAddr()
函数调用成功后返回指向 IPAddr 结构体的指针，调用失败返回错误类型 error。

【示例 3】DNS 域名解析。

// DNS 域名解析package mainimport( \"fmt\" \"net\" \"os\")func main() {
if len(os.Args) != 2{ fmt.Fprintf(os.Stderr, \"Usage: %s hostname\\n\",
os.Args\[0\]) fmt.Println(\"Usage: \", os.Args\[0\], \"hostname\")
os.Exit(1) } name := os.Args\[1\] addr, err := net.ResolveIPAddr(\"ip\",
name) if err != nil { fmt.Println(\"Resolvtion error\", err.Error())
os.Exit(1) } fmt.Println(\"Resolved address is\", addr.String())
os.Exit(0)}

编译并运行该程序，结果如下所示：

PS D:\\code\> go run .\\main.go c.biancheng.net\
                     Resolved address is 61.240.154.117

## 13.20 Go语言TCP网络程序设计

TCP 工作在网络的传输层，它属于一种面向连接的可靠的通信协议。TCP
网络程序设计属于 C-S
模式，一般要设计一个服务器程序，一个或多个客户机程序。另外，TCP
是面向连接的通信协议，所以客户机要和服务器进行通信，首先要在通信双方之间建立通信连接。本节将详细讲解
TCP 网络编程服务器、客户机的设计原理和设计过程。

### 13.20.1 TCPAddr 地址结构体

在进行 TCP 网络编程时，服务器或客户机的地址使用 TCPAddr
地址结构体表示，TCPAddr 包含两个字段：IP 和 Port，形式如下：

type TCPAddr struct {\
    IP IP\
    Port int\
}

函数 ResolveTCPAddr() 可以把网络地址转换为 TCPAddr
地址结构，该函数原型定义如下：

func ResolveTCPAddr(net, addr string) (\*TCPAddr, error)

在调用函数 ResolveTCPAddr() 时，参数 net
是网络协议名，可以是"tcp"、"tcp4"或"tcp6"。参数 addr 是 IP
地址或域名，如果是 IPv6
地址则必须使用"\[\]"括起来。另外，端口号以":"的形式跟随在 IP
地址或域名的后而，端口是可选的。例如："www.google.com：80"或"127.0.0.1：21"。

还有一种特例，就是对于 HTTP 服务器，当主机地址为本地测试地址时
(127.0.0.1)，可以直接使用端口号作为 TCP 连接地址，形如":80"。

函数 ResolveTCPAddr() 调用成功后返回一个指向 TCPAddr
结构体的指针，否则返回一个错误类型。

另外，TCPAddr 地址对象还有两个方法：Network() 和 String()，Network()
方法用于返回 TCPAddr 地址对象的网络协议名，比如"tcp"；String()
方法可以将 TCPAddr 地址转换成字符串形式。这两个方法原型定义如下：

func (a \*TCPAddr) Network() string\
func (a \*TCPAddr) String() string

【示例 1】TCP 连接地址。

import( \"fmt\" \"net\" \"os\")func main() { if len(os.Args) != 3 {
fmt.Fprintf(os.Stderr, \"Usage: %s networkType addr\\n\", os.Args\[0\])
os.Exit(1) } networkType := os.Args\[1\] addr := os.Args\[2\] tcpAddr,
err := net.ResolveTCPAddr(networkType, addr) if err != nil {
fmt.Println(\"ResolveTCPAddr error: \", err.Error()) os.Exit(1) }
fmt.Println(\"The network type is: \", tcpAddr.Network())
fmt.Println(\"The IP address is: \", tcpAddr.String()) os.Exit(0)}

编译并运行该程序，测试过程如下：

PS D:\\code\> go run .\\main.go tcp c.biancheng.net:80\
                     The network type is:  tcp\
                     The IP address is:  61.240.154.115:80

### 13.20.2TCPConn 对象

在进行 TCP 网络编程时，客户机和服务器之间是通过 TCPConn
对象实现连接的，TCPConn 是 Conn 接口的实现。TCPConn
对象绑定了服务器的网络协议和地址信息，TCPConn 对象定义如下：

type TCPConn struct {\
    //空结构\
)

通过 TCPConn 连接对象，可以实现客户机和服务器间的全双工通信。可以通过
TCPConn 对象的 Read() 方法和 Write()
方法，在服务器和客户机之间发送和接收数据。Read() 方法和 Write()
方法的原型定义如下：

func (c \*TCPConn) Read(b \[\]byte) (n int, err error)\
func (c \*TCPConn) Write(b \[\]byte) (n int, err error)

Read()
方法调用成功后会返回接收到的字节数，调用失败返回一个错误类型；Write()
方法调用成功后会返回正确发送的字节数，调用失败返回一个错误类型。另外，这两个方法的执行都会引起阻塞。

### 13.20.3TCP 服务器设计

前面讲了 Go语言网络编程和传统 Socket 网络编程有所不同，TCP
服务器的工作过程如下：

1.  

TCP 服务器首先注册一个公知端口，然后调用 ListenTCP()
函数在这个端口上创建一个 TCPListener
监听对象，并在该对象上监听客户机的连接请求。

2.  
3.  

启用 TCPListener 对象的 Accept()
方法接收客户机的连接请求，并返回一个协议相关的 Conn 对象，这里就是
TCPConn 对象。

4.  
5.  

如果返回了一个新的 TCPConn 对象，服务器就可以调用该对象的 Read()
方法接收客户机发来的数据，或者调用 Write() 方法向客户机发送数据了。

6.  

TCPListener 对象、ListenTCP() 函数的原型定义如下：

type TCPListener struct {\
    //contains filtered or unexported fields\
}\
func ListenTCP(net string, laddr \*TCPAddr) (\*TCPListener, error)

在调用函数 ListenTCP() 时，参数 net
是网络协议名，可以是"tcp"、"tcp4"或"tcp6"。参数 laddr
是服务器本地地址，可以是任意活动的主机地址，或者是内部测试地址"127.0.0.1"。该函数调用成功，返回一个
TCPListener 对象；调用失败，返回一个错误类型。

TCPListener 对象的 Accept() 方法原型定义如下：

func (l \*TCPListener) Accept() (c Conn, err error)

Accept() 方法调用成功后，返回 TCPConn 对象；否则，返回一个错误类型。

服务器和客户机的通信连接建立成功后，就可以使用 Read() 和 Write()
方法收发数据。在通信过程中，如果还想获取通信双方的地址信息，可以使用
LocalAddr() 方法和 RemoteAddr() 方法来完成，这两个方法原型定义如下：

func (c \*TCPConn) LocalAddr() Addr\
func (c \*TCPConn) RemoteAddr() Addr

LocalAddr() 方法会返回本地主机地址，RemoteAddr() 方法返回远端主机地址。

【示例 2】TCP Server 端设计，服务器使用本地地址，服务端口号为
5000。服务器设计工作模式采用循环服务器，对每一个连接请求调用线程
handleClient 来处理。

// TCP Server 端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { service := \":5000\" tcpAddr, err :=
net.ResolveTCPAddr(\"tcp\", service) checkError(err) listener, err :=
net.ListenTCP(\"tcp\", tcpAddr) checkError(err) for { conn, err :=
listener.Accept() if err != nil { continue } handleClient(conn)
conn.Close() }}func handleClient(conn net.Conn) { var buf \[512\]byte
for { n, err := conn.Read(buf\[0:\]) if err != nil { return } rAddr :=
conn.RemoteAddr() fmt.Println(\"Receive from client\", rAddr.String(),
string(buf\[0:n\])) \_, err2 := conn.Write(\[\]byte(\"Welcome client\"))
if err2 != nil { return } }}func checkError(err error) { if err != nil {
fmt.Fprintf(os.Stderr, \"Fatal error %s\", err.Error()) os.Exit(1) }}

### 13.20.4TCP 客户机设计

在 TCP 网络编程中，客户机的工作过程如下：

1.  TCP 客户机在获取了服务器的服务端口号和服务地址之后，可以调用
    DialTCP() 函数向服务器发出连接请求，如果请求成功会返回 TCPConn
    对象。

2.  客户机调用 TCPConn 对象的 Read() 或 Write()
    方法，与服务器进行通信活动。

3.  通信完成后，客户机调用 Close() 方法关闭连接，断开通信链路。

DialTCP() 函数原型定义如下：

Func DialTCP(net string, laddr, raddr \*TCPAddr) (\*TCPConn, error)

在调用函数 DialTCP() 时，参数 net
是网络协议名，可以是"tcp"、"tcp4"或"tcp6"。参数 laddr
是本地主机地址，可以设为 nil。参数 raddr
是对方主机地址，必须指定不能省略。函数调用成功后，返回 TCPConn
对象；调用失败，返回一个错误类型。

方法 Close() 的原型定义如下：

func (c \*TCPConn) Close() error

该方法调用成功后，关闭 TCPConn 连接；调用失败，返回一个错误类型。

【示例 3】TCP Client 端设计，客户机通过内部测试地址"127.0.0.1"和端口
5000 和服务器建立通信连接。

// TCP Client端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { var buf \[512\]byte if len(os.Args) != 2 {
fmt.Fprintf(os.Stderr, \"Usage: %s host:port\", os.Args\[0\]) } service
:= os.Args\[1\] tcpAddr, err := net.ResolveTCPAddr(\"tcp\", service)
checkError(err) conn, err := net.DialTCP(\"tcp\", nil, tcpAddr)
checkError(err) rAddr := conn.RemoteAddr() n, err :=
conn.Write(\[\]byte(\"Hello server\")) checkError(err) n, err =
conn.Read(buf\[0:\]) checkError(err) fmt.Println(\"Reply form server\",
rAddr.String(), string(buf\[0:n\])) conn.Close() os.Exit(0)}func
checkError(err error) { if err != nil { fmt.Fprintf(os.Stderr, \"Fatal
error: %s\", err.Error()) os.Exit(1) }}

编译并运行服务器端和客户端，测试过程如下：

启动服务器：go run .\\main.go\
客户机连接：go run .\\client.go 127.0.0.1:5000\
服务器响应：Receive from client 127.0.0.1:50813 Hello server\
客户机接收：Reply form server 127.0.0.1:5000 Welcome client

从上述测试结果可以看出，服务器注册了一个公知端口
5000，而当客户机与服务器建立连接后，客户机会生成一个临时端口"50813"与服务器进行通信。服务器不管启动多少次端口号都是
5000，而客户机每一次重新启动端口号都不一样。

### 13.20.5 使用 Goroutine 实现并发服务器

前面的讲解中服务器设计采用循环服务器设计模式，这种服务器设计简单但缺陷明显。因为这种服务器一旦启动，就一直阻塞监听客户机的连接请求，直至服务器关闭。所以，循环服务器很耗费系统资源。

解决问题的方法是采用并发服务器模式，在这种模式中，对每一个客户机的连接请求，服务器都会创建一个新的进程、线程或者协程进行响应，而服务器还可以去处理其他任务。Goroutine
即协程是一种比线程更轻量级的任务单位，所以这里就使用 Goroutine
来实现并发服务器的设计。

【示例 4】并发服务器设计，服务器使用本地地址，服务端口号为
5000。服务器设计工作模式采用并发服务器模式，对每一个连接请求创建一个能调用
handleClient() 函数的 Goroutine 来处理。

纯文本复制

// TCP Server 端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { service := \":5000\" tcpAddr, err :=
net.ResolveTCPAddr(\"tcp\", service) checkError(err) listener, err :=
net.ListenTCP(\"tcp\", tcpAddr) checkError(err) for { conn, err :=
listener.Accept() if err != nil { continue } go handleClient(conn)
//创建 Goroutine }}func handleClient(conn net.Conn) { defer conn.Close()
//逆序调用 Close() 保证连接能正常关闭 var buf \[512\]byte for { n, err
:= conn.Read(buf\[0:\]) if err != nil { return } rAddr :=
conn.RemoteAddr() fmt.Println(\"Receive from client\", rAddr.String(),
string(buf\[0:n\])) \_, err2 := conn.Write(\[\]byte(\"Welcome client\"))
if err2 != nil { return } }}func checkError(err error) { if err != nil {
fmt.Fprintf(os.Stderr, \"Fatal error %s\", err.Error()) os.Exit(1) }}

编译并运行服务器端和客户端，测试过程如下、：

启动服务器：go run .\\main.go\
客户机连接：go run .\\client.go 127.0.0.1:5000\
服务器响应：Receive from client 127.0.0.1:51369 Hello server\
客户机接收：Reply form server 127.0.0.1:5000 Welcome client

通过测试可以发现，并发服务器可以同时响应多个客户机的连接请求，并能和多个客户机并发通信，尤其在多核心系统平台上，这种通信模式效率更高。而循环服务器只能按客户机的请求队列次序，一个一个地为客户机提供通信服务，通信效率低下。

## 13.21 Go语言UDP网络程序设计

UDP 和上一节《TCP网络程序设计》中的 TCP 一样，也工作在网络传输层，但和
TCP 不同的是，它提供不可靠的通信服务。UDP 网络编程也为 C-S
模式，要设计一个服务器，一个或多个客户机。

另外，UDP
是不保证可靠性的通信协议，所以客户机和服务器之间只要建立连接，就可以直接通信，而不用调用
Aceept() 进行连接确认。本节将详细讲解 UDP
网络编程服务器、客户机的设计原理和设计过程。

### 13.21.1 UDPAddr 地址结构体

在进行 UDP 网络编程时，服务器或客户机的地址使用 UDPAddr
地址结构体表示，UDPAddr 包含两个字段：IP 和 Port，形式如下：

type UDPAddr struct {\
    IP IP\
    Port int\
}

函数 ResolveUDPAddr() 可以把网络地址转换为 UDPAddr
地址结构，该函数原型定义如下：

func ResolveUDPAddr(net, addr string) (\*UDPAddr, error)

在调用函数 ResolveUDPAddr() 时，参数 net
是网络协议名，可以是"udp"、"udp4"或"udp6"。参数 addr 是 IP
地址或域名，如果是 IPv6
地址则必须使用"\[\]"括起来。另外，端口号以":"的形式跟随在 IP
地址或域名的后面，端口是可选的。

函数 ResolveUDPAddr() 调用成功后返回一个指向 UDPAddr
结构体的指针，否则返回一个错误类型。

另外，UDPAddr 地址对象还有两个方法：Network() 和 String()，Network()
方法用于返回 UDPAddr 地址对象的网络协议名，比如"udp"；String()
方法可以将 UDPAddr 地址转换成字符串形式。这两个方法原型定义如下：

func (a \*UDPAddr) Network() string\
func (a \*UDPAddr) String() string

### 13.21.2 UDPConn 对象

在进行 UDP 网络编程时，客户机和服务器之间是通过 UDPConn
对象实现连接的，UDPConn 是 Conn 接口的实现。UDPConn
对象绑定了服务器的网络协议和地址信息。UDPConn 对象定义如下：

type UDPConn struct {\
    //空结构\
}

通过 UDPConn 连接对象在客户机和服务器之间进行通信，UDP
并不能保证通信的可靠性和有序性，这些都要由程序员来处理。为此，TCPConn
对象提供了 ReadFromUDP() 方法和 WriteToUDP()
方法，这两个方法直接使用远端主机地址进行数据发送和接收，即便在链路失效的情况下，通信操作都能正常进行。

ReadFromUDP() 方法和 WriteToUDP() 方法的原型定义如下：

func (c \*UDPConn) ReadFromUDP(b \[\]byte) (n int, addr \*UDPAddr, err
error)\
func (c \*UDPConn) WriteToUDP(b \[\]byte, addr \*UDPAddr) (int, error)

ReadFromUDP()
方法调用成功后返回接收字节数和发送方地址，否则返回一个错误类型；WriteToUDP()
方法调用成功后返回发送字节数，否则返回一个错误类型。

### 13.21.3 UDP 服务器设计

在 UDP 网络编程中，服务器工作过程如下：

1.  

UDP 服务器首先注册一个公知端口，然后调用 ListenUDP()
函数在这个端口上创建一个 UDPConn
连接对象，并在该对象上和客户机建立不可靠连接。

2.  
3.  

如果服务器和某个客户机建立了 UDPConn 连接，就可以使用该对象的
ReadFromUDP() 方法和 WriteToUDP() 方法相互通信了。

4.  
5.  

不管上一次通信是否完成或正常，UDP 服务器依然会接受下一次连接请求。

6.  

函数 ListenUDP() 原型定义如下：

func ListenUDP(net sting, laddr \*UDPAddr) (\*UDPConn, error)

在调用函数 ListenUDP() 时，参数 net
是网络协议名，可以是"udp"、"udp4"或"udp6"。参数 laddr
是服务器本地地址，可以是任意活动的主机地址，或者是内部测试地址"127.0.0.1"。该函数调用成功，返回一个
UDPConn 对象；调用失败，返回一个错误类型。

【示例 1】UDP Server 端设计，服务器使用本地地址，服务端口号为
5001。服务器设计工作模式采用循环服务器，对每一个连接请求调用线程
handleClient 来处理。

//UDP Server 端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { service := \":5001\" udpAddr, err :=
net.ResolveUDPAddr(\"udp\", service) checkError(err) conn, err :=
net.ListenUDP(\"udp\", udpAddr) checkError(err) for { handleClient(conn)
}}func handleClient(conn \*net.UDPConn) { var buf \[512\]byte n, addr,
err := conn.ReadFromUDP(buf\[0:\]) if err != nil { return }
fmt.Println(\"Receive from client\", addr.String(), string(buf\[0:n\]))
conn.WriteToUDP(\[\]byte(\"Welcome Client!\"), addr)}func checkError(err
error) { if err != nil { fmt.Fprintf(os.Stderr, \"Fatal error: %s\",
err.Error()) os.Exit(1) }}

### 13.21.4 UDP 客户机设计

在 UDP 网络编程中，客户机工作过程如下：

1.  

UDP 客户机在获取了服务器的服务端口号和服务地址之后，可以调用 DialUDP()
函数向服务器发出连接请求，如果请求成功会返回 UDPConn 对象。

2.  
3.  

客户机可以直接调用 UDPConn 对象的 ReadFromUDP() 方法或 WriteToUDP()
方法，与服务器进行通信活动。

4.  
5.  

通信完成后，客户机调用 Close() 方法关闭 UDPConn 连接，断开通信链路。

6.  

函数 DialUDP() 原型定义如下：

func DialUDP(net string, laddr, raddr \*UDPAddr)(\*UDPConn, error)

在调用函数 DialUDP() 时，参数 net
是网络协议名，可以是"udp"、"udp4"或"udp6"。参数 laddr
是本地主机地址，可以设为 nil。参数 raddr
是对方主机地址，必须指定不能省略。函数调用成功后，返回 UDPConn
对象；调用失败，返回一个错误类型。

方法 Close() 的原型定义如下：

func (c \*UDPConn) Close() error

该方法调用成功后，关闭 UDPConn 连接；调用失败，返回一个错误类型。

【示例 2】UDP Client 端设计，客户机通过内部测试地址"127.0.0.1"和端口
5001 和服务器建立通信连接。

// UDP Client端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { if len(os.Args) != 2 { fmt.Fprintf(os.Stderr, \"Usage: %s
host:port\", os.Args\[0\]) } service := os.Args\[1\] udpAddr, err :=
net.ResolveUDPAddr(\"udp\", service) checkError(err) conn, err :=
net.DialUDP(\"udp\", nil, udpAddr) checkError(err) \_, err =
conn.Write(\[\]byte(\"Hello server!\")) checkError(err) var buf
\[512\]byte n, addr, err := conn.ReadFromUDP(buf\[0:\]) checkError(err)
fmt.Println(\"Reply form server\", addr.String(), string(buf\[0:n\]))
conn.Close() os.Exit(0)}func checkError(err error) { if err != nil {
fmt.Fprintf(os.Stderr, \"Fatal error: %s\", err.Error()) os.Exit(1) }}

编译并运行服务器端和客户端，测试过程如下：

启动服务器：go run .\\main.go\
客户机连接：go run .\\client.go 127.0.0.1:5001\
服务器响应：Receive from client 127.0.0.1:53825 Hello server!\
客户机接收：Reply form server 127.0.0.1:5001 Welcome Client!

通过测试结果会发现，采用 TCP
时必须先启动服务器，然后才能正常启动客户机，如果服务器中断，则客户机也会异常退出。而采用
UDP
时，客户机和服务器启动没有先后次序，而且即便是服务器异常退出，客户机也能正常工作。

总之，TCP
可以保证客户机、服务器双方按照可靠有序的方式进行通信，但通信效率低；而
UDP
虽然不能保证通信的可靠性，但通信效率要高得多，在有些场合还是非常有用的。

## 13.22 Go语言IP网络程序设计

IP 是 Internet
网络层的核心协议，它是一种不可靠的、无连接的通信协议。TCP、UDP 都是在 IP
的基础上实现的通信协议，所以 IP 属于一种底层协议，它可以直接对网络数据包
(Package) 进行处理。另外，通过 IP
用户还可以实现自己的网络服务协议。本节将详细讲解 IP
网络编程服务器、客户机的设计原理和设计过程。

### 13.22.1IPAddr 地址结构体

在进行 IP 网络编程时，服务器或客户机的地址使用 IPAddr
地址结构体表示，IPAddr 结构体只有一个字段 IP，形式如下：

type IPAddr struct {\
    IP IP\
}

通过了解 IPAddr 地址结构可以发现，IP
网络编程属于一种底层网络程序设计，它可以直接对 IP 包进行处理，所以
IPAddr 地址中没有端口地址，这个和 TCPAddr 地址结构、UDPAddr
地址结构都不同，在应用时要特别注意。

函数 ResolveIPAddr() 可以把网络地址转换为 IPAddr
地址结构，该函数原型定义如下：

func ResolveIPAddr(net, addr string) (\*IPAddr, error)

在调用 ResolveIPAddr() 函数时，参数 net
表示网络类型，可以是"ip"、"ip4"或"ip6"，参数 addr 是 IP
地址或域名，如果是 IPv6 地址则必须使用"\[\]"括起来。

函数 ResolveIPAddr() 调用成功后返回一个指向 IPAddr
结构体的指针，否则返回一个错误类型。

另外，IPAddr 地址对象还有两个方法：Network() 和 String()。Network()
方法用于返回 IPAddr 地址对象的网络协议名，比如"ip"；String() 方法可以将
IPAddr 地址转换成字符串形式。这两个方法原型定义如下：

func (a \*IPAddr) Network() string\
func (a \*IPAddr) String() string

### 13.22.2IPConn 对象

在进行 IP 网络编程时，客户机和服务器之间是通过 IPConn
对象实现连接的，IPConn 是 Conn 接口的实现。IPConn
对象绑定了服务器的网络协议和地址信息，IPConn 对象定义如下：

type IPConn struct {\
    //空结构\
}

由于 IPConn 是一个无连接的通信对象，所以 IPConn 对象提供了 ReadFromIP()
方法和 WriteToIP()
方法用于在客户机和服务器之间进行数据收发操作。ReadFromIP() 和
WriteToIP() 的原型定义如下：

func (c \*IPConn) ReadFromIP(b \[\]byte) (int, \*IPAddr, error)\
func (c \*IPConn) WriteToIP(b \[\]bytez addr \*IPAddr) (int, error)

ReadFromIP()
方法调用成功后返回接收字节数和发送方地址，否则返回一个错误类型；WriteToIP()
方法调用成功后返回发送字节数，否则返回一个错误类型。

### 13.22.3IP 服务器设计

由于工作在网络层，ip
服务器并不需要在一个指定的端口上和客户机进行通信连接，IP
服务器的工作过程如下：

1.  

IP 服务器使用指定的协议簇和协议，调用 ListenIP() 函数创建一个 IPConn
连接对象，并在该对象和客户机间建立不可靠连接。

2.  
3.  

如果服务器和某个客户机建立了 IPConn 连接，就可以使用该对象的
ReadFromIP() 方法和 WriteToIP() 方法相互通信了。

4.  
5.  

如果通信结束，服务器还可以调用 Close() 方法关闭 IPConn 连接。

6.  

函数 ListenIP() 原型定义如下：

func ListenIP(netProto string, laddr \*IPAddr) (\*IPConn, error)

在调用函数 ListenIP() 时，参数 netProto
是"网络类型+协议名"或"网络类型+协议号"，中间用":"隔开，比如"IP4:IP"或"IP4:4"。参数
laddr
是服务器本地地址，可以是任意活动的主机地址，或者是内部测试地址"127.0.0.1"。该函数调用成功，返回一个
IPConn 对象；调用失败，返回一个错误类型。

【示例 1】IP Server 端设计，服务器使用本地主机地址，调用 Hostname()
函数获取。服务器设计工作模式采用循环服务器，对每一个连接请求调用线程
handleClient 来处理。

// IP Server 端设计package mainimport( \"fmt\" \"net\" \"os\")func
main() { name, err := os.Hostname() checkError(err) ipAddr, err :=
net.ResolveIPAddr(\"ip4\", name) checkError(err) fmt.Println(ipAddr)
conn, err := net.ListenIP(\"ip4:ip\", ipAddr) checkError(err) for {
handleClient(conn) }}func handleClient(conn \*net.IPConn) { var buf
\[512\]byte n, addr, err := conn.ReadFromIP(buf\[0:\]) if err != nil {
return } fmt.Println(\"Receive from client\", addr.String(),
string(buf\[0:n\])) conn.WriteToIP(\[\]byte(\"Welcome Client!\"),
addr)}func checkError(err error) { if err != nil {
fmt.Fprintf(os.Stderr, \"Fatal error: %s\", err.Error()) os.Exit(1) }}

### 13.22.4IP 客户机设计

在 ip 网络编程中，客户机工作过程如下：

1.  

IP 客户机在获取了服务器的网络地址之后，可以调用 DialIP()
函数向服务器发出连接请求，如果请求成功会返回 IPConn 对象。

2.  
3.  

如果连接成功，客户机可以直接调用 IPConn 对象的 ReadFromIP() 方法或
WriteToIP() 方法，与服务器进行通信活动。

4.  
5.  

通信完成后，客户机调用 Close() 方法关闭 IPConn 连接，断开通信链路。

6.  

函数 DialIP() 原型定义如下：

func DialIP (netProto string, laddr, raddr \*IPAddr) (\*IPConn, error)

在调用函数 DialIP() 时，参数 netProto
是"网络类型+协议名"或"网络类型+协议号"，中间用":"隔开，比如"IP4:IP"或"IP4:4"。参数
laddr 是本地主机地址，可以设为 nil。参数 raddr
是对方主机地址，必须指定不能省略。函数调用成功后，返回 IPConn
对象；调用失败，返回一个错误类型。

方法 Close() 的原型定义如下：

func (c \*IPConn) Close() error

该方法调用成功后，关闭 IPConn 连接；调用失败，返回一个错误类型。

【示例 2】IP Client
端设计，客户机通过内部测试地址"127.0.0.1"和服务器建立通信连接，服务器主机地址可以使用
Hostname() 函数获取。

// IP Client端设计package mainimport( \"fmt\" \"net\" \"os\")func main()
{ if len(os.Args) != 2 { fmt.Fprintf(os.Stderr, \"Usage: %s host:port\",
os.Args\[0\]) } service := os.Args\[1\] lAddr, err :=
net.ResolveIPAddr(\"ip4\", service) checkError(err) name, err :=
os.Hostname() checkError(err) rAddr, err := net.ResolveIPAddr(\"ip4\",
name) checkError(err) conn, err := net.DialIP(\"ip4:ip\", lAddr, rAddr)
checkError(err) \_, err = conn.WriteToIP(\[\]byte(\"Hello Server!\"),
rAddr) checkError(err) var buf \[512\]byte n, addr, err :=
conn.ReadFromIP(buf\[0:\]) checkError(err) fmt.Println(\"Reply form
server\", addr.String(), string(buf\[0:n\])) conn.Close()
os.Exit(0)}func checkError(err error) { if err != nil {
fmt.Fprintf(os.Stderr, \"Fatal error: %s\", err.Error()) os.Exit(1) }}

编译并运行服务器端和客户端，测试过程如下：

启动服务器：go run .\\main.go\
客戶机连接：go run .\\client.go 127.0.0.1\
服务器响应：Receive from client 127.0.0.1 Hello Server!\
客户机接收：Reply form server 192.168.1.104 Welcome Client!

通过测试结果可以看出，TCP、UDP 的服务器和客户机通信时必须使用端口号，而
IP
服务器和客户机之间通信不需要端口号。另外，如果在同一台计算机上，服务器、客户机要使用不同的地址进行测试，比如本例服务器地址是"192.168.1.104"，客户机使用内部测试地址"127.0.0.1"。

如果使用相同的地址，会发生自发自收的现象，原因是 IP 是底层通信，并没有像
TCP、UDP 那样使用端口号来区分不同的通信进程。

### 13.22.5Ping 程序设计

不管是 UNIX 还是 Windows 系统中都有一个 Ping
命令，利用它可以检查网络是否连通，分析判断网络故障。Ping
会向目标主机发送测试数据包，看对方是否有响应并统计响应时间，以此测试网络。

Ping 命令的这些功能是使用 IP 层的 ICMP
实现的，在测试过程中，源主机向目标主机发送回显请求报文（ICMP_ECHO_REQUEST,type
= 8, code = 0），目的主机返回回显响应报文（ICMP_ECHO_REPLY,type = 0,
code = 0），相关的数据包格式如下图所示。

![IMG_256](media/image24.png){width="5.208333333333333in"
height="1.5972222222222223in"}\
图：ICMP 回显请求和响应数据包格式

其中，标识符是源主机的进程号，序列码用来标识发出回显请求的次序，时间戳表示数据包发出的时刻，通过比较回显响应时刻和源主机当前时刻的差值，可以测出
ICMP 数据包的往返时间。

【示例 3】使用原始套接字和 ICMP 设计 Ping 程序，函数 makePingRequest()
的功能是生成 ICMP 请求包，函数 parsePingReply()
用于解析目标主机发回的响应包，函数 elapsedTime() 的功能是计算 ICMP
数据包往返时间。

// Ping 程序package mainimport( \"bytes\" \"fmt\" \"net\" \"os\"
\"time\")const( ICMP_ECHO_REQUEST = 8 ICMP_ECHO_REPLY = 0)func main() {
if len(os.Args) != 2 { fmt.Fprintf(os.Stderr, \"Usage: %s host\",
os.Args\[0\]) os.Exit(1) } dst := os.Args\[1\] raddr, err :=
net.ResolveIPAddr(\"ip4\",dst) checkError(err) ipconn, err :=
net.DialIP(\"ip4:icmp\", nil, raddr) checkError(err) sendid :=
os.Getpid() & 0xfff sendseq := 1 pingpktlen := 64 for { sendpkt :=
makePingRequest(sendid, sendseq, pingpktlen, \[\]byte(\"\")) start :=
int64(time.Now().Nanosecond()) \_, err := ipconn.WriteToIP(sendpkt,
raddr) checkError(err) resp := make(\[\]byte, 1024) for { n, from, err
:= ipconn.ReadFrom(resp) checkError(err) fmt.Printf(\"%d bytes from %s:
icmp_req = %d time = %.2f ms\\n\", n, from, sendseq, elapsedTime(start))
if resp\[0\] != ICMP_ECHO_REPLY { continue } rcvid, rcvseq :=
parsePingReply(resp) if rcvid != sendid \|\| rcvseq != sendseq {
fmt.Printf(\"Ping reply saw id\", rcvid, rcvseq, sendid, sendseq) }
break } if sendseq == 4 { break } else { sendseq++ } time.Sleep(1e9)
}}func makePingRequest(id, seq, pktlen int, filler \[\]byte) \[\]byte {
p := make(\[\]byte, pktlen) copy(p\[8:\], bytes.Repeat(filler,(pktlen -
8)/len(filler) + 1)) p\[0\] = ICMP_ECHO_REQUEST // type p\[1\] = 0 //
cksum p\[2\] = 0 // cksum p\[3\] = 0 // id p\[4\] = uint8(id \>\> 8) //
id p\[5\] = uint8(id & 0xff) // id p\[6\] = uint8(seq \>\> 8) //
sequence p\[7\] = uint8(seq & 0xff) // sequence cklen := len(p) s :=
uint32(0) for i := 0; i \< (cklen - 1); i += 2 { s += uint32 (p\[i +
1\]) \<\< 8 \| uint32(p\[i\]) } if cklen & 1 == 1 { s +=
uint32(p\[cklen - 1\]) } s = (s \>\> 16) + (s & 0xffff) s = s + (s \>\>
16) p\[2\] \^= uint8(\^s & 0xff) p\[3\] \^= uint8(\^s \>\> 8) return
p}func parsePingReply(p \[\]byte) (id, seq int) { id = int(p\[4\]) \<\<
8 \| int(p\[5\]) seq = int(p\[6\]) \<\< 8 \| int(p\[7\]) return}func
elapsedTime(start int64) float32 { t :=
float32((int64(time.Now().Nanosecond()) - start) / 1000000.0) return
t}func checkError(err error) { if err != nil { fmt.Fprintf (os.Stderr,
\"Fatal error: %s\", err.Error()) os.Exit(1) } }

编译并运行Ping程序，测试结果如下：

Ping www.sina.com.cn\
64 bytes from 218.30.66.101: icmp_req = 1 time = 15 ms\
64 bytes from 218.30.66.101: icmp_req = 2 time = 12 ms\
64 bytes from 218.30.66.101: icmp_req = 3 time = 15 ms\
64 bytes from 218.30.66.101: icmp_req = 4 time = 15 ms\
Ping www.google.com.hk\
64 bytes from 125.76.239.243: icmp_req = 1 time = 31 ms\
64 bytes from 125.76.239.243: icmp_req = 2 time = 15 ms\
64 bytes from 125.76.239.243: icmp_req = 3 time = 23 ms\
64 bytes from 125.76.239.243: icmp_req = 4 time = 15 ms

## 13.23 Go语言是如何使得Web工作的

前面已经介绍了如何通过 Go语言搭建一个 Web 服务，我们可以看到简单应用一个
net/http 包就方便的搭建起来了。那么 Go语言在底层到底是怎么做的呢？

### 13.23.1 web 工作方式的几个概念

以下均是服务器端的几个概念

-   Request：用户请求的信息，用来解析用户的请求信息，包括
    post、get、cookie、url 等信息

-   Response：服务器需要反馈给客户端的信息

-   Conn：用户的每次请求链接

-   Handler：处理请求和生成返回信息的处理逻辑

### 13.23.2 分析 http 包运行机制

下图是 Go 实现 Web 服务的工作模式的流程图

![IMG_256](media/image25.png){width="6.25in"
height="4.7756944444444445in"}\
图：http 包执行流程

-   创建 Listen Socket，监听指定的端口，等待客户端请求到来。

-   Listen Socket 接受客户端的请求，得到 Client Socket，接下来通过
    Client Socket 与客户端通信。

-   处理客户端的请求, 首先从 Client Socket 读取 HTTP
    请求的协议头，如果是 POST
    方法，还可能要读取客户端提交的数据，然后交给相应的 handler
    处理请求，handler 处理完毕准备好客户端需要的数据，通过 Client Socket
    写给客户端。

这整个的过程里面我们只要了解清楚下面三个问题，也就知道 Go 是如何让 Web
运行起来了。

-   如何监听端口？

-   如何接收客户端请求？

-   如何分配 handler？

前面小节的代码里面我们可以看到，Go 是通过一个函数 ListenAndServe
来处理这些事情的，这个底层其实这样处理的：初始化一个 server
对象，然后调用了 net.Listen(\"tcp\", addr)，也就是底层用 TCP
协议搭建了一个服务，然后监控我们设置的端口。

下面代码来自 Go 的 http 包的源码，通过下面的代码我们可以看到整个的 http
处理过程：

func (srv \*Server) Serve(l net.Listener) error { defer l.Close() var
tempDelay time.Duration // how long to sleep on accept failure for { rw,
e := l.Accept() if e != nil { if ne, ok := e.(net.Error); ok &&
ne.Temporary() { if tempDelay == 0 { tempDelay = 5 \* time.Millisecond }
else { tempDelay \*= 2 } if max := 1 \* time.Second; tempDelay \> max {
tempDelay = max } log.Printf(\"http: Accept error: %v; retrying in %v\",
e, tempDelay) time.Sleep(tempDelay) continue } return e } tempDelay = 0
c, err := srv.newConn(rw) if err != nil { continue } go c.serve() }}

监控之后如何接收客户端的请求呢？上面代码执行监控端口之后，调用了
srv.Serve(net.Listener)
函数，这个函数就是处理接收客户端的请求信息。这个函数里面起了一个
for{}，首先通过 Listener 接收请求，其次创建一个 Conn，最后单独开了一个
goroutine，把这个请求的数据当做参数扔给这个 conn 去服务：go
c.serve()。这个就是高并发体现了，用户的每一次请求都是在一个新的
goroutine 去服务，相互不影响。

那么如何具体分配到相应的函数来处理请求呢？conn 首先会解析
request:c.readRequest()，然后获取相应的 handler:handler :=
c.server.Handler，也就是我们刚才在调用函数 ListenAndServe
时候的第二个参数，我们前面例子传递的是 nil，也就是为空，那么默认获取
handler = DefaultServeMux，那么这个变量用来做什么的呢？

这个变量就是一个路由器，它用来匹配 url 跳转到其相应的 handle
函数，那么这个我们有设置过吗？有，我们调用的代码里面第一句不是调用了
http.HandleFunc(\"/\", sayhelloName) 嘛。

这个作用就是注册了请求 / 的路由规则，当请求 uri 为
\"/\"，路由就会转到函数 sayhelloName，DefaultServeMux 会调用 ServeHTTP
方法，这个方法内部其实就是调用 sayhelloName 本身，最后通过写入 response
的信息反馈到客户端。

详细的整个流程如下图所示：

![IMG_257](media/image26.png){width="5.3590277777777775in"
height="5.098611111111111in"}\
图：一个 http 连接处理流程

至此我们的三个问题已经全部得到了解答，现在对于 Go 如何让 Web
跑起来的是否已经基本了解了呢？

## 13.24 Go语言session的创建和管理

前面《Cookie设置与读取》一节我们介绍了 Cookie 的应用，本节我们将讲解
session 的应用，我们知道 session
是在服务器端实现的一种用户和服务器之间认证的解决方案，目前
Go语言标准包没有为 session 提供任何支持，接下来我们将会自己动手来实现 go
版本的 session 管理和创建。

### 13.24.1 session 创建过程

session
的基本原理是由服务器为每个会话维护一份信息数据，客户端和服务端依靠一个全局唯一的标识来访问这份数据，以达到交互的目的。当用户访问
Web 应用时，服务端程序会随需要创建 session，这个过程可以概括为三个步骤：

-   生成全局唯一标识符（sessionid）；

-   开辟数据存储空间。一般会在内存中创建相应的数据结构，但这种情况下，系统一旦掉电，所有的会话数据就会丢失，如果是电子商务类网站，这将造成严重的后果。所以为了解决这类问题，可以将会话数据写到文件里或存储在数据库中，当然这样会增加
    I/O 开销，但是它可以实现某种程度的 session 持久化，也更有利于
    session 的共享；

-   将 session 的全局唯一标示符发送给客户端。

以上三个步骤中，最关键的是如何发送这个 session
的唯一标识这一步上。考虑到 HTTP
协议的定义，数据无非可以放到请求行、头域或 Body
里，所以一般来说会有两种常用的方式：cookie 和 URL 重写。

Cookie 服务端通过设置 Set-cookie 头就可以将 session
的标识符传送到客户端，而客户端此后的每一次请求都会带上这个标识符，另外一般包含
session 信息的 cookie 会将失效时间设置为 0（会话
cookie），即浏览器进程有效时间。至于浏览器怎么处理这个
0，每个浏览器都有自己的方案，但差别都不会太大（一般体现在新建浏览器窗口的时候）。

URL 重写，所谓 URL 重写，就是在返回给用户的页面里的所有的 URL 后面追加
session
标识符，这样用户在收到响应之后，无论点击响应页面里的哪个链接或提交表单，都会自动带上
session
标识符，从而就实现了会话的保持。虽然这种做法比较麻烦，但是，如果客户端禁用了
cookie 的话，此种方案将会是首选。

### 13.24.2 Go 实现 session 管理

通过上面 session 创建过程的讲解，大家应该对 session
有了一个大体的认识，但是具体到动态页面技术里面，又是怎么实现 session
的呢？下面我们将结合 session 的生命周期（lifecycle），来实现
Go语言版本的 session 管理。

#### session 管理设计

我们知道 session 管理涉及到如下几个因素

-   全局 session 管理器

-   保证 sessionid 的全局唯一性

-   为每个客户关联一个 session

-   session 的存储（可以存储到内存、文件、数据库等）

-   session 过期处理

接下来将讲解一下关于 session 管理的整个设计思路以及相应的 go 代码示例：

#### session 管理器

定义一个全局的 session 管理器

type Manager struct { cookieName string // private cookiename lock
sync.Mutex // protects session provider Provider maxLifeTime int64}func
NewManager(provideName, cookieName string, maxLifeTime int64)
(\*Manager, error) { provider, ok := provides\[provideName\] if !ok {
return nil, fmt.Errorf(\"session: unknown provide %q (forgotten
import?)\", provideName) } return &Manager{provider: provider,
cookieName: cookieName, maxLifeTime: maxLifeTime}, nil}

Go 实现整个的流程应该也是这样的，在 main 包中创建一个全局的 session
管理器。

var globalSessions \*session.Manager\
//然后在init函数中初始化\
func init() {\
    globalSessions, \_ = NewManager(\"memory\", \"gosessionid\", 3600)\
}

我们知道 session
是保存在服务器端的数据，它可以以任何的方式存储，比如存储在内存、数据库或者文件中。因此我们抽象出一个
Provider 接口，用以表征 session 管理器底层存储结构。

type Provider interface {\
    SessionInit(sid string) (Session, error)\
    SessionRead(sid string) (Session, error)\
    SessionDestroy(sid string) error\
    SessionGC(maxLifeTime int64)\
}

-   SessionInit 函数实现 session 的初始化，操作成功则返回此新的 session
    变量；

-   SessionRead 函数返回 sid 所代表的 session 变量，如果不存在，那么将以
    sid 为参数调用 SessionInit 函数创建并返回一个新的 session 变量；

-   SessionDestroy 函数用来销毁 sid 对应的 session 变量；

-   SessionGC 根据 maxLifeTime 来删除过期的数据

那么 session 接口需要实现什么样的功能呢？有过 Web 开发经验的读者知道，对
Session 的处理基本就设置值、读取值、删除值以及获取当前 sessionID
这四个操作，所以我们的 session 接口也就实现这四个操作。

type Session interface {\
    Set(key, value interface{}) error  // set session value\
    Get(key interface{}) interface{}   // get session value\
    Delete(key interface{}) error      // delete session value\
    SessionID() string                       // back current sessionID\
}

以上设计思路来源于 database/sql/driver，先定义好接口，然后具体的存储
session
的结构实现相应的接口并注册后，相应功能这样就可以使用了，以下是用来随需注册存储
session 的结构的 Register 函数的实现。

var provides = make(map\[string\]Provider)//register
通过提供的名称提供会话。//如果用相同的名称调用两次 register，或者如果
driver 为 nil，它会恐慌。func Register(name string, provider Provider) {
if provider == nil { panic(\"session: Register provider is nil\") } if
\_, dup := provides\[name\]; dup { panic(\"session: Register called
twice for provider \" + name) } provides\[name\] = provider}

#### 全局唯一的 session ID

session ID 是用来识别访问 Web
应用的每一个用户，因此必须保证它是全局唯一的（GUID），下面代码展示了如何满足这一需求：

func (manager \*Manager) sessionId() string { b := make(\[\]byte, 32) if
\_, err := rand.Read(b); err != nil { return \"\" } return
base64.URLEncoding.EncodeToString(b)}

#### session 创建

我们需要为每个来访用户分配或获取与他相关连的 session，以便后面根据
session 信息来验证操作。SessionStart 这个函数就是用来检测是否已经有某个
session 与当前来访用户发生了关联，如果没有则创建之。

func (manager \*Manager) SessionStart(w http.ResponseWriter, r
\*http.Request) (session Session) { manager.lock.Lock() defer
manager.lock.Unlock() cookie, err := r.Cookie(manager.cookieName) if err
!= nil \|\| cookie.Value == \"\" { sid := manager.sessionId() session,
\_ = manager.provider.SessionInit(sid) cookie := http.Cookie{Name:
manager.cookieName, Value: url.QueryEscape(sid), Path: \"/\", HttpOnly:
true, MaxAge: int(manager.maxLifeTime)} http.SetCookie(w, &cookie) }
else { sid, \_ := url.QueryUnescape(cookie.Value) session, \_ =
manager.provider.SessionRead(sid) } return}

我们用前面 login 操作来演示 session 的运用：

func login(w http.ResponseWriter, r \*http.Request) { sess :=
globalSessions.SessionStart(w, r) r.ParseForm() if r.Method == \"GET\" {
t, \_ := template.ParseFiles(\"login.gtpl\")
w.Header().Set(\"Content-Type\", \"text/html\") t.Execute(w,
sess.Get(\"username\")) } else { sess.Set(\"username\",
r.Form\[\"username\"\]) http.Redirect(w, r, \"/\", 302) }}

#### 操作值：设置、读取和删除

SessionStart 函数返回的是一个满足 session
接口的变量，那么我们该如何用他来对 session 数据进行操作呢？

上面的例子中的代码 session.Get(\"uid\")
已经展示了基本的读取数据的操作，现在我们再来看一下详细的操作：

func count(w http.ResponseWriter, r \*http.Request) { sess :=
globalSessions.SessionStart(w, r) createtime := sess.Get(\"createtime\")
if createtime == nil { sess.Set(\"createtime\", time.Now().Unix()) }
else if (createtime.(int64) + 360) \< (time.Now().Unix()) {
globalSessions.SessionDestroy(w, r) sess =
globalSessions.SessionStart(w, r) } ct := sess.Get(\"countnum\") if ct
== nil { sess.Set(\"countnum\", 1) } else { sess.Set(\"countnum\",
(ct.(int) + 1)) } t, \_ := template.ParseFiles(\"count.gtpl\")
w.Header().Set(\"Content-Type\", \"text/html\") t.Execute(w,
sess.Get(\"countnum\"))}

通过上面的例子可以看到，session 的操作和操作 key/value
数据库类似：Set、Get、Delete 等操作。

因为 session 有过期的概念，所以我们定义了 GC 操作，当访问过期时间满足 GC
的触发条件后将会引起 GC，但是当我们进行了任意一个 session 操作，都会对
session 实体进行更新，都会触发对最后访问时间的修改，这样当 GC
的时候就不会误删除还在使用的 session 实体。

#### session 重置

我们知道，Web
应用中有用户退出这个操作，那么当用户退出应用的时候，我们需要对该用户的
session 数据进行销毁操作，上面的代码已经演示了如何使用 session
重置操作，下面这个函数就是实现了这个功能：

//Destroy sessionidfunc (manager \*Manager) SessionDestroy(w
http.ResponseWriter, r \*http.Request){ cookie, err :=
r.Cookie(manager.cookieName) if err != nil \|\| cookie.Value == \"\" {
return } else { manager.lock.Lock() defer manager.lock.Unlock()
manager.provider.SessionDestroy(cookie.Value) expiration := time.Now()
cookie := http.Cookie{Name: manager.cookieName, Path: \"/\", HttpOnly:
true, Expires: expiration, MaxAge: -1} http.SetCookie(w, &cookie) }}

#### session 销毁

我们来看一下 session 管理器如何来管理销毁，只要我们在 Main
启动的时候启动：

func init() { go globalSessions.GC()}func (manager \*Manager) GC() {
manager.lock.Lock() defer manager.lock.Unlock()
manager.provider.SessionGC(manager.maxLifeTime)
time.AfterFunc(time.Duration(manager.maxLifeTime), func() { manager.GC()
})}

我们可以看到 GC 充分利用了 time 包中的定时器功能，当超时 maxLifeTime
之后调用 GC 函数，这样就可以保证 maxLifeTime 时间内的 session
都是可用的，类似的方案也可以用于统计在线用户数之类的。

至此 我们实现了一个用来在 Web 应用中全局管理 session 的
SessionManager，定义了用来提供 session 存储实现 Provider
的接口，接下来，我们将通过接口定义来实现一些 Provider，供大家参考学习。

### 13.24.3session 存储

上面我们介绍了 session 管理器的实现原理，定义了存储 session
的接口，接下来我们将示例一个基于内存的 session
存储接口的实现，其他的存储方式，大家可以自行参考示例来实现，内存的实现请看下面的例子代码。

package memoryimport ( \"container/list\" \"github.com/astaxie/session\"
\"sync\" \"time\")var pder = &Provider{list: list.New()}type
SessionStore struct { sid string //session id唯一标示 timeAccessed
time.Time //最后访问时间 value map\[interface{}\]interface{}
//session里面存储的值}func (st \*SessionStore) Set(key, value
interface{}) error { st.value\[key\] = value pder.SessionUpdate(st.sid)
return nil}func (st \*SessionStore) Get(key interface{}) interface{} {
pder.SessionUpdate(st.sid) if v, ok := st.value\[key\]; ok { return v }
else { return nil }}func (st \*SessionStore) Delete(key interface{})
error { delete(st.value, key) pder.SessionUpdate(st.sid) return nil}func
(st \*SessionStore) SessionID() string { return st.sid}type Provider
struct { lock sync.Mutex //用来锁 sessions map\[string\]\*list.Element
//用来存储在内存 list \*list.List //用来做gc}func (pder \*Provider)
SessionInit(sid string) (session.Session, error) { pder.lock.Lock()
defer pder.lock.Unlock() v := make(map\[interface{}\]interface{}, 0)
newsess := &SessionStore{sid: sid, timeAccessed: time.Now(), value: v}
element := pder.list.PushBack(newsess) pder.sessions\[sid\] = element
return newsess, nil}func (pder \*Provider) SessionRead(sid string)
(session.Session, error) { if element, ok := pder.sessions\[sid\]; ok {
return element.Value.(\*SessionStore), nil } else { sess, err :=
pder.SessionInit(sid) return sess, err } return nil, nil}func (pder
\*Provider) SessionDestroy(sid string) error { if element, ok :=
pder.sessions\[sid\]; ok { delete(pder.sessions, sid)
pder.list.Remove(element) return nil } return nil}func (pder \*Provider)
SessionGC(maxlifetime int64) { pder.lock.Lock() defer pder.lock.Unlock()
for { element := pder.list.Back() if element == nil { break } if
(element.Value.(\*SessionStore).timeAccessed.Unix() + maxlifetime) \<
time.Now().Unix() { pder.list.Remove(element) delete(pder.sessions,
element.Value.(\*SessionStore).sid) } else { break } }}func (pder
\*Provider) SessionUpdate(sid string) error { pder.lock.Lock() defer
pder.lock.Unlock() if element, ok := pder.sessions\[sid\]; ok {
element.Value.(\*SessionStore).timeAccessed = time.Now()
pder.list.MoveToFront(element) return nil } return nil}func init() {
pder.sessions = make(map\[string\]\*list.Element, 0)
session.Register(\"memory\", pder)}

上面这个代码实现了一个内存存储的 session 机制。通过 init 函数注册到
session
管理器中。这样就可以方便的调用了。我们如何来调用该引擎呢？请看下面的代码。

import (\
    \"github.com/astaxie/session\"\
    \_ \"github.com/astaxie/session/providers/memory\"\
)

当 import 的时候已经执行了 memory 函数里面的 init 函数，这样就已经注册到
session 管理器中，我们就可以使用了，通过如下方式就可以初始化一个 session
管理器：

var globalSessions \*session.Manager//然后在init函数中初始化func init()
{ globalSessions, \_ = session.NewManager(\"memory\", \"gosessionid\",
3600) go globalSessions.GC()}

### 13.24.4预防 session 劫持

session 劫持是一种广泛存在的比较严重的安全威胁，在 session
技术中，客户端和服务端通过 session
的标识符来维护会话，但这个标识符很容易就能被嗅探到，从而被其他人利用。它是中间人攻击的一种类型。

下面将通过一个实例来演示会话劫持，希望通过这个实例，能让大家更好地理解
session 的本质。

#### session 劫持过程

我们写了如下的代码来展示一个 count 计数器：

func count(w http.ResponseWriter, r \*http.Request) { sess :=
globalSessions.SessionStart(w, r) ct := sess.Get(\"countnum\") if ct ==
nil { sess.Set(\"countnum\", 1) } else { sess.Set(\"countnum\",
(ct.(int) + 1)) } t, \_ := template.ParseFiles(\"count.gtpl\")
w.Header().Set(\"Content-Type\", \"text/html\") t.Execute(w,
sess.Get(\"countnum\"))}

count.gtpl 的代码如下所示：

Hi. Now count:{{.}}

然后我们在浏览器里面刷新可以看到如下内容：

![IMG_256](media/image27.png){width="3.941666666666667in"
height="1.1944444444444444in"}\
图：浏览器端显示 count 数

随着刷新，数字将不断增长，当数字显示为 6 的时候，打开浏览器（以 chrome
为例）的 cookie 管理器，可以看到类似如下的信息：

![IMG_257](media/image28.png){width="6.25in"
height="4.102083333333334in"}\
图：获取浏览器端保存的 cookie

下面这个步骤最为关键：打开另一个浏览器（这里我们打开了 firefox
浏览器），复制 chrome 地址栏里的地址到新打开的浏览器的地址栏中。然后打开
firefox 的 cookie 模拟插件，新建一个 cookie，把按上图中 cookie
内容原样在 firefox 中重建一份：

![IMG_258](media/image29.png){width="4.75in"
height="3.6902777777777778in"}\
图：模拟 cookie

回车后，大家将看到如下内容：

![IMG_259](media/image30.png){width="3.7465277777777777in"
height="1.4034722222222222in"}\
图：劫持 session 成功

可以看到虽然换了浏览器，但是我们却获得了 sessionID，然后模拟了 cookie
存储的过程。这个例子是在同一台计算机上做的，不过即使换用两台来做，其结果仍然一样。此时如果交替点击两个浏览器里的链接你会发现它们其实操纵的是同一个计数器。

不必惊讶，此处 firefox 盗用了 chrome 和 goserver
之间的维持会话的钥匙，即 gosessionid，这是一种类型的"会话劫持"。在
goserver 看来，它从 http 请求中得到了一个 gosessionid，由于 HTTP
协议的无状态性，它无法得知这个 gosessionid 是从 chrome
那里"劫持"来的，它依然会去查找对应的 session，并执行相关计算。与此同时
chrome 也无法得知自己保持的会话已经被"劫持"。

### 13.24.5session 劫持防范

#### cookieonly 和 token

通过上面 session 劫持的简单演示可以了解到 session
一旦被其他人劫持，就非常危险，劫持者可以假装成被劫持者进行很多非法操作。那么如何有效的防止
session 劫持呢？

其中一个解决方案就是 sessionID 的值只允许 cookie 设置，而不是通过 URL
重置方式设置，同时设置 cookie 的 httponly 为
true，这个属性是设置是否可通过客户端脚本访问这个设置的
cookie，第一这个可以防止这个 cookie 被 XSS 读取从而引起 session
劫持，第二 cookie 设置不会像 URL 重置方式那么容易获取 sessionID。

第二步就是在每个请求里面加上 token，实现类似前面章节里面讲的防止 form
重复递交类似的功能，我们在每个请求里面加上一个隐藏的
token，然后每次验证这个 token，从而保证用户的请求都是唯一性。

h :=
md5.New()salt:=\"astaxie%\^7&8888\"io.WriteString(h,salt+time.Now().String())token:=fmt.Sprintf(\"%x\",h.Sum(nil))if
r.Form\[\"token\"\]!=token{ //提示登录}sess.Set(\"token\",token)

#### 间隔生成新的 SID

还有一个解决方案就是，我们给 session
额外设置一个创建时间的值，一旦过了一定的时间，我们销毁这个
sessionID，重新生成新的 session，这样可以一定程度上防止 session
劫持的问题。

createtime := sess.Get(\"createtime\")if createtime == nil {
sess.Set(\"createtime\", time.Now().Unix())} else if
(createtime.(int64) + 60) \< (time.Now().Unix()) {
globalSessions.SessionDestroy(w, r) sess =
globalSessions.SessionStart(w, r)}

session 启动后，我们设置了一个值，用于记录生成 sessionID
的时间。通过判断每次请求是否过期（这里设置了 60 秒）定期生成新的
ID，这样使得攻击者获取有效 sessionID 的机会大大降低。

上面两个手段的组合可以在实践中消除 session 劫持的风险，一方面，由于
sessionID 频繁改变，使攻击者难有机会获取有效的 sessionID；另一方面，因为
sessionID 只能在 cookie 中传递，然后设置了 httponly，所以基于 URL
攻击的可能性为零，同时被 XSS 获取 sessionID
也不可能。最后，由于我们还设置了 MaxAge=0，这样就相当于 session cookie
不会留在浏览器的历史记录里面。

## 13.25 Go语言Ratelimit服务流量限制

计算机程序可依据其瓶颈分为磁盘 IO 瓶颈型，CPU
计算瓶颈型，⽹络带宽瓶颈型，分布式场景下有时候也会外部系统⽽导致⾃身瓶颈。

Web
系统打交道最多的是⽹络，⽆论是接收，解析⽤户请求，访问存储，还是把响应数据返回给⽤户，都是要⾛⽹络的。在没有
epoll/kqueue 之类的系统提供的 IO
多路复⽤接⼝之前，多个核⼼的现代计算机最头痛的是 C10k 问题，C10k
问题会导致计算机没有办法充分利⽤ CPU
来处理更多的⽤户连接，进⽽没有办法通过优化程序提升CPU利⽤率来处理更多的请求。

⾃从Linux实现了 epoll，FreeBSD 实现了 kqueue
，这个问题基本解决了，我们可以借助内核提供的 API 轻松解决当年的 C10k
问题，也就是说如今如果你的程序主要是和⽹络打交道，那么瓶颈⼀定在⽤户程序⽽不在操作系统内核。

随着时代的发展，编程语⾔对这些系统调⽤⼜进⼀步进⾏了封装，如今做应⽤层开发，⼏乎不会在程序中看到
epoll 之类的字眼，⼤多数时候我们就只要聚焦在业务逻辑上就好。

Go语言的 net 库针对不同平台封装了不同的 syscall API，http 库⼜是构建在
net 库之上，所以在 Go语⾔中我们可以借助标准库，很轻松地写出⾼性能的 http
服务，下⾯是⼀个简单的 hello world 服务的代码：

package mainimport ( \"io\" \"log\" \"net/http\")func sayhello(wr
http.ResponseWriter, r \*http.Request) { wr.WriteHeader(200)
io.WriteString(wr, \"hello world\")}func main() { http.HandleFunc(\"/\",
sayhello) err := http.ListenAndServe(\":9090\", nil) if err != nil {
log.Fatal(\"ListenAndServe:\", err) }}

我们需要衡量⼀下这个 Web 服务的吞吐量，再具体⼀些，实际上就是接⼝的
QPS。借助 wrk，在家⽤电脑 Macbook Pro 上对这个 hello world
服务进⾏基准测试，Mac 的硬件情况如下：

CPU: Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz\
Core: 2\
Threads: 4\
Graphics/Displays:\
    Chipset Model: Intel Iris Graphics 6100\
        Resolution: 2560 x 1600 Retina\
    Memory Slots:\
        Size: 4 GB\
        Speed: 1867 MHz\
        Size: 4 GB\
        Speed: 1867 MHz\
    Storage:\
        Size: 250.14 GB (250,140,319,744 bytes)\
        Media Name: APPLE SSD SM0256G Media\
        Size: 250.14 GB (250,140,319,744 bytes)\
        Medium Type: SSD

测试结果：

\~ ❯❯❯ wrk -c 10 -d 10s -t10 http://localhost:9090\
Running 10s test @ http://localhost:9090\
    10 threads and 10 connections\
    Thread Stats Avg Stdev Max +/- Stdev\
        Latency 339.99us 1.28ms 44.43ms 98.29%\
        Req/Sec 4.49k 656.81 7.47k 73.36%\
    449588 requests in 10.10s, 54.88MB read\
Requests/sec: 44513.22\
Transfer/sec: 5.43MB

\~ ❯❯❯ wrk -c 10 -d 10s -t10 http://localhost:9090\
Running 10s test @ http://localhost:9090\
    10 threads and 10 connections\
    Thread Stats Avg Stdev Max +/- Stdev\
        Latency 334.76us 1.21ms 45.47ms 98.27%\
        Req/Sec 4.42k 633.62 6.90k 71.16%\
    443582 requests in 10.10s, 54.15MB read\
Requests/sec: 43911.68\
Transfer/sec: 5.36MB

\~ ❯❯❯ wrk -c 10 -d 10s -t10 http://localhost:9090\
Running 10s test @ http://localhost:9090\
    10 threads and 10 connections\
    Thread Stats Avg Stdev Max +/- Stdev\
        Latency 379.26us 1.34ms 44.28ms 97.62%\
        Req/Sec 4.55k 591.64 8.20k 76.37%\
    455710 requests in 10.10s, 55.63MB read\
Requests/sec: 45118.57\
Transfer/sec: 5.51MB

多次测试的结果在 4 万左右的 QPS 浮动，响应时间最多也就是 40ms
左右，对于⼀个 Web
程序来说，这已经是很不错的成绩了，我们只是照抄了别⼈的示例代码，就完成了⼀个⾼性能的
hello world 服务器，是不是很有成就感？

这还只是家⽤ PC，线上服务器⼤多都是 24 核⼼起，32G 内存 +，CPU 基本都是
Intel i7。所以同样的程序在服务器上运⾏会得到更好的结果。

这⾥的 hello world
服务没有任何业务逻辑。真实环境的程序要复杂得多，有些程序偏⽹络 IO
瓶颈，例如⼀些 CDN 服务、Proxy 服务；有些程序偏 CPU/GPU
瓶颈，例如登陆校验服务、图像处理服务；有些程序瓶颈偏磁盘，例如专⻔的存储系统，数据库。

不同的程序瓶颈会体现在不同的地⽅，这⾥提到的这些功能单⼀的服务相对来说还算容易分析。如果碰到业务逻辑复杂代码量巨⼤的模块，其瓶颈并不是三下五除⼆可以推测出来的，还是需要从压⼒测试中得到更为精确的结论。

对于 IO/Network 瓶颈类的程序，其表现是⽹卡 / 磁盘 IO 会先于 CPU
打满，这种情况即使优化 CPU
的使⽤也不能提⾼整个系统的吞吐量，只能提⾼磁盘的读写速度，增加内存⼤⼩，提升⽹卡的带宽来提升整体性能。

⽽ CPU 瓶颈类的程序，则是在存储和⽹卡未打满之前 CPU 占⽤率提前到达
100%，CPU 忙于各种计算任务，IO 设备相对则较闲。

⽆论哪种类型的服务，在资源使⽤到极限的时候都会导致请求堆积，超时，系统
hang 死，最终伤害到终端⽤户。对于分布式的 Web
服务来说，瓶颈还不⼀定总在系统内部，也有可能在外部。

⾮计算密集型的系统往往会在关系型数据库环节失守，⽽这时候 Web
模块本身还远远未达到瓶颈。不管我们的服务瓶颈在哪⾥，最终要做的事情都是⼀样的，那就是流量限制。

### 13.25.1常⻅的流量限制⼿段

流量限制的⼿段有很多，最常⻅的：漏桶、令牌桶两种：

-   漏桶是指我们有⼀个⼀直装满了⽔的桶，每过固定的⼀段时间即向外漏⼀滴⽔。如果你接到了这滴⽔，那么你就可以继续服务请求，如果没有接到，那么就需要等待下⼀滴⽔。

-   令牌桶则是指匀速向桶中添加令牌，服务请求时需要从桶中获取令牌，令牌的数⽬可以按照需要消耗的资源进⾏相应的调整。如果没有令牌，可以选择等待，或者放弃。

这两种⽅法看起来很像，不过还是有区别的。漏桶流出的速率固定，⽽令牌桶只要在桶中有令牌，那就可以拿。也就是说令牌桶是允许⼀定程度的并发的，⽐如同⼀个时刻，有
100 个⽤户请求，只要令牌桶中有 100 个令牌，那么这 100
个请求全都会放过去。令牌桶在桶中没有令牌的情况下也会退化为漏桶模型。

![IMG_256](media/image31.png){width="5.2243055555555555in"
height="3.19375in"}\
图：令牌桶

实际应⽤中令牌桶应⽤较为⼴泛，开源界流⾏的限流器⼤多数都是基于令牌桶思想的。并且在此基础上进⾏了⼀定程度的扩充，⽐如 github.com/juju/ratelimit 提供了⼏种不同特⾊的令牌桶填充⽅式：

func NewBucket(fillInterval time.Duration, capacity int64) \*Bucket

默认的令牌桶，fillInterval 指每过多⻓时间向桶⾥放⼀个令牌，capacity
是桶的容量，超过桶容量的部分会被直接丢弃。桶初始是满的。

func NewBucketWithQuantum(fillInterval time.Duration, capacity, quantum
int64) \*Bucket

和普通的 NewBucket() 的区别是，每次向桶中放令牌时，是放 quantum
个令牌，⽽不是⼀个令牌。

func NewBucketWithRate(rate float64, capacity int64) \*Bucket

这个就有点特殊了，会按照提供的⽐例，每秒钟填充令牌数。例如 capacity 是
100，⽽ rate 是 0.1，那么每秒会填充 10 个令牌。

从桶中获取令牌也提供了⼏个 API：

func (tb \*Bucket) Take(count int64) time.Duration {}\
func (tb \*Bucket) TakeAvailable(count int64) int64 {}\
func (tb \*Bucket) TakeMaxDuration(count int64, maxWait time.Duration)
(\
    time.Duration, bool,\
) {}\
func (tb \*Bucket) Wait(count int64) {}\
func (tb \*Bucket) WaitMaxDuration(count int64, maxWait time.Duration)
bool {}

名称和功能都⽐较直观，这⾥就不再赘述了。相⽐于开源界更为有名的 Google
的Java⼯具库 Guava 中提供的
ratelimiter，这个库不⽀持令牌桶预热，且⽆法修改初始的令牌容量，所以可能个别极端情况下的需求⽆法满⾜。

但在明⽩令牌桶的基本原理之后，如果没办法满⾜需求，相信大家也可以很快对其进⾏修改并⽀持⾃⼰的业务场景。

### 13.25.2原理

从功能上来看，令牌桶模型实际上就是对全局计数的加减法操作过程，但使⽤计数需要我们⾃⼰加读写锁，有⼩⼩的思想负担。如果我们对
Go语⾔已经⽐较熟悉的话，很容易想到可以⽤ buffered channel
来完成简单的加令牌取令牌操作：

var tokenBucket = make(chan struct{}, capacity)

每过⼀段时间向 tokenBucket 中添加 token，如果 bucket
已经满了，那么直接放弃：

fillToken := func() {\
    ticker := time.NewTicker(fillInterval)\
    for {\
        select {\
            case \<-ticker.C:\
                select {\
                    case tokenBucket \<- struct{}{}:\
                    default:\
                }\
                fmt.Println(\"current token cnt:\", len(tokenBucket),
time.Now())\
        }\
    }\
}

把代码组合起来：

package mainimport ( \"fmt\" \"time\")func main() { var fillInterval =
time.Millisecond \* 10 var capacity = 100 var tokenBucket = make(chan
struct{}, capacity) fillToken := func() { ticker :=
time.NewTicker(fillInterval) for { select { case \<-ticker.C: select {
case tokenBucket \<- struct{}{}: default: } fmt.Println(\"current token
cnt:\", len(tokenBucket), time.Now()) } } } go fillToken()
time.Sleep(time.Hour)}

看看运⾏结果：

current token cnt: 98 2019-08-30 17:34:31.44304 +0800 CST
m=+1.007173201\
current token cnt: 99 2019-08-30 17:34:31.4530154 +0800 CST
m=+1.017148601\
current token cnt: 100 2019-08-30 17:34:31.462987 +0800 CST
m=+1.027120201\
current token cnt: 100 2019-08-30 17:34:31.4729601 +0800 CST
m=+1.037093301\
current token cnt: 100 2019-08-30 17:34:31.4829352 +0800 CST
m=+1.047068401\
current token cnt: 100 2019-08-30 17:34:31.4939354 +0800 CST
m=+1.058068601\
current token cnt: 100 2019-08-30 17:34:31.5028803 +0800 CST
m=+1.067013501\
current token cnt: 100 2019-08-30 17:34:31.5128549 +0800 CST
m=+1.076988101\
current token cnt: 100 2019-08-30 17:34:31.5248539 +0800 CST
m=+1.088987101\
current token cnt: 100 2019-08-30 17:34:31.5348291 +0800 CST
m=+1.098962301\
current token cnt: 100 2019-08-30 17:34:31.5437705 +0800 CST
m=+1.107903701\
current token cnt: 100 2019-08-30 17:34:31.5537455 +0800 CST
m=+1.117878701

在 1s 钟的时候刚好填满 100 个，没有太⼤的偏差。不过这⾥可以看到，Go
的定时器存在⼤约 0.001s 的误差，所以如果令牌桶⼤⼩在 1000
以上的填充可能会有⼀定的误差。对于⼀般的服务来说，这⼀点误差⽆关紧要。

上⾯的令牌桶的取令牌操作实现起来也⽐较简单，简化问题，我们这⾥只取⼀个令牌：

func TakeAvailable(block bool) bool{\
    var takenResult bool\
    if block {\
        select {\
        case \<-tokenBucket:\
            takenResult = true\
        }\
    } else {\
        select {\
        case \<-tokenBucket:\
            takenResult = true\
        default:\
            takenResult = false\
        }\
    }\
    return takenResult\
}

⼀些公司⾃⼰造的限流的轮⼦就是⽤上⾯这种⽅式来实现的，不过如果开源版
ratelimit 也如此的话，那我们也没什么可说的了。现实并不是这样的。

我们来思考⼀下，令牌桶每隔⼀段固定的时间向桶中放令牌，如果我们记下上⼀次放令牌的时间为
t1，和当时的令牌数 k1，放令牌的时间间隔为 ti，每次向令牌桶中放 x
个令牌，令牌桶容量为 cap。现在如果有⼈来调⽤ TakeAvailable 来取 n
个令牌，我们将这个时刻记为 t2。在 t2
时刻，令牌桶中理论上应该有多少令牌呢？伪代码如下：

cur = k1 + ((t2 - t1)/ti) \* x\
cur = cur \> cap ? cap : cur

我们⽤两个时间点的时间差，再结合其它的参数，理论上在取令牌之前就完全可以知道桶⾥有多少令牌了。那劳⼼费⼒地像本⼩节前⾯向
channel ⾥填充 token 的操作，理论上是没有必要的。

只要在每次 Take 的时候，再对令牌桶中的 token
数进⾏简单计算，就可以得到正确的令牌数。是不是很像惰性求值的感觉？

在得到正确的令牌数之后，再进⾏实际的 Take 操作就好，这个 Take
操作只需要对令牌数进⾏简单的减法即可，记得加锁以保证并发安全。github.com/juju/ratelimit 这个库就是这样做的。

### 13.25.3服务瓶颈和 QoS

前⾯我们说了很多 CPU 瓶颈、IO
瓶颈之类的概念，这种性能瓶颈从⼤多数公司都有的监控系统中可以⽐较快速地定位出来，如果⼀个系统遇到了性能问题，那监控图的反应⼀般都是最快的。

虽然性能指标很重要，但对⽤户提供服务时还应考虑服务整体的 QoS。QoS 全称是
Quality of Service，顾名思义是服务质量。QoS
包含有可⽤性、吞吐量、时延、时延变化和丢失等指标。⼀般来讲我们可以通过优化系统，来提⾼
Web 服务的 CPU
利⽤率，从⽽提⾼整个系统的吞吐量。但吞吐量提⾼的同时，⽤户体验是有可能变差的。

⽤户⻆度⽐较敏感的除了可⽤性之外，还有时延。虽然你的系统吞吐量⾼，但半天刷不开⻚⾯，想必会造成⼤量的⽤户流失。所以在⼤公司的Web服务性能指标中，除了平均响应时延之外，还会把响应时间的
95 分位，99 分位也拿出来作为性能标准。

平均响应在提⾼ CPU 利⽤率没受到太⼤影响时，可能 95 分位、99
分位的响应时间⼤幅度攀升了，那么这时候就要考虑提⾼这些 CPU
利⽤率所付出的代价是否值得了。在线系统的机器⼀般都会保持 CPU
有⼀定的余裕。

## 13.26 Go语言WEB框架(Gin)详解

在 Go语言开发的 Web 框架中，有两款著名 Web 框架分别是 Martini 和
Gin，两款 Web 框架相比较的话，Gin 自己说它比 Martini 要强很多。

Gin 是 Go语言写的一个 web
框架，它具有运行速度快，分组的路由器，良好的崩溃捕获和错误处理，非常好的支持中间件和
json。总之在 Go语言开发领域是一款值得好好研究的 Web
框架，开源网址：https://github.com/gin-gonic/gin

首先下载安装 gin 包：

go get -u github.com/gin-gonic/gin

一个简单的例子：

package mainimport \"github.com/gin-gonic/gin\"func main() {
//Default返回一个默认的路由引擎 r := gin.Default() r.GET(\"/ping\",
func(c \*gin.Context) { //输出json结果给调用方 c.JSON(200, gin.H{
\"message\": \"pong\", }) }) r.Run() // listen and serve on
0.0.0.0:8080}

编译运行程序，打开浏览器，访问http://localhost:8080/ping页面显示：

{\"message\":\"pong\"}

gin 的功能不只是简单输出 Json 数据。它是一个轻量级的 WEB 框架，支持
RestFull 风格 API，支持 GET，POST，PUT，PATCH，DELETE，OPTIONS 等 http
方法，支持文件上传，分组路由，Multipart/Urlencoded FORM，以及支持
JsonP，参数处理等等功能，这些都和 WEB
紧密相关，通过提供这些功能，使开发人员更方便地处理 WEB 业务。

### 13.26.1 Gin 实际应用

接下来使用 Gin 作为框架来搭建一个拥有静态资源站点，动态 WEB 站点，以及
RESTFull API 接口站点（可专门作为手机 APP
应用提供服务使用）组成的，亦可根据情况分拆这套系统，每种功能独立出来单独提供服务。

下面按照一套系统但采用分站点来说明，首先是整个系统的目录结构，website
目录下面 static 是资源类文件，为静态资源站点专用；photo 目录是 UGC
上传图片目录，tpl 是动态站点的模板。

当然这个目录结构是一种约定，可以根据情况来修改。整个项目已经开源，可以访问来详细了解：https://github.com/ffhelicopter/tmm具体每个站点的功能怎么实现呢？请看下面有关每个功能的讲述：

#### 静态资源站点

一般网站开发中，我们会考虑把
js，css，以及资源图片放在一起，作为静态站点部署在
CDN，提升响应速度。采用 Gin 实现起来非常简单，当然也可以使用 net/http
包轻松实现，但使用 Gin 会更方便。

不管怎么样，使用 Go 开发，我们可以不用花太多时间在 WEB
服务环境搭建上，程序启动就直接可以提供 WEB 服务了。

package mainimport ( \"net/http\" \"github.com/gin-gonic/gin\")func
main() { router := gin.Default() //
静态资源加载，本例为css,js以及资源图片 router.StaticFS(\"/public\",
http.Dir(\"D:/goproject/src/github.com/ffhelicopter/tmm/website/static\"))
router.StaticFile(\"/favicon.ico\", \"./resources/favicon.ico\") //
Listen and serve on 0.0.0.0:80 router.Run(\":80\")}

首先需要是生成一个 Engine，这是 gin 的核心，默认带有 Logger 和 Recovery
两个中间件。

router := gin.Default()

StaticFile 是加载单个文件，而 StaticFS 是加载一个完整的目录资源：

func (group \*RouterGroup) StaticFile(relativePath, filepath string)
IRoutes\
func (group \*RouterGroup) StaticFS(relativePath string, fs
http.FileSystem) IRoutes

这些目录下资源是可以随时更新，而不用重新启动程序。现在编译运行程序，静态站点就可以正常访问了。

访问http://localhost/public/images/logo.jpg图片加载正常。每次请求响应都会在服务端有日志产生，包括响应时间，加载资源名称，响应状态值等等。

#### 动态站点

如果需要动态交互的功能，比如发一段文字+图片上传。由于这些功能出来前端页面外，还需要服务端程序一起来实现，而且迭代需要经常需要修改代码和模板，所以把这些统一放在一个大目录下，姑且称动态站点。

tpl 是动态站点所有模板的根目录，这些模板可调用静态资源站点的
css，图片等；photo 是图片上传后存放的目录。

package mainimport ( \"context\" \"log\" \"net/http\" \"os\"
\"os/signal\" \"time\" \"github.com/ffhelicopter/tmm/handler\"
\"github.com/gin-gonic/gin\")func main() { router := gin.Default() //
静态资源加载，本例为css,js以及资源图片 router.StaticFS(\"/public\",
http.Dir(\"D:/goproject/src/github.com/ffhelicopter/tmm/website/static\"))
router.StaticFile(\"/favicon.ico\", \"./resources/favicon.ico\") //
导入所有模板，多级目录结构需要这样写
router.LoadHTMLGlob(\"website/tpl/\*/\*\") // website分组 v :=
router.Group(\"/\") { v.GET(\"/index.html\", handler.IndexHandler)
v.GET(\"/add.html\", handler.AddHandler) v.POST(\"/postme.html\",
handler.PostmeHandler) } // router.Run(\":80\") //
这样写就可以了，下面所有代码（go1.8+）是为了优雅处理重启等动作。 srv :=
&http.Server{ Addr: \":80\", Handler: router, ReadTimeout: 30 \*
time.Second, WriteTimeout: 30 \* time.Second, } go func() { // 监听请求
if err := srv.ListenAndServe(); err != nil && err !=
http.ErrServerClosed { log.Fatalf(\"listen: %s\\n\", err) } }() //
优雅Shutdown（或重启）服务 quit := make(chan os.Signal)
signal.Notify(quit, os.Interrupt) // syscall.SIGKILL \<-quit
log.Println(\"Shutdown Server \...\") ctx, cancel :=
context.WithTimeout(context.Background(), 5\*time.Second) defer cancel()
if err := srv.Shutdown(ctx); err != nil { log.Fatal(\"Server
Shutdown:\", err) } select { case \<-ctx.Done(): } log.Println(\"Server
exiting\")}

在动态站点实现中，引入 WEB 分组以及优雅重启这两个功能。WEB
分组功能可以通过不同的入口根路径来区别不同的模块，这里我们可以访问：http://localhost/index.html。如果新增一个分组，比如：

v := router.Group(\"/login\")

我们可以访问：http://localhost/login/xxxx，xxx 是我们在 v.GET 方法或
v.POST 方法中的路径。

// 导入所有模板，多级目录结构需要这样写\
router.LoadHTMLGlob(\"website/tpl/\*/\*\")

// website分组\
v := router.Group(\"/\")\
{

v.GET(\"/index.html\", handler.IndexHandler)\
    v.GET(\"/add.html\", handler.AddHandler)\
    v.POST(\"/postme.html\", handler.PostmeHandler)\
}

通过 router.LoadHTMLGlob(\"website/tpl//\")
导入模板根目录下所有的文件。在前面有讲过 html/template
包的使用，这里模板文件中的语法和前面一致。

router.LoadHTMLGlob(\"website/tpl/\*/\*\")

比如 v.GET(\"/index.html\",
handler.IndexHandler)，通过访问http://localhost/index.html这个
URL，实际由 handler.IndexHandler 来处理。而在 tmm 目录下的 handler
存放了 package handler 文件。在包里定义了 IndexHandler 函数，它使用了
index.html 模板。

func IndexHandler(c \*gin.Context) {\
    c.HTML(http.StatusOK, \"index.html\", gin.H{\
        \"Title\": \"作品欣赏\",\
    })\
}

index.html 模板：

\<!DOCTYPE html\>\<html\>\<head\>{{template \"header\"
.}}\</head\>\<body\>\<!\--导航\--\>\<div class=\"feeds\"\> \<div
class=\"top-nav\"\> \<a href=\"/index.tml\" class=\"active\"\>欣赏\</a\>
\<a href=\"/add.html\" class=\"add-btn\"\> \<svg class=\"icon\"
aria-hidden=\"true\"\> \<use xlink:href=\"#icon-add\"\>\</use\> \</svg\>
发布 \</a\> \</div\> \<input type=\"hidden\" id=\"showmore\"
value=\"{\$showmore}\"\> \<input type=\"hidden\" id=\"page\"
value=\"{\$page}\"\> \<!\--\</div\>\--\>\</div\>\<script
type=\"text/javascript\"\> var done = true;
\$(window).scroll(function(){ var scrollTop = \$(window).scrollTop();
var scrollHeight = \$(document).height(); var windowHeight =
\$(window).height(); var showmore = \$(\"#showmore\").val();
if(scrollTop + windowHeight + 300 \>= scrollHeight && showmore == 1 &&
done){ var page = \$(\"#page\").val(); done = false;
\$.get(\"{:U(\'Product/listsAjax\')}\", { page : page }, function(json)
{ if (json.rs != \"\") { \$(\".feeds\").append(json.rs);
\$(\"#showmore\").val(json.showmore); \$(\"#page\").val(json.page); done
= true; } },\'json\'); } });\</script\> \<script
src=\"//at.alicdn.com/t/font_ttszo9rnm0wwmi.js\"\>\</script\>\</body\>\</html\>

在 index.html 模板中，通过 {{template \"header\" .}} 语句，嵌套了
header.html 模板。

header.html 模板：

{{ define \"header\" }} \<meta charset=\"UTF-8\"\> \<meta
name=\"viewport\" content=\"width=device-width, initial-scale=1,
maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui\"\>
\<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"\>
\<meta name=\"format-detection\" content=\"telephone=no,email=no\"\>
\<title\>{{ .Title }}\</title\> \<link rel=\"stylesheet\"
href=\"/public/css/common.css\"\> \<script
src=\"/public/lib/jquery-3.1.1.min.js\"\>\</script\> \<script
src=\"/public/lib/jquery.cookie.js\"\>\</script\> \<link
href=\"/public/css/font-awesome.css?v=4.4.0\" rel=\"stylesheet\"\>{{ end
}}

{{ define \"header\" }} 让我们在模板嵌套时直接使用 header 名字，而在
index.html 中的 {{template \"header\" .}}
注意"."，可以使参数嵌套传递，否则不能传递，比如这里的 Title。

现在我们访问http://localhost/index.html，可以看到浏览器显示 Title
是"作品欣赏"，这个 Title 是通过 IndexHandler 来指定的。

接下来点击"发布"按钮，我们进入发布页面，上传图片，点击"完成"提交，会提示我们成功上传图片。可以在
photo 目录中看到刚才上传的图片。

> 注意：由于在本人在发布到 github
> 的代码中，在处理图片上传的代码中，除了服务器存储外，还实现了 IPFS
> 发布存储，如果不需要 IPFS，请注释相关代码。

有关 IPFS: IPFS
本质上是一种内容可寻址、版本化、点对点超媒体的分布式存储、传输协议，目标是补充甚至取代过去
20
年里使用的超文本媒体传输协议（HTTP），希望构建更快、更安全、更自由的互联网时代。

IPFS
不算严格意义上区块链项目，是一个去中心化存储解决方案，但有些区块链项目通过它来做存储。

IPFS 项目有在 github 上开源，Go语言实现哦，可以关注并了解。

优雅重启在迭代中有较好的实际意义，每次版本发布，如果直接停服务在部署重启，对业务还是有蛮大的影响，而通过优雅重启，这方面的体验可以做得更好些。这里
ctrl + c 后过 5 秒服务停止。

中间件的使用，在 API 中可能使用限流，身份验证等

Go语言中 net/http 设计的一大特点就是特别容易构建中间件。gin
也提供了类似的中间件。需要注意的是在 gin
里面中间件只对注册过的路由函数起作用。

而对于分组路由，嵌套使用中间件，可以限定中间件的作用范围。大致分为全局中间件，单个路由中间件和分组中间件。

即使是全局中间件，其使用前的代码不受影响。也可在 handler
中局部使用，具体见 api.GetUser。

在高并发场景中，有时候需要用到限流降速的功能，这里引入一个限流中间件。有关限流方法常见有两种，具体可自行研究，这里只讲使用。

导入import
\"github.com/didip/tollbooth/limiter\"包，在上面代码基础上增加如下语句：

//rate-limit 限流中间件\
lmt := tollbooth.NewLimiter(1, nil)\
lmt.SetMessage(\"服务繁忙，请稍后再试\...\")

并修改

v.GET(\"/index.html\", LimitHandler(lmt), handler.IndexHandler)

当 F5
刷新刷新http://localhost/index.html页面时，浏览器会显示：服务繁忙，请稍后再试\...

限流策略也可以为 IP：

tollbooth.LimitByKeys(lmt, \[\]string{\"127.0.0.1\", \"/\"})

更多限流策略的配置，可以进一步github.com/didip/tollbooth/limiter了解。

#### RestFull API 接口

前面说了在 gin 里面可以采用分组来组织访问 URL，这里 RestFull API
需要给出不同的访问 URL 来和动态站点区分，所以新建了一个分组 v1。

在浏览器中访问http://localhost/v1/user/1100000/这里对
v1.GET(\"/user/:id/\*action\", LimitHandler(lmt), api.GetUser)
进行了限流控制，所以如果频繁访问上面地址也将会有限制，这在 API
接口中非常有作用。

通过 api 这个包，来实现所有有关 API 的代码。在 GetUser 函数中，通过读取
mysql 数据库，查找到对应 userid 的用户信息，并通过 Json 格式返回给
client。

在 api.GetUser 中，设置了一个局部中间件：

//CORS 局部CORS，可在路由中设置全局的CORS\
c.Writer.Header().Add(\"Access-Control-Allow-Origin\", \"\*\")

gin 关于参数的处理，api 包中 api.go
文件中有简单说明，限于篇幅原因，就不在此展开。这个项目的详细情况，请访问https://github.com/ffhelicopter/tmm了解。有关
gin
的更多信息，请访问 https://github.com/gin-gonic/gin，该开源项目比较活跃，可以关注。

完整 mian.go 代码：

纯文本复制

package mainimport ( \"context\" \"log\" \"net/http\" \"os\"
\"os/signal\" \"time\" \"github.com/didip/tollbooth\"
\"github.com/didip/tollbooth/limiter\"
\"github.com/ffhelicopter/tmm/api\"
\"github.com/ffhelicopter/tmm/handler\" \"github.com/gin-gonic/gin\")//
定义全局的CORS中间件func Cors() gin.HandlerFunc { return func(c
\*gin.Context) { c.Writer.Header().Add(\"Access-Control-Allow-Origin\",
\"\*\") c.Next() }}func LimitHandler(lmt \*limiter.Limiter)
gin.HandlerFunc { return func(c \*gin.Context) { httpError :=
tollbooth.LimitByRequest(lmt, c.Writer, c.Request) if httpError != nil {
c.Data(httpError.StatusCode, lmt.GetMessageContentType(),
\[\]byte(httpError.Message)) c.Abort() } else { c.Next() } }}func main()
{ gin.SetMode(gin.ReleaseMode) router := gin.Default() //
静态资源加载，本例为css,js以及资源图片 router.StaticFS(\"/public\",
http.Dir(\"D:/goproject/src/github.com/ffhelicopter/tmm/website/static\"))
router.StaticFile(\"/favicon.ico\", \"./resources/favicon.ico\") //
导入所有模板，多级目录结构需要这样写
router.LoadHTMLGlob(\"website/tpl/\*/\*\") //
也可以根据handler，实时导入模板。 // website分组 v :=
router.Group(\"/\") { v.GET(\"/index.html\", handler.IndexHandler)
v.GET(\"/add.html\", handler.AddHandler) v.POST(\"/postme.html\",
handler.PostmeHandler) } // 中间件
golang的net/http设计的一大特点就是特别容易构建中间件。 //
gin也提供了类似的中间件。需要注意的是中间件只对注册过的路由函数起作用。
// 对于分组路由，嵌套使用中间件，可以限定中间件的作用范围。 //
大致分为全局中间件，单个路由中间件和群组中间件。 // 使用全局CORS中间件。
// router.Use(Cors()) // 即使是全局中间件，在use前的代码不受影响 //
也可在handler中局部使用，见api.GetUser //rate-limit 中间件 lmt :=
tollbooth.NewLimiter(1, nil)
lmt.SetMessage(\"服务繁忙，请稍后再试\...\") //
API分组(RESTFULL)以及版本控制 v1 := router.Group(\"/v1\") { //
下面是群组中间的用法 // v1.Use(Cors()) // 单个中间件的用法 //
v1.GET(\"/user/:id/\*action\",Cors(), api.GetUser) // rate-limit
v1.GET(\"/user/:id/\*action\", LimitHandler(lmt), api.GetUser)
//v1.GET(\"/user/:id/\*action\", Cors(), api.GetUser) // AJAX OPTIONS
，下面是有关OPTIONS用法的示例 // v1.OPTIONS(\"/users\", OptionsUser) //
POST // v1.OPTIONS(\"/users/:id\", OptionsUser) // PUT, DELETE } srv :=
&http.Server{ Addr: \":80\", Handler: router, ReadTimeout: 30 \*
time.Second, WriteTimeout: 30 \* time.Second, } go func() { if err :=
srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
log.Fatalf(\"listen: %s\\n\", err) } }() // 优雅Shutdown（或重启）服务
// 5秒后优雅Shutdown服务 quit := make(chan os.Signal)
signal.Notify(quit, os.Interrupt) //syscall.SIGKILL \<-quit
log.Println(\"Shutdown Server \...\") ctx, cancel :=
context.WithTimeout(context.Background(), 5\*time.Second) defer cancel()
if err := srv.Shutdown(ctx); err != nil { log.Fatal(\"Server
Shutdown:\", err) } select { case \<-ctx.Done(): } log.Println(\"Server
exiting\")}
