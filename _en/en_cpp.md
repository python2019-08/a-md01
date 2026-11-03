# C++ 软件工程师 常用英语单词、词组、句子
> 按场景分类，优先写高频词汇，附带释义，最后附工作常用短句（阅读源码、写文档、代码评审、邮件沟通）

## 一、基础 C++ 核心术语
|英文|中文|
| ---- | ---- |
|compiler|编译器|
|interpreter|解释器|
|preprocessor|预处理器|
|header file|头文件（`.h`/`.hpp`）|
|source file|源文件（`.cpp`）|
|namespace|命名空间|
|keyword|关键字|
|identifier|标识符|
|literal|字面量|
|variable|变量|
|constant / const|常量|
|type|类型|
|primitive type|基础内置类型|
|user-defined type|用户自定义类型|
|static type|静态类型|
|strongly typed|强类型|
|declaration|声明|
|definition|定义|
|initialization|初始化|
|assignment|赋值|
|scope|作用域|
|lifetime|生命周期|
|memory|内存|
|stack|栈|
|heap|堆|
|static memory|静态内存|
|pointer|指针|
|reference|引用|
|smart pointer|智能指针|
|raw pointer|裸指针|
|ownership|所有权|
|move semantics|移动语义|
|copy semantics|拷贝语义|
|lvalue|左值|
|rvalue|右值|
|template|模板|
|template instantiation|模板实例化|
|generic programming|泛型编程|
|metaprogramming|元编程（compile-time metaprogramming 编译期元编程）|
|class|类|
|object / instance|对象 / 实例|
|member|成员|
|member function|成员函数|
|member variable|成员变量|
|constructor|构造函数|
|destructor|析构函数|
|copy constructor|拷贝构造函数|
|move constructor|移动构造函数|
|overload|重载（函数重载 function overload）|
|override|重写（覆盖虚函数）|
|overwrite|覆写（内存数据）|
|inheritance|继承|
|base class|基类|
|derived class|派生类|
|polymorphism|多态|
|virtual function|虚函数|
|pure virtual function|纯虚函数|
|abstract class|抽象类|
|encapsulation|封装|
|access specifier|访问修饰符（public / protected / private）|
|constexpr|编译期常量表达式|
|inline|内联|
|lambda expression|lambda表达式|
|STL = Standard Template Library|标准模板库|
|container|容器|
|iterator|迭代器|
|algorithm|算法|
|allocator|分配器|
|exception|异常|
|try / catch / throw|异常捕获与抛出|
|undefined behavior (UB)|未定义行为|
|well-defined behavior|定义良好行为|

## 二、构建、编译、链接 & 工程词汇
|英文|中文|
| ---- | ---- |
|build|构建|
|compile|编译|
|link|链接|
|linker|链接器|
|object file|目标文件（`.o`/`.obj`）|
|executable|可执行程序|
|library|库|
|static library|静态库（`.a`/`.lib`）|
|dynamic library / shared library|动态库/共享库（`.so`/`.dll`）|
|dependency|依赖|
|CMake|跨平台构建工具|
|Makefile|make构建脚本|
|toolchain|工具链|
|target|构建目标|
|compile option|编译选项|
|link flag|链接参数|
|optimization|优化（O0/O1/O2/O3）|
|debug build|调试版本|
|release build|发布版本|
|assert|断言|
|sanitizer|消毒器（ASAN/TSAN/UBSAN）|
|static analysis|静态代码分析|
|dynamic analysis|动态分析|
|lint|代码检查工具|

## 三、内存、并发、性能（高频！）
|英文|中文|
| ---- | ---- |
|memory leak|内存泄漏|
|buffer overflow|缓冲区溢出|
|out-of-bounds access|越界访问|
|dangling pointer|野指针/悬垂指针|
|double free|重复释放|
|race condition|竞态条件|
|data race|数据竞争|
|thread|线程|
|mutex|互斥锁|
|lock / unlock|加锁 / 解锁|
|deadlock|死锁|
|atomic|原子变量|
|synchronization|同步|
|asynchronous|异步|
|concurrency|并发|
|parallelism|并行|
|lock-free|无锁|
|cache|缓存|
|cache line|缓存行|
|cache miss|缓存未命中|
|bandwidth|带宽|
|latency|延迟|
|throughput|吞吐量|
|bottleneck|性能瓶颈|
|profiler|性能剖析器|
|benchmark|基准测试|

## 四、版本控制、代码评审、软件工程
|英文|中文|
| ---- | ---- |
|version control|版本控制|
|git commit|提交|
|branch|分支|
|merge|合并|
|rebase|变基|
|pull request / merge request|PR/MR 合并请求|
|code review|代码评审|
|refactor|重构|
|technical debt|技术债|
|unit test|单元测试|
|integration test|集成测试|
|regression test|回归测试|
|bug / defect|缺陷，bug|
|root cause|根本原因|
|fix / patch|修复，补丁|
|feature|功能|
|hotfix|紧急修复|
|API = Application Programming Interface|应用程序接口|
|ABI = Application Binary Interface|应用二进制接口|
|interface|接口|
|contract|契约（接口契约）|

## 五、常用工作短句（写文档、评审、沟通、Issue）
> 适合英文文档、Github issue、代码注释、外企沟通

### 代码 & 实现描述
1. This function returns a raw pointer; caller must manage memory.
这个函数返回裸指针，调用方需要自行管理内存。
2. Use `std::unique_ptr` to enforce exclusive ownership.
使用 `std::unique_ptr` 保证独占所有权。
3. The class is non-copyable but movable.
该类不可拷贝，但支持移动。
4. This method is not thread-safe.
该方法不是线程安全的。
5. Avoid undefined behavior when the input is null.
输入为空时需要避免未定义行为。
6. We use template specialization for this case.
针对该场景我们使用模板特化。
7. Const-qualify member functions where possible.
尽可能给成员函数加上const修饰。

### 编译、构建、Bug相关
1. Compilation fails due to missing header file.
编译失败，缺少头文件。
2. Link error: undefined reference to symbol.
链接错误：符号未找到。
3. This crash is caused by buffer out-of-bounds access.
这次崩溃是缓冲区越界访问导致。
4. ASAN reports a memory leak here.
ASAN检测到此处存在内存泄漏。
5. The issue only reproduces on release build.
该问题只在Release版本复现。
6. Need to add a sanitizer CI job.
需要增加CI的sanitizer检查任务。

### Code Review & 评审常用
1. Suggest replacing raw pointer with smart pointer.
建议把裸指针替换为智能指针。
2. This part needs unit test coverage.
这部分需要补充单元测试覆盖。
3. Please refactor to reduce code duplication.
请重构减少代码重复。
4. The current implementation may introduce race conditions.
当前实现可能引入竞态条件。
5. Add comments to explain non-obvious logic.
增加注释说明不易理解的逻辑。

### 性能相关
1. Cache miss becomes the main bottleneck.
缓存未命中成为主要瓶颈。
2. Lock contention limits throughput.
锁竞争限制了吞吐量。
3. We can move heavy computation to compile time.
可以把繁重计算放到编译期执行。
4. Benchmark shows this optimization reduces latency.
基准测试显示该优化降低延迟。

## 六、C++ 缩写速查（阅读文档/源码经常见到）
- UB = Undefined Behavior 未定义行为
- RAII = Resource Acquisition Is Initialization 资源获取即初始化
- SFINAE = Substitution Failure Is Not An Error 替换失败不是错误
- CRTP = Curiously Recurring Template Pattern 奇异递归模板模式
- STL = Standard Template Library
- ABI = Application Binary Interface
- API = Application Programming Interface
- ASAN = Address Sanitizer 内存检查工具
- TSAN = Thread Sanitizer 线程竞争检查工具

如果你需要，我可以再输出：
版本1：精简版（只保留最高频100个单词，适合背诵）
版本2：纯英文无中文对照版（用于默写）
版本3：更多C++面试英文问答句子