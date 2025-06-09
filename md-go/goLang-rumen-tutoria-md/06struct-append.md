# 0.contents
```
01 golang 的结构体 是 值类型还是引用类型
02 结构体嵌入的 指针嵌入和值嵌入
03.结构体嵌入的 指针嵌入和值嵌入的严谨解析

```

==========================================
==========================================

# 01 golang 的结构体 是 值类型还是引用类型

在 Go 语言中，**结构体（struct）是值类型**，但可以通过指针实现类似引用类型的行为。以下是详细解释和示例：


### **一、结构体是值类型**
1. **赋值和传参时复制值**  
   当结构体被赋值给另一个变量或作为参数传递时，会复制整个结构体的内容：
   ```go
   type Point struct {
       X, Y int
   }

   func main() {
       p1 := Point{1, 2}
       p2 := p1       // 复制 p1 的值到 p2
       p2.X = 100     // 修改 p2 不会影响 p1
       fmt.Println(p1) // 输出: {1 2}
       fmt.Println(p2) // 输出: {100 2}
   }
   ```

2. **函数内修改不影响原结构体**  
   函数参数接收的是结构体的副本，修改副本不会影响原始值：
   ```go
   func modify(p Point) {
       p.X = 100      // 修改的是副本
   }

   func main() {
       p := Point{1, 2}
       modify(p)
       fmt.Println(p) // 输出: {1 2}（未被修改）
   }
   ```


### **二、通过指针实现引用行为**
1. **结构体指针的赋值和传参**  
   使用指针时，赋值和传参传递的是内存地址，而非值的副本：
   ```go
   func modifyByPtr(p *Point) {
       p.X = 100      // 通过指针修改原始值
   }

   func main() {
       p := &Point{1, 2}
       modifyByPtr(p)
       fmt.Println(p) // 输出: &{100 2}（已被修改）
   }
   ```

2. **结构体包含指针字段**  
   结构体内部的指针字段不会被深拷贝：
   ```go
   type Person struct {
       Name string
       Age  *int    // 指针字段
   }

   func main() {
       age := 30
       p1 := Person{Name: "Alice", Age: &age}
       p2 := p1       // 复制结构体，但 Age 指向同一内存地址
       *p2.Age = 31   // 修改指针指向的值
       fmt.Println(*p1.Age) // 输出: 31（p1 也被修改）
   }
   ```


### **三、值类型 vs 引用类型对比**
| **特性**               | **值类型（结构体）**         | **引用类型（切片、映射）**    |
|------------------------|-----------------------------|-----------------------------|
| 赋值/传参时的行为      | 复制整个值                  | 复制引用（共享底层数据）      |
| 修改是否影响原值       | 否                          | 是                          |
| 内存占用               | 与字段数量和大小成正比       | 固定大小（指针+元数据）       |
| 零值                   | 各字段的零值组合            | nil                         |


### **四、常见场景选择**
1. **使用值类型的情况**  
   - 结构体较小且无需修改原值。  
   - 需要保持数据的不可变性。  
   - 作为 map 的键（必须是可比较的类型）。

2. **使用指针类型的情况**  
   - 结构体较大，频繁传递时为避免复制开销。  
   - 需要在函数内部修改原始结构体。  
   - 实现接口时（接口方法接收者为指针）。


### **五、示例对比**
#### **值类型行为**
```go
type Rectangle struct {
    Width, Height float64
}

func (r Rectangle) Area() float64 {
    return r.Width * r.Height
}

func main() {
    r1 := Rectangle{10, 20}
    r2 := r1
    r2.Width = 100
    fmt.Println(r1.Area()) // 输出: 200（r1 未被修改）
}
```

#### **引用类型行为（通过指针）**
```go
func (r *Rectangle) SetWidth(w float64) {
    r.Width = w
}

func main() {
    r1 := &Rectangle{10, 20}
    r2 := r1
    r2.SetWidth(100)
    fmt.Println(r1.Area()) // 输出: 2000（r1 被修改）
}
```


### **总结**
- **结构体本身是值类型**，赋值和传参时会复制整个值。  
- **通过指针**可以实现引用语义，避免复制开销并修改原始数据。  
- **选择值类型还是指针类型**取决于具体场景，需权衡性能和语义需求。

==========================================
# 02 结构体嵌入的 指针嵌入和值嵌入

[6.8+1结构体嵌入的 指针嵌入和值嵌入]
```go
type HelloServiceClient struct {
	*rpc.Client
}
```
这里，*rpc.Client是golang的什么语法?

doubaoAI:

在 Go 语言中，`*rpc.Client` 这种语法表示 **结构体嵌入（Struct Embedding）**，也称为 **匿名组合（Anonymous Composition）**。这是 Go 语言实现继承和代码复用的一种方式，允许一个结构体直接包含另一个结构体的字段和方法。


### **一、语法解析**
```go
type HelloServiceClient struct {
    *rpc.Client  // 嵌入指针类型的结构体
}
```
- **含义**：`HelloServiceClient` 结构体**隐式包含**了 `rpc.Client` 的所有字段和方法。
- **类型**：嵌入的是 `*rpc.Client`（指针类型），而非 `rpc.Client`（值类型）。


### **二、核心特性**
#### **1. 方法和字段的继承**
`HelloServiceClient` 可以直接调用 `rpc.Client` 的方法，无需显式转发：
```go
client := &HelloServiceClient{rpc.Dial("tcp", "localhost:1234")}
client.Call("Service.Method", args, &reply)  // 直接调用 rpc.Client 的方法
```

#### **2. 访问控制**
- 嵌入结构体的**导出字段和方法**（首字母大写）会被提升为外部结构体的字段和方法。
- 未导出的字段和方法（首字母小写）无法直接访问。

#### **3. 指针 vs 值嵌入**
- **指针嵌入（`*rpc.Client`）**：多个实例 可能会共享同一个底层对象，修改会影响所有引用（取决于指针初始化）。
- **值嵌入（`rpc.Client`）**：每个实例有独立的副本，修改不会相互影响。
- 参见 “# 03.结构体嵌入的 指针嵌入和值嵌入的严谨解析”

### **三、使用场景**
#### **1. 扩展已有类型**
为 `rpc.Client` 添加额外功能，同时保留原有接口：
```go
type LoggedClient struct {
    *rpc.Client
    logger *log.Logger
}

// 添加新方法
func (c *LoggedClient) LoggedCall(serviceMethod string, args, reply interface{}) error {
    c.logger.Printf("Calling %s", serviceMethod)
    return c.Client.Call(serviceMethod, args, reply)  // 调用嵌入的方法
}
```

#### **2. 实现接口组合**
通过嵌入多个结构体，组合多个接口的功能：
```go
type HTTPRequest struct {
    *bytes.Buffer  // 嵌入 io.Reader 和 io.Writer 接口的实现
    url.URL
}
```


### **四、与传统继承的区别**
| 特性               | Go 结构体嵌入                | 传统继承（如 Java）         |
|--------------------|------------------------------|----------------------------|
| 语法               | 显式嵌入结构体               | 通过 `extends` 关键字       |
| 实现方式           | 组合（Composition）          | 继承（Inheritance）         |
| 类型关系           | 无类型关系，仅方法提升       | 子类是父类的子类型         |
| 多重继承           | 支持嵌入多个结构体           | 不支持多重继承             |
| 方法重写           | 通过定义同名方法覆盖         | 通过 `override` 关键字      |


### **五、注意事项**
1. **命名冲突**：若嵌入多个结构体存在同名方法，需显式指定调用路径：
   ```go
   client.rpc.Client.Call(...)  // 明确指定调用 rpc.Client 的方法
   ```

2. **初始化**：嵌入指针类型时，需确保指针已初始化：
   ```go
   client := &HelloServiceClient{
       Client: rpc.Dial("tcp", "localhost:1234"),  // 显式初始化
   }
   ```

3. **接口实现**：若嵌入的结构体实现了某个接口，外部结构体也会被视为实现了该接口。


### **六、示例代码**
```go
package main

import (
    "fmt"
    "net/rpc"
)

// 定义服务客户端
type HelloServiceClient struct {
    *rpc.Client
}

// 添加新方法
func (c *HelloServiceClient) SayHello(name string) (string, error) {
    var reply string
    err := c.Client.Call("HelloService.Say", name, &reply)
    return reply, err
}

func main() {
    // 初始化客户端
    rpcClient, _ := rpc.Dial("tcp", "localhost:1234")
    client := &HelloServiceClient{rpcClient}

    // 调用嵌入的方法
    client.Close()

    // 调用自定义方法
    reply, _ := client.SayHello("World")
    fmt.Println(reply)
}
```


### **总结**
`*rpc.Client` 在 Go 中是**结构体嵌入语法**，允许 `HelloServiceClient` 直接使用 `rpc.Client` 的所有功能，同时可以添加新方法或修改行为。这是 Go 语言实现代码复用和接口组合的核心机制之一，相比传统继承更灵活、更清晰。

=============================================
# 03.结构体嵌入的 指针嵌入和值嵌入的严谨解析
质疑：golang中“结构体嵌入的 指针嵌入,多个实例共享同一个底层对象，修改会影响所有引用;结构体嵌入的 值嵌入：每个实例有独立的副本，修改不会相互影响“，这种说法不严谨吧，指针嵌入可以做到 多个实例共享同一个底层对象而不是必然。

### Golang 结构体嵌入的指针与值语义解析

您的质疑非常正确！关于 Golang 中结构体嵌入的说法确实需要更严谨的表述。让我详细解释这个问题。


#### **值嵌入与指针嵌入的本质区别**

1. **值嵌入（Value Embedding）**  
   当嵌入一个结构体值时，每个外层结构体实例都会包含该结构体的独立副本。
   ```go
   type Address struct {
       City string
   }

   type Person struct {
       Address  // 值嵌入
   }

   p1 := Person{Address: Address{City: "Beijing"}}
   p2 := p1
   p2.Address.City = "Shanghai"  // 仅修改 p2 的副本
   fmt.Println(p1.Address.City)  // 输出: Beijing
   ```

2. **指针嵌入（Pointer Embedding）**  
   当嵌入一个结构体指针时，外层结构体实例会共享同一个底层对象（如果它们指向相同的指针）。但这不是必然的，取决于指针的初始化方式。
   ```go
   type Person struct {
       *Address  // 指针嵌入
   }

   addr := &Address{City: "Beijing"}
   p1 := Person{Address: addr}
   p2 := Person{Address: addr}  // 共享同一个指针
   p2.Address.City = "Shanghai"  // 修改会影响 p1 和 p2
   fmt.Println(p1.Address.City)  // 输出: Shanghai

   // 但如果初始化不同的指针...
   p3 := Person{Address: &Address{City: "Guangzhou"}}
   p3.Address.City = "Shenzhen"  // 仅影响 p3
   ```


#### **关键点澄清**

1. **指针嵌入的共享性取决于初始化**  
   指针嵌入本身并不强制共享，而是提供了共享的**可能性**：
   - 当多个实例指向同一指针时，修改会相互影响。
   - 当每个实例指向不同指针时，修改不会相互影响。

2. **值嵌入的隔离性是必然的**  
   值嵌入保证每个实例有独立副本，修改永远不会相互影响。


#### **实际应用场景**

1. **共享状态的指针嵌入**  
   ```go
   type Config struct {
       Debug bool
   }

   type App struct {
       *Config  // 多个 App 实例共享同一配置
   }

   config := &Config{Debug: true}
   app1 := App{Config: config}
   app2 := App{Config: config}
   app1.Debug = false  // 同时影响 app2
   ```

2. **独立状态的值嵌入**  
   ```go
   type Position struct {
       X, Y int
   }

   type Entity struct {
       Position  // 每个 Entity 有独立位置
   }

   e1 := Entity{Position: {X: 10, Y: 20}}
   e2 := e1
   e2.X = 30  // 仅修改 e2 的位置
   ```


#### **总结**

您的观察非常准确：
- **指针嵌入**：多个实例可以共享同一底层对象，但这取决于指针是否指向同一地址。
- **值嵌入**：每个实例必然有独立副本，修改不会相互影响。

更严谨的表述应该是：
> "结构体的值嵌入保证每个实例有独立的副本，而指针嵌入允许多个实例共享同一个底层对象（取决于指针初始化）。"


这种设计为 Golang 提供了灵活的状态管理方式：
- 需要共享状态时，使用指针嵌入并指向同一对象。
- 需要隔离状态时，使用值嵌入或指针嵌入但指向不同对象。

==========================================
==========================================
# 04.golang结构体标签（struct tags）
 
**下面的golang结构体 定义中，每行的最后字符串是什么语法**
```go
type User struct {
    Id int64 `gorm:"primary_key" json:"id"`
    Name string // 默认字符串对应的是数据库的longtext文本类型
    CreatedAt *time.Time `json:"createdAt" gorm:"column:create_at"`
    Email string `gorm:"type:varchar(255);unique_index"` // 使用type字段定义类型，并设置为唯一索引
    Role string `gorm:"size:255"` // 设置字段的大小为255个字节
    MemberNumber *string `gorm:"unique;not null"` // 设置memberNumber 字段唯一且不为空
    Num int `gorm:"AUTO_INCREMENT"` // 设置 Num字段自增
    Address string `gorm:"index:addr"` // 给Address 创建一个名字是 `addr`的索引
    IgnoreMe int `gorm:"-"` // 忽略这个字段
}
```
------------------------

在给出的Golang结构体定义中，每行字段声明后面的字符串是结构体标签（struct tags）。结构体标签是Go语言的一个特性，允许在结构体字段后面附加元数据。这些标签通常用于控制结构体字段在JSON、XML或其他格式中的编码和解码行为，或者用于ORM（对象关系映射）工具中定义数据库表的列属性。

具体来说，这些标签的语法是反引号（`）括起来的一系列键值对，键值对之间用空格分隔。例如：
- gorm:"primary_key"：这是一个用于GORM ORM框架的标签，表示该字段是数据库表的主键。
- json:"id"：这是一个用于json编码/解码的标签，表示在JSON数据中，该字段应该映射为id。
- gorm:"column:create_at"：GORM标签，表示数据库中对应的列名是create_at（注意这里可能是个笔误，通常应该是created_at）。
- gorm:"type:varchar(255);unique_index"：GORM标签，表示数据库字段类型为VARCHAR(255)，并设置唯一索引。
- gorm:"size:255"：GORM标签，表示数据库字段的大小为255个字节。
- gorm:"unique;not null"：GORM标签，表示该字段在数据库中是唯一的且不允许为空。
- gorm:"AUTO_INCREMENT"：GORM标签，表示该字段是自增的。
- gorm:"index:addr"：GORM标签，表示创建一个名为addr的索引。
- gorm:"-"：GORM标签，表示忽略该字段，不在数据库表中创建对应的列。
这些标签为开发者提供了强大的灵活性，允许在不改变结构体字段本身的情况下，控制字段的多种行为。
 
## 4.1结构体标签（struct tag）示例

```go
type Website struct {
	Name   string  `xml:"name,attr"`
	Url    string
	Course []string
}

func Demo_writeJson() {
	info := []Website{
		{"Golang",
			"http://c.biancheng.net/golang/",
			[]string{"http://c.biancheng.net/cplus/",
				"http://c.biancheng.net/linux_tutorial/"}},
		{"Java",
			"http://c.biancheng.net/java/",
			[]string{"http://c.biancheng.net/socket/",
				"http://c.biancheng.net/python/",
				"http://c11.biancheng.net/python/",
				"http://c12.biancheng.net/python/"}} }

	// 创建文件
	filePtr, err := os.Create("info.json")
	if err != nil {
		fmt.Println("文件创建失败", err.Error())
		return
	}
	defer filePtr.Close()

	// 创建Json编码器
	encoder := json.NewEncoder(filePtr)

	err = encoder.Encode(info)
	if err != nil {
		fmt.Println("编码错误", err.Error())

	} else {
		fmt.Println("编码成功")
	}
}
```
在你的代码中，`xml:"name,attr"` 是一个结构体标签（struct tag），用于指定结构体字段在XML序列化和反序列化时的行为。但需要注意的是，你当前的代码使用的是JSON编码（`json.NewEncoder`），而不是XML，因此这个标签在JSON处理中**不会生效**。


### **结构体标签的作用**
结构体标签是Go语言中一种元数据，用于控制反射（如序列化库）如何处理结构体字段。常见的标签有：
- `json:"field_name"`：用于JSON序列化/反序列化。
- `xml:"field_name"`：用于XML序列化/反序列化。
- `db:"column_name"`：用于ORM（如GORM）映射数据库列。


### **`xml:"name,attr"` 的具体含义**
如果使用XML序列化（如 `encoding/xml` 包），这个标签会：
1. **将字段映射到XML属性**：`Name` 字段会被序列化为XML元素的属性，而非子元素。
2. **指定属性名称**：属性名会被指定为 `name`（而非默认的 `Name`）。

#### **示例对比**
假设没有标签：
```go
type Website struct {
    Name string // 无标签
}
```
XML输出：
```xml
<Website>
  <Name>Golang</Name>
</Website>
```

有 `xml:"name,attr"` 标签：
```go
type Website struct {
    Name string `xml:"name,attr"`
}
```
XML输出：
```xml
<Website name="Golang"></Website>
```


### **你的代码中的问题**
由于你使用的是JSON编码，这个XML标签会被忽略。JSON序列化会使用默认规则（或 `json` 标签）：
- 字段 `Name` 会被序列化为JSON键 `"Name"`（首字母大写，因为字段是公开的）。
- 若想自定义JSON键名，需使用 `json` 标签：
  ```go
  Name string `json:"name"` // JSON键名为"name"
  ```


### **修正建议**
如果你确实需要JSON序列化，应添加 `json` 标签：
```go
type Website struct {
    Name   string   `json:"name"`
    Url    string   `json:"url"`
    Course []string `json:"course"`
}
```

如果你需要XML序列化，应使用 `encoding/xml` 包，并保留 `xml` 标签：
```go
func Demo_writeXML() {
    // ... 代码同上 ...
    encoder := xml.NewEncoder(filePtr)
    err = encoder.Encode(info)
    // ...
}
```


### **总结**
- **`xml:"name,attr"`**：仅对XML序列化有效，将字段转为XML属性。
- **JSON序列化**：需要使用 `json` 标签（如 `json:"name"`）。
- **当前代码**：XML标签被忽略，JSON会使用字段名（首字母大写）作为键。

=========================================================
## 4.2请解释  `json:"rows,omitempty"`
```go
type ConfigFieldUIOptions struct { 
	Rows           string          `json:"rows,omitempty"`
}
```
请解释  `json:"rows,omitempty"`


在 Go 语言中，`json:"rows,omitempty"` 是一个结构体字段标签（Struct Tag），用于控制 JSON 序列化和反序列化的行为。以下是对该标签的详细解释：


### **一、标签语法解析**
```go
Rows string `json:"rows,omitempty"`
```
- **`json`**：表示这是一个 JSON 相关的标签。
- **`"rows"`**：指定 JSON 中的字段名（序列化和反序列化时使用）。
- **`omitempty`**：可选参数，表示当字段值为空时（如空字符串、零值、nil 等），不包含该字段在 JSON 输出中。


### **二、核心作用**
#### **1. 字段重命名**
若结构体字段名与 JSON 字段名不一致，可通过标签指定映射：
```go
type User struct {
    Name string `json:"username"`  // JSON 中使用 "username"
}
```
序列化后：
```json
{"username": "Alice"}
```

#### **2. 忽略空值字段**
`omitempty` 可避免在 JSON 中输出无意义的空值：
```go
type Config struct {
    Host string `json:"host,omitempty"`  // 空字符串时忽略
    Port int    `json:"port,omitempty"`  // 零值时忽略
}

// 当字段为空时
cfg := Config{Host: ""}
```
序列化后：
```json
{}  // 而非 {"host": ""}
```


### **三、示例验证**
#### **结构体定义**
```go
type ConfigFieldUIOptions struct {
    Rows string `json:"rows,omitempty"`
}
```

#### **序列化行为**
```go
// 字段有值
opts := ConfigFieldUIOptions{Rows: "5"}
json.Marshal(opts)  // 输出: {"rows": "5"}

// 字段为空
opts = ConfigFieldUIOptions{}
json.Marshal(opts)  // 输出: {}（而非 {"rows": ""}）
```

#### **反序列化行为**
```json
// JSON 输入
{"rows": "10"}

// 解析后
ConfigFieldUIOptions{Rows: "10"}

// 输入中无 "rows" 字段时
ConfigFieldUIOptions{Rows: ""}  // 字段默认为空字符串
```


### **四、常见应用场景**
1. **API 响应优化**  
   避免返回大量空字段，减少数据传输量：
   ```json
   // 未使用 omitempty
   {"name": "Alice", "age": 0, "email": ""}

   // 使用 omitempty
   {"name": "Alice"}
   ```

2. **兼容第三方 API**  
   当 JSON 字段名与 Go 结构体字段名不一致时：
   ```go
   type GitHubUser struct {
       Login string `json:"login"`  // 对应 GitHub API 的 "login" 字段
   }
   ```

3. **可选配置项**  
   配置文件中某些字段可选，无值时不生成：
   ```go
   type AppConfig struct {
       Timeout int `json:"timeout,omitempty"`  // 无配置时忽略
   }
   ```


### **五、注意事项**
(1). **零值判断规则**  
   `omitempty` 对不同类型的零值判断：
   - **字符串**：空字符串 `""`  
   - **数值**：0  
   - **布尔值**：false  
   - **指针/切片/映射**：nil  
   - **结构体**：空结构体（需显式标记 `omitempty`）

(2). **标签组合使用**  
   可与其他标签组合（如 `yaml`、`xml`）：
   ```go
   type Person struct {
       Name string `json:"name,omitempty" yaml:"name,omitempty"`
   }
   ```

(3). **私有字段**  
   未导出的字段（首字母小写）会被 JSON 包直接忽略，标签无效：
   ```go
   type Example struct {
       privateField string `json:"private,omitempty"`  // 无效
   }
   ```


### **总结**
`json:"rows,omitempty"` 标签的作用是：
- 指定 JSON 序列化/反序列化时的字段名。
- 当字段值为空时，自动从 JSON 输出中省略该字段。

这是 Go 语言处理 JSON 数据时的常用技巧，可提高数据传输效率和可读性。

=========================================================
## 4.3除了忽略空值，还有哪些常见的标签值？

在 Go 语言中，JSON 标签（`json:"..."`）除了 `omitempty` 外，还有许多其他常见的标签值和选项。以下是一些常用的标签配置及其应用场景：


### **一、字段重命名**
通过指定 JSON 字段名，实现结构体字段与 JSON 字段的映射：
```go
type User struct {
    FullName string `json:"name"`      // JSON 中使用 "name"
    Email    string `json:"email"`     // 字段名一致，可省略标签
    Age      int    `json:"user_age"`  // 自定义名称（带下划线）
}
```
**序列化结果**：
```json
{
    "name": "Alice",
    "email": "alice@example.com",
    "user_age": 30
}
```


### **二、忽略字段**
使用 `-` 标签忽略某个字段，使其不参与序列化和反序列化：
```go
type User struct {
    Password string `json:"-"`         // 永远忽略密码字段
    Token    string `json:"-"`         // 敏感信息不暴露
    Created  int64  `json:"created_at"`
}
```
**序列化结果**：
```json
{
    "created_at": 1694851200
}
```


### **三、强制包含空值**
使用 `,string` 标签将数值类型转换为字符串格式，避免空值被忽略：
```go
type Config struct {
    Port   int    `json:"port,string"`    // 转为字符串，空值保留
    Debug  bool   `json:"debug,string"`   // 布尔值转为字符串
    Token  string `json:"token,omitempty"` // 普通字符串，空值忽略
}
```
**序列化结果**：
```go
cfg := Config{Port: 0, Debug: false, Token: ""}
// 输出: {"port": "0", "debug": "false"}
```


### **四、嵌套结构体展开**
使用 `,inline` 标签将嵌套结构体的字段展开到外层：
```go
type Address struct {
    City    string `json:"city"`
    Country string `json:"country"`
}

type User struct {
    Name    string  `json:"name"`
    Contact Address `json:",inline"`  // 展开嵌套结构体
}
```
**序列化结果**：
```json
{
    "name": "Alice",
    "city": "New York",
    "country": "USA"
}
```


### **五、处理指针类型**
指针类型默认会被序列化为 `null`，可结合 `omitempty` 忽略：
```go
type User struct {
    Age    *int    `json:"age,omitempty"`    // 指针，空值忽略
    Email  *string `json:"email"`            // 指针，空值为 null
}
```
**序列化结果**：
```go
// 当 Age 为 nil，Email 为非空指针时
{"age": null, "email": "alice@example.com"}

// 当 Age 和 Email 均为 nil 时
{}  // 若 Email 也有 omitempty，则完全忽略
```


### **六、处理布尔值和数值**
- `,string`：将数值或布尔值转为字符串格式。
- `,omitempty`：忽略零值（如 `false`、`0`）。
```go
type Options struct {
    Enabled bool  `json:"enabled,omitempty"`    // 忽略 false
    Retry   int   `json:"retry,string"`         // 转为字符串
    Weight  int   `json:"weight,omitempty"`     // 忽略 0
}
```
**序列化结果**：
```go
opts := Options{Enabled: false, Retry: 3, Weight: 0}
// 输出: {"retry": "3"}
```


### **七、处理嵌套数组和映射**
```go
type Response struct {
    Items  []string  `json:"items,omitempty"`    // 空切片忽略
    Config map[string]int `json:"config"`        // 空映射保留
}
```
**序列化结果**：
```go
resp := Response{Items: nil, Config: nil}
// 输出: {"config": null} （Items 被忽略，Config 保留 null）
```


### **八、组合标签示例**
```go
type Book struct {
    ID        int       `json:"id"`             // 普通字段
    Title     string    `json:"title,omitempty"`  // 空值忽略
    Author    *string   `json:"author"`         // 指针，可为 null
    Price     float64   `json:"price,string"`   // 转为字符串
    Tags      []string  `json:"tags,omitempty"` // 空切片忽略
    Secret    string    `json:"-"`              // 永远忽略
}
```


### **九、其他标签选项**
1. **处理 time.Time**  
   使用 `,string` 将时间转为 RFC3339 格式字符串：
   ```go
   type Event struct {
       CreatedAt time.Time `json:"created_at,string"`
   }
   ```

2. **自定义序列化**  
   实现 `json.Marshaler` 和 `json.Unmarshaler` 接口，配合标签使用：
   ```go
   type Duration time.Duration

   func (d Duration) MarshalJSON() ([]byte, error) {
       return json.Marshal(time.Duration(d).String())
   }

   type Config struct {
       Timeout Duration `json:"timeout"`
   }
   ```


### **总结**
常见的 JSON 标签选项组合：
| 标签示例              | 作用                                   |
|-----------------------|----------------------------------------|
| `json:"name"`         | 重命名字段                             |
| `json:"-"`            | 忽略字段                               |
| `json:"name,omitempty"` | 重命名并忽略空值                     |
| `json:",inline"`      | 展开嵌套结构体                       |
| `json:",string"`      | 转为字符串格式                       |
| `json:",omitempty"`   | 忽略零值                             |

合理使用这些标签可以让 JSON 序列化和反序列化更加灵活，满足各种复杂场景的需求。

=========================================================
# 05.golang的结构体数组和结构体指针数组的初始化方法一样的？


```go
type sType1 struct {
	a int
	b string
}

func Test_struct() {
	// pointer of struct
	var stP *sType1 = &sType1{1, "1"}
	fmt.Println("stP *sType1=", stP)

	// slice of struct
	var stSlice [4]sType1 = [4]sType1{
		{1, "1"},
		{2, "2"},
	}
	fmt.Println("stSlice [4]sType1=", stSlice)

	// slice of struct pointer
	var stpSlice [4]*sType1 = [4]*sType1{
		{1, "1"},
		{2, "2"},
	}
	fmt.Println("stpSlice [4]*sType1", stpSlice)
}
```
如上述代码所示，golang的结构体数组和结构体指针数组的初始化方法一样的？



在Go语言中，结构体数组和结构体指针数组的初始化方法是不同的。你的代码中已经展示了正确的结构体数组初始化方式，但结构体指针数组的初始化存在错误。让我来解释一下：

### 结构体数组 vs 结构体指针数组

1. **结构体数组**：直接存储结构体实例
2. **结构体指针数组**：存储指向结构体实例的指针

### 错误分析

你的代码中这部分存在错误：

```go
// slice of struct pointer
var stpSlice [4]*sType1 = [4]*sType1{
    {1, "1"},
    {2, "2"},
}
```

这里的问题是，结构体指针数组需要存储指针值（如`&sType1{...}`），而不是直接存储结构体字面量。

### 正确的初始化方式

以下是修复后的完整代码：
```go
package main

import "fmt"

type sType1 struct {
	a int
	b string
}

func Test_struct() {
	// 结构体指针
	var stP *sType1 = &sType1{1, "1"}
	fmt.Println("stP *sType1=", stP)

	// 结构体数组
	var stSlice [4]sType1 = [4]sType1{
		{1, "1"},
		{2, "2"},
	}
	fmt.Println("stSlice [4]sType1=", stSlice)

	// 结构体指针数组 (正确初始化)
	var stpSlice [4]*sType1 = [4]*sType1{
		&sType1{1, "1"},
		&sType1{2, "2"},
	}
	fmt.Println("stpSlice [4]*sType1=", stpSlice)
}

func main() {
	Test_struct()
}

```

    


### 其他初始化方式

除了上述方法，还有几种常见的初始化方式：

```go
// 使用var声明后逐个赋值
var arr1 [2]*sType1
arr1[0] = &sType1{1, "1"}
arr1[1] = &sType1{2, "2"}

// 使用make创建切片并追加元素
slice := make([]*sType1, 0, 4)
slice = append(slice, &sType1{1, "1"})
slice = append(slice, &sType1{2, "2"})

// 使用复合字面量初始化切片
slice2 := []*sType1{
    &sType1{1, "1"},
    &sType1{2, "2"},
}
```

### 主要区别

- **结构体数组**：存储的是结构体的副本，修改数组中的元素不会影响原始结构体
- **结构体指针数组**：存储的是指针，修改指针指向的结构体内容会影响原始结构体

在实际应用中，结构体指针数组更适合处理大型结构体或需要共享数据的场景，因为它避免了结构体复制的开销。

==============================================================
# 06.redundant type from array, slice, or map composite

vscode针对
```go
	var stpSlice [4]*sType1 = [4]*sType1{
		&sType1{1, "1"},
		&sType1{2, "2"},
	}
```    
中的&sType1{1, "1"}和&sType1{2, "2"}提示 redundant type from array, slice, or map composite


你遇到的这个提示 `redundant type from array, slice, or map composite` 是 Go 语言中常见的一个静态检查警告，它表示你在复合字面量中显式指定的类型是多余的。

### 警告原因

在 Go 中，当你已经在变量声明中指定了类型时，复合字面量（如 `[4]*sType1{...}`）中的类型声明通常是多余的。这是因为 Go 编译器已经知道变量的类型，所以不需要在初始化时再次指定。

### 解决方法

你可以通过两种方式解决这个问题：

1. **省略复合字面量中的类型**（推荐方式）：
   ```go
   var stpSlice [2]*sType1 = [...] *sType1{
       &sType1{1, "1"},
       &sType1{2, "2"},
   }
   ```

2. **使用短变量声明**（`:=`）：
   ```go
   stpSlice := [...] *sType1{
       &sType1{1, "1"},
       &sType1{2, "2"},
   }
   ```

### 完整修正代码

下面是修正后的完整代码，移除了冗余的类型声明：
```go
package main

import "fmt"

type sType1 struct {
	a int
	b string
}

func Test_struct() {
	// 结构体指针
	var stP *sType1 = &sType1{1, "1"}
	fmt.Println("stP *sType1=", stP)

	// 结构体数组
	var stSlice [2]sType1 = [...]sType1{
		{1, "1"},
		{2, "2"},
	}
	fmt.Println("stSlice [4]sType1=", stSlice)

	// 结构体指针数组 (修正冗余类型声明)
	var stpSlice [2]*sType1 = [...] *sType1{
		&sType1{1, "1"},
		&sType1{2, "2"},
	}
	fmt.Println("stpSlice [4]*sType1=", stpSlice)
}

func main() {
	Test_struct()
}
```    

### 说明

- 当使用 `:=` 声明变量时，Go 会自动推断变量类型，所以不需要指定 `[4]*sType1`。
- 当使用 `var` 声明变量时，类型已经在变量名后指定，复合字面量中可以使用 `[...]` 代替显式类型。
- 这个警告不会影响代码的功能，但移除冗余代码可以提高可读性和符合 Go 的编码风格。

如果你想完全消除警告，可以采用上述任一方式修改代码。

# 07.[go语言 golint警告]redundant type from array, slice, or map composite literal

haunan 于 2021-06-29 18:55:07 发布 
原文链接：https://blog.csdn.net/Huanan_z/article/details/118341605

**问题：**碰到golint 提示redundant type from array, slice, or map composite literal。
翻译：数组、切片或映射复合文字中的冗余类型。

原因：
var foo = map[int][]int{
	0: []int{1, 2},
	1: []int{1, 2},
}
 
如上面代码改所示，foo的类型已经通过声明知道是map[int][]int。
很明显，foo的键值对中的值一定为[]int，所以不需要 额外声明键值对中的值的类型。直接使用{},而不是[]int{}。
解决做法：

var foo = map[int][]int{
	0: {1, 2},
	1: {1, 2},
}
 
去除掉多余的类型声明，解决了golint报错的问题。 
