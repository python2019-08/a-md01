[15.5+1 C语言和go语言之间的交互操作方法](\l)
    [一、go代码中使用C代码](\l)
    [二、C语言中使用go语言](\l)
    [三、C语言中使用go语言，使用的go语言又使用了c语言](\l)



## 15.5+1 C语言和go语言之间的交互操作方法

2021-05-17 16:06jingxian C/C++

下面小编就为大家带来一篇C语言和go语言之间的交互操作方法。小编觉得挺不错的，现在就分享给大家，也给大家做个参考。一起跟随小编过来看看吧

### **一、go代码中使用C代码**

go代码中使用C代码，在[go语言](http://www.zzvips.com/article/155730.html)的函数块中，以注释的方式写入C代码,然后紧跟import “C” 即可在go代码中使用C函数

<img src="./media15/media/image3.png" style="width:4.29583in;height:0.90625in" alt="C语言和go语言之间的交互操作方法" />

**代码示例：**

**go代码：testC.go**

?

<table>
<colgroup>
<col style="width: 5%" />
<col style="width: 94%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p>
<p>12</p>
<p>13</p>
<p>14</p>
<p>15</p>
<p>16</p>
<p>17</p></td>
<td><p>package main</p>
<p>/*</p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;stdlib.h&gt;</p>
<p>void c_print(char *str) {</p>
<p> printf("%s\n", str);</p>
<p>}</p>
<p>*/</p>
<p>import "C"  //import “C” 必须单起一行，并且紧跟在注释行之后</p>
<p>import "unsafe"</p>
<p> </p>
<p>func main() {</p>
<p> s := "Hello Cgo"</p>
<p> cs := C.CString(s)//字符串映射</p>
<p> C.c_print(cs)//调用C函数</p>
<p> defer C.free(unsafe.Pointer(cs))//释放内存</p>
<p>}</p></td>
</tr>
</tbody>
</table>

运行结果：

?

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 88%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p></td>
<td><p>$ go run testC.go</p>
<p>Hello Cgo</p></td>
</tr>
</tbody>
</table>

**讲解：**

1、go代码中的C代码，需要用注释包裹，块注释和行注释均可，其次import “C”是必须的，并且和上面的C代码之间不能用空行分割，必须紧密相连

如果执行go run \*\*时出现

\# command-line-arguments  
could not determine kind of name for xxx

那么就需要考虑 是不是improt “C”和上面的C代码没有紧挨着导致了

2、import “C” 并没有导入一个名为C的包，这里的import “C”类似于告诉Cgo将之前注释块中的C代码生成一段具有包装性质的Go代码

3、访问[C语言](http://www.zzvips.com/article/124013.html)中的函数需要在前面加上C.前缀，如C.Cstring C.go_print C.free

4、对于C语中的原生类型，Cgo都有对应的Go语言中的类型 如go代码中C.int，C.char对应于c语言中的int，signed char，而C语言中void\*指针在Go语言中用特殊的unsafe.Pointer(cs)来对应

而Go语言中的string类型，在C语言中用字符数组来表示，二者的转换需要通过go提供的一系列函数来完成：

**C.Cstring ：** 转换go的字符串为C字符串，C中的字符串是使用malloc分配的，所以需要调用C.free来释放内存

**C.Gostring ： **转换C字符串为go字符串

**C.GoStringN ：** 转换一定长度的C字符串为go字符串

需要注意的是每次转换都会导致一次内存复制，所以字符串的内容是不可以修改的

5、17行 利用defer C.free 和unsafe.Pointer显示释放调用C.Cstring所生成的内存块

### **二、C语言中使用go语言**

<img src="./media15/media/image4.png" style="width:4.29583in;height:0.90625in" alt="C语言和go语言之间的交互操作方法" />

**代码示例：**

**go代码：print.go**

?

<table>
<colgroup>
<col style="width: 3%" />
<col style="width: 96%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p></td>
<td><p>package main</p>
<p>import "C"</p>
<p>import "fmt"</p>
<p>//export go_print</p>
<p>func go_print(value string) {</p>
<p>  fmt.Println(value)</p>
<p>}</p>
<p>func main() {//main函数是必须的 有main函数才能让cgo编译器去把包编译成C的库</p>
<p>}</p></td>
</tr>
</tbody>
</table>

**讲解：**

1、第11行 这里go代码中的main函数是必须的，有main函数才能让cgo编译器去把包编译成c的库

2、第3行 import “C”是必须的，如果没有import “C” 将只会build出一个.a文件，而缺少.h文件

3、第6行 //exoort go_print 这里的go_print要和下面的的go函数名一致，并且下面一行即为要导出的go函数

4、命令执行完毕后会生成两个文件 nautilus.a nautilus.h

nautilus.h中定义了go语言中的类型在C中对应的类型 和导出的go函数的函数声明

**如：**

typedef signed char GoInt8;//对应go代码中的int8类型

typedef struct { const char \*p; GoInt n; } GoString;//对应go中的字符串

extern void go_print(GoString p0);//go中导出的函数的函数声明

**C代码： c_go.c**

?

<table>
<colgroup>
<col style="width: 4%" />
<col style="width: 95%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p></td>
<td><p>#include “nautilus.h”//引入go代码导出的生成的C头文件</p>
<p>#include &lt;stdio.h&gt;</p>
<p> </p>
<p>int main() {</p>
<p> char cvalue[] = "Hello This is a C Application";</p>
<p> int length = strlen(cvalue);</p>
<p> GoString value = {cvalue, length};//go中的字符串类型在c中为GoString</p>
<p> go_print(value);</p>
<p> return 0;</p>
<p>}</p></td>
</tr>
</tbody>
</table>

**编译步骤**

// as c-shared library  
\$ go build -buildmode=c-shared -o nautilus.a print.go

**或者**

// as c-archive  
\$ go build -buildmode=c-archive -o nautilus.a print.go

\$ gcc -o c_go c_go.c nautilus.a

**运行结果**

?

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 92%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p></td>
<td><p>$ ./c_go</p>
<p>Hello This is a C Application</p></td>
</tr>
</tbody>
</table>

**讲解：**

1、第1行 \#include “nautilus.h"包含go代码导出生成的C头文件

2、第7行 go中字符串类型在c中为GoString 定义为typedef struct { const char \*p; GoInt n; } GoString; p为字符串指针，n为长度；所以这里通过GoString value = {cavalue, length}将C中的char赋值给GoString

3、第8行 go_print调用对应函数

### **三、C语言中使用go语言，使用的go语言又使用了c语言**

<img src="./media15/media/image5.png" style="width:6.24931in;height:0.87778in" alt="C语言和go语言之间的交互操作方法" />

**代码示例：**

**被go调用的C代码 hello.h**

?

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 92%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p></td>
<td><p>#ifndef HELLO_H</p>
<p>#define HELLO_H</p>
<p> </p>
<p> </p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;stdlib.h&gt;7</p>
<p>void go_print_c(char *str);</p>
<p> </p>
<p>#endif</p></td>
</tr>
</tbody>
</table>

被go调用的C代码 hello.c

?

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 92%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p></td>
<td><p>#include "hello.h"</p>
<p> </p>
<p>void go_print_c(char *str) {</p>
<p>  printf("%s\n", str);</p>
<p>}</p></td>
</tr>
</tbody>
</table>

**被C调用的go代码 print.go**

?

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 90%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p>
<p>12</p>
<p>13</p></td>
<td><p>package main</p>
<p> </p>
<p>//#include "hello.h"</p>
<p>import "C"</p>
<p> </p>
<p>//export go_print</p>
<p>func go_print(value string) {</p>
<p> cs := C.CString(value)</p>
<p> C.go_print_c(cs)</p>
<p>}</p>
<p> </p>
<p>func main() {</p>
<p>}</p></td>
</tr>
</tbody>
</table>

**讲解：**

**1、这里在函数前面加上了inline关键字**

如果把C代码放入go代码注释块中并且没有inline关键字中，会出现重定义的错误

**p.go**

?

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 90%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
<p>11</p>
<p>12</p>
<p>13</p>
<p>14</p>
<p>15</p>
<p>16</p>
<p>17</p>
<p>18</p></td>
<td><p>package main</p>
<p> </p>
<p>/*</p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;stdlib.h&gt;</p>
<p>void go_print_c(char *str) {</p>
<p> printf("%s\n", str);</p>
<p>}</p>
<p>*/</p>
<p>import "C"</p>
<p>import "unsafe"</p>
<p> </p>
<p>//export go_print</p>
<p>func go_print(value string) {</p>
<p> cs := C.CString(value)</p>
<p> C.go_print_c(cs)</p>
<p>}</p>
<p>...</p></td>
</tr>
</tbody>
</table>

go build -buildmode=c-shared -o nautilus.a print.go执行失败

duplicate symbol \_go_print_c in:  
\$WORK/\_/Users/baidu/go_code/t/\_obj/\_cgo_export.o  
\$WORK/\_/Users/baidu/go_code/t/\_obj/p.cgo2.o  
ld: 1 duplicate symbol for architecture x86_64  
clang: error: linker command failed with exit code 1 (use -v to see invocation)

**解决办法**是给函数加上inline或者static关键字将函数改成内部链接，或者是像上面那样include头文件

**C代码 \_c_go.c**

?

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 92%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p></td>
<td><p>#include "nautilus.h"</p>
<p>#include3</p>
<p>int main() {</p>
<p> printf("This is a C Application.\n");</p>
<p> char cvalue[] = "hello world";</p>
<p> int length = strlen(cvalue);</p>
<p> GoString value = {cvalue, length};</p>
<p> go_print(value);</p>
<p> return 0;</p>
<p>}</p></td>
</tr>
</tbody>
</table>

**编译步骤：**

?

<table>
<colgroup>
<col style="width: 4%" />
<col style="width: 95%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p></td>
<td><p>// as c-shared library</p>
<p>$ go build -buildmode=c-shared -o nautilus.a</p></td>
</tr>
</tbody>
</table>

**或者**

?

<table>
<colgroup>
<col style="width: 4%" />
<col style="width: 95%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p>
<p>4</p></td>
<td><p>// as c-archive</p>
<p>$ go build -buildmode=c-archive -o nautilus.a</p>
<p> </p>
<p>$ gcc -o c_go_c c_go.c nautilus.a</p></td>
</tr>
</tbody>
</table>

**运行结果**

?

<table>
<colgroup>
<col style="width: 8%" />
<col style="width: 91%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>1</p>
<p>2</p>
<p>3</p></td>
<td><p>$ ./c_go_c.o</p>
<p>This is a C Application.</p>
<p>hello world</p></td>
</tr>
</tbody>
</table>

以上这篇C语言和go语言之间的[交互](http://www.zzvips.com/article/124279.html)操作方法就是小编分享给大家的全部内容了，希望能给大家一个参考，也希望大家多多支持服务器之家。
