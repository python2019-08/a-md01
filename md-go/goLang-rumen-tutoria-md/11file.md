Go语言入门教程，Golang入门教程（非常详细）

<http://c.biancheng.net/golang/>

<https://www.kancloud.cn/imdszxs/golang/1535582>

<https://www.xinbaoku.com/archive/2DHvuPFr.html>

# 目录

[11.文件处理 [3](#文件处理)](\l)

[11.1 自定义数据文件 [3](#自定义数据文件)](\l)

[11.2 JSON文件的读写操作 [7](#json文件的读写操作)](\l)

[11.2.1写 JSON 文件 [8](#写-json-文件)](\l)

[11.2.2读 JSON 文件 [9](#读-json-文件)](\l)

[11.3 XML文件的读写操作 [11](#xml文件的读写操作)](\l)

[11.3.1写 XML 文件 [11](#写-xml-文件)](\l)

[11.3.2读 XML 文件 [12](#读-xml-文件)](\l)

[11.4 使用Gob传输数据 [14](#使用gob传输数据)](\l)

[11.4.1创建 gob 文件 [15](#创建-gob-文件)](\l)

[11.4.2读取 gob 文件 [16](#读取-gob-文件)](\l)

[11.5 纯文本文件的读写操作 [16](#纯文本文件的读写操作)](\l)

[11.5.1写纯文本文件 [16](#写纯文本文件)](\l)

[11.5.2读纯文本文件 [18](#读纯文本文件)](\l)

[11.6 二进制文件的读写操作 [19](#二进制文件的读写操作)](\l)

[11.6.1写Go语言二进制文件 [20](#写go语言二进制文件)](\l)

[11.6.2读Go语言二进制文件 [20](#读go语言二进制文件)](\l)

[11.7 自定义二进制文件的读写操作 [21](#自定义二进制文件的读写操作)](\l)

[11.7.1写自定义二进制文件 [22](#写自定义二进制文件)](\l)

[11.7.2读自定义二进制文件 [23](#读自定义二进制文件)](\l)

[11.8 zip归档文件的读写操作 [25](#zip归档文件的读写操作)](\l)

[11.8.1创建 zip 归档文件 [26](#创建-zip-归档文件)](\l)

[11.8.2读取 zip 归档文件 [27](#读取-zip-归档文件)](\l)

[11.9 tar归档文件的读写操作 [28](#tar归档文件的读写操作)](\l)

[11.9.1创建 tar 归档文件 [28](#创建-tar-归档文件)](\l)

[11.9.2解压 tar 归档文件 [31](#解压-tar-归档文件)](\l)

[11.10 Go语言使用buffer读取文件 [32](#go语言使用buffer读取文件)](\l)

[11.10.1使用 bufio 包写入文件 [33](#使用-bufio-包写入文件)](\l)

[11.10.2使用 bufio 包读取文件 [35](#使用-bufio-包读取文件)](\l)

[11.11 示例：并发目录遍历 [38](#示例并发目录遍历)](\l)

[11.12 示例：从INI配置文件中读取需要的值
[45](#示例从ini配置文件中读取需要的值)](\l)

[11.12.1 INI 文件的格式 [45](#ini-文件的格式)](\l)

[11.12.2从 INI 文件中取值的函数 [45](#从-ini-文件中取值的函数)](\l)

[11.12.3读取文件 [47](#读取文件)](\l)

[11.12.4读取行文本 [48](#读取行文本)](\l)

[11.12.5读取段 [48](#读取段)](\l)

[11.12.6读取键值 [49](#读取键值)](\l)

[11.13 文件的写入、追加、读取、复制操作
[50](#文件的写入追加读取复制操作)](\l)

[11.14 Go语言文件锁操作 [56](#go语言文件锁操作)](\l)

# [11.文件处理](http://c.biancheng.net/golang/102/)

[Go语言文件处理](http://c.biancheng.net/golang/102/)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

本章我们将带领大家深入了解一下
Go语言中的文件处理，重点在于文件而非目录或者通用的文件系统，特别是如何读写标准格式（如
XML 和 JSON 格式）的文件以及自定义的纯文本和二进制格式文件。\
\
由于前面的内容已覆盖 Go语言的所有特性，现在我们可以灵活地使用
Go语言提供的所有工具。我们会充分利用这种灵活性并利用闭包来避免重复性的代码，同时在某些情况下充分利用
Go语言对面向对象的支持，特别是对为函数添加方法的支持。

## 11.1 [自定义数据文件](http://c.biancheng.net/view/4543.html)

Go语言自定义数据文件

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

对一个程序非常普遍的需求包括维护内部数据结构，为数据交换提供导入导出功能，也支持使用外部工具来处理数据。\
\
由于我们这里的关注重点是文件处理，因此我们纯粹只关心如何从程序内部数据结构中读取数据并将其写入标准和自定义格式的文件中，以及如何从标准和自定义格式文件中读取数据并写入程序的内部数据结构中。\
\
本节中，我们会为所有的例子使用相同的数据，以便直接比较不同的文件格式。所有的代码都来自
invoicedate 程序（在 invoicedata 目录中的 invoicedata.go \>
gob.go、inv.go、jsn.go、txt.go 和 xml.go
等文件中）。大家可以从我的网盘（链接: https://pan.baidu.com/s/1j22QfIScihrauVCVFV6MWw 提取码:
ajrk）下载相关的代码。\
\
该程序接受两个文件名作为命令行参数，一个用于读，另一个用于写（它们必须是不同的文件）。程序从第一个文件中读取数据（以其后缀所表示的任何格式），并将数据写入第二个文件（也是以其后缀所表示的任何格式）。\
\
由 invoicedata
程序创建的文件可跨平台使用，也就是说，无论是什么格式，Windows
上创建的文件都可在 Mac OS X 以及 Linux 上读取，反之亦然。Gzip
格式压缩的文件（如 invoices.gob.gz）可以无缝读写。\
\
这些数据由一个 \[\]invoice 组成，也就是说，是一个保存了指向 Invoice
值的指针的切片。每一个发票数据都保存在一个 invoice
类型的值中，同时每一个发票数据都以 \[\]\*Item 的形式保存着 0
个或者多个项。

1.  type Invoice struct {

2.  Id int

3.  Customerld int

4.  Raised time.Time

5.  Due time.Time

6.  Paid bool

7.  Note string

8.  Items \[\]\*Item

9.  }

10. 

11. type Item struct {

12. Id string

13. Price float64

14. Quantity int

15. Note string

16. }

这两个结构体用于保存数据。下表给出了一些非正式的对比，展示了每种格式下读写相同的
50000 份随机发票数据所需的时间，以及以该格式所存储文件的大小。\
\
计时按秒计，并向上舍入到最近的十分之一秒。我们应该把计时结果认为是无绝对单位的，因为不同硬件以及不
同负载情况下该值都不尽相同。大小一栏以千字节（KB）算，该值在所有机器上应该都是相同的。\
\
对于该数据集，虽然未压缩文件的大小千差万别，但压缩文件的大小都惊人的相似。而代码的
函数不包括所有格式通用的代码（例如，那些用于压缩和解压缩以及定义结构体的代码）。

表：各种格式的速度以及大小对比

  ---------- ---------- ---------- --------------- ----------------- ------------------
  **后缀**   **读取**   **写入**   **大小(KiB)**   **读/写LOC**      **格式**

  .gob       0.3        0.2        7948            21 + 11 =32       Go二进制

  .gob.gz    0.5        1.5        2589                              

  jsn        4.5        2.2        16283           32+17 = 49        JSON

  .jsn.gz    4.5        3.4        2678                              

  .xml       6.7        1.2        18917           45 + 30 = 75      XML

  .xml.gz    6.9        2.7        2730                              

  ..txt      1.9        1.0        12375           86 + 53 = 139     纯文本（UTF-8）

  .txt.gz    2.2        2.2        2514                              

  .inv       1.7        3.5        7250            128 + 87 = 215    自定义二进制

  .inv.gz    1.6        2.6        2400                              
  ---------- ---------- ---------- --------------- ----------------- ------------------

这些读写时间和文件大小在我们的合理预期范围内，除了纯文本格式的读写异常快之外。这得益于
fmt 包优秀的打印和扫描函数，以及我们设计的易于解析的自定义文本格式。\
\
对于 JSON 和 XML 格式，我们只简单地存储了日期部分而非存储默认的
time.Time 值（一个 ISO-8601
日期/时间字符串），通过牺牲一些速度和增加一些额外代码稍微减小了文件的大小。\
\
例如，如果让JSON代码自己来处理time.Time值，它能够运行得更快，并且其代码行数与
Go语言二进制编码差不多。\
\
对于二进制数据，Go语言的二进制格式是最便于使用的。它非常快且极端紧凑，所需的代码非常少，并且相对容易适应数据的变化。然而，如果我们使用的自定义类型不原生支持
gob 编码，我们必须让该类型满足 gob.Encoder 和 gob. Decoder
接口，这样会导致 gob 格式的 读写相当得慢，并且文件大小也会膨胀。\
\
对于可读的数据，XML
可能是最好使用的格式，特别是作为一种数据交换格式时非常有用。与处理 JSON
格式相比，处理 XML 格式需要更多行代码。这是因为 Go \[没有一个
xml.Marshaler 接口，也因为我们这里使用了并行的数据类型 （XMLInvoice 和
XMLItem）来帮助映射 XML 数据和发票数据（invoice 和 Item）。\
\
使用 XML 作为外部存储格式的应用程序可能不需要并行的数据类型或者也不需要
invoicedata 程序这样的 转换，因此就有可能比 invoicedata
例子中所给出的更快，并且所需的代码也更少。\
\
除了读写速度和文件大小以及代码行数之外，还有另一个问题值得考虑：格式的稳健性。例如，如果我们为
Invoice 结构体和 Item
结构体添加了一个字段，那么就必须再改变文件的格式。我们的代码适应读写新格式并继续支持读旧格式的难易程度如何？如果我们为文件格式定义版本，这样的变化就很容易被适应（会以本章一个练习的形式给岀），除了让
JSON 格式同时适应读写新旧格式稍微复杂一点之外。\
\
除了 Invoice 和 Item 结构体之外，所有文件格式都共享以下常量：

1.  const （

2.  fileType = \"INVOICES\" //用于纯文本格式

3.  magicNumber = 0xl25D // 用于二进制格式

4.  fileVersion = 100 //用于所有的格式

5.  dataFormat = \"2006-01-02\" //必须总是使用该日期

6.  ）

magicNumber 用于唯一标记发票文件。fileVersion
用于标记发票文件的版本，该标记便于之后修改程序来适应数据格式的改变。dataFormat
稍后介绍，它表 示我们希望数据如何按照可读的格式进行格式化。\
\
同时，我们也创建了一对接口。

1.  type InvoiceMarshaler interface {

2.  Marshallnvoices（writer io.Writer, invoices \[\]\*Invoice） error

3.  }

4.  type InvoiceUnmarshaler interface {

5.  Unmarshallnvoices(reader io.Reader) (\[\]\*Invoice, error)

6.  }

这样做的目的是以统一的方式针对特定格式使用 reader 和
writer。例如，下列函数是 invoicedata
程序用来从一个打开的文件中读取发票数据的。

1.  func readinvoices(reader io.Reader, suffix string)(\[\]\*Invoice,
    error) {

2.  var unmarshaler InvoicesUnmarshaler

3.  switch suffix {

4.  case \".gobn:

5.  unmarshaler = GobMarshaler{}

6.  case H.inv\":

7.  unmarshaler = InvMarshaler{}

8.  case ,f. jsn\", H. jsonn:

9.  unmarshaler = JSONMarshaler{}

10. case \".txt"：

11. unmarshaler = TxtMarshaler{}

12. case \".xml\":

13. unmarshaler = XMLMarshaler{}

14. }

15. if unmarshaler != nil {

16. return unmarshaler.Unmarshallnvoices(reader)

17. }

18. return nil, fmt.Errorf(\"unrecognized input suffix: %s\", suffix)

19. }

其中，reader 是任何能够满足 io.Reader 接口的值，例如，一个打开的文件 (
其类型为 \*os . File)\> 一个 gzip 解码器 ( 其类型为 \*gzip. Reader)
或者一个 string. Readero 字符串 suffix 是文件的后缀名 ( 从 .gz
文件中解压之后)。\
\
在接下来的小节中我们将会看到 GobMarshaler 和 InvMarshaler
等自定义的类型，它们提供了 MarshmlTnvoices() 和 Unmarshallnvoices() 方法
(因此满足 InvoicesMarshaler 和 InvoicesUnmarshaler 接口)。

## 11.2 [JSON文件的读写操作](http://c.biancheng.net/view/4545.html)

[Go语言JSON文件的读写操作](http://c.biancheng.net/view/4545.html)

----------------------\-\-\-\--------------------

JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，易于阅读和编写，同时也易于机器解析和生成。它基于 JavaScript
Programming Language, Standard ECMA-262 3rd Edition - December 1999 的一个子集。

JSON 是一种使用 UTF-8编码的纯文本格式，采用完全独立于语言的文本格式，由于写起来比 XML格式方便，并且更为紧凑，同时所需的处理时间也更少，致使 JSON格式越来越流行，特别是在通过网络连接传送数据方面。

开发人员可以使用 JSON传输简单的字符串、数字、布尔值，也可以传输一个数组或者一个更复杂的复合结构。在Web 开发领域中，JSON 被广泛应用于 Web服务端程序和客户端之间的数据通信。

Go语言内建对 JSON 的支持，使用内置的 encoding/json 标准库，开发人员可以轻松使用Go程序生成和解析 JSON 格式的数据。

JSON 结构如下所示：
{"key1":"value1","key2":value2,"key3":["value3","value4","value5"]}

### 11.2.1写 JSON 文件

使用Go语言创建一个 json 文件非常方便，示例代码如下：

1.  package main
2.  
3.  import (
4.      "encoding/json"
5.      "fmt"
6.      "os"
7.  )
8.  
9.  type Website struct {
10.     Name   string `xml:"name,attr"`
11.     Url    string
12.     Course []string
13. }
14. 
15. func main() {
16.     info := []Website{
17.           {"Golang",
18.            "http://c.biancheng.net/golang/",
19.             []string{"http://c.biancheng.net/cplus/",
20.                      "http://c.biancheng.net/linux_tutorial/"}
21.           },
22.           {"Java",
23.            "http://c.biancheng.net/java/",
24.             []string{"http://c.biancheng.net/socket/",
25.                      "http://c.biancheng.net/python/"}}}
26. 
27.     // 创建文件
28.     filePtr, err := os.Create("info.json")
29.     if err != nil {
30.         fmt.Println("文件创建失败", err.Error())
31.         return
32.     }
33.     defer filePtr.Close()
34. 
35.     // 创建Json编码器
36.     encoder := json.NewEncoder(filePtr)
37. 
38.     err = encoder.Encode(info)
39.     if err != nil {
40.         fmt.Println("编码错误", err.Error())
41. 
42.     } else {
43.         fmt.Println("编码成功")
44.     }
45. }

运行上面的代码会在当前目录下生成一个 info.json 文件，文件内容如下：

[
    {
        "Name":"Golang",
        "Url":"http://c.biancheng.net/golang/",
        "Course":[
            "http://c.biancheng.net/golang/102/",
            "http://c.biancheng.net/golang/concurrent/"
        ]
    },
    {
        "Name":"Java",
        "Url":"http://c.biancheng.net/java/",
        "Course":[
            "http://c.biancheng.net/java/10/",
            "http://c.biancheng.net/python/"
        ]
    }
]

### 11.2.2读 JSON 文件

读 JSON 数据与写 JSON 数据一样简单，示例代码如下：

1.  package main
2.  
3.  import (
4.      "encoding/json"
5.      "fmt"
6.      "os"
7.  )
8.  
9.  type Website struct {
10.     Name   string `xml:"name,attr"`
11.     Url    string
12.     Course []string
13. }
14. 
15. func main() {
16.     filePtr, err := os.Open("./info.json")
17.     if err != nil {
18.         fmt.Println("文件打开失败 [Err:%s]", err.Error())
19.         return
20.     }
21.     defer filePtr.Close()
22.     var info []Website
23.     // 创建json解码器
24.     decoder := json.NewDecoder(filePtr)
25.     err = decoder.Decode(&info)
26.     if err != nil {
27.         fmt.Println("解码失败", err.Error())
28.     } else {
29.         fmt.Println("解码成功")
30.         fmt.Println(info)
31.     }
32. }

运行结果如下：

go run main.go
解码成功
[{Golang http://c.biancheng.net/golang/
[http://c.biancheng.net/golang/102/
http://c.biancheng.net/golang/concurrent/]} {Java
http://c.biancheng.net/java/ [http://c.biancheng.net/java/10/
http://c.biancheng.net/python/]}]

顺便提一下，还有一种叫做 BSON (Binary JSON) 的格式与 JSON 非常类似，与
JSON 相比，BSON 着眼于提高存储和扫描效率。BSON
文档中的大型元素以长度字段为前缀以便于扫描。在某些情况下，由于长度前缀和显式数组索引的存在，BSON
使用的空间会多于 JSON。

## 11.3 [XML文件的读写操作](http://c.biancheng.net/view/4551.html)

Go语言XML文件的读写操作

---------------\-\-\-\-\-\-\-\-----------------------

XML（extensible Markup
Language）格式被广泛用作一种数据交换格式，并且自成一种文件格式。与上一节介绍的 JSON 相比
XML 要复杂得多，而且手动写起来相对乏味得多。

在 JSON 还未像现在这么广泛使用时，XML 的使用相当广泛。XML
作为一种数据交换和信息传递的格式，使用还是很广泛的，现在很多开放平台接口，基本都会支持
XML 格式。

Go语言内置的 **encoding/xml 包**可以用在结构体和 XML
格式之间进行编解码，其方式跟 encoding/json 包类似。然而与 JSON 相比 XML
的编码和解码在功能上更苛刻得多，这是由于 encoding/xml
包要求结构体的字段包含格式合理的标签，而 JSON 格式却不需要。

### 11.3.1写 XML 文件

使用 encoidng/xml 包可以很方便的将 xml 数据存储到文件中，示例代码如下：

1.  package main

2.  

3.  import (

4.      "encoding/xml"

5.      "fmt"

6.      "os"

7.  )

8.  

9.  type Website struct {

10.     Name   string `xml:"name,attr"`

11.     Url    string

12.     Course []string

13. }

14. 

15. func main() {

16.     //实例化对象

17.     info := Website{"C语言中文网",
    "http://c.biancheng.net/golang/", []string{"Go语言入门教程",
    "Golang入门教程"}}

18.     f, err := os.Create("./info.xml")

19.     if err != nil {

20.         fmt.Println("文件创建失败", err.Error())

21.         return

22.     }

23.     defer f.Close()

24.     //序列化到文件中

25.     encoder := xml.NewEncoder(f)

26.     err = encoder.Encode(info)

27.     if err != nil {

28.         fmt.Println("编码错误：", err.Error())

29.         return

30.     } else {

31.         fmt.Println("编码成功")

32.     }

33. }

运行上面的代码会在当前目录生成一个 info.xml 文件，文件的内容如下所示：

<Website name="C语言中文网">
    <Url>http://c.biancheng.net/golang/</Url>
    <Course>Go语言入门教程</Course>
    <Course>Golang入门教程</Course>
</Website>

### 11.3.2读 XML 文件

读 XML 文件比写 XML
文件稍微复杂，特别是在必须处理一些我们自定义字段的时候（例如日期）。但是，如果我们使用合理的打上
XML 标签的结构体，就不会复杂。示例代码如下：

1.  package main

2.  

3.  import (

4.      "encoding/xml"

5.      "fmt"

6.      "os"

7.  )

8.  

9.  type Website struct {

10.     Name   string `xml:"name,attr"`

11.     Url    string

12.     Course []string

13. }

14. 

15. func main() {

16.     //打开xml文件

17.     file, err := os.Open("./info.xml")

18.     if err != nil {

19.         fmt.Printf("文件打开失败：%v", err)

20.         return

21.     }

22.     defer file.Close()

23. 

24.     info := Website{}

25.     //创建 xml 解码器

26.     decoder := xml.NewDecoder(file)

27.     err = decoder.Decode(&info)

28.     if err != nil {

29.         fmt.Printf("解码失败：%v", err)

30.         return

31.     } else {

32.         fmt.Println("解码成功")

33.         fmt.Println(info)

34.     }

35. }

运行结果如下：

go run main.go
解码成功
{C语言中文网 http://c.biancheng.net/golang/ [Go语言入门教程
Golang入门教程]}

正如写 XML 时一样，我们无需关心对所读取的 XML
数据进行转义，xml.NewDecoder.Decode() 函数会自动处理这些。

xml 包还支持更为复杂的标签，包括嵌套。例如标签名为
'xml:"Books>Author"' 产生的是
<Books><Author>content</Author></Books> 这样的 XML
内容。同时除了 'xml:", attr"' 之外，该包还支持 'xml:",chardata"'
这样的标签表示将该字段当做字符数据来写，支持 'xml:",innerxml"'
这样的标签表示按照字面量来写该字段，以及 'xml:",comment"'
这样的标签表示将该字段当做 XML
注释。因此，通过使用标签化的结构体，我们可以充分利用好这些方便的编码解码函数，同时合理控制如何读写
XML 数据。

## 11.4 [使用Gob传输数据](http://c.biancheng.net/view/4597.html)

Go语言使用Gob传输数据

------------\-\-\-\-\-\-\-\-\-\-\-\-\--------------

为了让某个数据结构能够在网络上传输或能够保存至文件，它必须被编码然后再解码。当然已经有许多可用的编码方式了，比如 JSON、XML、Google
的 protocol buffers 等等。而现在又多了一种，由Go语言 encoding/gob
包提供的方式。

Gob 是Go语言自己以二进制形式序列化和反序列化程序数据的格式，可以在
encoding 包中找到。这种格式的数据简称为 Gob（即 Go binary
的缩写）。类似于 Python 的"pickle"和 Java 的"Serialization"。

Gob 和 JSON 的 pack 之类的方法一样，由发送端使用 Encoder
对数据结构进行编码。在接收端收到消息之后，接收端使用 Decoder
将序列化的数据变化成本地变量。

Go语言可以通过 JSON 或 Gob 来序列化 struct 对象，虽然 JSON
的序列化更为通用，但利用 Gob 编码可以实现 JSON 所不能支持的 struct
的方法序列化，利用 Gob 包序列化 struct 保存到本地也十分简单。

Gob 不是可外部定义、语言无关的编码方式，它的首选的是二进制格式，而不是像
JSON 或 XML 那样的文本格式。Gob 并不是一种不同于 Go
的语言，而是在编码和解码过程中用到了 Go 的反射。

Gob
通常用于远程方法调用参数和结果的传输，以及应用程序和机器之间的数据传输。它和
JSON 或 XML 有什么不同呢？**Gob 特定的用于纯 Go
的环境中**，例如两个用Go语言写的服务之间的通信。这样的话服务可以被实现得更加高效和优化。

Gob
文件或流是**完全自描述的**，它里面包含的所有类型都有一个对应的描述，并且都是可以用Go语言解码，而不需要了解文件的内容。

只有可导出的字段会被编码，零值会被忽略。在解码结构体的时候，只有同时匹配名称和可兼容类型的字段才会被解码。当源数据类型增加新字段后，Gob
解码客户端仍然可以以这种方式正常工作。解码客户端会继续识别以前存在的字段，并且还提供了很大的灵活性，比如在发送者看来，整数被编码成没有固定长度的可变长度，而忽略具体的
Go 类型。

假如有下面这样一个结构体 T：

type T struct { X, Y, Z int }
var t = T{X: 7, Y: 0, Z: 8}

而在接收时可以用一个结构体 U 类型的变量 u 来接收这个值：

type U struct { X, Y *int8 }
var u U

在接收时，X 的值是 7，Y 的值是 0（Y 的值并没有从 t
中传递过来，因为它是零值）和 JSON 的使用方式一样，Gob 使用通用的
io.Writer 接口，通过 NewEncoder() 函数创建 Encoder 对象并调用
Encode()，相反的过程使用通用的 io.Reader 接口，通过 NewDecoder()
函数创建 Decoder 对象并调用 Decode 。

### 11.4.1创建 gob 文件

下面通过简单的示例程序来演示Go语言是如何创建 gob 文件的，代码如下所示：

1.  package main

2.  

3.  import (

4.  "encoding/gob"

5.  "fmt"

6.  "os"

7.  )

8.  

9.  func main() {

10. info := map[string]string{

11. "name": "C语言中文网",

12. "website": "http://c.biancheng.net/golang/",

13. }

14. name := "demo.gob"

15. File, _ := os.OpenFile(name, os.O_RDWR|os.O_CREATE, 0777)

16. defer File.Close()

17. enc := gob.NewEncoder(File)

18. if err := enc.Encode(info); err != nil {

19. fmt.Println(err)

20. }

21. }

运行上面的代码会在当前目录下生成 demo.gob 文件，文件的内容如下所示：

0eff 8104 0102 ff82 0001 0c01 0c00 0041
ff82 0002 046e 616d 6510 43e8 afad e8a8
80e4 b8ad e696 87e7 bd91 0777 6562 7369
7465 1e68 7474 703a 2f2f 632e 6269 616e
... ...

### 11.4.2读取 gob 文件

读取 gob 文件与创建 gob 文件同样简单，示例代码如下：

1.  package main

2.  

3.  import (

4.  "encoding/gob"

5.  "fmt"

6.  "os"

7.  )

8.  

9.  func main() {

10. var M map[string]string

11. File, _ := os.Open("demo.gob")

12. D := gob.NewDecoder(File)

13. D.Decode(&M)

14. fmt.Println(M)

15. }

运行结果如下：

go run main.go
map[name:C语言中文网 website:http://c.biancheng.net/golang/]

## 11.5 [纯文本文件的读写操作](http://c.biancheng.net/view/4556.html)

Go语言纯文本文件的读写操作

----------------\-\-\-\-\-\-\-\-\-\-\-\-\----------

Go语言提供了很多文件操作的支持，在不同场景下，有对应的处理方式，本节我们来介绍一下文本文件的读写操作。

### 11.5.1写纯文本文件

由于Go语言的 fmt
包中打印函数强大而灵活，写纯文本数据非常简单直接，示例代码如下所示：

1.  package main

2.  

3.  import (

4.  "bufio"

5.  "fmt"

6.  "os"

7.  )

8.  

9.  func main() {

10. //创建一个新文件，写入内容

11. filePath := "./output.txt"

12. file, err := os.OpenFile(filePath, os.O_WRONLY|os.O_CREATE, 0666)

13. if err != nil {

14. fmt.Printf("打开文件错误= %v \\n\", err)

15. return

16. }

17. //及时关闭

18. defer file.Close()

19. //写入内容

20. str := \"http://c.biancheng.net/golang/\\n\" // \\n\\r表示换行
    txt文件要看到换行效果要用 \\r\\n

21. //写入时，使用带缓存的 \*Writer

22. writer := bufio.NewWriter(file)

23. for i := 0; i \< 3; i++ {

24. writer.WriteString(str)

25. }

26. //因为 writer 是带缓存的，因此在调用 WriterString
    方法时，内容是先写入缓存的

27. //所以要调用 flush方法，将缓存的数据真正写入到文件中。

28. writer.Flush()

29. }

运行上面代码会在当前目录下生成一个 output.txt 文件，文件内容如下：

http://c.biancheng.net/golang/\
http://c.biancheng.net/golang/\
http://c.biancheng.net/golang/

### 11.5.2读纯文本文件

打开并读取一个纯文本格式的数据跟写入纯文本格式数据一样简单。要解析文本来重建原始数据可能稍微复杂，这需根据格式的复杂性而定。\
\
示例代码如下所示：

1.  package main

2.  

3.  import (

4.  \"bufio\"

5.  \"fmt\"

6.  \"io\"

7.  \"os\"

8.  )

9.  

10. func main() {

11. //打开文件

12. file, err := os.Open(\"./output.txt\")

13. if err != nil {

14. fmt.Println(\"文件打开失败 = \", err)

15. }

16. //及时关闭 file 句柄，否则会有内存泄漏

17. defer file.Close()

18. //创建一个 \*Reader ， 是带缓冲的

19. reader := bufio.NewReader(file)

20. for {

21. str, err := reader.ReadString(\'\\n\') //读到一个换行就结束

22. if err == io.EOF { //io.EOF 表示文件的末尾

23. break

24. }

25. fmt.Print(str)

26. }

27. fmt.Println(\"文件读取结束\...\")

28. }

运行结果如下：

go run main.go\
http://c.biancheng.net/golang/\
http://c.biancheng.net/golang/\
http://c.biancheng.net/golang/\
文件读取结束\...

## 11.6 [二进制文件的读写操作](http://c.biancheng.net/view/4563.html)

Go语言二进制文件的读写操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Go语言的二进制（gob）格式是一个自描述的二进制序列。从其内部表示来看，Go语言的二进制格式由一个
0 块或者更多块的序列组成，其中的每一块都包含一个字节数，一个由 0
个或者多个 typeId-typeSpecification 对组成的序列，以及一个 typeId-value
对。\
\
如果 typeId-value 对的 typeId 是预先定义好的（例如 bool、int 和 string
等），则这些 typeId-typeSpecification
对可以省略。否则就用类型对来描述一个自定义类型（如一个自定义的结构体）。类型对和值对之间的
typeId 没有区别。\
\
正如我们将看到的，我们无需了解其内部结构就可以使用 gob 格式， 因为
encoding/gob 包会在幕后为我们打理好一切底层细节。\
\
Go语言中的 encoding/gob 包也提供了与 encoding/json
包一样的编码解码功能，并且容易使用。通常而言如果对肉眼可读性不做要求，gob
格式是Go语言上用于文件存储和网络传输最为方便的格式。

### 11.6.1写Go语言二进制文件

下面通过一个简单的示例来演示一下Go语言是如何生成一个二进制文件的，代码如下所示：

1.  package main

2.  

3.  import (

4.  \"encoding/gob\"

5.  \"fmt\"

6.  \"os\"

7.  )

8.  

9.  func main() {

10. info := \"http://c.biancheng.net/golang/\"

11. file, err := os.Create(\"./output.gob\")

12. if err != nil {

13. fmt.Println(\"文件创建失败\", err.Error())

14. return

15. }

16. defer file.Close()

17. 

18. encoder := gob.NewEncoder(file)

19. err = encoder.Encode(info)

20. if err != nil {

21. fmt.Println(\"编码错误\", err.Error())

22. return

23. } else {

24. fmt.Println(\"编码成功\")

25. }

26. }

运行上面的代码会在当前目录下生成一个 output.gob 文件，文件内容如下所示：

210c 001e 6874 7470 3a2f 2f63 2e62 6961\
6e63 6865 6e67 2e6e 6574 2f67 6f6c 616e\
672f 

### 11.6.2读Go语言二进制文件

读 gob 数据和写一样简单，示例代码如下：

1.  package main

2.  

3.  import (

4.  \"encoding/gob\"

5.  \"fmt\"

6.  \"os\"

7.  )

8.  

9.  func main() {

10. file, err := os.Open(\"./output.gob\")

11. if err != nil {

12. fmt.Println(\"文件打开失败\", err.Error())

13. return

14. }

15. defer file.Close()

16. 

17. decoder := gob.NewDecoder(file)

18. info := \"\"

19. err = decoder.Decode(&info)

20. if err != nil {

21. fmt.Println(\"解码失败\", err.Error())

22. } else {

23. fmt.Println(\"解码成功\")

24. fmt.Println(info)

25. }

26. }

运行结果如下：

go run main.go\
解码成功\
http://c.biancheng.net/golang/

## 11.7 [自定义二进制文件的读写操作](http://c.biancheng.net/view/4570.html)

Go语言自定义二进制文件的读写操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

虽然Go语言的 encoding/gob
包非常易用，而且使用时所需代码量也非常少，但是我们仍有可能需要创建自定义的二进制格式。自定义的二进制格式有可能做到最紧凑的数据表示，并且读写速度可以非常快。\
\
不过，在实际使用中，我们发现以Go语言二进制格式的读写通常比自定义格式要快非常多，而且创建的文件也不会大很多。但如果我们必须通过满足
gob.GobEncoder 和 gob.GobDecoder 接口来处理一些不可被 gob
编码的数据，这些优势就有可能会失去。\
\
在有些情况下我们可能需要与一些使用自定义二进制格式的软件交互，因此了解如何处理二进制文件就非常有用。

### 11.7.1写自定义二进制文件

Go语言的 encoding/binary 包中的 binary.Write()
函数使得以二进制格式写数据非常简单，函数原型如下：

func Write(w io.Writer, order ByteOrder, data interface{}) error

Write 函数可以将**参数 data 的 binary 编码格式写入参数 w 中**，参数 data
必须是定长值、定长值的切片、定长值的指针。参数 order
指定写入数据的字节序，写入结构体时，名字中有_的字段会置为 0。\
\
下面通过一个简单的示例程序来演示一下 Write 函数的使用，示例代码如下：

1.  package main

2.  

3.  import (

4.  \"bytes\"

5.  \"encoding/binary\"

6.  \"fmt\"

7.  \"os\"

8.  )

9.  

10. type Website struct {

11. Url int32

12. }

13. 

14. func main() {

15. file, err := **os.Create**(\"output.bin\")

16. for i := 1; i \<= 10; i++ {

17. info := Website{

18. int32(i),

19. }

20. if err != nil {

21. fmt.Println(\"文件创建失败 \", err.Error())

22. return

23. }

24. defer file.Close()

25. 

26. var bin_buf bytes.Buffer

27. binary.Write(&bin_buf, binary.LittleEndian, info)

28. b := bin_buf.Bytes()

29. \_, err = file.Write(b)

30. 

31. if err != nil {

32. fmt.Println(\"编码失败\", err.Error())

33. return

34. }

35. }

36. fmt.Println(\"编码成功\")

37. }

运行上面的程序会在当前目录下生成 output.bin 文件，文件内容如下：

0100 0000 0200 0000 0300 0000 0400 0000\
0500 0000 0600 0000 0700 0000 0800 0000\
0900 0000 0a00 0000 

### 11.7.2读自定义二进制文件

读取自定义的二进制数据与写自定义二进制数据一样简单。我们无需解析这类数据，只需使用与写数据时相同的字节顺序将数据读进相同类型的值中。\
\
示例代码如下：

1.  package main

2.  

3.  import (

4.  \"bytes\"

5.  \"encoding/binary\"

6.  \"fmt\"

7.  \"os\"

8.  )

9.  

10. type Website struct {

11. Url int32

12. }

13. 

14. func main() {

15. file, err := os.Open(\"output.bin\")

16. defer file.Close()

17. if err != nil {

18. fmt.Println(\"文件打开失败\", err.Error())

19. return

20. }

21. m := Website{}

22. for i := 1; i \<= 10; i++ {

23. data := readNextBytes(file, 4)

24. buffer := bytes.NewBuffer(data)

25. err = binary.Read(buffer, binary.LittleEndian, &m)

26. if err != nil {

27. fmt.Println(\"二进制文件读取失败\", err)

28. return

29. }

30. fmt.Println(\"第\", i, \"个值为：\", m)

31. }

32. }

33. 

34. func readNextBytes(file \*os.File, number int) \[\]byte {

35. bytes := make(\[\]byte, number)

36. 

37. \_, err := file.Read(bytes)

38. if err != nil {

39. fmt.Println(\"解码失败\", err)

40. }

41. 

42. return bytes

43. }

运行结果如下：

go run main.go\
第 1 个值为: {1}\
第 2 个值为: {2}\
第 3 个值为: {3}\
第 4 个值为: {4}\
第 5 个值为: {5}\
第 6 个值为: {6}\
第 7 个值为: {7}\
第 8 个值为: {8}\
第 9 个值为: {9}\
第 10 个值为: {10}

至此，我们完成了对自定义二进制数据的读和写操作。只要小心选择表示长度的整数符号和大小，并将该长度值写在变长值（如切片）的内容之前，那么使用二进制数据进行工作并不难。\
\
Go语言对二进制文件的支持还包括随机访问。这种情况下，我们必须使用
os.OpenFile() 函数来打开文件（而非
os.Open()），并给它传入合理的权限标志和模式（例如 os.O_RDWR
表示可读写）参数。\
\
然后，就可以使用 os.File.Seek() 方法来在文件中定位并读写，或者使用
os.File.ReadAt() 和 os.File.WriteAt()
方法来从特定的字节偏移中读取或者写入数据。\
\
Go语言还提供了其他常用的方法，包括 os.File.Stat() 方法，它返回的
os.FileInfo 包含了文件大小、权限以及日期时间等细节信息。

## 11.8 [zip归档文件的读写操作](http://c.biancheng.net/view/4583.html)

Go语言zip归档文件的读写操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Go语言的标准库提供了对几种压缩格式的支持，其中包括 gzip，因此 Go
程序可以无缝地读写 .gz 扩展名的 gzip 压缩文件或非 .gz
扩展名的非压缩文件。此外标准库也提供了读和写 .zip 文件、tar 包文件（.tar
和 .tar.gz），以及读 .bz2 文件（即 .tar .bz2 文件）的功能。\
\
本节我们将主要介绍 zip 归档文件的读写操作。

### 11.8.1创建 zip 归档文件

Go语言提供了 archive/zip
包来操作压缩文件，下面通过一个简单的的示例演示如何使用Go语言来创建一个
zip 文件，示例代码如下：

1.  package main

2.  

3.  import (

4.  \"archive/zip\"

5.  \"bytes\"

6.  \"fmt\"

7.  \"os\"

8.  )

9.  

10. func main() {

11. // 创建一个缓冲区用来保存压缩文件内容

12. buf := new(bytes.Buffer)

13. 

14. // 创建一个压缩文档

15. w := zip.NewWriter(buf)

16. 

17. // 将文件加入压缩文档

18. var files = \[\]struct {

19. Name, Body string

20. }{

21. {\"Golang.txt\", \"http://c.biancheng.net/golang/\"},

22. }

23. for \_, file := range files {

24. f, err := w.Create(file.Name)

25. if err != nil {

26. fmt.Println(err)

27. }

28. \_, err = f.Write(\[\]byte(file.Body))

29. if err != nil {

30. fmt.Println(err)

31. }

32. }

33. 

34. // 关闭压缩文档

35. err := w.Close()

36. if err != nil {

37. fmt.Println(err)

38. }

39. 

40. // 将压缩文档内容写入文件

41. f, err := os.OpenFile(\"file.zip\", os.O_CREATE\|os.O_WRONLY, 0666)

42. if err != nil {

43. fmt.Println(err)

44. }

45. buf.WriteTo(f)

46. }

运行上面的文件会在当前目录下生成 file.zip 文件，如下图所示：

![IMG_256](media/image1.png){width="7.302083333333333in"
height="0.7770833333333333in"}\
图：生成的压缩文件及文件的内容

### 11.8.2读取 zip 归档文件

读取一个 .zip
归档文件与创建一个归档文件一样简单，只是如果归档文件中包含带有路径的文件名，就必须重建目录结构。\
\
示例代码如下所示：

1.  package main

2.  

3.  import (

4.  \"archive/zip\"

5.  \"fmt\"

6.  \"io\"

7.  \"os\"

8.  )

9.  

10. func main() {

11. // 打开一个zip格式文件

12. r, err := zip.OpenReader(\"file.zip\")

13. if err != nil {

14. fmt.Printf(err.Error())

15. }

16. defer r.Close()

17. 

18. // 迭代压缩文件中的文件，打印出文件中的内容

19. for \_, f := range r.File {

20. fmt.Printf(\"文件名: %s\\n\", f.Name)

21. rc, err := f.Open()

22. if err != nil {

23. fmt.Printf(err.Error())

24. }

25. \_, err = io.CopyN(os.Stdout, rc, int64(f.UncompressedSize64))

26. if err != nil {

27. fmt.Printf(err.Error())

28. }

29. rc.Close()

30. }

31. }

运行结果如下：

go run main.go\
文件名: Golang.txt\
http://c.biancheng.net/golang/

## 11.9 [tar归档文件的读写操作](http://c.biancheng.net/view/4584.html)

Go语言tar归档文件的读写操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

在上一节《创建 .zip 归档文件》中我们介绍了 zip
归档文件的创建和读取，那么接下来介绍一下 tar 归档文件的创建及读取。

### 11.9.1创建 tar 归档文件

tar 是一种打包格式，但不对文件进行压缩，所以打包后的文档一般远远大于 zip
和 tar.gz，因为不需要压缩的原因，所以打包的速度是非常快的，打包时 CPU
占用率也很低。\
\
tar
的目的在于方便文件的管理，比如在我们的生活中，有很多小物品分散在房间的各个角落，为了方便整洁可以将这些零散的物品整理进一个箱子中，而
tar 的功能就类似这样。\
\
创建 tar 归档文件与创建 .zip
归档文件非常类似，主要不同点在于我们将所有数据都写入相同的 writer
中，并且在写入文件的数据之前必须写入完整的头部，而非仅仅是一个文件名。\
\
tar 打包实现原理如下：

-   创建一个文件 x.tar，然后向 x.tar 写入 tar 头部信息；

-   打开要被 tar 的文件，向 x.tar 写入头部信息，然后向 x.tar
    写入文件信息；

-   当有多个文件需要被 tar 时，重复第二步直到所有文件都被写入到 x.tar
    中；

-   关闭 x.tar，完成打包。

下面通过示例程序简单演示一下Go语言 tar 打包的实现：

1.  package main

2.  

3.  import (

4.  \"archive/tar\"

5.  \"fmt\"

6.  \"io\"

7.  \"os\"

8.  )

9.  

10. func main() {

11. f, err := os.Create(\"./output.tar\") //创建一个 tar 文件

12. if err != nil {

13. fmt.Println(err)

14. return

15. }

16. defer f.Close()

17. 

18. tw := tar.NewWriter(f)

19. defer tw.Close()

20. 

21. fileinfo, err := os.Stat(\"./main.exe\") //获取文件相关信息

22. if err != nil {

23. fmt.Println(err)

24. }

25. hdr, err := tar.FileInfoHeader(fileinfo, \"\")

26. if err != nil {

27. fmt.Println(err)

28. }

29. 

30. err = tw.WriteHeader(hdr) //写入头文件信息

31. if err != nil {

32. fmt.Println(err)

33. }

34. 

35. f1, err := os.Open(\"./main.exe\")

36. if err != nil {

37. fmt.Println(err)

38. return

39. }

40. m, err := io.Copy(tw, f1) //将main.exe文件中的信息写入压缩包中

41. if err != nil {

42. fmt.Println(err)

43. }

44. fmt.Println(m)

45. }

运行上面的代码会在当前目录下生成一个 output.tar 文件，如下图所示：

![IMG_256](media/image2.png){width="5.6819444444444445in"
height="2.8986111111111112in"}\
图：生成的 output.tar 文件

### 11.9.2解压 tar 归档文件

解压 tar 归档文件比创建 tar
归档文档稍微简单些。首先需要将其打开，然后从这个 tar
头部中循环读取存储在这个归档文件内的文件头信息，从这个文件头里读取文件名，以这个文件名创建文件，然后向这个文件里写入数据即可。\
\
示例代码如下所示：

1.  package main

2.  

3.  import (

4.  \"archive/tar\"

5.  \"fmt\"

6.  \"io\"

7.  \"os\"

8.  )

9.  

10. func main() {

11. f, err := os.Open(\"output.tar\")

12. if err != nil {

13. fmt.Println(\"文件打开失败\", err)

14. return

15. }

16. defer f.Close()

17. r := tar.NewReader(f)

18. for hdr, err := r.Next(); err != io.EOF; hdr, err = r.Next() {

19. if err != nil {

20. fmt.Println(err)

21. return

22. }

23. fileinfo := hdr.FileInfo()

24. fmt.Println(fileinfo.Name())

25. f, err := os.Create(\"123\" + fileinfo.Name())

26. if err != nil {

27. fmt.Println(err)

28. }

29. defer f.Close()

30. \_, err = io.Copy(f, r)

31. if err != nil {

32. fmt.Println(err)

33. }

34. }

35. }

运行上面的程序会将 tar 包的文件解压到当前目录中，如下图所示：

![IMG_257](media/image3.png){width="5.7652777777777775in"
height="1.525in"}\
图：解压 tar 包

至此，我们完成了对压缩和归档文件及常规文件处理的介绍。Go语言使用
io.Reader、io.ReadCloser、io.Writer 和 io.WriteCloser
等接口处理文件的方式让开发者可以使用相同的编码模式来读写文件或者其他流（如网络流或者甚至是字符串），从而大大降低了难度。

## 11.10 [Go语言使用buffer读取文件](http://c.biancheng.net/view/4595.html)

Go语言使用buffer读取文件

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

buffer 是缓冲器的意思，Go语言要实现缓冲读取需要使用到 bufio 包。bufio
包本身包装了 io.Reader 和 io.Writer 对象，同时创建了另外的 Reader 和
Writer 对象，因此对于文本 I/O 来说，bufio 包提供了一定的便利性。\
\
buffer
缓冲器的实现原理就是，将文件读取进缓冲（内存）之中，再次读取的时候就可以避免文件系统的
I/O
从而提高速度。同理在进行写操作时，先把文件写入缓冲（内存），然后由缓冲写入文件系统。

### 11.10.1使用 bufio 包写入文件

bufio 和 io 包中有很多操作都是相似的，唯一不同的地方是 bufio
提供了一些缓冲的操作，如果对文件 I/O 操作比较频繁的，使用 bufio
包能够提高一定的性能。\
\
在 bufio 包中，有一个 Writer
结构体，而其相关的方法支持一些写入操作，如下所示。

1.  //Writer 是一个空的结构体，一般需要使用 NewWriter 或者 NewWriterSize
    来初始化一个结构体对象

2.  type Writer struct {

3.  // contains filtered or unexported fields

4.  }

5.  

6.  //NewWriterSize 和 NewWriter 函数

7.  //返回默认缓冲大小的 Writer 对象(默认是4096)

8.  func NewWriter(w io.Writer) \*Writer

9.  

10. //指定缓冲大小创建一个 Writer 对象

11. func NewWriterSize(w io.Writer, size int) \*Writer

12. 

13. //Writer 对象相关的写入数据的方法

14. 

15. //把 p 中的内容写入 buffer，返回写入的字节数和错误信息。如果 nn \<
    len(p)，返回错误信息中会包含为什么写入的数据比较短

16. func (b \*Writer) Write(p \[\]byte) (nn int, err error)

17. //将 buffer 中的数据写入 io.Writer

18. func (b \*Writer) Flush() error

19. 

20. //以下三个方法可以直接写入到文件中

21. //写入单个字节

22. func (b \*Writer) WriteByte(c byte) error

23. //写入单个 Unicode 指针返回写入字节数错误信息

24. func (b \*Writer) WriteRune(r rune) (size int, err error)

25. //写入字符串并返回写入字节数和错误信息

26. func (b \*Writer) WriteString(s string) (int, error)

示例代码如下所示：

1.  package main

2.  

3.  import (

4.  \"bufio\"

5.  \"fmt\"

6.  \"os\"

7.  )

8.  

9.  func main() {

10. name := \"demo.txt\"

11. content := \"http://c.biancheng.net/golang/\"

12. 

13. fileObj, err := os.OpenFile(name,
    os.O_RDWR\|os.O_CREATE\|os.O_APPEND, 0644)

14. if err != nil {

15. fmt.Println(\"文件打开失败\", err)

16. }

17. 

18. defer fileObj.Close()

19. writeObj := bufio.NewWriterSize(fileObj, 4096)

20. 

21. //使用 Write 方法,需要使用 Writer 对象的 Flush 方法将 buffer
    中的数据刷到磁盘

22. buf := \[\]byte(content)

23. if \_, err := writeObj.Write(buf); err == nil {

24. if err := writeObj.Flush(); err != nil {

25. panic(err)

26. }

27. fmt.Println(\"数据写入成功\")

28. }

29. }

运行上面的代码会在当前目录之下生成 demo.txt
文件，并将"http://c.biancheng.net/golang/"写入到该文件中。

### 11.10.2使用 bufio 包读取文件

使用 bufio 包读取文件也非常方便，我们先来看下 bufio 包的相关的 Reader
函数方法：

1.  //首先定义了一个用来缓冲 io.Reader
    对象的结构体，同时该结构体拥有以下相关的方法

2.  type Reader struct {

3.  }

4.  

5.  //NewReader 函数用来返回一个默认大小 buffer 的 Reader
    对象（默认大小是 4096） 等同于 NewReaderSize(rd,4096)

6.  func NewReader(rd io.Reader) \*Reader

7.  

8.  //该函数返回一个指定大小 buffer（size 最小为 16）的 Reader
    对象，如果 io.Reader 参数已经是一个足够大的 Reader，它将返回该
    Reader

9.  func NewReaderSize(rd io.Reader, size int) \*Reader

10. 

11. //该方法返回从当前 buffer 中能被读到的字节数

12. func (b \*Reader) Buffered() int

13. 

14. //Discard 方法跳过后续的 n 个字节的数据，返回跳过的字节数。如果 0
    \<= n \<= b.Buffered()，该方法将不会从 io.Reader 中成功读取数据

15. func (b \*Reader) Discard(n int) (discarded int, err error)

16. 

17. //Peekf 方法返回缓存的一个切片，该切片只包含缓存中的前 n
    个字节的数据

18. func (b \*Reader) Peek(n int) (\[\]byte, error)

19. 

20. //把 Reader 缓存对象中的数据读入到 \[\]byte 类型的 p
    中，并返回读取的字节数。读取成功，err 将返回空值

21. func (b \*Reader) Read(p \[\]byte) (n int, err error)

22. 

23. //返回单个字节，如果没有数据返回 err

24. func (b \*Reader) ReadByte() (byte, error)

25. 

26. //该方法在 b 中读取 delimz
    之前的所有数据，返回的切片是已读出的数据的引用，切片中的数据在下一次的读取操作之前是有效的。如果未找到
    delim，将返回查找结果并返回 nil
    空值。因为缓存的数据可能被下一次的读写操作修改，因此一般使用
    ReadBytes 或者 ReadString，他们返回的都是数据拷贝

27. func (b \*Reader) ReadSlice(delim byte) (line \[\]byte, err error)

28. 

29. //功能同 ReadSlice，返回数据的拷贝

30. func (b \*Reader) ReadBytes(delim byte) (\[\]byte, error)

31. 

32. //功能同 ReadBytes，返回字符串

33. func (b \*Reader) ReadString(delim byte) (string, error)

34. 

35. //该方法是一个低水平的读取方式，一般建议使用 ReadBytes(\'\\n\') 或
    ReadString(\'\\n\')，或者使用一个 Scanner 来代替。ReadLine 通过调用
    ReadSlice
    方法实现，返回的也是缓存的切片，用于读取一行数据，不包括行尾标记（\\n
    或 \\r\\n）

36. func (b \*Reader) ReadLine() (line \[\]byte, isPrefix bool, err
    error)

37. 

38. //读取单个 UTF-8 字符并返回一个 rune 和字节大小

39. func (b \*Reader) ReadRune() (r rune, size int, err error)

示例代码如下：

1.  package main

2.  

3.  import (

4.  \"bufio\"

5.  \"fmt\"

6.  \"os\"

7.  \"strconv\"

8.  )

9.  

10. func main() {

11. fileObj, err := os.Open(\"demo.txt\")

12. if err != nil {

13. fmt.Println(\"文件打开失败：\", err)

14. return

15. }

16. defer fileObj.Close()

17. //一个文件对象本身是实现了io.Reader的
    使用bufio.NewReader去初始化一个Reader对象，存在buffer中的，读取一次就会被清空

18. reader := bufio.NewReader(fileObj)

19. buf := make(\[\]byte, 1024)

20. //读取 Reader 对象中的内容到 \[\]byte 类型的 buf 中

21. info, err := reader.Read(buf)

22. if err != nil {

23. fmt.Println(err)

24. }

25. fmt.Println(\"读取的字节数:\" + strconv.Itoa(info))

26. //这里的buf是一个\[\]byte，因此如果需要只输出内容，仍然需要将文件内容的换行符替换掉

27. fmt.Println(\"读取的文件内容:\", string(buf))

28. }

运行结果如下：

go run main.go\
读取的字节数:30\
读取的文件内容: http://c.biancheng.net/golang/

## 11.11 [示例：并发目录遍历](http://c.biancheng.net/view/vip_7359.html)

在本节中，我们将构建一个程序，根据命令行指定的输入，报告一个或多个目录的磁盘使用情况，类似于
UNIX 的du命令。该程序大多数工作是由下面的 walkDir 函数完成，它使用
dirents 辅助函数来枚举目录中的条目，如下所示：

// wakjDir 递归地遍历以 dir 为根目录的整个文件树，并在 filesizes
上发送每个已找到文件的大小

func walkDir(dir string, fileSizes chan\<- int64) {

for \_, entry := range dirents(dir) {

if entry.IsDir() {

subdir := filepath.Join(dir, entry.Name())

walkDir(subdir, fileSizes)

} else {

fileSizes \<- entry.Size()

}

}}

// dirents 返回 dir 目录中的条目

func dirents(dir string) \[\]os.FileInfo {

entries, err := ioutil.ReadDir(dir)

if err != nil {

fmt.Fprintf(os.Stderr, \"du1: %v\\n\", err)

return nil

}

return entries

}

ioutil.ReadDir 函数返回一个 os.FileInfo 类型的
slice，针对单个文件同样的信息可以通过调用 os.Stat
函数来返回。对每一个子目录，walkDir
递归调用它自己，对于每一个文件，walkDir 发送一条消息到 fileSizes
通道，消息的内容为文件所占用的字节数。

程序的完整代码如下所示，代码中 main 函数使用两个 goroutine，后台
goroutine 调用 walkDir 遍历命令行上指定的每一个目录，最后关闭 fileSizes
通道；主 goroutine 计算从通道中接收的文件的大小的和，最后输出总数。

package main

import (

\"flag\"

\"fmt\"

\"io/ioutil\"

\"os\"

\"path/filepath\"

)

func main() {

// 确定初始目录

flag.Parse()

roots := flag.Args()

if len(roots) == 0 {

roots = \[\]string{\".\"}

}

// 遍历文件树

fileSizes := make(chan int64)

go func() {

for \_, root := range roots {

walkDir(root, fileSizes)

}

close(fileSizes)

}()

// 输出结果

var nfiles, nbytes int64

for size := range fileSizes {

nfiles++

nbytes += size

}

printDiskUsage(nfiles, nbytes)

}

func printDiskUsage(nfiles, nbytes int64) {

fmt.Printf(\"%d files %.1f GB\\n\", nfiles, float64(nbytes)/1e9)

}

// wakjDir 递归地遍历以 dir 为根目录的整个文件树,并在 filesizes
上发送每个已找到的文件的大小

func walkDir(dir string, fileSizes chan\<- int64) {

for \_, entry := range dirents(dir) {

if entry.IsDir() {

subdir := filepath.Join(dir, entry.Name())

walkDir(subdir, fileSizes)

} else {

fileSizes \<- entry.Size()

}

}}

// dirents 返回 dir 目录中的条目

func dirents(dir string) \[\]os.FileInfo {

entries, err := ioutil.ReadDir(dir)

if err != nil {

fmt.Fprintf(os.Stderr, \"du1: %v\\n\", err)

return nil

}

return entries

}

在输出结果前，程序等待较长时间：

go run main.go D:/code\
18681 files  0.5 GB

如果程序可以通知它的进度，将会更友好，但是仅把 printDiskUsage
调用移动到循环内部会使它输出数千行结果，所以这里对上面的程序进行一些调整，在有-v标识的时候周期性的输出当前目录的总和，如果只想看到最终的结果省略-v即可。

package main

import (

\"flag\"

\"fmt\"

\"io/ioutil\"

\"os\"

\"path/filepath\"

\"time\"

)

var verbose = flag.Bool(\"v\", false, \"显示详细进度\")

func main() {

// \...启动后台 goroutine\...

// 确定初始目录

flag.Parse()

roots := flag.Args()

if len(roots) == 0 {

roots = \[\]string{\".\"}

}

// 遍历文件树

fileSizes := make(chan int64)

go func() {

for \_, root := range roots {

walkDir(root, fileSizes)

}

close(fileSizes)

}()

// 定期打印结果

var tick \<-chan time.Time

if \*verbose {

tick = time.Tick(500 \* time.Millisecond)

}

var nfiles, nbytes int64

loop:

for {

select {

case size, ok := \<-fileSizes:

if !ok {

break loop

// fileSizes 关闭

}

nfiles++

nbytes += size

case \<-tick:

printDiskUsage(nfiles, nbytes)

}

}

printDiskUsage(nfiles, nbytes)// 最终总数

}

func printDiskUsage(nfiles, nbytes int64) {

fmt.Printf(\"%d files %.1f GB\\n\", nfiles, float64(nbytes)/1e9)

}

// wakjDir 递归地遍历以 dir 为根目录的整个文件树,并在 filesizes
上发送每个已找到的文件的大小

func walkDir(dir string, fileSizes chan\<- int64) {

for \_, entry := range dirents(dir) {

if entry.IsDir() {

subdir := filepath.Join(dir, entry.Name())

walkDir(subdir, fileSizes)

} else {

fileSizes \<- entry.Size()

}

}}

// dirents 返回 dir 目录中的条目

func dirents(dir string) \[\]os.FileInfo {

entries, err := ioutil.ReadDir(dir)

if err != nil {

fmt.Fprintf(os.Stderr, \"du1: %v\\n\", err)

return nil

}

return entries

}

因为这个程序没有使用 range 循环，所以第一个 select 情况必须显式判断
fileSizes
通道是否已经关闭，使用两个返回值的形式进行接收操作。如果通道已经关闭，程序退出循环。标签化的
break 语句将跳出 select 和 for 循环的逻辑。没有标签的 break 只能跳出
select 的逻辑，导致循环的下一次迭代。

运行结果如下所示：

go run main.go -v D:\\\
296077 files  57.9 GB\
302142 files  58.0 GB\
306669 files  58.1 GB\
314725 files  58.2 GB\
320050 files  58.3 GB\
341713 files  58.6 GB\
346102 files  64.2 GB

此程序的弊端也很明显，它依然会耗费太长的时间。

所以，下面为每一个 walkDir 的调用创建一个新的 goroutine。它使用
sync.WaitGroup 来为当前存活的 walkDir 调用计数，一个 goroutine
在计数器减为 0 的时候关闭 fileSizes 通道。

package mainimport ( \"flag\" \"fmt\" \"io/ioutil\" \"os\"
\"path/filepath\" \"sync\" \"time\")var verbose = flag.Bool(\"v\",
false, \"显示详细进度\")func main() { // \...确定根目录\... flag.Parse()
// 确定初始目录 roots := flag.Args() if len(roots) == 0 { roots =
\[\]string{\".\"} } // 并行遍历每一个文件树 fileSizes := make(chan
int64) var n sync.WaitGroup for \_, root := range roots { n.Add(1) go
walkDir(root, &n, fileSizes) } go func() { n.Wait() close(fileSizes) }()
// 定期打印结果 var tick \<-chan time.Time if \*verbose { tick =
time.Tick(500 \* time.Millisecond) } var nfiles, nbytes int64loop: for {
select { case size, ok := \<-fileSizes: if !ok { break loop // fileSizes
关闭 } nfiles++ nbytes += size case \<-tick: printDiskUsage(nfiles,
nbytes) } } printDiskUsage(nfiles, nbytes) // 最终总数}func
printDiskUsage(nfiles, nbytes int64) { fmt.Printf(\"%d files %.1f
GB\\n\", nfiles, float64(nbytes)/1e9)}func walkDir(dir string, n
\*sync.WaitGroup, fileSizes chan\<- int64) { defer n.Done() for \_,
entry := range dirents(dir) { if entry.IsDir() { n.Add(1) subdir :=
filepath.Join(dir, entry.Name()) go walkDir(subdir, n, fileSizes) } else
{ fileSizes \<- entry.Size() } }}//
sema是一个用于限制目录并发数的计数信号量var sema = make(chan struct{},
20)// dirents返回directory目录中的条目func dirents(dir string)
\[\]os.FileInfo { sema \<- struct{}{} // 获取令牌 defer func() { \<-sema
}() // 释放令牌 entries, err := ioutil.ReadDir(dir) if err != nil {
fmt.Fprintf(os.Stderr, \"du: %v\\n\", err) return nil } return entries}

尽管系统与系统之间有很多的不同，但是这个版本的速度比前一个版本快几倍。

## 11.12 [示例：从INI配置文件中读取需要的值](http://c.biancheng.net/view/vip_7360.html)

INI 文件是 Initialization File 的缩写，即初始化文件，是 Windows
的系统配置文件所采用的存储格式，统管 Windows 的各项配置。INI
文件格式由节（section）和键（key）构成，一般用于操作系统、虚幻游戏引擎、GIT
版本管理中，这种配置文件的文件扩展名为.ini。

下面是从 GIT 版本管理的配置文件中截取的一部分内容，展示 INI 文件的样式。

\[core\]\
repositoryformatversion = 0

filemode = false\
bare = false\
logallrefupdates = true\
symlinks = false\
ignorecase = true\
hideDotFiles = dotGitOnly\
\[remote \"origin\"\]\
url = https://github.com/davyxu/cellnet\
fetch = +refs/heads/\*:refs/remotes/origin/\*\
\[branch \"master\"\]\
remote = origin\
merge = refs/heads/master

### 11.12.1 INI 文件的格式

INI 文件由多行文本组成，整个配置由\[
\]拆分为多个"段"（section）。每个段中又以＝分割为"键"和"值"。

INI 文件以;置于行首视为注释，注释后将不会被处理和识别，如下所示：

\[sectionl\]\
key1=value1\
;key2=value2\
\[section2\]

### 11.12.2从 INI 文件中取值的函数

熟悉了 INI 文件的格式后，下面我们创建一个 example.ini 文件，并将从 GIT
版本管理配置文件中截取的一部分内容复制到该文件中。

准备好 example.ini 文件后，下面我们开始尝试读取该 INI
文件，并从文件中获取需要的数据，完整的示例代码如下所示：

package mainimport ( \"bufio\" \"fmt\" \"os\" \"strings\")//
根据文件名，段名，键名获取ini的值func getValue(filename, expectSection,
expectKey string) string { // 打开文件 file, err := os.Open(filename) //
文件找不到，返回空 if err != nil { return \"\" } //
在函数结束时，关闭文件 defer file.Close() // 使用读取器读取文件 reader
:= bufio.NewReader(file) // 当前读取的段的名字 var sectionName string
for { // 读取文件的一行 linestr, err := reader.ReadString(\'\\n\') if
err != nil { break } // 切掉行的左右两边的空白字符 linestr =
strings.TrimSpace(linestr) // 忽略空行 if linestr == \"\" { continue }
// 忽略注释 if linestr\[0\] == \';\' { continue } //
行首和尾巴分别是方括号的，说明是段标记的起止符 if linestr\[0\] == \'\[\'
&& linestr\[len(linestr)-1\] == \'\]\' { // 将段名取出 sectionName =
linestr\[1 : len(linestr)-1\] // 这个段是希望读取的 } else if
sectionName == expectSection { // 切开等号分割的键值对 pair :=
strings.Split(linestr, \"=\") // 保证切开只有1个等号分割的简直情况 if
len(pair) == 2 { // 去掉键的多余空白字符 key :=
strings.TrimSpace(pair\[0\]) // 是期望的键 if key == expectKey { //
返回去掉空白字符的值 return strings.TrimSpace(pair\[1\]) } } } } return
\"\"}func main() { fmt.Println(getValue(\"example.ini\", \"remote
\\\"origin\\\"\", \"fetch\")) fmt.Println(getValue(\"example.ini\",
\"core\", \"hideDotFiles\"))}

本例并不是将整个 INI 文件读取保存后再获取需要的字段数据并返回，这里使用
getValue()
函数，每次从指定文件中找到需要的段（Section）及键（Key）对应的值。

getValue() 函数的声明如下：

func getValue(filename, expectSection, expectKey string) string

参数说明如下。

-   filename：INI 文件的文件名。

-   expectSection：期望读取的段。

-   expectKey：期望读取段中的键。

getValue() 函数的实际使用例子参考代码如下：

func main() {\
    fmt.Println(getValue(\"example.ini\", \"remote \\\"origin\\\"\",
\"fetch\"))\
    fmt.Println(getValue(\"example.ini\", \"core\", \"hideDotFiles\"))\
}

运行上面的示例程序，输出结果如下：

+refs/heads/\*:refs/remotes/origin/\*\
dotGitOnly

输出内容中"+refs/heads/\*:refs/remotes/origin/\*"表示 INI 文件中\[remote
\"origin\"\]的 \"fetch\" 键对应的值；dotGitOnly 表示 INI
文件中\[core\]中键名为 \"hideDotFiles\" 的值。

注意 main 函数的第 2 行中，由于段名中包含双引号，所以使用\\进行转义。

getValue() 函数的逻辑由 4
部分组成：即读取文件、读取行文本、读取段和读取键值组成。接下来分步骤了解
getValue() 函数的详细处理过程。

### 11.12.3读取文件

Go语言的 OS 包中提供了文件打开函数
os.Open()，文件读取完成后需要及时关闭，否则文件会发生占用，系统无法释放缓冲资源。参考下面代码：

// 打开文件file, err := os.Open(filename)// 文件找不到，返回空if err !=
nil { return \"\"}// 在函数结束时，关闭文件defer file.Close()

代码说明如下：

-   第 2 行，filename 是由 getValue() 函数参数提供的 INI 的文件名。使用
    os.Open()
    函数打开文件，如果成功打开，会返回文件句柄，同时返回打开文件时可能发生的错误：err。

-   第 5 行，如果文件打开错误，err 将不为 nil，此时 getValue()
    函数返回一个空的字符串，表示无法从给定的 INI 文件中获取到需要的值。

-   第 10 行，使用 defer 延迟执行函数，defer
    并不会在这一行执行，而是延迟在任何一个 getValue()
    函数的返回点，也就是函数退出的地方执行。调用 file.Close()
    函数后，打开的文件就会被关闭并释放系统资源。

INI 文件已经打开了，接下来就可以开始读取 INI 的数据了。

### 11.12.4读取行文本

INI 文件的格式是由多行文本组成，因此需要构造一个循环，不断地读取 INI
文件的所有行。Go语言总是将文件以二进制格式打开，通过不同的读取方式对二进制文件进行操作。Go语言对二进制读取有专门的代码，bufio
包即可以方便地以比较常见的方式读取二进制文件。

// 使用读取器读取文件reader := bufio.NewReader(file)//
当前读取的段的名字var sectionName stringfor { // 读取文件的一行 linestr,
err := reader.ReadString(\'\\n\') if err != nil { break } //
切掉行的左右两边的空白字符 linestr = strings.TrimSpace(linestr) //
忽略空行 if linestr == \"\" { continue } // 忽略注释 if linestr\[0\] ==
\';\' { continue } //读取段和键值的代码 //\...}

代码说明如下：

-   第 2 行，使用 bufio 包提供的 NewReader()
    函数，传入文件并构造一个读取器。

-   第 5 行，提前声明段的名字字符串，方便后面的段和键值读取。

-   第 7 行，构建一个读取循环，不断地读取文件中的每一行。

-   第 10 行，使用 reader.ReadString()
    从文件中读取字符串，直到碰到\\n，也就是行结束。这个函数返回读取到的行字符串（包括\\n）和可能的读取错误
    err，例如文件读取完毕。

-   第 16
    行，每一行的文本可能会在标识符两边混杂有空格、回车符、换行符等不可见的空白字符，使用
    strings.TrimSpace() 可以去掉这些空白字符。

-   第 19 行，可能存在空行的情况，继续读取下一行，忽略空行。

-   第 24
    行，当行首的字符为;分号时，表示这一行是注释行，忽略一整行的读取。

读取 INI
文本文件时，需要注意各种异常情况。文本中的空白符就是经常容易忽略的部分，空白符在调试时完全不可见，需要打印出字符的
ASCII 码才能辨别。

抛开各种异常情况拿到了每行的行文本 linestr 后，就可以方便地读取 INI
文件的段和键值了。

### 11.12.5读取段

行字符串 linestr
已经去除了空白字符串，段的起止符又以\[开头，以\]结尾，因此可以直接判断行首和行尾的字符串匹配段的起止符匹配时读取的是段，如下图所示。

![IMG_256](media/image4.png){width="3.670138888888889in"
height="2.2381944444444444in"}\
图：INI 文件的段名解析

此时，段只是一个标识，而无任何内容，因此需要将段的名字取出保存在
sectionName（己在之前的代码中定义）中，待读取段后面的键值对时使用。

// 行首和尾巴分别是方括号的，说明是段标记的起止符if linestr\[0\] ==
\'\[\' && linestr\[len(linestr)-1\] == \'\]\' { // 将段名取出
sectionName = linestr\[1 : len(linestr)-1\] // 这个段是希望读取的}

代码说明如下：

-   第 2
    行，linestr\[0\]表示行首的字符，len(linestr)-1取出字符串的最后一个字符索引随后取出行尾的字符。根据两个字符串是否匹配方括号，断定当前行是否为段。

-   第 5 行，linestr 两边的\[和\]去掉，取出中间的段名保存在 sectionName
    中，留着后面的代码用。

### 11.12.6读取键值

这里代码紧接着前面的代码。当前行不是段时（不以\[开头），那么行内容一定是键值对。别忘记此时
getValue()
的参数对段有匹配要求。找到能匹配段的键值对后，开始对键值对进行解析，参考下面的代码：

else if sectionName == expectSection { // 切开等号分割的键值对 pair :=
strings.Split(linestr, \"=\") // 保证切开只有1个等号分割的简直情况 if
len(pair) == 2 { // 去掉键的多余空白字符 key :=
strings.TrimSpace(pair\[0\]) // 是期望的键 if key == expectKey { //
返回去掉空白字符的值 return strings.TrimSpace(pair\[1\]) } }}

代码说明如下：

-   第 1 行，当前的段匹配期望的段时，进行后面的解析。

-   第 4 行，对行内容（linestr）通过 strings.Split() 函数进行切割，INI
    的键值对使用=分割，分割后 strings.Split()
    函数会返回字符串切片，其类型为
    \[\]string。这里只考虑一个=的情况，因此被分割后 strings.Split()
    函数返回的字符串切片有 2 个元素。

-   第 7 行，只考虑切割出 2 个元素的情况。其他情况会被忽略，
    键值如没有=、行中多余一个=等情况。

-   第 10 行，pair\[0\] 表示=左边的键。使用 strings.TrimSpace()
    函数去掉空白符，如下图所示。

-   第 13 行，键值对切割出后，还需要判断键是否为期望的键。

-   第 16 行，匹配期望的键时，将 pair\[1\]
    中保存的键对应的值经过去掉空白字符处理后作为函数返回值返回。

![IMG_257](media/image5.png){width="2.0854166666666667in"
height="1.0277777777777777in"}\
图：lNI 的键值解析

## 11.13 [文件的写入、追加、读取、复制操作](http://c.biancheng.net/view/5729.html)

Go语言文件的写入、追加、读取、复制操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Go语言的 os 包下有一个 OpenFile 函数，其原型如下所示：

func OpenFile(name string, flag int, perm FileMode) (file \*File, err
error)

其中 name 是文件的文件名，如果不是在当前路径下运行需要加上具体路径；flag
是文件的处理参数，为 int
类型，根据系统的不同具体值可能有所不同，但是作用是相同的。\
\
下面列举了一些常用的 flag 文件处理参数：

-   O_RDONLY：只读模式打开文件；

-   O_WRONLY：只写模式打开文件；

-   O_RDWR：读写模式打开文件；

-   O_APPEND：写操作时将数据附加到文件尾部（追加）；

-   O_CREATE：如果不存在将创建一个新文件；

-   O_EXCL：和 O_CREATE 配合使用，文件必须不存在，否则返回一个错误；

-   O_SYNC：当进行一系列写操作时，每次都要等待上次的 I/O
    操作完成再进行；

-   O_TRUNC：如果可能，在打开时清空文件。

【示例 1】：创建一个新文件 golang.txt，并在其中写入 5
句"http://c.biancheng.net/golang/"。

1.  package main

2.  

3.  import (

4.      \"bufio\"

5.      \"fmt\"

6.      \"os\"

7.  )

8.  

9.  func main() {

10.     //创建一个新文件，写入内容 5 句 "http://c.biancheng.net/golang/"

11.     filePath := \"e:/code/golang.txt\"

12.     file, err := os.OpenFile(filePath, os.O_WRONLY\|os.O_CREATE,
    0666)

13.     if err != nil {

14.         fmt.Println(\"文件打开失败\", err)

15.     }

16.     //及时关闭file句柄

17.     defer file.Close()

18. 

19.     //写入文件时，使用带缓存的 \*Writer

20.     write := bufio.NewWriter(file)

21.     for i := 0; i \< 5; i++ {

22.         write.WriteString(\"http://c.biancheng.net/golang/ \\n\")

23.     }

24.     //Flush将缓存的文件真正写入到文件中

25.     write.Flush()

26. }

执行成功之后会在指定目录下生成一个 golang.txt
文件，打开该文件如下图所示：

![IMG_256](media/image6.png){width="5.5993055555555555in"
height="3.165277777777778in"}

【示例 2】：打开一个存在的文件，在原来的内容追加内容"C语言中文网"

1.  package main

2.  

3.  import (

4.      \"bufio\"

5.      \"fmt\"

6.      \"os\"

7.  )

8.  

9.  func main() {

10.     filePath := \"e:/code/golang.txt\"

11.     file, err := os.OpenFile(filePath, os.O_WRONLY\|os.O_APPEND,
    0666)

12.     if err != nil {

13.         fmt.Println(\"文件打开失败\", err)

14.     }

15.     //及时关闭file句柄

16.     defer file.Close()

17. 

18.     //写入文件时，使用带缓存的 \*Writer

19.     write := bufio.NewWriter(file)

20.     for i := 0; i \< 5; i++ {

21.         write.WriteString(\"C语言中文网 \\r\\n\")

22.     }

23.     //Flush将缓存的文件真正写入到文件中

24.     write.Flush()

25. }

执行成功之后，打开 golang.txt 文件发现内容追加成功，如下图所示：

![IMG_257](media/image7.png){width="6.25in"
height="4.552083333333333in"}

【示例 3】：打开一个存在的文件，将原来的内容读出来，显示在终端，并且追加
5 句"Hello，C语言中文网"。

1.  package main

2.  

3.  import (

4.      \"bufio\"

5.      \"fmt\"

6.      \"io\"

7.      \"os\"

8.  )

9.  

10. func main() {

11.     filePath := \"e:/code/golang.txt\"

12.     file, err := os.OpenFile(filePath, os.O_RDWR\|os.O_APPEND, 0666)

13.     if err != nil {

14.         fmt.Println(\"文件打开失败\", err)

15.     }

16.     //及时关闭file句柄

17.     defer file.Close()

18. 

19.     //读原来文件的内容，并且显示在终端

20.     reader := bufio.NewReader(file)

21.     for {

22.         str, err := reader.ReadString(\'\\n\')

23.         if err == io.EOF {

24.             break

25.         }

26.         fmt.Print(str)

27.     }

28. 

29.     //写入文件时，使用带缓存的 \*Writer

30.     write := bufio.NewWriter(file)

31.     for i := 0; i \< 5; i++ {

32.         write.WriteString(\"Hello，C语言中文网。 \\r\\n\")

33.     }

34.     //Flush将缓存的文件真正写入到文件中

35.     write.Flush()

36. }

执行成功之后，会在控制台打印出文件的内容，并在文件中追加指定的内容，如下图所示：

![IMG_258](media/image8.png){width="6.25in"
height="5.656944444444444in"}

【示例
4】：编写一个程序，将一个文件的内容复制到另外一个文件（注：这两个文件都已存在）

1.  package main

2.  

3.  import (

4.      \"fmt\"

5.      \"io/ioutil\"

6.  )

7.  

8.  func main() {

9.      file1Path := \"e:/code/golang.txt\"

10.     file2Path := \"e:/code/other.txt\"

11.     data, err := ioutil.ReadFile(file1Path)

12.     if err != nil {

13.         fmt.Printf(\"文件打开失败=%v\\n\", err)

14.         return

15.     }

16.     err = ioutil.WriteFile(file2Path, data, 0666)

17.     if err != nil {

18.         fmt.Printf(\"文件打开失败=%v\\n\", err)

19.     }

20. }

执行成功后，发现内容已经复制成功，如下图所示：

![IMG_259](media/image9.png){width="6.56875in"
height="5.8493055555555555in"}

## 11.14 [Go语言文件锁操作](http://c.biancheng.net/view/5730.html)

Go语言文件锁操作

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

我们使用Go语言开发一些程序的时候，往往出现多个进程同时操作同一份文件的情况，这很容易导致文件中的数据混乱。这时我们就需要采用一些手段来平衡这些冲突，文件锁（flock）应运而生，下面我们就来介绍一下。\
\
对于 flock，最常见的例子就是 Nginx，进程运行起来后就会把当前的 PID
写入这个文件，当然如果这个文件已经存在了，也就是前一个进程还没有退出，那么
Nginx 就不会重新启动，所以 flock 还可以用来检测进程是否存在。\
\
flock
是对于整个文件的建议性锁。也就是说，如果一个进程在一个文件（inode）上放了锁，其它进程是可以知道的（建议性锁不强求进程遵守）。最棒的一点是，它的第一个参数是文件描述符，在此文件描述符关闭时，锁会自动释放。而当进程终止时，所有的文件描述符均会被关闭。所以很多时候就不用考虑类似原子锁解锁的事情。\
\
在具体介绍前，先上代码

1.  package main

2.  

3.  import (

4.  \"fmt\"

5.  \"os\"

6.  \"sync\"

7.  \"syscall\"

8.  \"time\"

9.  )

10. 

11. //文件锁

12. type FileLock struct {

13. dir string

14. f \*os.File

15. }

16. 

17. func New(dir string) \*FileLock {

18. return &FileLock{

19. dir: dir,

20. }

21. }

22. 

23. //加锁

24. func (l \*FileLock) Lock() error {

25. f, err := os.Open(l.dir)

26. if err != nil {

27. return err

28. }

29. l.f = f

30. err = syscall.Flock(int(f.Fd()), syscall.LOCK_EX\|syscall.LOCK_NB)

31. if err != nil {

32. return fmt.Errorf(\"cannot flock directory %s - %s\", l.dir, err)

33. }

34. return nil

35. }

36. 

37. //释放锁

38. func (l \*FileLock) Unlock() error {

39. defer l.f.Close()

40. return syscall.Flock(int(l.f.Fd()), syscall.LOCK_UN)

41. }

42. 

43. func main() {

44. test_file_path, \_ := os.Getwd()

45. locked_file := test_file_path

46. 

47. wg := sync.WaitGroup{}

48. 

49. for i := 0; i \< 10; i++ {

50. wg.Add(1)

51. go func(num int) {

52. flock := New(locked_file)

53. err := flock.Lock()

54. if err != nil {

55. wg.Done()

56. fmt.Println(err.Error())

57. return

58. }

59. fmt.Printf(\"output : %d\\n\", num)

60. wg.Done()

61. }(i)

62. }

63. wg.Wait()

64. time.Sleep(2 \* time.Second)

65. 

66. }

在 Windows 系统下运行上面的代码会出现下面的错误：

undefined: syscall.Flock\
undefined: syscall.LOCK_EX\
undefined: syscall.LOCK_NB\
undefined: syscall.Flock\
undefined: syscall.LOCK_UN

这是因为 Windows 系统不支持 pid 锁，所以我们需要在 Linux 或 Mac
系统下才能正常运行上面的程序。\
\
上面代码中演示了同时启动 10 个 goroutinue，但在程序运行过程中，只有一个
goroutine 能获得文件锁（flock）。其它的 goroutinue 在获取不到 flock
后，会抛出异常的信息。这样即可达到同一文件在指定的周期内只允许一个进程访问的效果。\
\
代码中文件锁的具体调用：

syscall.Flock(int(f.Fd()), syscall.LOCK_EX\|syscall.LOCK_NB)

我们采用了 syscall.LOCK_EX、syscall.LOCK_NB，这是什么意思呢？\
\
flock 属于建议性锁，不具备强制性。一个进程使用 flock
将文件锁住，另一个进程可以直接操作正在被锁的文件，修改文件中的数据，原因在于
flock
只是用于检测文件是否被加锁，针对文件已经被加锁，另一个进程写入数据的情况，内核不会阻止这个进程的写入操作，也就是建议性锁的内核处理策略。\
\
flock 主要三种操作类型：

-   LOCK_SH：共享锁，多个进程可以使用同一把锁，常被用作读共享锁；

-   LOCK_EX：排他锁，同时只允许一个进程使用，常被用作写锁；

-   LOCK_UN：释放锁。

进程使用 flock
尝试锁文件时，如果文件已经被其他进程锁住，进程会被阻塞直到锁被释放掉，或者在调用
flock 的时候，采用 LOCK_NB
参数。在尝试锁住该文件的时候，发现已经被其他服务锁住，会返回错误，错误码为
EWOULDBLOCK。\
\
flock 锁的释放非常具有特色，即可调用 LOCK_UN
参数来释放文件锁，也可以通过关闭 fd 的方式来释放文件锁（flock
的第一个参数是 fd），意味着 flock 会随着进程的关闭而被自动释放掉。
