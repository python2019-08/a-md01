# 1. spf13/cobra
   
`spf13/cobra` 是 Go 语言中最流行的命令行界面（CLI）框架之一，被许多知名项目（如 Kubernetes、Hugo、Docker 等）广泛使用。它提供了强大的命令行解析能力和优雅的代码结构，使开发者能够轻松构建复杂而友好的 CLI 工具。


### **1. 核心概念**
#### **命令（Command）**
- **作用**：代表一个命令行操作（如 `git clone`、`docker run`）。
- **结构**：每个命令由 `Use`（命令名）、`Short`（简短描述）、`Long`（详细描述）和 `Run`（执行逻辑）组成。

#### **参数（Args）**
- 命令后面的位置参数（如 `git clone <repo-url>` 中的 `repo-url`）。

#### **标志（Flag）**
- 选项参数，用于修改命令行为（如 `--verbose`、`-f filename`）。


### **2. 快速入门**
#### **安装**
```bash
go get -u github.com/spf13/cobra@latest
```

#### **创建 CLI 应用**
使用 `cobra-cli` 工具（需单独安装）：
```bash
go install github.com/spf13/cobra-cli@latest
cobra-cli init myapp --pkg-name github.com/yourusername/myapp
cd myapp
```


### **3. 基本用法**
#### **定义根命令**
```go
// cmd/root.go
package cmd

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
    Use:   "myapp",
    Short: "My CLI application",
    Long:  "A powerful CLI tool for various tasks.",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Welcome to myapp! Use --help for available commands.")
    },
}

func Execute() {
    if err := rootCmd.Execute(); err != nil {
        os.Exit(1)
    }
}
```

#### **添加子命令**
```go
// cmd/greet.go
package cmd

import (
    "fmt"

    "github.com/spf13/cobra"
)

var greetCmd = &cobra.Command{
    Use:   "greet",
    Short: "Greet someone",
    Run: func(cmd *cobra.Command, args []string) {
        name := "World"
        if len(args) > 0 {
            name = args[0]
        }
        fmt.Printf("Hello, %s!\n", name)
    },
}

func init() {
    rootCmd.AddCommand(greetCmd)
}
```

#### **运行应用**
```bash
go run main.go greet        # 输出：Hello, World!
go run main.go greet Alice  # 输出：Hello, Alice!
```


### **4. 标志（Flags）**
#### **局部标志（仅用于当前命令）**
```go
var name string

var greetCmd = &cobra.Command{
    Use:   "greet",
    Short: "Greet someone",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Printf("Hello, %s!\n", name)
    },
}

func init() {
    greetCmd.Flags().StringVarP(&name, "name", "n", "World", "Name to greet")
}
```

#### **全局标志（所有命令可用）**
```go
// 在 rootCmd 中添加
var verbose bool

func init() {
    rootCmd.PersistentFlags().BoolVarP(&verbose, "verbose", "v", false, "Enable verbose output")
}
```


### **5. 分层命令结构**
可以构建多级命令，例如：
```bash
myapp server start  # 启动服务器
myapp server stop   # 停止服务器
```

```go
// cmd/server.go
var serverCmd = &cobra.Command{
    Use:   "server",
    Short: "Manage server",
}

var startCmd = &cobra.Command{
    Use:   "start",
    Short: "Start server",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Starting server...")
    },
}

var stopCmd = &cobra.Command{
    Use:   "stop",
    Short: "Stop server",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Stopping server...")
    },
}

func init() {
    rootCmd.AddCommand(serverCmd)
    serverCmd.AddCommand(startCmd, stopCmd)
}
```


### **6. 高级特性**
#### **命令完成（自动补全）**
通过 `ValidArgs` 和 `ValidArgsFunction` 实现：
```go
greetCmd.ValidArgs = []string{"alice", "bob", "charlie"}
```

#### **配置文件支持**
使用 `viper` 库读取配置文件：
```go
import "github.com/spf13/viper"

func init() {
    viper.SetConfigName("config")
    viper.SetConfigType("yaml")
    viper.AddConfigPath(".")
    err := viper.ReadInConfig()
    if err != nil {
        // 处理错误
    }
}
```

#### **自定义帮助信息**
通过 `PersistentPreRun` 或 `HelpFunc` 自定义：
```go
rootCmd.SetHelpFunc(func(cmd *cobra.Command, args []string) {
    fmt.Println("Custom help message...")
    cmd.OriginalHelpFunc()
})
```


### **7. 最佳实践**
1. **单一职责原则**：每个命令专注于一个功能。
2. **命令分组**：通过分层结构组织命令。
3. **清晰的错误处理**：在 `Run` 函数中处理错误。
4. **使用 `cobra-cli`**：快速生成命令模板。
5. **文档完善**：为每个命令提供 `Short` 和 `Long` 描述。


### **总结**
`cobra` 提供了优雅的 API 和强大的功能，使开发者能够高效构建专业的 CLI 工具。其核心优势包括：
- 自动生成帮助信息和命令完成。
- 灵活的标志和参数解析。
- 可扩展的命令层级结构。
- 与其他库（如 `viper`）良好集成。

如果你需要开发 Go 语言的 CLI 应用，`cobra` 是首选框架。
===============================================================
# 2. cobra.Command.AddCommand

在 Go 语言中，`cobra.Command.AddCommand` 是 `cobra` 库的核心方法之一，用于构建层级化的命令行接口（CLI）。`cobra` 是一个流行的 CLI 框架，被许多知名项目（如 Kubernetes、Hugo）使用。


### **1. 方法定义**
```go
func (c *Command) AddCommand(commands ...*Command)
```
- **作用**：将一个或多个子命令添加到当前命令（`c`）下，形成命令层级结构。
- **参数**：接受多个 `*Command` 类型的参数，表示要添加的子命令。


### **2. 基本用法**
#### **示例代码**
```go
package main

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
)

func main() {
    // 定义根命令
    rootCmd := &cobra.Command{
        Use:   "app",
        Short: "My CLI application",
        Run: func(cmd *cobra.Command, args []string) {
            fmt.Println("Welcome to my app!")
        },
    }

    // 定义子命令
    greetCmd := &cobra.Command{
        Use:   "greet",
        Short: "Greet someone",
        Run: func(cmd *cobra.Command, args []string) {
            fmt.Println("Hello!")
        },
    }

    // 添加子命令到根命令
    rootCmd.AddCommand(greetCmd)

    // 执行命令
    if err := rootCmd.Execute(); err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
}
```

#### **执行效果**
```bash
$ go run main.go         # 执行根命令
Welcome to my app!

$ go run main.go greet   # 执行子命令
Hello!
```


### **3. 多层级命令结构**
可以通过嵌套 `AddCommand` 构建更复杂的层级：

```go
// 定义二级子命令
helloCmd := &cobra.Command{
    Use:   "hello",
    Short: "Say hello",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Hello world!")
    },
}

// 将 helloCmd 添加到 greetCmd 下
greetCmd.AddCommand(helloCmd)

// 现在的命令结构：
// app
// └── greet
//     └── hello
```

执行方式：
```bash
$ go run main.go greet hello   # 输出：Hello world!
```


### **4. 实战场景**
#### **Git 风格的 CLI**
```go
// 模拟 git 命令结构
gitRoot := &cobra.Command{Use: "git"}

// 添加子命令
gitRoot.AddCommand(
    &cobra.Command{
        Use:   "clone",
        Short: "Clone a repository",
        Run: func(cmd *cobra.Command, args []string) {
            fmt.Printf("Cloning repo: %s\n", args[0])
        },
    },
    &cobra.Command{
        Use:   "commit",
        Short: "Commit changes",
        Run: func(cmd *cobra.Command, args []string) {
            fmt.Println("Committing changes...")
        },
    },
)

// 执行：go run main.go git clone https://github.com/xxx/xxx
```


### **5. 注意事项**
1. **命令名称唯一性**：  
   同一层级的子命令名称不能重复，否则会覆盖前一个命令。

2. **参数传递**：  
   子命令可以通过 `args` 参数接收命令行参数（如示例中的 `clone` 命令接收仓库 URL）。

3. **命令帮助信息**：  
   `cobra` 会自动生成帮助信息，包括子命令列表。执行 `app --help` 即可查看。

4. **链式调用**：  
   `AddCommand` 支持链式调用：
   ```go
   rootCmd.AddCommand(cmd1).AddCommand(cmd2)
   ```


### **总结**
`cobra.Command.AddCommand` 是构建复杂 CLI 工具的基础，通过它可以轻松实现层级化的命令结构，让你的 CLI 工具既强大又易用。结合 `cobra` 的其他特性（如 flags、persistent flags），可以打造出专业级的命令行应用。
