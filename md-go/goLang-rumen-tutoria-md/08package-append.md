# 1.text/template

### Go 语言的 text/template 包简介

`text/template` 是 Go 语言标准库中的一个强大包，用于生成文本输出。它允许你定义模板文件，然后通过注入数据来生成最终的文本内容。这个包在生成配置文件、HTML 页面、邮件模板等场景中非常有用。

### 基本概念

- **模板**：包含文本和动作的文件或字符串
- **动作**：用 `{{` 和 `}}` 包围的表达式，用于控制输出
- **数据**：传递给模板的变量，可以是结构体、映射、切片等
- **管道**：使用 `|` 连接的函数链，类似于 Unix 管道

### 简单示例

下面是一个简单的 `text/template` 使用示例：
```go
package main

import (
	"log"
	"os"
	"text/template"
)

// Person 定义数据结构
type Person struct {
	Name    string
	Age     int
	Address struct {
		City    string
		Country string
	}
}

func main() {
	// 创建一个 Person 实例
	person := Person{
		Name: "John Doe",
		Age:  30,
		Address: struct {
			City    string
			Country string
		}{
			City:    "New York",
			Country: "USA",
		},
	}

	// 定义模板
	tmpl := `Hello, my name is {{.Name}} and I am {{.Age}} years old.
I live in {{.Address.City}}, {{.Address.Country}}.`

	// 解析模板
	t, err := template.New("example").Parse(tmpl)
	if err != nil {
		log.Fatalf("解析模板时出错: %v", err)
	}

	// 执行模板并将结果输出到标准输出
	err = t.Execute(os.Stdout, person)
	if err != nil {
		log.Fatalf("执行模板时出错: %v", err)
	}
}

```


### 模板语法

`text/template` 提供了丰富的模板语法：

1. **变量访问**：
   ```go
   {{.Field}}        // 访问结构体字段
   {{.Key}}          // 访问映射值
   {{index .Slice 0}} // 访问切片元素
   ```

2. **条件判断**：
   ```go
   {{if .Condition}}
       条件为真时的内容
   {{else}}
       条件为假时的内容
   {{end}}
   ```

3. **循环**：
   ```go
   {{range .Items}}
       当前项: {{.}}
   {{end}}
   ```

4. **管道操作**：
   ```go
   {{.Value | func1 | func2}}
   ```

5. **函数调用**：
   ```go
   {{len .Slice}}     // 调用内置函数
   {{formatAge .Age}} // 调用自定义函数
   ```

### 自定义函数

你可以注册自定义函数供模板使用：
```go
package main

import (
	"log"
	"os"
	"strings"
	"text/template"
)

// 自定义函数
func upperCase(s string) string {
	return strings.ToUpper(s)
}

func main() {
	// 创建模板函数映射
	funcMap := template.FuncMap{
		"upper": upperCase,
	}

	// 创建并解析模板，注册自定义函数
	tmpl := `{{"hello" | upper}} World!`
	t, err := template.New("example").Funcs(funcMap).Parse(tmpl)
	if err != nil {
		log.Fatalf("解析模板时出错: %v", err)
	}

	// 执行模板
	err = t.Execute(os.Stdout, nil)
	if err != nil {
		log.Fatalf("执行模板时出错: %v", err)
	}
}
```    


### 从文件加载模板

在实际应用中，通常会从文件加载模板：
```go
package main

import (
	"log"
	"os"
	"text/template"
)

func main() {
	// 从文件加载模板
	tmpl, err := template.ParseFiles("template.txt")
	if err != nil {
		log.Fatalf("解析模板文件时出错: %v", err)
	}

	// 准备数据
	data := map[string]interface{}{
		"Name": "Go 语言",
		"Features": []string{
			"并发支持",
			"垃圾回收",
			"静态类型",
			"内置测试",
		},
	}

	// 执行模板
	err = tmpl.Execute(os.Stdout, data)
	if err != nil {
		log.Fatalf("执行模板时出错: %v", err)
	}
}
```    


### 常用场景

1. **生成配置文件**：根据不同环境生成不同的配置
2. **生成邮件内容**：使用模板生成个性化邮件
3. **命令行工具输出**：格式化命令行工具的输出
4. **代码生成**：自动生成代码框架

`text/template` 是一个功能强大的工具，掌握它可以帮助你更高效地处理文本生成任务。

==================================================
# 2.filepath.Join

### Go 语言中的 filepath.Join 函数详解

`filepath.Join` 是 Go 语言标准库 `path/filepath` 包中的一个核心函数，用于**智能拼接文件路径**。它能够根据不同操作系统的规则自动处理路径分隔符，是编写跨平台应用的重要工具。


#### ### 一、基本功能与语法
**功能**：将多个路径组件连接成一个路径，自动处理路径分隔符和多余的斜杠。

**语法**：
```go
func Join(elem ...string) string
```

**参数**：
- `elem`：可变参数，表示要连接的路径组件

**返回值**：
- 连接后的规范化路径字符串


#### ### 二、核心特性
1. **自动处理路径分隔符**
   - 在 Unix/Linux/macOS 系统上使用 `/`
   - 在 Windows 系统上使用 `\`

2. **处理多余的分隔符**
   - 自动删除重复的分隔符（如 `a///b` → `a/b`）

3. **处理相对路径**
   - 支持 `.`（当前目录）和 `..`（父目录）

4. **处理空组件**
   - 忽略空字符串组件（如 `Join("a", "", "b")` → `a/b`）


#### ### 三、使用示例
##### 1. **基本路径拼接**
```go
package main

import (
    "fmt"
    "path/filepath"
)

func main() {
    // Unix/Linux/macOS 结果: "home/user/documents/report.txt"
    // Windows 结果: "home\\user\\documents\\report.txt"
    path := filepath.Join("home", "user", "documents", "report.txt")
    fmt.Println(path)
}
```

##### 2. **处理多余的分隔符**
```go
path := filepath.Join("a", "//", "b", "/", "c")
// 结果: "a/b/c" (Unix) 或 "a\\b\\c" (Windows)
```

##### 3. **处理相对路径**
```go
path := filepath.Join(".", "data", "..", "config")
// 结果: "data/../config" → "config" (Unix) 或 "config" (Windows)
```

##### 4. **处理空组件**
```go
path := filepath.Join("a", "", "b", "")
// 结果: "a/b" (Unix) 或 "a\\b" (Windows)
```


#### ### 四、与 path.Join 的区别
Go 标准库中有两个类似的函数：
1. **`path/filepath.Join`**
   - 基于操作系统的路径规则（Unix 使用 `/`，Windows 使用 `\`）
   - 推荐用于处理实际文件系统路径

2. **`path.Join`**
   - 始终使用 `/` 作为分隔符
   - 推荐用于处理 URL 路径或不依赖操作系统的抽象路径

**示例对比**：
```go
import (
    "fmt"
    "path"
    "path/filepath"
)

func main() {
    // Unix 系统
    fmt.Println(filepath.Join("a", "b")) // 输出: a/b
    fmt.Println(path.Join("a", "b"))     // 输出: a/b
    
    // Windows 系统
    fmt.Println(filepath.Join("a", "b")) // 输出: a\b
    fmt.Println(path.Join("a", "b"))     // 输出: a/b
}
```


#### ### 五、常见应用场景
1. **构建配置文件路径**
```go
configPath := filepath.Join(os.Getenv("HOME"), ".config", "app", "settings.json")
```

2. **遍历目录**
```go
dir := filepath.Join("data", "logs")
files, _ := os.ReadDir(dir)
```

3. **处理命令行参数**
```go
// 将用户输入的相对路径转为绝对路径
absPath, _ := filepath.Abs(filepath.Join(".", userInput))
```

4. **构建临时文件路径**
```go
tempFile := filepath.Join(os.TempDir(), "temp-"+uuid.New().String())
```


#### ### 六、注意事项
1. **不检查路径是否存在**
   - `filepath.Join` 只处理字符串拼接，不验证路径是否真实存在。

2. **不处理绝对路径**
   - 如果某个组件是绝对路径（如 `/usr` 或 `C:\Windows`），则之前的组件会被丢弃。
   ```go
   path := filepath.Join("a", "/b", "c")
   // 结果: "/b/c" (Unix) 或 "\b\c" (Windows)
   ```

3. **与 filepath.Clean 的配合使用**
   - 对于复杂路径，建议先使用 `Join` 拼接，再用 `Clean` 规范化：
   ```go
   path := filepath.Clean(filepath.Join("a", "..", "b"))
   // 结果: "b"
   ```


#### ### 七、相关函数
1. **filepath.Clean**：规范化路径，处理 `.`、`..` 和多余分隔符
2. **filepath.Abs**：返回绝对路径
3. **filepath.Dir**：返回路径的目录部分
4. **filepath.Base**：返回路径的最后一个组件
5. **filepath.Ext**：返回文件扩展名

**示例**：
```go
path := "/home/user/documents/report.txt"
fmt.Println(filepath.Dir(path))  // 输出: /home/user/documents
fmt.Println(filepath.Base(path)) // 输出: report.txt
fmt.Println(filepath.Ext(path))  // 输出: .txt
```


#### ### 总结
`filepath.Join` 是 Go 语言中处理文件路径的核心函数，它能够智能处理不同操作系统的路径分隔符，是编写跨平台应用的必备工具。在实际开发中，建议始终使用 `filepath.Join` 替代手动拼接路径，以提高代码的可移植性和健壮性。