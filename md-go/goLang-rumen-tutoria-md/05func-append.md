# 2.golang 函数模板

在 Go 语言中，函数是组织代码的基本单元。以下是常见的函数模板，涵盖不同场景和最佳实践：


### **1. 基本函数模板**
```go
// Add 计算两个整数的和
func Add(a, b int) int {
    return a + b
}
```


### **2. 带错误返回的函数**
```go
// Divide 计算 a/b，当 b 为 0 时返回错误
func Divide(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("division by zero")
    }
    return a / b, nil
}
```


### **3. 变参函数**
```go
// Sum 计算任意数量整数的和
func Sum(nums ...int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum
}
```


### **4. 闭包函数**
```go
// Counter 返回一个递增计数器函数
func Counter() func() int {
    count := 0
    return func() int {
        count++
        return count
    }
}
```


### **5. 递归函数**
```go
// Factorial 计算 n 的阶乘
func Factorial(n int) int {
    if n <= 1 {
        return 1
    }
    return n * Factorial(n-1)
}
```


### **6. 方法（绑定到结构体）**
```go
// Rectangle 表示矩形
type Rectangle struct {
    Width  float64
    Height float64
}

// Area 计算矩形面积
func (r Rectangle) Area() float64 {
    return r.Width * r.Height
}

// Perimeter 计算矩形周长
func (r *Rectangle) Perimeter() float64 {
    return 2 * (r.Width + r.Height)
}
```


### **7. 接口方法**
```go
// Shape 定义形状接口
type Shape interface {
    Area() float64
    Perimeter() float64
}

// Circle 实现 Shape 接口
type Circle struct {
    Radius float64
}

func (c Circle) Area() float64 {
    return math.Pi * c.Radius * c.Radius
}

func (c Circle) Perimeter() float64 {
    return 2 * math.Pi * c.Radius
}
```


### **8. 并发函数（使用 goroutine）**
```go
// DownloadFile 异步下载文件
func DownloadFile(url string, result chan<- error) {
    go func() {
        resp, err := http.Get(url)
        if err != nil {
            result <- err
            return
        }
        defer resp.Body.Close()
        
        // 处理文件...
        result <- nil
    }()
}
```


### **9. 带超时的函数**
```go
// ProcessWithTimeout 在指定时间内执行任务
func ProcessWithTimeout(ctx context.Context, task func() error) error {
    done := make(chan error, 1)
    
    go func() {
        done <- task()
    }()
    
    select {
    case err := <-done:
        return err
    case <-ctx.Done():
        return ctx.Err()
    }
}
```


### **10. 高阶函数（接收/返回函数）**
```go
// MultiplyBy 返回一个乘以 n 的函数
func MultiplyBy(n int) func(int) int {
    return func(x int) int {
        return x * n
    }
}
```


### **函数注释规范**
```go
// CalculateTotal 计算订单总价
// 参数：
//   - items：商品列表
//   - discount：折扣率（0.0-1.0）
// 返回：
//   - 总价
//   - 错误信息（如折扣率无效）
func CalculateTotal(items []Item, discount float64) (float64, error) {
    if discount < 0 || discount > 1 {
        return 0, fmt.Errorf("invalid discount: %f", discount)
    }
    
    total := 0.0
    for _, item := range items {
        total += item.Price * (1 - discount)
    }
    return total, nil
}
```


### **错误处理最佳实践**
```go
// ReadConfig 读取配置文件
func ReadConfig(path string) (*Config, error) {
    data, err := os.ReadFile(path)
    if err != nil {
        return nil, fmt.Errorf("read config: %w", err)
    }
    
    var cfg Config
    if err := json.Unmarshal(data, &cfg); err != nil {
        return nil, fmt.Errorf("parse config: %w", err)
    }
    
    return &cfg, nil
}
```


根据具体需求选择合适的函数模板，并遵循 Go 语言的编码规范和最佳实践。

=========================================================

