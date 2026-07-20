# 1. ros2 的版本不同，写的代码不一样吗
简单直接地回答你：是的，不同版本的 ROS 2 之间代码会有差异，但并不是“天差地别”。
随着 ROS 2 的演进，API 会不断优化，有些旧的写法会被弃用（Deprecated），而新的特性会被引入。

ROS 2 的发布节奏分为 LTS（长期支持版，如 Foxy, Humble） 和 非 LTS 版（如 Galactic, Iron）。代码差异主要体现在以下几个方面：
**API** 的演进： 比如从 Foxy 升级到 Humble 时，某些 C++ 的头文件路径或 Python 的函数参数可能会发生变化。
**底层 RMW（中间件）**的变更： 不同的版本默认使用的通信中间件（如 Cyclone DDS 或 Fast DDS）可能不同，虽然这通常不直接改动业务代码，但会影响配置文件和性能表现。
**构建系统** 的优化： colcon 构建工具虽然通用，但在不同版本中，CMakeLists.txt 或 package.xml 的依赖写法可能会有微调。

## 我该选哪个版本？
作为开发者（Abner），选择版本通常取决于你的硬件和操作系统：

如果你在用 Ubuntu 24.04： 请直接安装 Jazzy Jalisco。它是目前最成熟且受支持的 LTS。
如果你在用 Ubuntu 22.04： 那么 Humble 依然是你的唯一选择（因为 ROS 2 版本与 Ubuntu 版本是严格绑定的）。
如果你准备尝试 Ubuntu 26.04： 那么请关注本月发布的 Lyrical Luth。

<!-- ---------------------------------------------- -->

# 2. ros2核心概念

了解 ROS 2 的核心概念是掌握机器人开发的钥匙。我们可以把 ROS 2 想象成一个**“数字城市”**，不同的概念对应着城市运行的不同规则。

---

### 1. 节点与通信机制（城市里的居民与对话）

#### **节点 (Nodes)**
节点是 ROS 2 中最基本的单位。一个节点通常只负责一个单一的任务（比如：控制电机、读取雷达数据、进行路径规划）。
*   **逻辑：** “各司其职”。如果一个节点崩溃了，其他节点通常还能运行，这增强了系统的健壮性。

#### **通信模式：话题、服务、动作**
这三者构成了节点之间沟通的桥梁：

*   **话题 (Topics) - “广播模式”**
    *   **逻辑：** 异步通信。节点 A 发送数据（发布者），节点 B 接收数据（订阅者）。
    *   **特点：** 发布者不知道谁在听，订阅者不知道谁在发。适用于连续、高频的数据流（如传感器数据）。
*   **服务 (Services) - “问答模式”**
    *   **逻辑：** 同步通信。一个节点发送请求（Request），另一个节点处理并返回响应（Response）。
    *   **特点：** 发起方会等待。适用于快速、离散的操作（如开关灯、查询状态）。
*   **动作 (Actions) - “任务模式”**
    *   **逻辑：** 复杂的问答。包含：目标设定（Goal）、反馈（Feedback）和结果（Result）。
    *   **特点：** 适用于耗时任务（如机器人导航去厨房）。你可以中途收到“距离还有5米”的反馈，也可以随时取消。



---

### 2. DDS 通信机制（城市的地下神经网）

**DDS (Data Distribution Service)** 是 ROS 2 的核心灵魂，也是它与 ROS 1 最大的区别。

*   **去中心化：** ROS 1 需要一个“Master”节点来管理全局，一旦 Master 挂了全城瘫痪。ROS 2 的 DDS 机制让节点之间可以**自动发现**彼此，像蓝牙一样，不需要中心路由器。
*   **QoS (Quality of Service) 策略：** 这是 DDS 的杀手锏。你可以为不同的通信设置不同的“质量要求”：
    *   **可靠性：** 必须收到数据包（像发邮件）。
    *   **实时性：** 只要最新的数据，丢包也没关系（像看直播视频）。
*   **安全性：** 支持加密通信，这在工业和军事机器人中至关重要。

---

### 3. 工作空间与包（城市的行政区划）

在开发时，代码需要按照严格的层级组织，否则编译器（`colcon`）找不到它们。

#### **层级结构：**
```text
my_robot_ws/                <-- 工作空间 (Workspace)：你的总工程目录
└── src/                    <-- 源代码目录：所有代码必须放这里
    ├── my_sensor_pkg/      <-- 功能包 (Package A)：传感器驱动
    │   ├── package.xml     <-- 包的身份证（声明依赖）
    │   ├── CMakeLists.txt  <-- 编译脚本（C++ 用）或 setup.py (Python 用)
    │   └── src/ / scripts/ <-- 实际的代码文件
    └── my_logic_pkg/       <-- 功能包 (Package B)：控制算法
```

*   **工作空间 (Workspace)：** 这是一个隔离的环境。你在终端执行 `source install/setup.bash` 后，系统才能识别这个空间里的指令。
*   **包 (Package)：** 这是 ROS 2 代码分发的**最小单位**。如果你想把你的雷达驱动给别人用，你只需把整个包文件夹打包给他就行。
    *   **必须包含：** `package.xml`（列出你的代码需要哪些库）和构建文件（`CMakeLists.txt`）。



---

### 总结逻辑
1.  你编写**代码**并组织成**包 (Package)**。
2.  将包放入**工作空间 (Workspace)** 并编译。
3.  程序运行时产生**节点 (Node)**。
4.  节点通过 **DDS** 协议，利用**话题、服务或动作**进行数据交换。

<!-- ================================================================== -->

# 3."如果一个节点崩溃了，其他节点通常还能运行",所以节点是进程？

你的直觉非常准确。**在 ROS 2 的物理执行层面，节点通常就是以进程（Process）的形式存在的。**

为了让你理解得更透彻，我们需要从“逻辑层面”和“物理层面”两个维度来看：

---

### 1. 逻辑层面：节点 (Node)
在写代码时，我们将节点看作是一个**功能单元**。比如你写了一个 Python 脚本或 C++ 程序，里面定义了一个 `Node` 类。逻辑上，它就是一个独立的“大脑”。

### 2. 物理层面：进程 (Process) vs 线程 (Thread)

这是 ROS 2 最核心的设计逻辑：

#### **默认情况：一个节点 = 一个进程**
当你使用 `ros2 run <package> <executable>` 启动一个节点时，操作系统（如你的 Ubuntu）会为这个可执行文件创建一个独立的**进程**。
*   **隔离性：** 既然是独立的进程，它拥有自己独立的内存空间。如果这个进程因为段错误（Segment Fault）或异常崩溃了，操作系统只会回收这一个进程的资源，**不会影响到其他正在运行的进程（节点）**。这就是你提到的“其他节点还能运行”的原因。



#### **进阶情况：多节点共用进程（组件 Component）**
ROS 2 引入了一个非常强大的概念叫 **Component (组件)**。
*   **逻辑：** 你可以把多个节点“打包”到一个进程里运行。
*   **原因：** 进程间通信（IPC）虽然安全，但通过 DDS 传输数据会有一定的开销。如果两个节点数据交换量极大（比如传高分辨率图片），把它们放在同一个进程内，利用**共享内存（Zero-copy）**通信，效率会极高。
*   **风险：** 这种情况下，如果其中一个节点导致进程崩溃，那么该进程内的所有节点都会一起“殉职”。

---

### 3. 为什么 ROS 2 强调这种“节点”设计？

相比于传统的单体程序（一个巨大的 `.exe` 跑所有功能），ROS 2 的这种“节点化/进程化”设计有三大好处：

1.  **故障隔离：** 你的“自动刹车节点”不应该因为“音乐播放节点”死机而停止工作。
2.  **分布式运行：** 因为节点是独立的，你可以让“视觉算法节点”跑在带 GPU 的电脑上，而让“电机驱动节点”跑在树莓派上，它们通过网络通信，逻辑上依然像在一台机器上一样。
3.  **混合编程：** 你的感知节点可以用 Python 写（方便调库），而控制节点可以用 C++ 写（追求性能），它们作为不同进程完美协同。

---

### 总结
*   **通常情况下**：是的，一个节点就是一个独立的进程。
*   **高性能场景下**：多个节点可以像插件一样加载进同一个进程中运行。

这种设计让 ROS 2 既具备了类似微服务架构的**鲁棒性**，又保留了底层开发需要的**高性能**。

<!-- ================================================================== -->

# 4.学会ubuntu 24.04 上 和 android上用ros ,是不是能满足大部分的市场需求

学会 Ubuntu 24.04 (Jazzy) 和 Android 上的 ROS 2 开发，**确实能够覆盖目前市场上很大一部分（约 60%-70%）的机器人开发需求**，但要达到“满足大部分市场需求”的专家水平，还需要补齐另外几个维度的拼图。

我们可以从**操作系统分布**、**应用场景**以及**技能深度**三个维度来拆解：

### 1. 操作系统维度：Ubuntu 是绝对统治者
*   **Ubuntu (24.04/22.04):** 它是机器人行业的“国标”。几乎所有的算法原型、仿真环境（Gazebo/Isaac Sim）和工业级控制器都是基于 Ubuntu 的。掌握了 24.04 上的 Jazzy，你就掌握了未来 3-5 年的主流开发环境。
*   **Android:** 这是一个极具潜力的**差异化技能**。Android 在机器人中通常扮演两个角色：
    *   **人机交互界面 (HMI):** 比如餐厅送餐机器人的那个平板屏幕。
    *   **轻量化控制器:** 利用手机/平板的传感器和算力。
    *   **市场地位：** 如果你会 Android + ROS 2 跨平台通信，你在服务型机器人（配送、陪护、商用显示）领域会非常有竞争力。

### 2. 市场需求覆盖图
掌握这两者后，你能触达的市场如下：

| 细分市场 | 需求程度 | 核心组合 |
| :--- | :--- | :--- |
| **自动驾驶/AMR** | 极高 | Ubuntu + C++ + 激光雷达/视觉 SLAM |
| **商用服务机器人** | 极高 | Ubuntu (大脑) + Android (交互界面) |
| **工业机械臂** | 高 | Ubuntu + MoveIt + 实时 Linux 内核 |
| **特种/无人机** | 中 | Ubuntu (地面站) + PX4/嵌入式 (飞控) |

### 3. 还需要补齐的“硬骨头”
虽然 Ubuntu 和 Android 很重要，但市场对高级人才的要求通常还包括：

*   **硬件与嵌入式 (micro-ROS):** 很多电机控制是在 STM32 或 ESP32 上跑的，你需要了解 **micro-ROS** 如何让这些小芯片与你的 Ubuntu 节点沟通。
*   **仿真能力 (Sim2Real):** 既然你之前有 **Blender 和 Unity** 的基础，这其实是你的**巨大优势**。现在的趋势是在 Unity 或 Omniverse 里训练算法，然后部署到真机。
*   **C++ 深度开发:** Android 上通常用 Java/Kotlin，但 ROS 2 的高性能节点（尤其是涉及底层驱动和复杂数学运算时）必须用 C++。
*   **DDS 调优:** 能够根据不同的网络环境（比如 WiFi 不稳的情况下）配置 **QoS**，是区分初级开发者和资深架构师的分水岭。

### 总结建议
**能满足大部分需求吗？能。**
尤其是考虑到你已经具备了 **计算机视觉 (ResNet/Swin)** 和 **3D 建模 (Unity)** 的背景，如果你再加上 **Ubuntu/Android ROS 2** 的通信能力，你其实已经构成了一个非常完整的“**视觉+仿真+系统**”闭环。



**下一步建议：**
不要只停留在安装和跑通小海龟。尝试把你在 Unity 里的 `bi6city` 场景导出的模型放入 **Gazebo Harmonic** (Jazzy 默认仿真器) 中，或者尝试让 Android 手机的摄像头数据通过 ROS 2 话题实时传输到 Ubuntu 电脑上进行你擅长的**纹理分析**。这才是市场上最硬核的竞争力。

=============================================================
# 5.工作空间（Workspace）的分层与环境设置
这段文字讲解的是 ROS 2 中最基础但也最重要的概念：**工作空间（Workspace）的分层与环境设置**。

对于有开发经验的人来说，你可以把它类比为 Python 的 `venv`（虚拟环境）或者是 Docker 的分层镜像逻辑，但它是通过 **Shell 环境变量** 来实现的。

以下是核心要点的详细解读：

### 1. 什么是工作空间 (Workspace)？
在 ROS 2 中，工作空间就是你存放代码、编译产物和开发包的**目录**。它不是散乱的，而是有特定结构的文件夹。

### 2. Underlay 与 Overlay（底座与上层）
这是这段文字最核心的逻辑，即**工作空间的层叠（Overlaying）**：

*   **Underlay（底层工作空间）：** 通常指你安装 ROS 2 系统本身的地方（例如 `/opt/ros/jazzy`）。它包含了 ROS 2 的核心库和工具。
*   **Overlay（上层工作空间）：** 是你在本地创建的开发目录。当你“激活”它时，它会覆盖或叠加在 Underlay 之上。
*   **逻辑优势：** 如果 Underlay 里有一个包，而你的 Overlay 里也有一个同名的包，系统会优先使用 Overlay 里的版本。这让你可以在不破坏系统安装的情况下，自由地修改和测试特定功能包。



---

### 3. Sourcing（环境激活）的必要性
文字强调了 `source` 命令的重要性。

*   **原理：** ROS 2 的各种指令（如 `ros2`）和库路径并不是默认存在于系统的 `PATH` 中的。
*   **操作：** 每次打开新终端，你必须运行 `source /opt/ros/jazzy/setup.bash`。
*   **后果：** 如果不执行这一步，Shell 找不到 ROS 2 的可执行文件，你就无法执行任何 ROS 指令。

### 4. 多版本并存与切换
由于采用了这种基于环境变量的设计，ROS 2 允许你在同一台电脑上安装多个版本（比如同时安装 Humble 和 Jazzy）：
*   你想用 Jazzy？就 `source` Jazzy 的脚本。
*   你想用 Humble？就 `source` Humble 的脚本。
*   它们之间通过环境变量完全隔离，互不干扰。

---

### 资深开发者视角：
这段话其实是在告诉你 ROS 2 的**隔离机制**。作为 C++ 开发者，你可以理解为：`source` 脚本动态地修改了你的 `PATH`、`LD_LIBRARY_PATH` 和 `PYTHONPATH`，从而为当前的终端会话构建了一个特定的运行上下文。

**小技巧：**
为了方便，开发者通常会将 `source /opt/ros/jazzy/setup.bash` 写入 `~/.bashrc`。但如果你需要频繁切换不同版本或不同的项目工作空间，建议配合 **Alias（别名）** 或者使用像 `direnv` 这样的工具来管理。

<!-- ======================================================== -->

# 6.Combining workspaces  指什么

在 ROS 2 的语境下，**Combining workspaces**（组合工作空间）本质上是一个**路径搜索优先级的堆叠（Stacking）过程**。

对于有 C++ 开发经验的人来说，你可以把它理解为：**动态修改环境变量（如 `PATH` 和 `LD_LIBRARY_PATH`），将多个安装目录按照先后顺序串联起来，使系统能够跨目录寻找头文件、库文件和可执行程序。**

以下是这一概念的深度拆解：

---

### 1. 核心逻辑：底座（Underlay）与 覆盖层（Overlay）

ROS 2 的工作空间不是平铺的，而是**垂直堆叠**的。

*   **Underlay (底层)：** 你“组合”的第一个空间。通常是全局安装的 ROS 2 发行版（如 `/opt/ros/jazzy`）。它提供了所有基础包。
*   **Overlay (上层)：** 你在本地创建并编译的工作空间（如 `~/dev_ws`）。
*   **Combining (组合)：** 当你在当前终端先 `source` 了底层，再 `source` 了上层，这两个空间就“组合”在了一起。



---

### 2. 为什么要“组合”？（实际开发场景）

作为开发者，你不会把所有代码都塞进一个巨大的文件夹里。组合机制解决了以下问题：

*   **解耦第三方库：** 你可以有一个专门存放各种开源驱动（如雷达、相机）的工作空间作为 A 层，而你的核心业务逻辑（如纹理识别算法）在 B 层。B 层只需“组合” A 层即可调用其功能。
*   **局部修改（重写）：** 这是最强大的功能。如果你发现官方的 `image_proc` 包有个 Bug，你不需要去动 `/opt/ros` 里的系统文件。你只需把 `image_proc` 的源码下载到你的本地 Overlay 中进行修改并编译。**由于 Overlay 优先级更高，系统运行时会忽略系统包，转而调用你修改后的本地版本。**

---

### 3. “组合”是如何在系统层面工作的？

当你执行 `source ~/dev_ws/install/setup.bash` 时，ROS 2 的脚本会执行以下操作：

1.  **检测父级空间：** 检查你在 `colcon build` 之前是否已经 `source` 过其他空间（比如 `/opt/ros/jazzy`）。
2.  **环境变量追加：**
    *   将本地空间的 `lib` 路径**置于** `LD_LIBRARY_PATH` 的**最前端**。
    *   将本地空间的 `bin` 路径**置于** `PATH` 的**最前端**。
    *   将本地空间的 `include` 路径**置于** C++ 编译器搜索路径的前端。

---

### 4. 操作示例：如何正确组合

假设你现在有两个工作空间：
1.  系统空间（Underlay）：`/opt/ros/jazzy`
2.  你的项目空间（Overlay）：`~/my_robot_ws`

**正确的组合步骤：**
```bash
# 1. 先引入系统环境
source /opt/ros/jazzy/setup.bash

# 2. 进入你的开发空间
cd ~/my_robot_ws

# 3. 编译（它会自动感知到刚才 source 的下层环境）
colcon build

# 4. 引入本地环境（完成组合）
source install/setup.bash
```

### 5. 资深开发者注意：常见的坑

*   **顺序很重要：** 必须先 `source` 下层，再编译上层。如果在编译上层时没有下层的环境，`colcon` 会因为找不到依赖库而报错。
*   **环境变量污染：** 如果你在一个终端里反复 `source` 不同的工作空间，环境变量会变得非常臃肿且混乱。
    *   **建议：** 每次切换大型项目或版本时，**新开一个终端（New Shell）**。

**总结：**
**Combining workspaces** 让你能够像“搭积木”一样组织机器人软件。你可以依赖稳定的系统层，同时在自己的局部空间内进行高效的迭代开发，而不需要重新编译整个 ROS 系统。

<!-- ====================================================================== -->

# 7.ROS 2 的核心架构 不包括 parameter吗

这是一个非常敏锐的观察。在很多基础教材中，大家习惯于把 **Topic、Service、Action** 称为“三大通信机制”。但从严格的**核心架构**和**功能逻辑**来说，**Parameter（参数）是绝对包含在内的，它是 ROS 2 系统运行的四大基石之一。**

之所以有时被“忽视”，是因为在 ROS 2 底层，**Parameter 实际上是基于 Service（服务）机制实现的**。

---

### 1. 为什么 Parameter 是核心架构的一部分？
在机器人开发中，节点不能是“写死”的。你需要随时调整相机的曝光度、雷达的扫描频率、或者 PID 控制器的增益。

*   **全局性：** 每个节点都有自己的参数服务器。
*   **动态性：** ROS 2 支持动态参数监听，你可以在不重启节点的情况下，实时修改参数并让节点立刻生效。
*   **持久性：** 你可以将参数保存为 `.yaml` 文件，在启动（Launch）时统一加载。

---

### 2. Parameter 的底层逻辑（资深开发者视角）
作为 C++ 开发者，理解它的底层实现会让你更清晰：

在 ROS 2 中，当你创建一个节点时，系统会自动为该节点生成几个隐藏的 **Services**。当你使用命令行 `ros2 param set` 或在代码中修改参数时，本质上是发起了一次 **Service Request**。

这些隐藏服务通常包括：
*   `get_parameters`
*   `set_parameters`
*   `list_parameters`
*   `describe_parameters`



---

### 3. 核心架构的“ 3+1 ”模式
我们可以把 ROS 2 的通信架构总结为 **3 个基础模式 + 1 个配置模式**：

| 机制 | 逻辑类型 | 通信方向 | 适用场景 |
| :--- | :--- | :--- | :--- |
| **Topic** | 异步广播 | 多对多 | 传感器数据流、连续状态更新。 |
| **Service** | 同步/异步问答 | 一对一 | 短时间触发的任务、状态查询。 |
| **Action** | 进阶反馈任务 | 一对一 | 耗时任务（如导航到某点）。 |
| **Parameter** | **配置管理** | **节点内部/外部** | **系统调优、配置切换、动态开关。** |

---

### 4. C++ 中如何使用 Parameter？
既然你有多年 C++ 经验，你会发现 ROS 2 的参数处理非常严谨：

1.  **声明参数 (Declare)：** 在 ROS 2 中，参数必须先声明后使用，这增强了代码的安全性。
    ```cpp
    this->declare_parameter("my_param", 42);
    ```
2.  **获取参数 (Get)：**
    
```cpp
    int val = this->get_parameter("my_param").as_int();
    ```
3.  **监听回调：** 你可以注册一个回调函数，当外部（如 RQT 或命令行）修改参数时，你的代码会自动触发逻辑更新。

---

### 总结
**ROS 2 的核心架构当然包括 Parameter。**

如果把机器人比作一辆车：
*   **Topic** 是仪表盘上的实时读数。
*   **Service** 是转向灯开关（点一下动一下）。
*   **Action** 是自动泊车系统（给个目标，持续反馈直到完成）。
*   **Parameter** 则是这辆车的**出厂设置和调教参数**（如限速设定、避震软硬）。

你目前在做的纹理匹配算法，如果需要根据环境光线调整阈值，**Parameter** 就是存储这些阈值的最佳地方，而不是把它们硬编码在 C++ 类里。
```
====================================================

# 8.ros2 创建workspace的命令

创建 ROS 2 工作空间（Workspace）其实并不需要专门的“创建”命令，它本质上就是创建一个文件夹并按照特定的结构组织代码。

以下是标准的 **四步走** 流程：

### 1. 创建工作空间目录
通常命名为 `dev_ws`（development workspace），并在其中创建一个 `src` 文件夹，这是存放所有源代码的地方。

```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/
```

### 2. 编译工作空间
在工作空间的根目录下运行 `colcon build`。即使 `src` 是空的，这一步也会生成 `build`、`install` 和 `log` 目录。

```bash
colcon build
```



---

### 3. 配置环境变量 (Source)
这一步至关重要。编译完成后，你需要将这个工作空间“告诉”系统，这样你才能运行其中的节点。

```bash
# 激活当前工作空间
source install/setup.bash
```

---

### 4. 验证
你可以通过检查 `AMENT_PREFIX_PATH` 环境变量来确认你的工作空间是否已经生效：

```bash
echo $AMENT_PREFIX_PATH
```
如果输出中包含了 `~/ros2_ws/install/...` 的路径，说明配置成功了。

---

### 💡 进阶小贴士

*   **创建功能包 (Package)**：
    以后你想写代码时，必须在 `src` 目录下创建功能包，而不是直接写 Python/C++ 文件。
    ```bash
    cd ~/ros2_ws/src
    # 创建 Python 功能包
    ros2 pkg create --build-type ament_python <your_package_name>
    # 或者创建 C++ 功能包
    ros2 pkg create --build-type ament_cmake <your_package_name>
    ```

*   **只编译选定包**：
    当项目变大时，全部编译很慢，可以指定包名：
    ```bash
    colcon build --packages-select <package_name>
    ```

*   **符号链接安装 (Symlink Install)**：
    对于 Python 开发者，建议加上这个参数。这样你修改 Python 代码后**不需要重新编译**即可生效：
    ```bash
    colcon build --symlink-install
    ```

你现在的 `ch02` 目录下是不是已经手动创建了这些文件夹？建议严格遵守 `ws/src/package` 这个三级目录结构。

==========================================================

# 9.ros2 的Action 的编程步骤，请举例

既然你有深厚的 C++ 开发背景，理解 ROS 2 Action 的最佳方式是将其视为一个**带有进度反馈的、可撤销的异步状态机**。

Action 基于 ROS 2 的三种基础机制构建：**Goal**（Service）、**Feedback**（Topic）和 **Result**（Service）。

---

### ROS 2 Action 编程的 5 个标准步骤

我们将以一个简单的“机器人旋转指定角度”的任务为例：

#### 1. 定义 Action 通信协议 (`.action` 文件)

首先在包的 `action/` 目录下定义接口。这类似于定义一个 RPC 接口或 IDL。

```text
# Goal: 客户端发送的目标
float32 target_yaw
---
# Result: 任务完成后的最终结果
bool success
---
# Feedback: 任务执行过程中的实时反馈
float32 current_yaw

```

#### 2. 创建 Action Server 节点

服务器负责接收目标、执行耗时任务并发布反馈。

* **声明类与句柄**：使用 `rclcpp_action::Server<MyAction>`。
* **处理 Goal 勾子**：决定是否接受该目标（例如检查机器人是否已经在运动）。
* **处理 Cancel 勾子**：处理用户取消任务的逻辑。
* **执行逻辑 (Execute)**：通常开启一个独立的线程来跑任务，避免阻塞 Executor。

#### 3. 编写服务器核心逻辑

在执行线程中，你会进入一个循环：

1. 检查 `is_canceling()`。
2. 计算当前进度。
3. 调用 `publish_feedback()` 发送实时数据。
4. 任务结束调用 `succeed()` 返回结果。

#### 4. 创建 Action Client 节点

客户端负责发送请求并监听反馈。

* **发送目标**：使用 `async_send_goal()`。
* **目标响应回调**：确认服务器是否接受了目标。
* **反馈回调**：处理服务器传回的中间数据（如更新 UI 进度条）。
* **结果回调**：处理任务最终的成功或失败。

#### 5. 编译与配置文件

在 `CMakeLists.txt` 中添加对 `rosidl_default_generators` 的依赖，确保自动生成 C++ 对应的头文件（`.hpp`）。

---

### C++ 代码示例：旋转 Action 服务器

这是一个简化版的服务器端实现（Jazzy/Humble 风格）：

```cpp
#include <memory>
#include <thread>
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"
#include "my_robot_interfaces/action/rotate.hpp" // 假设的接口

class RotateActionServer : public rclcpp::Node {
public:
    using Rotate = my_robot_interfaces::action::Rotate;
    using GoalHandleRotate = rclcpp_action::ServerGoalHandle<Rotate>;

    RotateActionServer() : Node("rotate_action_server") {
        this->action_server_ = rclcpp_action::create_server<Rotate>(
            this, "rotate",
            std::bind(&RotateActionServer::handle_goal, this, std::placeholders::_1, std::placeholders::_2),
            std::bind(&RotateActionServer::handle_cancel, this, std::placeholders::_1),
            std::bind(&RotateActionServer::handle_accepted, this, std::placeholders::_1)
        );
    }

private:
    rclcpp_action::Server<Rotate>::SharedPtr action_server_;

    // 1. 收到目标：检查参数是否合法
    rclcpp_action::GoalResponse handle_goal(const rclcpp_action::GoalUUID &, std::shared_ptr<const Rotate::Goal> goal) {
        RCLCPP_INFO(this->get_logger(), "收到旋转目标: %f", goal->target_yaw);
        return rclcpp_action::GoalResponse::ACCEPT_AND_EXECUTE;
    }

    // 2. 收到取消请求
    rclcpp_action::CancelResponse handle_cancel(const std::shared_ptr<GoalHandleRotate>) {
        RCLCPP_INFO(this->get_logger(), "收到取消请求");
        return rclcpp_action::CancelResponse::ACCEPT;
    }

    // 3. 开始执行：开启新线程避免阻塞
    void handle_accepted(const std::shared_ptr<GoalHandleRotate> goal_handle) {
        std::thread{std::bind(&RotateActionServer::execute, this, std::placeholders::_1), goal_handle}.detach();
    }

    void execute(const std::shared_ptr<GoalHandleRotate> goal_handle) {
        const auto goal = goal_handle->get_goal();
        auto feedback = std::make_shared<Rotate::Feedback>();
        auto result = std::make_shared<Rotate::Result>();
        
        rclcpp::Rate loop_rate(1);
        for (float i = 0; i < goal->target_yaw; i += 10.0) {
            // 检查是否取消
            if (goal_handle->is_canceling()) {
                result->success = false;
                goal_handle->canceled(result);
                return;
            }
            // 发布反馈
            feedback->current_yaw = i;
            goal_handle->publish_feedback(feedback);
            loop_rate.sleep();
        }

        // 任务完成
        result->success = true;
        goal_handle->succeed(result);
    }
};

```

### 资深开发者笔记：

1. **线程安全**：Action Server 的回调可能在不同线程触发。在 `execute` 循环中访问类成员变量时，务必注意互斥锁（Mutex）的使用。
2. **独占性**：通常一个机器人同一时间只能执行一个运动 Action。在 `handle_goal` 中，你应该判断当前是否有正在运行的任务，并决定是拒绝新任务还是抢占（Preempt）旧任务。
3. **DDS 性能**：Action 比 Topic 复杂得多。在高频反馈场景下，请确保 QoS 配置正确，避免反馈丢失导致客户端逻辑卡死。

你之前在 Unity 中处理过不少异步加载或状态切换，ROS 2 的 Action 其实就是这种逻辑在分布式系统中的标准化实现。

===================================================

# 10. ros2 的Action 的编程 举例-py-yuanbaoAI

下面给你一个**完整、可运行的 ROS 2 Action 编程示例**，从**概念 → 接口定义 → Server → Client → 运行效果**，一步一步来。示例选用 **Python（rclpy）**，这是目前 ROS 2 最常用、也最适合和“千帆 / AI 推理”结合的方式。

---

## 一、ROS 2 Action 是什么？

一句话：  
👉 **Action = Goal（目标）+ Feedback（过程反馈）+ Result（最终结果）**

适合**耗时较长、可中断、需要进度反馈**的任务，例如：

- 机器人导航
- 机械臂抓取
- 图像识别 / 搜索
- 长时间数据采集

对比：

| 通信方式 | 是否阻塞 | 是否有反馈 | 是否可取消 |
|--------|--------|----------|----------|
| Topic | ❌ | ✅ | ❌ |
| Service | ✅ | ❌ | ❌ |
| **Action** | ❌ | ✅ | ✅ |

---

## 二、示例需求（贴近你之前的业务）

> **Action 名称：`ImageSearch`**  
> 客户端上传一张图片 → 服务端调用千帆 API → 实时反馈搜索进度 → 最终返回 Top‑N 商品编号

---

## 三、1️⃣ 定义 Action 接口（`.action` 文件）

📁 `image_search_interfaces/action/ImageSearch.action`

```txt
# Goal：客户端发给服务端
string image_path
---
# Result：最终返回
int32 matched_count
string[] product_ids
float32[] scores
---
# Feedback：过程反馈
string status
float32 progress   # 0.0 ~ 1.0
```

### 编译接口包
```bash
colcon build --packages-select image_search_interfaces
source install/setup.bash
```

---

## 四、2️⃣ Action Server（服务端）

📁 `image_search_py/image_search_py/image_search_server.py`

```python
import time
import rclpy
from rclpy.action import ActionServer
from rclpy.node import Node
from image_search_interfaces.action import ImageSearch

class ImageSearchServer(Node):

    def __init__(self):
        super().__init__('image_search_server')

        self._action_server = ActionServer(
            self,
            ImageSearch,
            'image_search',
            self.execute_callback
        )

    def execute_callback(self, goal_handle):
        self.get_logger().info(f'收到图片：{goal_handle.request.image_path}')

        feedback_msg = ImageSearch.Feedback()
        result_msg = ImageSearch.Result()

        # 模拟处理过程（后面可换成千帆 API）
        steps = ['加载图片', '提取特征', '向量检索', '排序结果']
        for i, step in enumerate(steps):
            feedback_msg.status = step
            feedback_msg.progress = (i + 1) / len(steps)
            self.get_logger().info(f'{step} ({feedback_msg.progress*100:.0f}%)')
            goal_handle.publish_feedback(feedback_msg)
            time.sleep(1)

        # 最终结果
        result_msg.matched_count = 3
        result_msg.product_ids = ['SKU001', 'SKU042', 'SKU107']
        result_msg.scores = [0.98, 0.91, 0.85]

        goal_handle.succeed()
        self.get_logger().info('搜索完成 ✅')
        return result_msg


def main(args=None):
    rclpy.init(args=args)
    node = ImageSearchServer()
    rclpy.spin(node)
    rclpy.shutdown()
```

📄 `setup.py`
```python
entry_points={
    'console_scripts': [
        'image_search_server = image_search_py.image_search_server:main'
    ]
}
```

---

## 五、3️⃣ Action Client（客户端）

📁 `image_search_py/image_search_py/image_search_client.py`

```python
import rclpy
from rclpy.action import ActionClient
from rclpy.node import Node
from image_search_interfaces.action import ImageSearch

class ImageSearchClient(Node):

    def __init__(self):
        super().__init__('image_search_client')
        self._action_client = ActionClient(self, ImageSearch, 'image_search')

    def send_goal(self, image_path):
        goal_msg = ImageSearch.Goal()
        goal_msg.image_path = image_path

        self._action_client.wait_for_server()
        self._send_goal_future = self._action_client.send_goal_async(
            goal_msg,
            feedback_callback=self.feedback_callback
        )
        self._send_goal_future.add_done_callback(self.goal_response_callback)

    def goal_response_callback(self, future):
        goal_handle = future.result()
        if not goal_handle.accepted:
            self.get_logger().info('Goal 被拒绝 ❌')
            return

        self.get_logger().info('Goal 已接受 ✅')
        self._get_result_future = goal_handle.get_result_async()
        self._get_result_future.add_done_callback(self.get_result_callback)

    def feedback_callback(self, msg):
        feedback = msg.feedback
        self.get_logger().info(
            f'状态: {feedback.status}, 进度: {feedback.progress*100:.0f}%'
        )

    def get_result_callback(self, future):
        result = future.result().result
        self.get_logger().info('🎯 最终结果：')
        for i in range(result.matched_count):
            self.get_logger().info(
                f'  #{i+1} {result.product_ids[i]} ({result.scores[i]*100:.1f}%)'
            )
        rclpy.shutdown()


def main():
    rclpy.init()
    client = ImageSearchClient()
    client.send_goal('/home/user/test.jpg')
    rclpy.spin(client)
```

---

## 六、4️⃣ 运行效果

### 终端 1
```bash
ros2 run image_search_py image_search_server
```

### 终端 2
```bash
ros2 run image_search_py image_search_client
```

### 输出示例
```text
状态: 加载图片, 进度: 25%
状态: 提取特征, 进度: 50%
状态: 向量检索, 进度: 75%
状态: 排序结果, 进度: 100%

🎯 最终结果：
  #1 SKU001 (98.0%)
  #2 SKU042 (91.0%)
  #3 SKU107 (85.0%)
```

---

## 七、✅ 与你“千帆图片搜索”的真实结合点

你现在只需要把 **Server 里的模拟逻辑** 换成：

```python
# 1. 调用千帆 Embedding API
vector = get_qianfan_image_vector(image_path)

# 2. 调用千帆 VectorDB
results = search_image_in_cloud(vector)
```

并且：

- **Feedback**：  
  - “正在调用千帆 API…”  
  - “正在检索 30k 商品库…”
- **Result**：  
  - Top‑5 / Top‑10 商品编号 + 相似度

✅ 完美契合你“**高召回 + 多结果 + 可中断**”的业务需求。

---

## 八、下一步我可以继续帮你做的事

你可以直接说 👇  
- ✅ 把这个 **Action Server 改成真实千帆 API 调用版**
- ✅ 用 **C++（rclcpp）** 写一个版本
- ✅ 讲清楚 **Action 和 Service 什么时候该用哪个**
- ✅ 把 Action 接入 **Launch 文件 + 多节点**
- ✅ 用 Action 做 **“边搜边反馈” 的小程序后台**

你想继续哪一步？


===================================================

# 11. ros2 的Action 的编程 举例-cpp-yuanbaoAI

下面给你一个**完整、可编译、可运行的 ROS 2 Action（rclcpp / C++）示例**，结构、语义与前面 Python 版本一一对应，非常适合**工业现场 / 高性能 / 与千帆 API 对接**。

---

# 一、示例目标（C++ Action）

✅ Action 名称：`ImageSearch`  
✅ 功能：  
- Client 发送图片路径  
- Server 模拟（或真实）调用千帆 API  
- 实时反馈进度（Feedback）  
- 返回 Top‑N 商品编号（Result）

---

# 二、1️⃣ Action 接口（不变）

📁 `image_search_interfaces/action/ImageSearch.action`

```txt
string image_path
---
int32 matched_count
string[] product_ids
float32[] scores
---
string status
float32 progress
```

```bash
colcon build --packages-select image_search_interfaces
source install/setup.bash
```

---

# 三、2️⃣ Action Server（C++ / rclcpp）

📁 `image_search_cpp/src/image_search_server.cpp`

```cpp
#include <memory>
#include <thread>
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"
#include "image_search_interfaces/action/image_search.hpp"

using ImageSearch = image_search_interfaces::action::ImageSearch;

class ImageSearchServer : public rclcpp::Node
{
public:
  ImageSearchServer()
  : Node("image_search_server")
  {
    action_server_ = rclcpp_action::create_server<ImageSearch>(
      this,
      "image_search",
      std::bind(&ImageSearchServer::handle_goal, this, std::placeholders::_1, std::placeholders::_2),
      std::bind(&ImageSearchServer::handle_cancel, this, std::placeholders::_1),
      std::bind(&ImageSearchServer::handle_accepted, this, std::placeholders::_1));
  }

private:
  rclcpp_action::Server<ImageSearch>::SharedPtr action_server_;

  rclcpp_action::GoalResponse handle_goal(
    const rclcpp_action::GoalUUID &,
    std::shared_ptr<const ImageSearch::Goal> goal)
  {
    RCLCPP_INFO(this->get_logger(), "收到图片: %s", goal->image_path.c_str());
    return rclcpp_action::GoalResponse::ACCEPT_AND_EXECUTE;
  }

  rclcpp_action::CancelResponse handle_cancel(
    const std::shared_ptr<rclcpp_action::ServerGoalHandle<ImageSearch>>)
  {
    RCLCPP_INFO(this->get_logger(), "收到取消请求");
    return rclcpp_action::CancelResponse::ACCEPT;
  }

  void handle_accepted(
    const std::shared_ptr<rclcpp_action::ServerGoalHandle<ImageSearch>> goal_handle)
  {
    std::thread( {
      execute(goal_handle);
    }).detach();
  }

  void execute(
    const std::shared_ptr<rclcpp_action::ServerGoalHandle<ImageSearch>> goal_handle)
  {
    auto goal = goal_handle->get_goal();
    auto feedback = std::make_shared<ImageSearch::Feedback>();
    auto result = std::make_shared<ImageSearch::Result>();

    const char* steps[] = {"加载图片", "提取特征", "向量检索", "排序结果"};
    int total = sizeof(steps) / sizeof(steps[0]);

    for (int i = 0; i < total; ++i) {
      feedback->status = steps[i];
      feedback->progress = static_cast<float>(i + 1) / total;
      goal_handle->publish_feedback(feedback);
      RCLCPP_INFO(this->get_logger(), "%s (%.0f%%)",
                  steps[i], feedback->progress * 100);
      std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    // 最终结果（后续替换为千帆 API 返回）
    result->matched_count = 3;
    result->product_ids = {"SKU001", "SKU042", "SKU107"};
    result->scores = {0.98, 0.91, 0.85};

    goal_handle->succeed(result);
    RCLCPP_INFO(this->get_logger(), "搜索完成 ✅");
  }
};

int main(int argc, char **argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ImageSearchServer>());
  rclcpp::shutdown();
  return 0;
}
```

---

# 四、3️⃣ Action Client（C++ / rclcpp）

📁 `image_search_cpp/src/image_search_client.cpp`

```cpp
#include <memory>
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"
#include "image_search_interfaces/action/image_search.hpp"

using ImageSearch = image_search_interfaces::action::ImageSearch;

class ImageSearchClient : public rclcpp::Node
{
public:
  ImageSearchClient()
  : Node("image_search_client")
  {
    client_ = rclcpp_action::create_client<ImageSearch>(this, "image_search");
  }

  void send_goal(const std::string &image_path)
  {
    client_->wait_for_action_server();

    auto goal = ImageSearch::Goal();
    goal.image_path = image_path;

    auto send_goal_options =
      rclcpp_action::Client<ImageSearch>::SendGoalOptions();

    send_goal_options.feedback_callback =
      [this](rclcpp_action::ClientGoalHandle<ImageSearch>::SharedPtr,
             const std::shared_ptr<const ImageSearch::Feedback> feedback) {
        RCLCPP_INFO(this->get_logger(),
                   "状态: %s | 进度: %.0f%%",
                   feedback->status.c_str(),
                   feedback->progress * 100);
      };

    send_goal_options.result_callback =
      const rclcpp_action::ClientGoalHandle<ImageSearch>::WrappedResult & result {
        RCLCPP_INFO(this->get_logger(), "🎯 最终结果:");
        for (size_t i = 0; i < result.result->matched_count; ++i) {
          RCLCPP_INFO(this->get_logger(),
                      "  #%zu %s (%.1f%%)",
                      i + 1,
                      result.result->product_ids[i].c_str(),
                      result.result->scores[i] * 100);
        }
        rclcpp::shutdown();
      };

    client_->async_send_goal(goal, send_goal_options);
  }

private:
  rclcpp_action::Client<ImageSearch>::SharedPtr client_;
};

int main(int argc, char **argv)
{
  rclcpp::init(argc, argv);
  auto node = std::make_shared<ImageSearchClient>();
  node->send_goal("/home/user/test.jpg");
  rclcpp::spin(node);
  return 0;
}
```

---

# 五、4️⃣ CMakeLists.txt（关键）

📁 `image_search_cpp/CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.8)
project(image_search_cpp)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(image_search_interfaces REQUIRED)

add_executable(image_search_server src/image_search_server.cpp)
ament_target_dependencies(
  image_search_server
  rclcpp rclcpp_action image_search_interfaces
)

add_executable(image_search_client src/image_search_client.cpp)
ament_target_dependencies(
  image_search_client
  rclcpp rclcpp_action image_search_interfaces
)

install(TARGETS
  image_search_server
  image_search_client
  DESTINATION lib/${PROJECT_NAME})

ament_package()
```

---

# 六、5️⃣ 运行效果

```bash
# Terminal 1
ros2 run image_search_cpp image_search_server

# Terminal 2
ros2 run image_search_cpp image_search_client
```

输出示例：
```text
状态: 加载图片 | 进度: 25%
状态: 提取特征 | 进度: 50%
状态: 向量检索 | 进度: 75%
状态: 排序结果 | 进度: 100%

🎯 最终结果:
  #1 SKU001 (98.0%)
  #2 SKU042 (91.0%)
  #3 SKU107 (85.0%)
```

---

# 七、✅ 与千帆 API 的真实对接点（C++）

你可以在 `execute()` 中替换为：

```cpp
// 1. 调用千帆 Embedding API（libcurl / cpprestsdk）
std::vector<float> vector = qianfan_embedding(image_path);

// 2. 调用千帆 VectorDB
auto results = qianfan_vector_search(vector);

// 3. 填充 result
result->product_ids = results.ids;
result->scores = results.scores;
```

如果你愿意，我可以继续帮你：

✅ 用 **libcurl** 封装千帆 API 的 C++ 调用  
✅ 把 **OpenCV** 集成进来做图片预处理  
✅ 用 **多线程 / 线程池** 优化高并发搜索  
✅ 改成 **Lifecycle Node**（工业常用）  
✅ 直接对接你现在的 **3 万图片库方案**

你想下一步接哪一块？