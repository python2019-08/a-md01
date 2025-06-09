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