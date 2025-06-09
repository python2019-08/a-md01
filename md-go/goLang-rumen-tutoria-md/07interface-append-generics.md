# 1.golang有类似于C++的模板函数的语法吗

在 Go 语言中，**泛型（Generics）** 提供了类似于 C++ 模板函数的功能，但语法和实现机制有所不同。Go 1.18 版本引入了泛型，允许你编写类型参数化的函数和类型，从而实现代码复用。


### **Go 泛型基础语法**
Go 泛型使用 **类型参数**（type parameters）来实现类似 C++ 模板的功能。以下是核心概念：

#### **1. 泛型函数**
```go
// Max 函数可以比较任意可排序类型的最大值
func Max[T Ordered](a, b T) T {
    if a > b {
        return a
    }
    return b
}

// Ordered 是一个约束（Constraint），表示支持 > 操作的类型
type Ordered interface {
    int | int8 | int16 | int32 | int64 |
        uint | uint8 | uint16 | uint32 | uint64 | uintptr |
        float32 | float64 |
        string
}
```

#### **2. 泛型类型**
```go
// Stack 是一个泛型栈结构
type Stack[T any] struct {
    items []T
}

func (s *Stack[T]) Push(item T) {
    s.items = append(s.items, item)
}

func (s *Stack[T]) Pop() T {
    if len(s.items) == 0 {
        var zero T
        return zero
    }
    last := len(s.items) - 1
    item := s.items[last]
    s.items = s.items[:last]
    return item
}
```


### **Go 泛型 vs C++ 模板**
| **特性**                | **Go 泛型**                          | **C++ 模板**                         |
|-------------------------|-------------------------------------|-------------------------------------|
| **语法**                | 使用 `[T constraint]` 声明类型参数    | 使用 `template <typename T>` 或 `template <class T>` |
| **约束机制**            | 显式约束（如 `interface{}` 或自定义约束） | 隐式依赖模板参数的操作（鸭子类型）   |
| **实例化**              | 编译时自动推断类型参数                | 需要显式或隐式实例化                 |
| **编译模型**            | 单遍编译，类型参数在编译时确定        | 多遍编译，可能导致代码膨胀           |
| **错误提示**            | 更友好，基于约束的错误信息            | 可能非常复杂，尤其在深层模板嵌套时   |


### **Go 泛型示例**
#### **1. 泛型切片反转**
```go
func Reverse[T any](s []T) []T {
    result := make([]T, len(s))
    for i, j := 0, len(s)-1; i <= j; i, j = i+1, j-1 {
        result[i], result[j] = s[j], s[i]
    }
    return result
}
```

#### **2. 泛型映射函数**
```go
func Map[T, U any](s []T, f func(T) U) []U {
    result := make([]U, len(s))
    for i, v := range s {
        result[i] = f(v)
    }
    return result
}

// 使用示例
nums := []int{1, 2, 3}
squared := Map(nums, func(x int) int { return x * x }) // [1, 4, 9]
```


### **约束（Constraints）的使用**
Go 泛型通过约束限制类型参数的范围：
```go
// 约束为支持加法的类型
type Addable interface {
    int | int64 | float64 | string
}

func Sum[T Addable](a, b T) T {
    return a + b
}
```

使用 `interface{}` 或 `any` 表示任意类型：
```go
func Print[T any](s T) {
    fmt.Println(s)
}
```


### **局限性**
尽管 Go 泛型提供了类似 C++ 模板的功能，但仍有一些限制：
1. **不支持偏特化**：Go 泛型不支持像 C++ 那样的模板偏特化。
2. **约束较简单**：Go 的约束系统相对 C++ 更简单，不支持复杂的模板元编程。
3. **性能开销**：某些场景下，泛型代码可能比手写类型特定代码略慢（但通常可忽略）。


### **总结**
Go 泛型提供了与 C++ 模板函数类似的功能，允许编写类型无关的代码，但语法更简洁，约束更明确，编译时错误提示更友好。如果你熟悉 C++ 模板，Go 泛型的概念很容易理解，但具体语法和使用方式有明显差异。

==================================================
# 2.快来！2023面试必问的Go泛型解析**

https://zhuanlan.zhihu.com/p/594661012

**文大侠666** 公众号：文大侠666，专注Go/C++和安全
编辑于 2023-01-11 09:59・湖北

## 2.1 为什么需要泛型 

比如现在实现一个add函数，支持int累加 
``` go
func add(x, y int) int {
    return x + y
}
```


现在新增一个float32累加，如下实现
``` go
func add(x, y float32) float32 {
    return x + y
}
```


再要支持其它类型比如float/string等，应该如何做呢？
-   每种类型定义一个函数
这是最朴素的想法，1.18之前go经常这样干，毕竟那时候go的口号是大道至简，手撸就完了！
当然，也可以结合go generate实现[自动化]，符合go依赖工具补充语法的设计思想。

-   万能类型+类型断言实现通用化
1.18之前go中也很常用，interface接受所有类型，类似c++的空指针或者java中的object表达通用参数，实现一个通用函数，如下


```go
func addGeneral(x, y interface{}) interface{} {
    switch ret := x.(type) {
    case int:
        return ret + y.(int)

    case float32:
        return ret + y.(float32)

    default:
        return nil
    }
}
```

这个程序可以不用重试定义多个add函数，但缺点也很明显：
> 1.需要添加多个类型实现
> 2.必须保证传入类型是符合要求的，比如`addGeneral(1,"2")`就会报错，也就是类型不安全
> 3.返回的类型也必须是interface，无法自动推断

-   泛型实现
1.18开始引入
``` go
func addT[T int | float32](x, y T) T {
    return x + y
}
```
这里定义了int和float32的add支持，并且  [类型安全]+返回自动推断，完美！

所以可以看到，泛型的作用在于如下
-   通用化，同一逻辑不用重复对每个类型实现
-   类型安全和自动推断 Tips： 不是所有地方都适合用泛型，原则上避免使用泛型引入新的抽象。 一般只有类库或者明确同一逻辑需要多个类型实现时才引入。

## 2.2泛型定义语法 


``` go
// 声明一个带有泛型的函数
// T :
// 指类型参数，就是一个参数，代表类型
// 
// Constraint :
// 是对类型参数T的约束，限制T的取值， 
// 可以是int、string、any等类型，any可以是任意类型的意思
// 也可以是一系列类型的组合，使用|连接，比如如上add函数定义的int |float32
// 
// s ：
// T类型的参数
func name[T {Constraint}](s T) T {}
```


## 2.3泛型常见用法 

### 2.3.1基础类型扩展  

如下，~前缀  表示  基础类型的**扩展类型**  也可以支持， 对于`type MyInt int `的 MyInt类型，如上addT函数无法支持， 如下定义声明扩展类型也支持即可
``` go
func addT2[T ~int | ~int64 | ~float32 | ~float64](x, y T) T {
    return x + y
}
```

### 2.3.2类型独立成接口

本质上，每种类型是一种接口，因此如上的泛型定义可以抽象成接口，如下定义
``` go
type Number interface {
    int | int64 | float32 | float64
}

func addNumber[T Number](x, y T) T {
    return x + y
}
```


### 2.3.3自定义泛型类型 
如上已提到泛型类型本质是不同接口类型。  除了默认类型组合，也可以自己定义接口作为类型，如下要求泛型类型必须实现 fmt.Stringer 接口
``` go
func makeStringT[T fmt.Stringer](x T) string {
    return x.String()
}
```

此时对于如下自定义类型，直接调用 makeStringT 会报错，因为 MyT 没有实现接口 fmt.Stringer
``` go
type MyT struct {
    val int
}
```

增加如下fmt.Stringer接口实现即可满足泛型类型检查
``` go
func (t MyT) String() string {
    return strconv.Itoa(t.val)
}
```

### 2.3.4 go自带泛型类型支持 
为了更好支持泛型，go标准库定义了几种常见用到的泛型接口作为自带支持

-   any
其实any就是`interface{}`别名，go标准库默认使用any替换之前的interface{}。
一个常见泛型示例
``` go
func printT[T any](x T) {
    fmt.Println(x)
}
```

-   comparable
如下实现一个泛型比较函数
``` go
func isEqualT2[T any](x, y T) bool {
    if x == y {
        return true
    } else {
        return false
    }
}
```

编译报错-`Invalid operation: x == y (the operator == is not defined on T) `
因为go不允许重载运算符，这里any类型T，无法知道T类型是否实现==运算符，因此报错。

go中引入 comparable 预定义接口标记类型实现==运算符，可如下定义
``` go
func isEqualT[T comparable](x, y T) bool {
    if x == y {
        return true
    } else {
        return false
    }
}
```

-   ordered
如下实现一个泛型max函数
``` go
func maxT2[T any](x, y T) T {
    if x >= y {
        return x
    } else {
        return y
    }
}
```


编译报错-`Invalid operation: x >= y (the operator >= is not defined on T) `
因为go不允许重载运算符，这里any类型T，无法知道T类型是否实现\>=运算符，因此报错。

go 1.18 beta1 contraints包中引入 ordered，但是后续 contraints 被移除，原本的 ordered 计划后续直接引入，这里我们可以先自行定义，如下
```go
type Ordered interface {
    ~int | ~int8 | ~int16 | ~int32 | ~int64 |
        ~uint | ~uint8 | ~uint16 | ~uint32 | ~uint64 | ~uintptr |
        ~float32 | ~float64 |
        ~string
}

func maxT[T Ordered](x, y T) T {
    if x >= y {
        return x
    } else {
        return y
    }
}
```

可以看到ordered其实就是内建标准类型的集合

### 结构体泛型支持 
和函数泛型定义类似，如下实现一个泛型栈的Pop和Push
``` go
type MyStack[T any] struct {
    vals []T
}

func (s *MyStack[T]) Pop() (T, error) {
    l := len(s.vals)
    if l == 0 {
        var zero T
        return zero, errors.New("empty stack")
    }

    v := s.vals[l-1]
    s.vals = s.vals[:l-1]

    return v, nil
}

func (s *MyStack[T]) Push(val T) {
    s.vals = append(s.vals, val)
}
```


注意go目前不支持结构体的方法定义泛型参数，如下
``` go
func (s *MyStack[T]) ConvertAndPush[In any](val In, f func (x In) T ) {
    s.vals = append(s.vals, f(val))
}
```

编译报错-`Method cannot have type parameters `

## 泛型注意点 

如下示例，addT3不会提示语法错误，但是编译报错-`untyped int constant 1000 `
因为前面我们提到泛型的一大作用是**类型安全**，这里1000超出int8范围，所以编译报错
addT4正常编译通过

``` go
func addT3[T int8](x T) T {
    return x + 1_000
}

func addT4[T int8](x T) T {
    return x + 100
}
```


## 演示代码

 <https://gitee.com/wenzhou1219/go-in-prod/blob/master/generics/simple_test.go>

## 参考  
 [Go 泛型那些事：能做什么，不能做什么，如何改变惯用模式 ](https://mp.weixin.qq.com/s/Vqhit3pscBouh7dCpnVyZA)
 
 [An Introduction to Generics in Go](https://blog.streamelements.com/an-introduction-to-generics-in-go-cc8cdae15ef2)
 
====================================================
 
# 3.**Go 泛型那些事：能做什么，不能做什么，如何改变惯用模式

译者tearon [polarisxu](javascript:void(0);) 2022-05-26 18:12 发表于北京

> <https://mp.weixin.qq.com/s/Vqhit3pscBouh7dCpnVyZA>

大家好，我是 polarisxu。

前两天分享了[《Learning Go》最后一章作者重写的
PDF](http://mp.weixin.qq.com/s?__biz=MzAxNzY0NDE3NA==&mid=2247490001&idx=1&sn=ac6c82750f60a542958d0667dac254a8&chksm=9be33630ac94bf26716ba107497450e1b8767845f670220754e63464343f14a599b019e9f54d&scene=21#wechat_redirect)，今天有
gopher 翻译成了中文，经过译者授权发布。

译者：tearon，译者首发地址：https://blog.csdn.net/tearon/article/details/124960440。

尽管对功能的重视程度较低，但 Go 并不是一种静止的、一成不变的编程语言。

新的功能是在经过大量的讨论和实验后慢慢采用的。自最初的 Go 1.0
发布以来，定义符合 Go 语言习惯的模式已经发生了重大变化。首先是在 Go 1.7
中采用了 context。随后在 Go 1.11 中采用了 modules，在 Go 1.13 中采用了
error wrapping。

下一个重大变化已经到来。Go 的 1.18
版本包括了类型参数的实现，也就是俗称的泛型。在本章中，我们将探讨人们为什么需要泛型，Go
的泛型实现可以做什么，不能做什么，以及它们如何改变惯用模式。

## 1.泛型减少重复代码并提高类型安全性

Go
是一种静态类型编程语言，这意味着在编译时会检查变量和参数的类型。内置类型（maps、slices、channels）和内置函数（如
len、cap 或 make）能够接收和返回不同具体类型的值，但在 Go 1.18
之前，用户定义的 Go 类型和函数不能如此。

如果你熟悉动态类型语言，即在代码运行前不对类型进行安全检查，你可能不明白泛型有什么大惊小怪的，而且你可能有点不清楚它们是什么。如果你将它们视为
"类型参数"，会有所帮助。我们习惯于编写接收参数的函数，这些参数的值在函数被调用时被指定。在这段代码中，我们指定
Min 函数接收两个 float64 类型的参数并返回一个 float64：

func Min(v1, v2 float64) float64 {

    if v1 \< v2 {

        return v1

    }

    return v2

}

然而，在某些情况下，编写函数或结构体时，参数或字段的具体类型在使用前是不被指定的，这时泛型就显得尤为重要了。

泛型类型的使用场景很容易理解。在第 133 页（指《Learning Go》这本图书）的
"Code Your Methods for nil Instances" 中，我们看了 ints
的二叉树。如果我们想为 strings 或 float64s
建立一个二叉树，并且希望类型安全，有几种选择。第一种可能性是为每个类型写一个自定义的树，但有那么多重复的代码很冗长且容易出错。

在 Go 没有加入泛型前，避免重复代码的唯一方法是修改我们的 Tree
实现，使其使用一个接口来指定如何对值进行排序。接口如下所示：

type Orderable interface {

    // Order returns:

    // a value \< 0 when the Orderable is less than the supplied value,

    // a value \> 0 when the Orderable is greater than the supplied
value,

    // and 0 when the two values are equal.

    Order(interface{}) int

}

现在我们有了 Orderable，我们可以修改 Tree 实现来支持它：

type Tree struct {

    val         Orderable

    left, right \*Tree

}

func (t \*Tree) Insert(val Orderable) \*Tree {

    if t == nil {

        return &Tree{val: val}

    }

    switch comp := val.Order(t.val); {

    case comp \< 0:

        t.left = t.left.Insert(val)

    case comp \> 0:

        t.right = t.right.Insert(val)

    }

    return t

}

有了 OrderableInt 类型，我们就可以插入 int 值了：

type OrderableInt int

func (oi OrderableInt) Order(val interface{}) int {

    return int(oi - val.(OrderableInt))

}

func main() {

    var it \*Tree

    it = it.Insert(OrderableInt(5))

    it = it.Insert(OrderableInt(3))

    // etc\...

}

虽然这段代码可以正常工作，但它不允许编译器验证插入到我们数据结构中的值是否都相同。如果我们还有一个
OrderableString 类型：

type OrderableString string

func (os OrderableString) Order(val interface{}) int {

    return strings.Compare(string(os), val.(string))

}

以下代码可以编译：

[var it \*Tree]{.mark}

[it = it.Insert(OrderableInt(5))]{.mark}

[it = it.Insert(OrderableString(\"nope\"))]{.mark}

Order 函数使用 interface{} 来表示传入的值。这降低了 Go
的主要优势之一，即编译时类型安全检查。当我们试图将 OrderableString
插入已经包含 OrderableInt
树中的代码时，编译器接受了该代码，然而，程序在运行时却出现了 panic：

panic: interface conversion: interface {} is main.OrderableInt, not
string

现在 Go
已经加入了泛型，有一种方法可以为多种类型的数据结构实现一次，并在编译时检测不兼容的数据。我们将在稍后看到如何正确使用它们。

虽然没有泛型的数据结构很不方便，但真正的限制在于编写函数。由于泛型最初不是语言的一部分，因此在
Go 的标准库中做出了几个实现决策。例如，Go
没有编写多个函数来处理不同的数字类型，而是使用 float64 参数来实现
math.Max、math.Min 和 math.Mod
等函数，这些参数的范围大到足以准确表示几乎所有其他数字类型（例外情况是
int、int64 或 uint，其值大于 2\^53 - 1 或小于 -2\^53 - 1）。

还有其他一些情况，没有泛型是不可能的。你不能为一个由接口指定的变量创建一个新的实例，你也不能指定两个具有相同接口类型的参数也具有相同的具体类型。如果没有泛型，你就不能写一个函数来处理任何类型的切片，而不需要借助反射，并放弃一些性能和编译时的类型安全（这就是
sort.Slice
的工作原理）。这意味着从过往的情况来看，对切片进行操作的函数会对每种类型的切片进行重复实现。

2017 年，我写了一篇名为 \"Closures Are the Generics for Go\[1\]\"
的博文，探讨了使用闭包来解决其中一些问题。然而，闭包方法有几个缺点。它的可读性要差得多，迫使数值逃逸到堆中，而且在许多常见的情况下根本不起作用。

其结果是，许多常见的算法，如 map、reduce 和
filter，最终都要为不同的类型重新实现。虽然简单的算法很容易复制，但许多（如果不是大多数）软件工程师发现，仅仅因为编译器不够聪明而自动重复代码是令人厌恶的。

## 2.介绍 Go 泛型

自 Go 首次发布以来，就一直有很多人呼吁将泛型加入到该语言中。Go
的开发负责人 Russ Cox 在 2009
年写了一篇博文，解释了为什么最初没有包含泛型。Go
强调快速的编译器、可读的代码和良好的执行时间，而他们所知道的泛型实现都不能让他们包含这三者。经过对这个问题研究了十年后，Go
团队有了一个可行的方法，在 Type Parameters
Proposal\[2\] （类型参数提案）中进行了概述。

我们将通过观察堆栈来了解泛型在 Go
中是如何工作的。如果你没有计算机科学背景，堆栈是一种数据类型，其中的值是按照后进先出（LIFO）的顺序添加和删除的。它就像一堆待洗的碗碟；先放的碗碟在底部，你只有洗完后来添加的碗碟才能拿到它们。让我们看看如何使用泛型来制作一个堆栈：

type Stack\[T any\] struct {

    vals \[\]T

}

func (s \*Stack\[T\]) Push(val T) {

    s.vals = append(s.vals, val)

}

func (s \*Stack\[T\]) Pop() (T, bool) {

    if len(s.vals) == 0 {

        var zero T

        return zero, false

    }

    top := s.vals\[len(s.vals)-1\]

    s.vals = s.vals\[:len(s.vals)-1\]

    return top, true

}

有几点需要注意。首先，我们在类型声明后面有 \[T
any\]，类型参数被放在括号里。它们的写法和变量参数一样，类型名称在前，类型约束在后。你可以为类型参数选择任何名字，但习惯上使用大写字母来表示它们。Go
使用接口来指定哪些类型可以使用。如果任何类型都可以使用，则使用新的
universe 块标识符 any 来指定，它完全等同于 interface{}（从 Go 1.18
及以后的版本开始，你可以在你的代码中使用 interface{} 的任何地方使用
any，但要注意你的代码将不能在 1.18 以前的 Go 版本中编译。）在 Stack
声明中，我们声明 vals 的类型为 \[\]T。

接下来，我们看一下我们的方法声明。就像我们在 vals 声明中使用 T
一样。我们在这里也这么做。我们还在接收器部分用 Stack\[T\]
来指代类型，而不是 Stack。

最后，泛型使零值处理变得有些有趣。在 Pop 中，我们不能直接返回
nil，因为这不是一个有效的值类型，比如
int。为泛型获得零值的最简单的方法是用 var
声明一个变量并返回它。因为根据定义，如果没有分配其他值，var
总是将其变量初始化为零值。

使用泛型类型与使用非泛型类型非常相似：

func main() {

    var intStack Stack\[int\]

    intStack.Push(10)

    intStack.Push(20)

    intStack.Push(30)

    v, ok := intStack.Pop()

    fmt.Println(v, ok)

}

唯一的区别是，当我们声明我们的变量时，我们包括了我们想在堆栈中使用的类型，在这个例子中是
int。如果你试图把一个 string
推到我们的堆栈中，编译器会捕获它。添加这一行：

intStack.Push(\"nope\")

产生编译器错误：

cannot use \"nope\" (untyped string constant) as int value

 in argument to intStack.Push

你可以在 **The Go
Playground^\[3\]^** 上试试我们的泛型堆栈。让我们给我们的堆栈添加另一个方法来告诉我们堆栈是否包含一个值：

func (s Stack\[T\]) Contains(val T) bool {

    for \_, v := range s.vals {

        if v == val {

            return true

        }

    }

    return false

}

不幸的是，这并不能编译。它给出了错误：

invalid operation: v == val (type parameter T is not comparable with ==)

就像 interface{} 什么都不说一样，any 也一样。我们只能存储 any
类型的值并检索它们。要使用==，我们需要一个不同的类型。由于几乎所有的 Go
类型都可以用 == 和 != 来比较，所以在 universe
块中定义了一个新的内置接口，叫做 comparable。如果我们改变我们对 Stack
的定义，使用 comparable：

type Stack\[T comparable\] struct {

    vals \[\]T

}

我们就可以使用我们的新方法：

func main() {

    var s Stack\[int\]

    s.Push(10)

    s.Push(20)

    s.Push(30)

    fmt.Println(s.Contains(10)) // true

    fmt.Println(s.Contains(5))  // false

}

你也可以试试这个**更新的堆栈^\[4\]^**。

稍后，我们将看到如何制作一个泛型二叉树。在这之前，我们要介绍一些额外的概念：泛型函数，泛型如何与接口一起工作，以及类型约束。

### 2.1泛型函数抽象算法

正如我们所暗示的那样，你也可以编写泛型函数。前面我们提到，如果没有泛型，就很难写出适用于所有类型的
map、reduce 和 filter
实现。泛型使之变得简单。下面是类型参数提案中的实现：

// Map turns a \[\]T1 to a \[\]T2 using a mapping function.

// This function has two type parameters, T1 and T2.

// This works with slices of any type.

func Map\[T1, T2 any\](s \[\]T1, f func(T1 \"T1, T2 any\") T2) \[\]T2 {

        r := make(\[\]T2, len(s))

        for i, v := range s {

            r\[i\] = f(v)

        }

        return r

    }

   

    // Reduce reduces a \[\]T1 to a single value using a reduction
function.

    func Reduce\[T1, T2 any\](s \[\]T1, initializer T2, f func(T2, T1
\"T1, T2 any\") T2) T2 {

        r := initializer

        for \_, v := range s {

            r = f(r, v)

        }

        return r

    }

   

    // Filter filters values from a slice using a filter function.

    // It returns a new slice with only the elements of s

    // for which f returned true.

    func Filter\[T any\](s \[\]T, f func(T \"T any\") bool) \[\]T {

        var r \[\]T

        for \_, v := range s {

            if f(v) {

                r = append(r, v)

            }

        }

        return r

    }

函数将其类型参数放在函数名之后，变量参数之前。Map 和 Reduce
有两个类型参数，都是 any 类型，而 Filter 有一个。当我们运行以下代码时：

words := \[\]string{\"One\", \"Potato\", \"Two\", \"Potato\"}

filtered := Filter(words, func(s string) bool {

    return s != \"Potato\"

})

fmt.Println(filtered)

lengths := Map(filtered, func(s string) int {

    return len(s)

})

fmt.Println(lengths)

sum := Reduce(lengths, 0, func(acc int, val int) int {

    return acc + val

})

fmt.Println(sum)

输出如下：

[\[One Two\]]{.mark}

[\[3 3\]]{.mark}

[6]{.mark}

亲自动手**试试吧^\[5\]^**。

### 2.2泛型和接口

你可以使用任何接口作为类型约束，而不仅仅是 any 和
comparable。例如，假设你想做一个可以容纳任意两个相同类型的值的类型，只要这个类型实现了
fmt.Stringer。泛型使我们有可能在编译时强制执行这一点：

type Pair\[T fmt.Stringer\] struct {

    Val1 T

    Val2 T

}

你也可以创建有类型参数的接口。例如，这里有一个接口，其方法是与指定类型的值进行比较，并返回一个
float64。它还嵌入了 fmt.Stringer：

type Differ\[T any\] interface {

    fmt.Stringer

    Diff(T) float64

}

我们将使用这两种类型来创建一个比较函数。这个函数接收两个具有 Differ
类型字段的 Pair 实例，并返回具有更接近值的 Pair。

func FindCloser\[T Differ\[T\]\](pair1, pair2 Pair\[T\] \"T
Differ\[T\]\") Pair\[T\] {

        d1 := pair1.Val1.Diff(pair1.Val2)

        d2 := pair2.Val1.Diff(pair2.Val2)

        if d1 \< d2 {

            return pair1

        }

        return pair2

}

请注意，FindCloser 接收的是具有符合 Differ 接口的字段的 Pair 实例。Pair
要求它的字段都是相同的类型，并且类型符合 fmt.Stringer
接口；这个函数的选择性更强。如果一个 Pair 实例中的字段不符合
Differ，编译器会阻止你用 FindCloser 来使用这个 Pair
实例。我们现在定义了几个符合 Differ 接口的类型：

type Point2D struct {

    X, Y int

}

func (p2 Point2D) String() string {

    return fmt.Sprintf(\"{%d,%d}\", p2.X, p2.Y)

}

func (p2 Point2D) Diff(from Point2D) float64 {

    x := p2.X - from.X

    y := p2.Y - from.Y

    return math.Sqrt(float64(x\*x) + float64(y\*y))

}

type Point3D struct {

    X, Y, Z int

}

func (p3 Point3D) String() string {

    return fmt.Sprintf(\"{%d,%d,%d}\", p3.X, p3.Y, p3.Z)

}

func (p3 Point3D) Diff(from Point3D) float64 {

    x := p3.X - from.X

    y := p3.Y - from.Y

    z := p3.Z - from.Z

    return math.Sqrt(float64(x\*x) + float64(y\*y) + float64(z\*z))

}

下面是使用这段代码的样子：

func main() {

    pair2Da := Pair\[Point2D\]{Point2D{1, 1}, Point2D{5, 5}}

    pair2Db := Pair\[Point2D\]{Point2D{10, 10}, Point2D{15, 5}}

    closer := FindCloser(pair2Da, pair2Db)

    fmt.Println(closer)

    pair3Da := Pair\[Point3D\]{Point3D{1, 1, 10}, Point3D{5, 5, 0}}

    pair3Db := Pair\[Point3D\]{Point3D{10, 10, 10}, Point3D{11, 5, 0}}

    closer2 := FindCloser(pair3Da, pair3Db)

    fmt.Println(closer2)

}

在 **The Go Playground^\[6\]^** 上亲自动手运行它。

### 2.3使用类型约束来指定操作符

还有一件事，我们需要用泛型来表示：操作符。如果我们想写一个 Min
的泛型，我们需要一种方法来指定我们可以使用比较运算符，比如 \< 和 \>。Go
泛型通过一个类型元素来实现，该元素由一个或多个类型项束组成。由一个接口中的一个或多个类型约束组成：

type BuiltInOrdered interface {

    string \| int \| int8 \| int16 \| int32 \| int64 \| float32 \|
float64 \|

    uint \| uint8 \| uint16 \| uint32 \| uint64 \| uintptr

}

我们已经在第 146 页的 \"Embedding and Interfaces\"
中看到了具有类型元素的接口。在那种情况下，我们嵌入了另一个接口，以表明包含接口的方法集包括嵌入接口的方法。在这里，我们列出了由
\|
分隔的具体类型。这指定了哪些类型可以被分配给一个类型参数，以及哪些运算符被支持。允许的操作符是那些对所有列出的类型都有效的操作符。在这种情况下，这些运算符是
==、!=、\>、\<、\>=、\<=、和
+。请注意，在一个类型元素中带有具体类型限界的接口只作为类型参数的边界有效。使用它们作为变量、字段、返回值或参数的类型是一个编译时错误。

现在我们可以编写 Min 的泛型版本，并将其与内置的 int 类型（或
BuiltInOrdered 中列出的任何其他类型）一起使用。

func Min\[T BuiltInOrdered\](v1, v2 T \"T BuiltInOrdered\") T {

        if v1 \< v2 {

            return v1

        }

        return v2

}

   

func main() {

    a := 10

    b := 20

    fmt.Println(Min(a, b))

}

默认情况下，类型限界完全匹配。如果我们试图用一个用户定义的类型来使用 Min
而该类型的底层类型是 BuiltInOrdered
中列出的类型之一，我们会得到一个错误。这段代码：

[type MyInt int]{.mark}

[var myA MyInt = 10]{.mark}

[var myB MyInt = 20]{.mark}

[fmt.Println(Min(myA, myB))]{.mark}

产生错误：

[MyInt does not implement BuiltInOrdered (possibly missing \~
for]{.mark}

[    int in constraint BuiltInOrdered)]{.mark}

错误文本给出了如何解决这个问题的提示。如果你想让一个类型限界对任何将该类型限界作为其底层类型的类型有效，在类型限界前加一个
\~。这就对 BuiltInOrdered 的定义改为：

type BuiltInOrdered interface {

    \~string \| \~int \| \~int8 \| \~int16 \| \~int32 \| \~int64 \|
\~float32 \| \~float64 \|

        \~uint \| \~uint8 \| \~uint16 \| \~uint32 \| \~uint64 \|
\~uintptr

}

您可以在 **The Go Playground^\[7\]^** 上看到这个 Min 函数。

在一个用于类型参数的接口中，同时拥有类型元素和方法元素是合法的。例如，你可以指定一个类型必须有一个
int 基本类型和一个 String() 字符串方法：

type PrintableInt interface {

    \~int

    String() string

}

请注意，Go 会让你声明一个无法实际实例化的类型参数接口。如果我们在
PrintableInt 中使用 int 而不是 \~int，就不会有符合它的有效类型，因为 int
没有方法。这可能看起来很糟糕，但编译器还是会来救你。如果你声明的类型或函数有一个不可能的类型参数，任何试图使用它的行为都会引起编译器错误。假设我们声明了这些类型：

type ImpossiblePrintableInt interface {

    int

    String() string

}

type ImpossibleStruct\[T ImpossiblePrintableInt\] struct {

    val T

}

type MyInt int

func (mi MyInt) String() string {

    return fmt.Sprint(mi)

}

尽管我们不能实例化
ImpossibleStruct，编译器对这些声明都没有问题。然而，一旦我们尝试使用
ImpossibleStruct，编译器就会报错。这段代码：

[s := ImpossibleStruct\[int\]{10}]{.mark}

[s2 := ImpossibleStruct\[MyInt\]{10}]{.mark}

产生编译时错误：

[int does not implement ImpossiblePrintableInt (missing String
method)]{.mark}

[MyInt does not implement ImpossiblePrintableInt (possibly missing \~
for]{.mark}

[int in constraint ImpossiblePrintableInt)]{.mark}

在 **The Go Playground^\[8\]^** 试试。

除了内置的原始类型外，类型限界还可以是切片、映射、数组、通道、结构体，甚至是函数。

当你想确保一个类型参数有一个特定的底层类型和一个或多个方法时，它们是最有用的。

### 2.4类型推断和泛型

正如 Go 在使用 :=
操作符时支持类型推断一样，它也支持类型推断以简化对泛型函数的调用。你可以在上面对
Map、Filter 和 reduce
的调用中看到这一点。在某些情况下，类型推断是不可能的（例如，当一个类型参数只作为返回值使用时）。当这种情况发生时，所有的类型参数都必须被指定。这里有一段略显愚蠢的代码，演示了类型推断不工作的情况：

type Integer interface {

    int \| int8 \| int16 \| int32 \| int64 \| uint \| uint8 \| uint16 \|
uint32 \| uint64

}

   

func Convert\[T1, T2 Integer\](in T1 \"T1, T2 Integer\") T2 {

    return T2(in)

}

func main() {

    var a int = 10

    b := Convert\[int, int64\](a \"int, int64\") // can\'t infer the
return type

    fmt.Println(b)

}

在 **The Go Playground^\[9\]^** 上试试。

### 2.5类型元素限制常量

类型元素还指定了哪些常量可以被分配给泛型类型的变量。像操作符一样，这些常量需要对类型元素中的所有类型限界有效。在类型元素中，没有常量可以被分配给
BuiltInOrdered
中列出的每个类型。因此你不能把常量分配给该泛型类型的变量。如果你使用
Integer 接口，下面的代码将不能编译，因为你不能把 1,000 分配给一个 8
位的整型：

// INVALID!

func PlusOneThousand\[T Integer\](in T \"T Integer\") T {

    return in + 1_000

}

然而，这是有效的：

// VALID

func PlusOneHundred\[T Integer\](in T \"T Integer\") T {

    return in + 100

}

### 2.6将泛型函数与泛型数据结构相结合

让我们回到二叉树示例，看看如何把我们所学到的一切结合起来，做成一个适用于任何具体类型的单一树。秘诀在于认识到我们的树需要的是一个单一的泛型函数，用来比较两个值并告诉我们它们的顺序：

type OrderableFunc\[T any\] func(t1, t2 T) int

现在我们有了 OrderableFunc，我们可以稍微修改我们的 Tree
实现。首先，我们要把它分成两种类型，Tree 和 Node：

type Tree\[T any\] struct {

    f    OrderableFunc\[T\]

    root \*Node\[T\]

}

type Node\[T any\] struct {

    val         T

    left, right \*Node\[T\]

}

我们用一个构造函数来构造一个新的 Tree：

func NewTree\[T any\](f OrderableFunc\[T\] \"T any\") \*Tree\[T\] {

        return &Tree\[T\]{

            f: f,

        }

}

Tree 的方法非常简单，因为它们只是调用 Node 来完成所有实际工作：

func (t \*Tree\[T\]) Add(v T) {

    t.root = t.root.Add(t.f, v)

}

func (t \*Tree\[T\]) Contains(v T) bool {

    return t.root.Contains(t.f, v)

}

Node 上的 Add 和 Contains
方法与我们之前看到的非常相似。唯一的区别是，我们用来排序元素的函数被传入：

func (n \*Node\[T\]) Add(f OrderableFunc\[T\], v T) \*Node\[T\] {

    if n == nil {

        return &Node\[T\]{val: v}

    }

    switch r := f(v, n.val); {

    case r \<= -1:

        n.left = n.left.Add(f, v)

    case r \>= 1:

        n.right = n.right.Add(f, v)

    }

    return n

}

func (n \*Node\[T\]) Contains(f OrderableFunc\[T\], v T) bool {

    if n == nil {

        return false

    }

    switch r := f(v, n.val); {

    case r \<= -1:

        return n.left.Contains(f, v)

    case r \>= 1:

        return n.right.Contains(f, v)

    }

    return true

}

现在我们需要一个匹配 OrderedFunc 定义的函数。通过利用
BuiltInOrdered，我们可以编写一个支持任何原始类型的函数：

func BuiltInOrderable\[T BuiltInOrdered\](t1, t2 T \"T BuiltInOrdered\")
int {

    if t1 \< t2 {

        return -1

    }

    if t1 \> t2 {

        return 1

    }

    return 0

}

当我们将 BuiltInOrderable 与我们的 Tree 一起使用时，它看起来像这样：

[t1 := NewTree(BuiltInOrderable\[int\])]{.mark}

[t1.Add(10)]{.mark}

[t1.Add(30)]{.mark}

[t1.Add(15)]{.mark}

[fmt.Println(t1.Contains(15))]{.mark}

[fmt.Println(t1.Contains(40))]{.mark}

对于结构体，我们有两种选择。我们可以写一个函数：

type Person struct {

    Name string

    Age  int

}

func OrderPeople(p1, p2 Person) int {

    out := strings.Compare(p1.Name, p2.Name)

    if out == 0 {

        out = p1.Age - p2.Age

    }

    return out

}

然后我们可以在创建树的时候把这个函数传进去：

func (p Person) Order(other Person) int {

    out := strings.Compare(p.Name, other.Name)

    if out == 0 {

        out = p.Age - other.Age

    }

    return out

}

然后我们使用它：

[t3 := NewTree(Person.Order)]{.mark}

[t3.Add(Person{\"Bob\", 30})]{.mark}

[t3.Add(Person{\"Maria\", 35})]{.mark}

[t3.Add(Person{\"Bob\", 50})]{.mark}

[fmt.Println(t3.Contains(Person{\"Bob\", 30}))]{.mark}

[fmt.Println(t3.Contains(Person{\"Fred\", 25}))]{.mark}

您可以在 **The Go Playground^\[10\]^** 上找到这棵树的代码。

## 3.遗漏的功能特性

Go 仍然是一种小而专注的语言，Go
的泛型实现并不包括其他语言的泛型实现中的许多功能。以下是 Go
泛型的初始实现中没有的一些功能。

虽然我们可以建立一个同时适用于用户定义类型和内置类型的单一树，但是像
Python、Ruby 和 C++
这样的语言是以不同的方式解决的这个问题。它们包括运算符重载，这使得用户定义的类型可以为运算符指定实现。Go
不会增加这一功能。这意味着你不能使用 range
来遍历用户定义的容器类型，也不能使用 \[\] 来对它们进行索引。

省去运算符重载是有充分理由的。首先，Go 中的运算符数量多得令人吃惊。Go
也没有函数或方法重载，你需要一种方法来为不同的类型指定不同的操作符功能。此外，运算符重载会导致代码更难理解，因为开发者为符号发明了巧妙的含义（在
C++中，\<\< 对某些类型来说意味着 "向左移位"，对其他类型来说意味着
"把右边的值写到左边的值" ）。这些都是 Go 试图避免的可读性问题。

另一个在最初的 Go 泛型实现中被遗漏的有用功能是方法上的附加类型参数。回顾
Map / Reduce / Filter 函数，你可能会认为它们作为方法会很有用，就像这样：

type functionalSlice\[T any\] \[\]T

// THIS DOES NOT WORK

func (fs functionalSlice\[T\]) Map\[E any\](f func(T \"T\]) Map\[E
any\") E) functionalSlice\[E\] {

    out := make(functionalSlice\[E\], len(fs))

    for i, v := range fs {

        out\[i\] = f(v)

    }

    return out

}

// THIS DOES NOT WORK

func (fs functionalSlice\[T\]) Reduce\[E any\](start E, f func(E, T
\"T\]) Reduce\[E any\") E) E {

    out := start

    for \_, v := range fs {

        out = f(out, v)

    }

    return out

}

你可以这样使用：

var numStrings = functionalSlice\[string\]{\"1\", \"2\", \"3\"}

sum := numStrings.Map(func(s string) int {

    v, \_ := strconv.Atoi(s)

    return v

}).Reduce(0, func(acc int, cur int) int {

    return acc + cur

})

不幸的是，对于函数式编程的爱好者来说，这并不可行。你需要的不是将方法调用链接在一起，而是将函数调用嵌套起来，或者使用更易读的方法，即一次一次地调用函数，并将中间值分配给变量。类型参数提案详细阐述了排除参数化方法的原因。

也没有可变参数类型参数。在第 314 页的 \"Build Functions with Reflection
to Automate Repetitive Tasks\"
中，我们用反射写了一个包装函数来为任何现有函数计时。这些函数仍然必须通过反射来处理，因为无法用泛型来处理。任何时候你使用类型参数，你都必须为你需要的每一种类型明确提供一个名称，所以你不能用任意数量的不同类型的参数来表示一个函数。

Go 泛型中遗漏的其他功能特性更为深奥。这些包括：

-   特殊化：一个函数或方法除了泛型版本外，还可以重载一个或多个特定类型的版本。由于
    Go 没有重载功能，所以这个功能不在考虑之列。

-   局部化（Currying）：允许你通过指定一些类型参数，在另一个泛型函数或类型的基础上部分实例化一个函数或类型。

-   元编程：允许你指定在编译时运行的代码来生成在运行时运行的代码。

## 4.惯用 Go 和泛型

泛型的加入显然改变了一些关于如何习惯性地使用 Go 的建议。使用 float64
来表示任何数字类型的做法将结束。你应该使用 any 而不是 interface{}
来表示数据结构或函数参数中未指定的类型。你可以只用一个函数处理不同的切片类型。但不要觉得有必要立即将你的所有代码都切换到使用类型参数。随着新的设计模式的发明和完善，你的旧代码仍然可以工作。

现在判断泛型对性能的长期影响还为时尚早。Go 1.18
中的编译器比以前的版本要慢，但这有望在未来的版本中得到解决。已经有一些关于当前运行时影响的研究。Vicent
Marti
写了一篇详细的博文\[11\]，他探讨了泛型导致代码变慢的情况以及解释了为什么会这样的实现细节。相反，Eli
Bendersky
写了一篇博文\[12\]，表明泛型使排序算法更快。同样，随着泛型实现在 Go
的未来版本中逐渐成熟，预计运行时性能将得到改善。

一如既往，我们的目标是编写足够快的可维护程序来满足你的需求。使用我们在第
285 页 \"Benchmarks\" 中讨论的基准和剖析工具来测量和改进。

## 5.进一步解锁未来

Go 1.18 中泛型的最初发布是非常保守的。它在 universe 块中加入了新的接口
any 和 comparable，但在标准库中并没有为支持泛型而改变
API。我们做了一种风格上的改变；标准库中几乎所有的 interface{}
的使用都被替换为 any。

未来版本的标准库可能会包括新的接口定义来表示常见情况（如
Orderable），新的类型（如 set、tree 或有序
map），以及新的函数。在此期间，你可以随意编写你自己的，但考虑在标准库更新后替换它们。

泛型可能是未来其他功能的基础。一种可能性是 sum
类型。就像类型元素被用来指定可以替代类型参数的类型一样，它们也可以被用于可变参数的接口。这将实现一些有趣的功能。今天，Go
在处理 JSON
常见业务时遇到了一个问题：一个字段可以是单个值，也可以是一个值的列表。即使有泛型，处理这种情况的唯一方法是使用
any 类型的字段。添加 sum
类型将允许你创建一个接口，指定一个字段可以是一个字符串，一个字符串的切片，而不是其他。然后，类型转换可以完全枚举每一种有效的类型，提高类型安全性。这种指定一组有界类型的能力允许许多现代语言（包括
Rust 和 Swift）使用 sum 类型来表示枚举。鉴于 Go
目前枚举功能的不足，这可能是一个有吸引力的解决方案，但这些想法需要时间来评估和探索。

## 6.结束语

在本章中，我们了解了泛型以及如何使用它们来简化我们的代码。Go
泛型还处于早期阶段。看到他们如何帮助 Go 语言成长，同时又保持 Go
独特的匠心精神，这将是令人兴奋的。

我们已经完成了对 Go
以及如何习惯使用它的旅程。就像任何毕业典礼一样，是时候说几句结束语了。让我们回顾一下序言中所说的内容。"写得好，Go
很无聊...... 写得好的 Go
程序往往是直截了当的，有时还有点重复"。我希望你现在能明白为什么这会造就更好的软件工程。惯用
Go
的一套工具、实践和模式，可以使跨时间和不断变化的团队维护软件变得更加容易。这并不是说其他语言的文化不重视可维护性；只是这可能不是他们的最高优先事项。相反，他们强调的是性能、新功能或简明的语法等。这些权衡都有其存在的意义，但从长远来看，我认为
Go 的重点是专注于打造能持久使用的软件，Go 在这一点上会胜出。

我祝愿你在为未来 50 年的计算创造软件时一切顺利。

### **参考资料**

\[1\]

**Closures Are the Generics for
Go: **https://medium.com/capital-one-tech/closures-are-the-generics-for-go-cb32021fb5b5

\[2\]

**Type Parameters
Proposal: **https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md

\[3\]

**The Go Playground: **https://go.dev/play/p/l5tpbYr55tz

\[4\]

**更新的堆栈: **https://go.dev/play/p/Ep2_6Zftl5r

\[5\]

**试试吧: **https://go.dev/play/p/MYYW3e7cpkX

\[6\]

**The Go Playground: **https://go.dev/play/p/1_tlI22De7r

\[7\]

**The Go Playground: **https://go.dev/play/p/DtSr07O_o1-

\[8\]

**The Go Playground: **https://go.dev/play/p/MRSprnfhyeT

\[9\]

**The Go Playground: **https://go.dev/play/p/bDffkpsewcj

\[10\]

**The Go Playground: **https://go.dev/play/p/Caw23gcjnmF

\[11\]

**详细的博文: **https://planetscale.com/blog/generics-can-make-your-go-code-slower

\[12\]

**博文: **https://eli.thegreenplace.net/2022/faster-sorting-with-go-generics

## 

===========================================================
# 4.type comparable interface{ comparable }

```go
//--  /home/xyz/programs/go/src/builtin/builtin.go

// comparable is an interface that is implemented by all comparable types
// (booleans, numbers, strings, pointers, channels, arrays of comparable types,
// structs whose fields are all comparable types).
// The comparable interface may only be used as a type parameter constraint,
// not as the type of a variable.
type comparable interface{ comparable }
```

### Go 语言中的 `comparable` 接口解析

你提供的代码片段 `type comparable interface{ comparable }` 是 Go 1.18 版本引入的一个特殊内置接口，用于表示可比较类型。这是 Go 泛型实现中的一个关键组成部分，让我们来深入了解它：

### 1. `comparable` 接口的定义

`comparable` 是 Go 语言的内置接口，其定义如下：

```go
// comparable 是一个预定义的约束，其匹配任何可比较的类型。
// 可比较的类型是布尔型、数字型、字符串型、指针型、通道型、接口型，
// 以及只包含这些类型的结构体或数组。
type comparable interface{ comparable }
```

这个定义看起来有点奇怪（自引用），但这是 Go 语言的一种特殊语法，表示它是一个预定义的约束，用于匹配所有可比较的类型。

### 2. 可比较类型的特点

可比较类型是指可以使用 `==` 和 `!=` 操作符进行比较的类型，包括：
- 基本类型：布尔型、数字型、字符串型
- 引用类型：指针、通道、接口
- 复合类型：只包含可比较类型的结构体和数组
- 注意：切片slice、映射map 和函数类型**不可比较**（除非是与 `nil` 比较）

### 3. 在泛型函数中的应用

`comparable` 接口主要用于泛型函数或泛型类型的约束，例如：
```go
package main

import "fmt"

// Find 查找切片中第一个匹配目标值的元素索引
func Find[T comparable](s []T, target T) int {
    for i, v := range s {
        // 由于 T 是 comparable，所以可以使用 == 操作符
        if v == target {
            return i
        }
    }
    return -1
}

func main() {
    // 使用 Find 函数处理整数切片
    nums := []int{10, 20, 30, 40}
    fmt.Println(Find(nums, 30)) // 输出: 2
    
    // 使用 Find 函数处理字符串切片
    strs := []string{"apple", "banana", "cherry"}
    fmt.Println(Find(strs, "banana")) // 输出: 1
    
    // 以下代码会编译错误，因为切片不可比较
    // slices := [][]int{{1}, {2, 3}}
    // fmt.Println(Find(slices, []int{2, 3})) // 编译错误
}
```

### 4. 与其他约束的组合使用

`comparable` 可以与其他约束组合使用，例如：
```go
package main

import "fmt"

// 定义一个约束，要求类型既是可比较的，又是有序的（支持 <, > 等操作符）
type Ordered interface {
    int | int8 | int16 | int32 | int64 |
        uint | uint8 | uint16 | uint32 | uint64 | uintptr |
        float32 | float64 |
        string
}

// Max 找出切片中的最大值
func Max[T Ordered](s []T) T {
    if len(s) == 0 {
        var zero T
        return zero
    }
    max := s[0]
    for _, v := range s[1:] {
        if v > max {
            max = v
        }
    }
    return max
}

// MapKeys 获取映射的所有键
func MapKeys[K comparable, V any](m map[K]V) []K {
    keys := make([]K, 0, len(m))
    for k := range m {
        keys = append(keys, k)
    }
    return keys
}

func main() {
    // 使用 Max 函数
    fmt.Println(Max([]int{1, 3, 2}))       // 输出: 3
    fmt.Println(Max([]float64{1.2, 3.4, 2.5})) // 输出: 3.4
    
    // 使用 MapKeys 函数
    m := map[string]int{"a": 1, "b": 2, "c": 3}
    fmt.Println(MapKeys(m)) // 输出: [a b c]（顺序不定）
}
```


### 5. 使用注意事项

1. **不可比较类型的限制**：
   - 如果你尝试对不可比较的类型（如切片、映射）使用 `comparable` 约束，会导致编译错误。
   - 例如，不能定义 `func FindSlice[T comparable](s []T, target T) int` 然后传入切片类型。

2. **与 `any` 约束的区别**：
   - `any` 允许任何类型，包括不可比较的类型。
   - `comparable` 只允许可比较的类型。

3. **在映射键中的应用**：
   - Go 语言要求映射的键类型必须是可比较的。
   - 在泛型代码中，如果你需要使用类型参数作为映射的键，必须使用 `comparable` 约束。

### 6. 泛型中其他常用约束

除了 `comparable`，Go 1.18 还引入了一些常用的约束：

- `any`：匹配任何类型，等同于 `interface{}`
- `~T`：匹配底层类型为 T 的类型（包括 T 本身）
- 自定义约束：通过接口定义更复杂的约束条件

`comparable` 接口是 Go 泛型系统中非常重要的一部分，它让我们能够编写更加通用和类型安全的代码，特别是在处理需要比较操作的场景时。