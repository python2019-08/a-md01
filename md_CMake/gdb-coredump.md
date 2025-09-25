# 1.GDB调试coredump的步骤

从你的输出中可以看到，GDB 无法找到核心转储文件（`core`），因此无法直接分析崩溃原因。以下是下一步的调试步骤和解决方案：

---

### **1. 确保生成核心转储文件**
#### **(1) 启用核心转储**
在 Linux 中，默认可能禁用核心转储。运行以下命令启用：
```bash
ulimit -c unlimited  # 解除核心文件大小限制
sudo sysctl -w kernel.core_pattern=/tmp/core-%e-%p-%t  # 设置核心文件保存路径
```
- 重新运行程序，崩溃后检查 `/tmp` 下是否生成 `core-*` 文件。

#### **(2) 手动运行程序并捕获崩溃**
```bash
./osgearth_version   # 触发段错误后，检查当前目录或 /tmp 是否有 core 文件
ls -l /tmp/core-*   # 查看核心转储文件
```

---

### **2. 直接使用 GDB 运行程序**
如果无法生成核心文件，可直接用 GDB 调试：
```bash
gdb ./osgearth_version
(gdb) run           # 启动程序
(gdb) bt            # 崩溃后输入 bt 查看调用栈
(gdb) info locals   # 查看崩溃时的局部变量
(gdb) disassemble   # 查看崩溃点的汇编指令
```

---

### **3. 常见段错误原因及解决**
#### **(1) 动态库不兼容**
- **检查动态库版本**：
  ```bash
  ldd ./osgearth_version  # 查看所有动态库依赖
  ```
  - 确保无 `not found` 或版本冲突（如 `libGL.so.1` vs `libGL.so.2`）。
- **解决方案**：
  - 设置 `LD_LIBRARY_PATH` 指向正确的库路径：
    ```bash
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
    ```

#### **(2) 静态库符号冲突**
- **表现**：静态库（如 `libosgEarth.a`）与其他库符号重复。
- **验证方法**：
  ```bash
  nm /path/to/libosgEarth.a | grep " T "  # 查看导出的全局符号
  ```
- **解决方案**：
  - 重新编译静态库，确保无符号泄露：
    ```bash
    CFLAGS="-fvisibility=hidden" cmake ...  # 隐藏非必要符号
    ```

#### **(3) 内存越界或空指针**
- **调试方法**：
  - 在 GDB 中运行程序，崩溃时检查 `bt` 输出的调用栈。
  - 重点关注 `osg::` 或 `osgEarth::` 相关代码。

#### **(4) OpenGL 上下文问题**
- **表现**：`libGL.so` 相关崩溃（如 `glXCreateContext` 失败）。
- **解决方案**：
  - 确保显卡驱动安装正确：
    ```bash
    glxinfo | grep OpenGL  # 检查 OpenGL 支持
    ```
  - 使用软件渲染测试：
    ```bash
    export LIBGL_ALWAYS_SOFTWARE=1
    ./osgearth_version
    ```

---

### **4. 快速测试建议**
#### **(1) 最小化测试**
修改 `osgearth_version.cpp`，仅保留最简代码：
```cpp
#include <iostream>
int main() {
    std::cout << "Test OK" << std::endl;
    return 0;
}
```
重新编译运行，验证是否仍崩溃。

#### **(2) 禁用部分功能**
在 CMake 中逐步禁用模块，定位问题库：
```bash
cmake ... -DOSGEARTH_BUILD_APPLICATIONS=OFF -DOSGEARTH_BUILD_TESTS=OFF
```

---

### **5. 关键检查点**
1. **核心转储是否生成**：
   - 确认 `ulimit -c` 返回 `unlimited`。
   - 检查 `kernel.core_pattern` 设置。

2. **动态库路径**：
   - 使用 `LD_DEBUG=libs ./osgearth_version` 查看库加载过程。

3. **静态库符号**：
   - 检查是否有重复定义的全局符号：
     ```bash
     nm libosgEarth.a | grep " T " | sort | uniq -d
     ```

---

### **总结**
- **优先通过 GDB 直接运行**获取崩溃调用栈（`bt`）。
- **确保动态库兼容性**（`ldd` + `LD_LIBRARY_PATH`）。
- **检查静态库符号冲突**（`nm` + 重新编译）。
- **简化测试**：最小化代码或禁用模块，逐步定位问题库。

如果提供 `gdb bt` 的完整输出或核心文件，可以进一步精准分析！

=============================================
# 2.gdb 调试 coredump的步骤
使用 `gdb` 调试核心转储文件（core dump）是定位程序崩溃原因的有效方法，尤其适用于段错误（Segmentation Fault）等内存问题。以下是详细的调试步骤：


### 一、准备工作
1. **确保核心文件和可执行程序匹配**  
   核心文件是程序崩溃时的内存快照，必须与产生它的**同一版本可执行程序**配合使用（编译后代码有任何修改，核心文件可能无法正常解析）。

2. **确保程序带调试符号**  
   调试时需要源码级信息（如行号、变量名），需确保程序编译时添加了 `-g` 选项（保留调试符号）。若缺少调试符号，`gdb` 会显示“没有调试符号”，需重新编译程序：
   ```bash
   # 以 CMake 为例，使用 Debug 模式编译
   cmake -DCMAKE_BUILD_TYPE=Debug ..
   make -j4
   ```


### 二、调试核心文件的步骤
#### 步骤 1：启动 gdb 并加载核心文件
在终端中执行以下命令，格式为：  
`gdb [可执行程序路径] [核心文件路径]`

示例：
```bash
# 假设程序为 ./osgearth_city，核心文件为 /var/crash/core-osgearth_city-12345-1695678900
gdb ./osgearth_city /var/crash/core-osgearth_city-12345-1695678900
```

执行后，`gdb` 会加载程序和核心文件，显示崩溃相关信息（如崩溃信号 `SIGSEGV` 表示段错误）。


#### 步骤 2：查看崩溃时的函数调用栈（关键！）
使用 `bt`（backtrace）命令打印函数调用链，这是定位崩溃位置的核心步骤：
```gdb
(gdb) bt
```

输出示例：
```
#0  0x00007f8d12345678 in osg::Node::accept(osg::NodeVisitor&) () from /usr/lib/libosg.so.160
#1  0x00007f8d12345abc in osgEarth::FeatureLayer::draw(osgEarth::RenderContext&) () from /usr/lib/libosgearth.so.3.2
#2  0x000055f8a1b2c3d4 in main () at src/osgearth_city.cpp:123
```

- 每行代表一个函数调用栈帧（`#0` 是崩溃发生的直接函数，`#1` 是调用它的函数，以此类推）。
- 示例中，崩溃发生在 `osg::Node::accept` 函数，由 `main` 函数的第 123 行触发。


#### 步骤 3：定位崩溃的具体代码行
使用 `frame N`（简写 `f N`）切换到指定栈帧（`N` 是栈帧编号），再用 `list`（简写 `l`）查看对应源码：

```gdb
# 切换到崩溃的栈帧（通常是 #0 或最接近 main 的栈帧）
(gdb) f 2  # 切换到示例中的 main 函数栈帧

# 查看当前栈帧对应的代码行（前后5行）
(gdb) l
```

输出示例：
```
118     osg::ref_ptr<osgEarth::FeatureLayer> layer = createLayer();
119     if (!layer) {
120         std::cerr << "Failed to create layer!" << std::endl;
121         return 1;
122     }
123     layer->draw(context);  // 崩溃发生在这一行
124     viewer.run();
125     return 0;
126 }
```

通过此步骤可定位到具体哪一行代码导致了崩溃。


#### 步骤 4：检查变量和参数状态
使用以下命令分析崩溃时的变量值，判断是否存在非法操作（如空指针、无效值）：

- `info locals`：查看当前函数的局部变量
  ```gdb
  (gdb) info locals
  context = {_ptr = 0x55f8a2c3d4e0}
  layer = {_ptr = 0x0}  # 发现 layer 是空指针（_ptr = 0x0）
  ```

- `info args`：查看当前函数的参数值
  ```gdb
  (gdb) info args
  this = 0x0  # 发现 this 指针为空（调用成员函数时会崩溃）
  visitor = @0x7ffd8a7b6a30: {<osg::NodeVisitor> = {_vptr.NodeVisitor = 0x7f8d12a3b2c0, ...}, ...}
  ```

- `print 变量名`（简写 `p 变量名`）：打印指定变量的值
  ```gdb
  (gdb) p layer  # 查看 layer 指针是否为空
  $1 = {_ptr = 0x0}  # 确认 layer 是空指针，调用 layer->draw() 会导致段错误
  ```


#### 步骤 5：分析崩溃原因并修复
根据上述信息推断崩溃原因：
- 若 `info locals` 显示 `layer = 0x0`，说明调用 `layer->draw()` 时指针为空，需在代码中添加非空检查。
- 若 `info args` 显示 `this = 0x0`，说明对空对象调用了成员函数，需追溯对象创建过程。
- 若变量值异常（如数组索引为负数），需检查赋值逻辑。


### 三、常用补充命令
- `bt full`：打印详细调用栈，包含各栈帧的局部变量（信息更全，但输出较长）。
- `up`/`down`：在调用栈中向上/向下切换栈帧（无需记住编号）。
- `info threads`：若程序是多线程，查看所有线程状态，用 `thread N` 切换到线程 `N`。
- `quit`（简写 `q`）：退出 `gdb`。


### 总结
核心步骤可简化为：  
`gdb 程序 核心文件` → `bt`（看调用栈） → `f N`（切栈帧） → `l`（看代码） → `info locals`/`p 变量`（查变量）。

通过这些步骤，可快速定位段错误、内存越界等问题的根源。若遇到具体的崩溃信息（如特定函数或变量值），可进一步分析代码逻辑。

=========================================
# 3.举例

```sh
(base) abner@abner-XPS:~/abner2/zdev/nv/osgearth0x/build_by_sh/ubuntu/install/osgearth/bin$ gdb ./osgearth_city  /tmp/core-oe.rex.loadtile-349430-1758813232
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./osgearth_city...

warning: Can't open file /memfd:/.nvidia_drv.XXXXXX (deleted) during file-backed mapping note processing
[New LWP 349484]
[New LWP 349468]
[New LWP 349470]
[New LWP 349570]
[New LWP 349469]
[New LWP 349471]
[New LWP 349486]
[New LWP 349430]
[New LWP 349485]
[New LWP 349568]
[New LWP 349569]
[New LWP 349487]

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.ubuntu.com>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
Downloading separate debug info for /lib/x86_64-linux-gnu/libX11.so.6
Downloading separate debug info for /lib/x86_64-linux-gnu/libXext.so.6                                                                                                                              
Downloading separate debug info for /lib/x86_64-linux-gnu/libGLX.so.0                                                                                                                               
--Type <RET> for more, q to quit, c to continue without paging--
Downloading separate debug info for /lib/x86_64-linux-gnu/libOpenGL.so.0                                                                                                                            
Downloading separate debug info for /lib/x86_64-linux-gnu/libstdc++.so.6                                                                                                                            
[#                                                                                                                                                                                 ]   1% (6.74 M)
Downloading separate debug info for /lib/x86_64-linux-gnu/libgcc_s.so.1                                                                                                                             
Downloading separate debug info for /lib/x86_64-linux-gnu/libxcb.so.1                                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/libGLdispatch.so.0                                                                                                                        
Downloading separate debug info for /lib/x86_64-linux-gnu/libXau.so.6                                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/libXdmcp.so.6                                                                                                                             
Downloading separate debug info for /lib/x86_64-linux-gnu/libbsd.so.0                                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/libmd.so.0                                                                                                                                
Downloading separate debug info for /lib/x86_64-linux-gnu/libGLX_nvidia.so.0                                                                                                                        
Downloading separate debug info for /lib/x86_64-linux-gnu/libnvidia-glsi.so.570.172.08                                                                                                              
Downloading separate debug info for /lib/x86_64-linux-gnu/libnvidia-tls.so.570.172.08                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/libnvidia-glcore.so.570.172.08                                                                                                            
Downloading separate debug info for /lib/x86_64-linux-gnu/libnvidia-gpucomp.so.570.172.08                                                                                                           
Downloading separate debug info for /lib/x86_64-linux-gnu/libxcb-glx.so.0                                                                                                                           
Downloading separate debug info for /lib/x86_64-linux-gnu/libxcb-randr.so.0                                                                                                                         
Downloading separate debug info for /lib/x86_64-linux-gnu/libxcb-dri3.so.0                                                                                                                          
Downloading separate debug info for /lib/x86_64-linux-gnu/libX11-xcb.so.1                                                                                                                           
Downloading separate debug info for /lib/x86_64-linux-gnu/libdbus-1.so.3                                                                                                                            
--Type <RET> for more, q to quit, c to continue without paging--
Downloading separate debug info for /lib/x86_64-linux-gnu/libsystemd.so.0                                                                                                                           
Downloading separate debug info for /lib/x86_64-linux-gnu/libcap.so.2                                                                                                                               
                                                                                                                                                                                                    
warning: could not find '.gnu_debugaltlink' file for /lib/x86_64-linux-gnu/libcap.so.2
Downloading separate debug info for /lib/x86_64-linux-gnu/libcap.so.2
Downloading separate debug info for /lib/x86_64-linux-gnu/libgcrypt.so.20                                                                                                                           
Downloading separate debug info for /lib/x86_64-linux-gnu/liblz4.so.1                                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/liblzma.so.5                                                                                                                              
Downloading separate debug info for /lib/x86_64-linux-gnu/libzstd.so.1                                                                                                                              
Downloading separate debug info for /lib/x86_64-linux-gnu/libgpg-error.so.0                                                                                                                         
Downloading separate debug info for /lib/x86_64-linux-gnu/libdrm.so.2                                                                                                                               
Downloading separate debug info for /lib/x86_64-linux-gnu/libnvidia-allocator.so.1                                                                                                                  
Downloading separate debug info for /lib/x86_64-linux-gnu/libnss_mdns4_minimal.so.2                                                                                                                 
Downloading separate debug info for /lib/x86_64-linux-gnu/libnss_mdns4_minimal.so.2                                                                                                                 
Downloading separate debug info for system-supplied DSO at 0x7bc2ec55a000                                                                                                                           
[Thread debugging using libthread_db enabled]                                                                                                                                                       
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Core was generated by `./osgearth_city'.
Program terminated with signal SIGSEGV, Segmentation fault.
Download failed: 无效的参数.  Continuing without source file ./nptl/./nptl/pthread_mutex_lock.c.
#0  ___pthread_mutex_lock (mutex=0x2c8) at ./nptl/pthread_mutex_lock.c:80

warning: 80	./nptl/pthread_mutex_lock.c: 没有那个文件或目录
[Current thread is 1 (Thread 0x7bc2ddffb6c0 (LWP 349484))]
(gdb) bt
#0  ___pthread_mutex_lock (mutex=0x2c8) at ./nptl/pthread_mutex_lock.c:80
#1  0x0000638af9318e1b in __gthread_mutex_lock (__mutex=0x2c8) at /usr/include/x86_64-linux-gnu/c++/13/bits/gthr-default.h:749
#2  0x0000638af9319c04 in std::mutex::lock (this=0x2c8) at /usr/include/c++/13/bits/std_mutex.h:113
#3  0x0000638af931b242 in std::lock_guard<std::mutex>::lock_guard (this=0x7bc2ddff8730, __m=...) at /usr/include/c++/13/bits/std_mutex.h:249
#4  0x0000638af94d8dbc in osgEarth::Registry::isBlacklisted (this=0x0, filename="https://readymap.org/readymap/tiles/1.0.0/116/2/2/2.tif")
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/Registry.cpp:546
#5  0x0000638af960b065 in (anonymous namespace)::doRead<(anonymous namespace)::ReadImage> (inputURI=..., dbOptions=0x638b3715eba0, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/URI.cpp:529
#6  0x0000638af9607f1b in osgEarth::URI::readImage (this=0x7bc2ddff8df0, dbOptions=0x638b3715eba0, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/URI.cpp:726
#7  0x0000638af95f03a8 in osgEarth::TMS::Driver::read (this=0x638b3732bd98, uri=..., key=..., invertY=false, progress=0x7bc2cc037490, readOptions=0x638b3715eba0)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TMS.cpp:947
#8  0x0000638af95f210c in osgEarth::TMSImageLayer::createImageImplementation (this=0x638b37310a40, key=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TMS.cpp:1241
#9  0x0000638af95f40d1 in osgEarth::TMSElevationLayer::createHeightFieldImplementation (this=0x638b371ad420, key=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TMS.cpp:1448
#10 0x0000638af93135a4 in osgEarth::ElevationLayer::createHeightFieldInKeyProfile (this=0x638b371ad420, key=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/ElevationLayer.cpp:477
#11 0x0000638af9312bbd in osgEarth::ElevationLayer::createHeightField (this=0x638b371ad420, key=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/ElevationLayer.cpp:360
#12 0x0000638af9314aaf in osgEarth::ElevationLayerVector::populateHeightField (this=0x638b37061858, hf=0x7bc2cc15cad0, resolutions=0x7bc2ddff9eb0, key=..., haeProfile=0x638b36e1ba30, 
    interpolation=osgEarth::INTERP_BILINEAR, progress=0x7bc2cc037490) at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/ElevationLayer.cpp:810
#13 0x0000638af970f30a in osgEarth::ElevationPool::getOrCreateRaster (this=0x638b370616c0, key=..., map=0x638b36e40670, acceptLowerRes=true, ws=0x638b37665118, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/ElevationPool.cpp:333
#14 0x0000638af9710d4b in osgEarth::ElevationPool::sampleMapCoords (this=0x638b370616c0, begin=..., end=..., ws=0x638b37665118, progress=0x7bc2cc037490, failValue=-3.40282347e+38)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/ElevationPool.cpp:661
#15 0x0000638af970b056 in osgEarth::NormalMapGenerator::createNormalMap (this=0x7bc2ddffa5bf, key=..., map=0x638b36e40670, ws=0x638b37665118, ruggedness=0x0, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/Elevation.cpp:326
#16 0x0000638af970a66d in osgEarth::ElevationTile::generateNormalMap (this=0x7bc2cc073720, map=0x638b36e40670, workingSet=0x638b37665118, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/Elevation.cpp:229
#17 0x0000638af958f50d in osgEarth::TerrainTileModelFactory::addElevation (this=0x638b37664e40, model=0x7bc2cc071a80, map=0x638b36e40670, key=..., manifest=..., border=0, progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TerrainTileModelFactory.cpp:458
#18 0x0000638af958dbea in osgEarth::TerrainTileModelFactory::createTileModel (this=0x638b37664e40, map=0x638b36e40670, key=..., manifest=..., require=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TerrainTileModelFactory.cpp:153
#19 0x0000638af95788e9 in osgEarth::TerrainEngineNode::createTileModel (this=0x638b379b8ca0, map=0x638b36e40670, key=..., manifest=..., progress=0x7bc2cc037490)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/TerrainEngineNode.cpp:223
#20 0x0000638af9fc94f6 in operator() (__closure=0x7bc2e02d5160, progress=...) at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarthDrivers/engine_rex/LoadTileData.cpp:84
#21 0x0000638af9fca1b2 in operator() (__closure=0x7bc2e02d5160) at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/weejobs.h:814
--Type <RET> for more, q to quit, c to continue without paging--
#22 0x0000638af9fcacd2 in std::__invoke_impl<bool, jobs::dispatch<osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)> >(osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)>, const context&)::<lambda()>&>(std::__invoke_other, struct {...} &) (__f=...) at /usr/include/c++/13/bits/invoke.h:61
#23 0x0000638af9fcab1e in std::__invoke_r<bool, jobs::dispatch<osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)> >(osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)>, const context&)::<lambda()>&>(struct {...} &) (__fn=...) at /usr/include/c++/13/bits/invoke.h:114
#24 0x0000638af9fca761 in std::_Function_handler<bool(), jobs::dispatch<osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)> >(osgEarth::REX::LoadTileDataOperation::dispatch(bool)::<lambda(osgEarth::Cancelable&)>, const context&)::<lambda()> >::_M_invoke(const std::_Any_data &) (__functor=...) at /usr/include/c++/13/bits/std_function.h:290
#25 0x0000638af9400724 in std::function<bool ()>::operator()() const (this=0x7bc2ddffaa10) at /usr/include/c++/13/bits/std_function.h:591
#26 0x0000638af93fe6ad in jobs::jobpool::run (this=0x638b37726a90) at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/weejobs.h:956
#27 0x0000638af93fe8fc in jobs::jobpool::start_threads()::{lambda()#1}::operator()() const (__closure=0x638b377c69e8)
    at /home/abner/abner2/zdev/nv/osgearth0x/3rd/osgearth/src/osgEarth/weejobs.h:1001
#28 0x0000638af941080e in std::__invoke_impl<void, jobs::jobpool::start_threads()::{lambda()#1}>(std::__invoke_other, jobs::jobpool::start_threads()::{lambda()#1}&&) (__f=...)
    at /usr/include/c++/13/bits/invoke.h:61
#29 0x0000638af94107c9 in std::__invoke<jobs::jobpool::start_threads()::{lambda()#1}>(jobs::jobpool::start_threads()::{lambda()#1}&&) (__fn=...) at /usr/include/c++/13/bits/invoke.h:96
#30 0x0000638af941076a in std::thread::_Invoker<std::tuple<jobs::jobpool::start_threads()::{lambda()#1}> >::_M_invoke<0ul>(std::_Index_tuple<0ul>) (this=0x638b377c69e8)
    at /usr/include/c++/13/bits/std_thread.h:292
#31 0x0000638af941071c in std::thread::_Invoker<std::tuple<jobs::jobpool::start_threads()::{lambda()#1}> >::operator()() (this=0x638b377c69e8) at /usr/include/c++/13/bits/std_thread.h:299
#32 0x0000638af94106de in std::thread::_State_impl<std::thread::_Invoker<std::tuple<jobs::jobpool::start_threads()::{lambda()#1}> > >::_M_run() (this=0x638b377c69e0)
    at /usr/include/c++/13/bits/std_thread.h:244
#33 0x00007bc2ec0ecdb4 in ?? () from /lib/x86_64-linux-gnu/libstdc++.so.6
#34 0x00007bc2ebc9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#35 0x00007bc2ebd29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
(gdb) 

```