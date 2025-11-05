# 1.深入解析 C++11 的 `std::atomic`：误区、性能与实际应用

Posted on 2024-12-10 03:30  
https://www.cnblogs.com/lizhuo6/p/18609373

在现代 C++ 开发中，std::atomic 是处理多线程同步时的重要工具之一。它通过提供原子操作保证了线程安全，但在实际使用时却隐藏着许多不为人知的陷阱和性能影响。本篇文章将带你深入理解 std::atomic 的使用方式、潜在问题，以及如何正确应用于多线程环境。

为什么需要 std::atomic？
在多线程程序中，共享变量的读写可能会发生竞态条件（race condition）。传统的锁（如 std::mutex）可以解决这个问题，但锁的使用会导致性能下降。而 std::atomic 通过底层硬件的支持，实现了高效的原子操作，无需额外加锁。
关键点：std::atomic 是 C++11 引入的，用于简化并发编程，同时保证线程安全。

## 一、误区与注意事项
### 1. 并非所有操作都是原子的
很多开发者容易误以为 std::atomic<T> 的所有操作都是原子性的，但实际上，只有特定的操作（如加减法、位运算等）是原子性的。对于以下类型的运算，std::atomic 并不支持原子性：
> 1. 整型的乘法和除法
> 2. 浮点数的加减乘除

来看一个实际的例子：
```cpp
std::atomic_int x{1};
x = 2 * x;  // 非原子操作
```

表面上看，这段代码好像是一个简单的原子操作，但实际上它是以下分步操作的组合：
```cpp
std::atomic_int x{1};
int tmp = x.load();  // 原子读取
tmp = tmp * 2;       // 普通乘法
x.store(tmp);        // 原子写入
```
因此，这段代码不能保证线程安全。


如何避免？
推荐使用 std::atomic 提供的专用方法，比如 fetch_add、fetch_sub 等。以下是一个对比示例：
```cpp
std::atomic_int x{1};
x.fetch_add(1);  // 原子操作
x += 1;          // 原子操作
x = x + 1;       // 非原子操作
```

### 2. std::atomic 并非总是无锁的
无锁（lock-free） 是 std::atomic 的重要特性之一，但并非所有 std::atomic 对象都能实现无锁操作。是否无锁依赖于以下因素：

(1)数据类型的大小
  * 小型数据类型（如 int、long）通常可以无锁操作。
  * 大型结构体（如包含多个成员的结构体）则可能需要锁。
(2)硬件架构
  * 某些 CPU（如 x86 架构）支持更广泛的无锁原子操作，而其他架构（如 ARM）可能对复杂类型采用加锁机制。


std::atomic 提供了 is_lock_free 方法来检查是否支持无锁操作：
```cpp
std::atomic<int> a;
std::cout << "Is lock free? " << a.is_lock_free() << std::endl;
```

结构体示例
```cpp
struct A { long x; };       // 通常无锁
struct B { long x; long y; };  // 可能无锁
struct C { char s[1024]; };  // 通常需要锁
```

## 二、性能与陷阱
使用原子操作一定会带来性能开销，这是因为原子操作涉及硬件的缓存同步机制和内存屏障（Memory Barrier）。

示例：原子操作的性能测试
以下代码比较了使用普通变量和原子变量的性能差异：
```cpp
#include <iostream>
#include <atomic>
#include <thread>
#include <chrono>

// 使用普通变量
int non_atomic_value = 0;

// 使用原子变量
std::atomic<int> atomic_value(0);

void increment_atomic() {
    for (int i = 0; i < 100000; ++i) {
        atomic_value.fetch_add(1);
    }
}

void increment_non_atomic() {
    for (int i = 0; i < 100000; ++i) {
        non_atomic_value++;
    }
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();

    std::thread t1(increment_atomic);
    std::thread t2(increment_atomic);
    t1.join();
    t2.join();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "Atomic time: " << duration.count() << "ms\n";
    std::cout << "Final atomic value: " << atomic_value.load() << "\n";

    start = std::chrono::high_resolution_clock::now();
    t1 = std::thread(increment_non_atomic);
    t2 = std::thread(increment_non_atomic);
    t1.join();
    t2.join();

    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "Non-atomic time: " << duration.count() << "ms\n";
    std::cout << "Final non-atomic value: " << non_atomic_value << "\n";

    return 0;
}
```

运行结果分析：
* 原子操作虽然保证了线程安全，但其耗时通常高于普通变量操作。
* 非原子变量可能导致数据竞争，结果不可靠。

## 三、实际应用示例
### 1. compare_exchange_strong
compare_exchange_strong 是原子操作中的核心，用于实现线程安全的条件更新。其原理可以理解为：

```cpp
value == expected ? value = new_value : expected = value;
```

示例代码：
```cpp
#include <iostream>
#include <atomic>

int main() {
    std::atomic<int> value(0);
    int expected = 5;
    int new_value = 11;

    bool result = value.compare_exchange_strong(expected, new_value);
    if (result) {
        std::cout << "Update successful. New value: " << value << "\n";
    } else {
        std::cout << "Update failed. Current value: " << value 
                  << ", expected was updated to: " << expected << "\n";
    }
    return 0;
}
```
## 四、总结
std::atomic 是 C++ 多线程编程的重要工具，但在使用中需注意以下几点： 
* 1. 并非所有操作都具备原子性，需谨慎选择操作方式。
* 2. std::atomic 是否无锁依赖于数据类型、硬件架构和内存对齐。
* 3. 虽然 std::atomic 提供线程安全，但也会带来一定性能开销。

通过正确使用 std::atomic 提供的原子方法，可以在多线程编程中实现更高效、更可靠的代码。
============================================================
# 2.C++之std::atomic＜bool＞原子bool类型与普通bool区别(二百六十二)
于 2024-03-28 12:04:54 发布
原文链接：https://blog.csdn.net/u010164190/article/details/137107074

## 2.1.前言
本篇目的：C++之std::atomic原子bool类型与普通bool区别

## 2.2.std::atomic原子bool类型与普通bool区别介绍
std::atomic 是 C++11 标准库中的一个模板特化，用于表示一个可以原子操作的布尔值。原子操作意味着这些操作是不可中断的，即在多线程环境中，当一个线程正在执行原子操作时，其他线程无法同时访问或修改这个值。

与普通的 bool 类型相比，std::atomic 有以下主要区别和用途：
> 1. 线程安全：普通的 bool 类型不是线程安全的。如果你在多线程环境中共享一个普通的 bool 变量，并且多个线程可能会同时读取或修改它，那么你需要额外的同步机制（如互斥锁）来避免数据竞争和不一致。而 std::atomic 提供了内建的线程安全保证，无需额外的同步。
> 
> 2. 原子操作：你可以对 std::atomic 执行原子操作，如 load(), store(), exchange(), compare_exchange_weak(), 和 compare_exchange_strong()。这些操作在多线程环境中是安全的，因为它们在执行时不会被其他线程打断。相比之下，对普通的 bool 的操作（如赋值或读取）通常不是原子的，因此在多线程环境中可能导致问题。

> 3. 性能：虽然使用 std::atomic 通常比使用互斥锁等同步机制有更高的性能开销，但在某些情况下，它仍然是一个很好的选择。特别是当需要频繁地、快速地访问和修改共享数据时，原子类型可以提供一个相对高效的解决方案，同时保持线程安全。
> 
> 4. 简化的同步：使用 std::atomic 可以简化代码，因为你不需要显式地管理锁或其他同步机制。这可以使代码更易于理解和维护。

一个典型的 std::atomic 的使用场景是在多线程环境中作为一个标志位或信号量。例如，一个线程可以原子地设置一个 std::atomic 变量来表示某个任务已经完成，而另一个线程可以原子地检查这个变量来确定是否应该继续执行后续操作。

## 2.3.代码实例
<1>.普通bool例子：多线程中的非原子操作（可能导致数据竞争）
```cpp
#include <iostream>  
#include <thread>  
#include <chrono>  
  
bool ready = false; // 非原子布尔变量  
  
void workerThread() {  
    std::this_thread::sleep_for(std::chrono::seconds(1));  
    ready = true; // 非原子地设置 ready 为 true  
}  
  
void waitForSignal() {  
    while (!ready) {  
        std::cout << "Waiting for the signal...\n";  
        std::this_thread::sleep_for(std::chrono::milliseconds(100)); // 等待信号  
    }  
    std::cout << "Received the signal!\n";  
}  
  
int main() {  
    std::thread worker(workerThread);  
    waitForSignal();  
    worker.join();  
    return 0;  
}
```
ready 是一个普通的 bool 变量，不是原子的。因此，在多线程环境中对它的读写可能会导致数据竞争和不确定的行为。

<2>.std::atomic例子：线程间的信号通知
```cpp
#include <iostream>  
#include <thread>  
#include <atomic>  
#include <chrono>  
  
std::atomic<bool> ready(false); // 初始化为 false 的原子布尔变量  
  
void workerThread() {  
    std::this_thread::sleep_for(std::chrono::seconds(1)); 
    ready.store(true); // 设置 ready 为 true，通知其他线程  
    std::cout << "Worker thread finished its work.\n";  
}  
  
int main() {  
    std::thread t(workerThread);  
  
    while (!ready.load()) {  
        std::cout << "Waiting for the worker thread to finish...\n";  
        std::this_thread::sleep_for(std::chrono::milliseconds(100)); // 等待 worker 线程完成  
    }  
  
    std::cout << "Main thread detected that the work is ready.\n";  
    t.join();  
    return 0;  
}
```
工作线程运行一个循环，直到 running 变量被设置为 false。主线程在一段时间后设置 running 为 false，工作线程检测到这个变化后停止循环。由于 running 是原子的，因此这个检查操作是线程安全的。
========================================================
# 3. std::atomic_int 
https://en.cppreference.com/w/cpp/atomic/atomic.html

```cpp
#include <atomic>
#include <iostream>
#include <thread>
#include <vector>
 
std::atomic_int acnt;
int cnt;
 
void f()
{
    for (auto n{10000}; n; --n)
    {
        ++acnt;
        ++cnt;
        // Note: for this example, relaxed memory order is sufficient,
        // e.g. acnt.fetch_add(1, std::memory_order_relaxed);
    }
}
 
int main()
{
    {
        std::vector<std::jthread> pool;
        for (int n = 0; n < 10; ++n)
            pool.emplace_back(f);
    }
 
    std::cout << "The atomic counter is " << acnt << '\n'
              << "The non-atomic counter is " << cnt << '\n';
}
```

Possible output:

The atomic counter is 100000
The non-atomic counter is 69696