# 5. std::call_once和singleton


`std::call_once` 是 C++11 标准库 `<mutex>` 头文件中提供的一个线程安全的一次性调用机制，用于确保某个函数（或可调用对象）在多线程环境下 **仅执行一次**，即使多个线程同时尝试调用它。

---

## **基本用法**
```cpp
#include <mutex>
#include <iostream>

std::once_flag flag;  // 用于同步的 once_flag 对象

void initialize() {
    std::cout << "Initialized only once!" << std::endl;
}

int main() {
    // 多个线程调用 call_once，但 initialize() 只会执行一次
    std::call_once(flag, initialize);
    std::call_once(flag, initialize);
    return 0;
}
```
**输出**：
```
Initialized only once
```
即使多次调用 `std::call_once`，`initialize()` 也只会执行一次。

---

## **核心特性**
1. **线程安全**  
   - 内部通过锁或原子操作保证线程安全，无需手动同步。
   - 适合用于 **懒汉式单例模式**、**全局初始化** 等场景。

2. **与 `std::once_flag` 配合使用**  
   - `std::once_flag` 是一个轻量级对象，用于标记是否已执行过。
   - **必须全局或长期存在**，不能是临时变量（否则无法保证唯一性）。

3. **异常处理**  
   - 如果被调用的函数抛出异常，`std::call_once` 会标记为“未执行”，允许其他线程再次尝试。

---

## **典型应用场景**
### **1. 懒汉式单例模式（线程安全版）**
```cpp
class Singleton {
public:
    static Singleton& getInstance() {
        static std::once_flag initFlag;
        std::call_once(initFlag,  {
            instance.reset(new Singleton());
        });
        return *instance;
    }

private:
    Singleton() = default;
    static std::unique_ptr<Singleton> instance;
};

std::unique_ptr<Singleton> Singleton::instance;
```

### **2. 全局资源初始化**
```cpp
std::shared_ptr<Resource> globalResource;
std::once_flag resourceFlag;

void initResource() {
    globalResource = std::make_shared<Resource>();
}

void useResource() {
    std::call_once(resourceFlag, initResource);
    globalResource->doSomething();
}
```

### **3. 替代静态局部变量的线程安全初始化**
C++11 已保证 **函数内的静态局部变量初始化是线程安全的**，但 `std::call_once` 更灵活：
```cpp
// C++11 静态局部变量（隐式线程安全）
void foo() {
    static auto obj = std::make_shared<MyClass>();  // 自动线程安全
}

// 显式使用 call_once（可控性更强）
void bar() {
    static std::once_flag flag;
    std::call_once(flag,  {
        auto obj = std::make_shared<MyClass>();
    });
}
```

---

## **与类似机制对比**
| 机制                | 线程安全 | 适用场景                          | 备注                     |
|---------------------|----------|-----------------------------------|--------------------------|
| `std::call_once`    | ✅        | 复杂初始化、单例模式              | 需配合 `std::once_flag`  |
| 静态局部变量        | ✅        | 简单初始化（C++11 起）            | 代码更简洁               |
| 双重检查锁定 (DCLP) | ❌（易错）| 旧代码（C++11 前）                | 需要手动管理内存屏障     |
| `std::mutex` + 标志 | ✅        | 需要自定义逻辑时                  | 代码较冗长               |

---

## **注意事项**
1. **不要复用 `std::once_flag`**  
   每个 `std::call_once` 应对应独立的 `std::once_flag`，否则行为未定义。

2. **性能开销**  
   - 首次调用有同步开销，后续调用无锁（通过原子标记优化）。
   - 适合低频初始化，不适用于高频调用的热路径。

3. **C++11 及以上支持**  
   低版本 C++ 需手动实现类似逻辑（如 `pthread_once`）。

---

## **总结**
- **用途**：确保多线程环境下某段代码只执行一次。
- **优势**：简单、线程安全、无竞态条件。
- **适用场景**：单例模式、全局初始化、延迟加载等。
- **替代方案**：C++11 的静态局部变量（更简洁，但灵活性较低）。

==============================================
# 6.std::call_once

`std::call_once()` 是 C++11 引入的线程安全机制，用于**确保某个函数在多线程环境中只被执行一次**，通常用于单例模式初始化、资源一次性加载等场景。它需要与 `std::once_flag` 配合使用，保证即使多个线程同时调用，目标函数也只会执行一次。


### 基本用法
```cpp
#include <mutex>
#include <iostream>
#include <thread>

std::once_flag flag;  // 标记是否已执行

void init_resource() {
    // 这个函数只会被执行一次
    std::cout << "初始化资源...\n";
}

void thread_func() {
    // 多个线程调用，但init_resource()仅执行一次
    std::call_once(flag, init_resource);
    std::cout << "线程工作中...\n";
}

int main() {
    std::thread t1(thread_func);
    std::thread t2(thread_func);
    std::thread t3(thread_func);

    t1.join();
    t2.join();
    t3.join();
    return 0;
}
```

**输出**：
```
初始化资源...
线程工作中...
线程工作中...
线程工作中...
```

- `std::once_flag` 是一个特殊类型的对象，用于跟踪函数是否已被执行，必须声明为全局或静态变量。
- `std::call_once(flag, func, args...)` 接收三个参数：`flag` 标记、`func` 目标函数、`func` 的参数（可选）。


### 核心特性
1. **线程安全**  
   当多个线程同时调用 `std::call_once()` 时，只有一个线程会执行 `init_resource()`，其他线程会阻塞等待，直到该函数执行完成（不会重复执行）。

2. **异常安全**  
   若目标函数 `func` 抛出异常，`std::call_once()` 会视其为“未执行成功”，允许其他线程再次尝试调用 `func`，直到成功执行一次。

3. **不可复制/移动**  
   `std::once_flag` 既不能复制也不能移动，通常声明为 `static` 或全局变量，确保生命周期覆盖所有可能的调用。


### 典型应用场景
#### 1. 单例模式的线程安全初始化
```cpp
class Singleton {
public:
    static Singleton& get_instance() {
        // 局部静态变量的初始化在C++11后是线程安全的，但配合call_once更明确
        std::call_once(flag_, [](){ 
            instance_.reset(new Singleton()); 
        });
        return *instance_;
    }

private:
    Singleton() = default;  // 私有构造函数
    static std::unique_ptr<Singleton> instance_;
    static std::once_flag flag_;
};

// 初始化静态成员
std::unique_ptr<Singleton> Singleton::instance_;
std::once_flag Singleton::flag_;
```

#### 2. 全局资源的一次性加载
```cpp
// 加载配置文件（只需执行一次）
void load_config() {
    // 读取配置文件到全局变量...
}

// 多个线程可能需要访问配置，但加载只需一次
void process() {
    std::call_once(flag, load_config);
    // 使用配置进行处理...
}
```


### 注意事项
- `std::once_flag` 必须与 `std::call_once()` 一一对应，一个 `flag` 只能控制一个函数的执行。
- 避免在目标函数中执行耗时操作，否则会阻塞其他等待的线程。
- 若目标函数可能抛出异常，需在函数内部捕获并处理，否则 `call_once` 会认为执行失败，允许其他线程重试。


`std::call_once()` 比手动使用互斥锁（`std::mutex`）实现“一次执行”更简洁、高效，是多线程环境下初始化操作的推荐方案。