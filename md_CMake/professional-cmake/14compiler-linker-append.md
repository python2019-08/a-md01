# 1. 完全静态链接的可执行文件

## 问题
-DCMAKE_EXE_LINKER_FLAGS="-static" 后 
```sh
$ ldd ~/osg3rd/build_by_sh/ubuntu/install/bin/tiffinfo
	不是动态可执行文件
```
## 腾讯元宝解释
从你的输出结果来看，`tiffinfo` 已经成功编译为一个 **完全静态链接的可执行文件**（`not a dynamic executable`）。以下是关键信息和建议：

---

### **1. 结果分析**
- **`ldd` 输出 `不是动态可执行文件`**：  
  表示 `tiffinfo` **不依赖任何动态库**（`.so` 文件），所有依赖（如 `liblzma.a`、`libjbig.a`）均已静态嵌入到二进制中。
- **优点**：  
  - 可独立运行，无需部署额外的 `.so` 文件。  
  - 避免因系统库版本不同导致的兼容性问题。

---

### **2. 验证静态链接内容**
#### **(1) 检查嵌入的静态库符号**
```bash
nm ~/osg3rd/build_by_sh/ubuntu/install/bin/tiffinfo | grep -E "lzma_|jbig_|deflate"
```
- **期望输出**：  
  应显示 `lzma_auto_decoder`、`jbig_` 等符号，证明相关库已静态链接。

#### **(2) 确认文件类型**
```bash
file /mnt/.../bin/tiffinfo
```
- **期望输出**：  
  ```
  ELF 64-bit LSB executable, x86-64, statically linked, BuildID[sha1]=..., stripped
  ```

---

### **3. 注意事项**
#### **(1) 文件大小**
静态链接的二进制文件通常较大（因为包含所有依赖库代码）。可通过 `strip` 减小体积：
```bash
strip /mnt/.../bin/tiffinfo
```

#### **(2) 潜在限制**
- **Glibc 限制**：部分 Linux 系统（如使用 glibc）可能无法完全静态链接（如 `pthread` 相关函数）。  
- **替代方案**：如需完全静态化，考虑使用 https://musl.libc.org/ 编译：
  ```bash
  sudo apt-get install musl-tools
  CC=musl-gcc ./configure --disable-shared --enable-static
  ```

---

### **4. 如何恢复动态链接？**
如果需要恢复动态链接，移除 `-static` 并重新编译：
```bash
cmake -S${OSG3RD_srcDir}/libtiff -B ${BuildDIR_lib} \
  -DCMAKE_INSTALL_PREFIX=${OSG3RD_INSTALL_PREFIX_ubuntu} \
  -DBUILD_SHARED_LIBS=ON  # 启用动态库
```

---

### **5. 总结**
| 行为                | 静态链接（`-static`）              | 动态链接（默认）               |
|---------------------|-----------------------------------|-------------------------------|
| **文件类型**        | 独立可执行文件（无外部依赖）       | 依赖系统 `.so` 文件            |
| **文件大小**        | 较大                              | 较小                          |
| **兼容性**          | 跨同架构系统运行                  | 需匹配系统库版本               |
| **调试难度**        | 符号嵌入，易调试                 | 需跟踪动态库加载              |

- **推荐场景**：  
  - 静态链接：部署到不同 Linux 环境或容器中。  
  - 动态链接：节省磁盘空间或依赖系统库更新。

如果仍有疑问，请提供：  
1. `file /mnt/.../bin/tiffinfo` 的完整输出。  
2. 编译时的 `CMake` 或 `make` 完整日志。

================================================
# 2.完全静态链接的动态库（.so）

在 CMake 中，`-DCMAKE_EXE_LINKER_FLAGS="-static"` 仅针对可执行文件（`exe`）强制静态链接。若要对动态库（`.so`）也实现静态链接依赖库，需采用不同的策略。以下是具体方法：

---

### **1. 针对动态库（.so）的静态链接方法**
#### **(1) 使用 `target_link_options` 或 `target_link_libraries`**
在 CMakeLists.txt 中，为动态库目标显式指定静态库路径，并通过链接器标志控制行为：
```cmake
add_library(mylib SHARED mylib.cpp)

# 方法1：直接链接静态库（.a）
target_link_libraries(mylib PRIVATE /path/to/static_dependency.a)

# 方法2：强制静态链接所有依赖（需谨慎）
target_link_options(mylib PRIVATE -Wl,-Bstatic -lz -Wl,-Bdynamic)
```
- **`-Wl,-Bstatic`**：告诉链接器后续库静态链接。
- **`-Wl,-Bdynamic`**：恢复动态链接（避免影响系统库）。

#### **(2) 全局设置静态链接（谨慎使用）**
```cmake
set(BUILD_SHARED_LIBS OFF)  # 强制所有库目标为静态（不推荐，会破坏动态库设计初衷）
```

---

### **2. 关键注意事项**
| 场景                | 处理方式                                                                 |
|---------------------|--------------------------------------------------------------------------|
| **动态库本身**      | 必须保持为 `.so`（`SHARED`），但可以静态链接其依赖库（如 `libz.a`）。     |
| **系统库（如glibc）** | 避免静态链接（可能导致兼容性问题），通过 `-Wl,-Bdynamic` 排除。          |
| **符号冲突**        | 确保静态库与动态库的符号无冲突（如重复定义的全局变量）。                  |

---

### **3. 完整示例**
#### **CMakeLists.txt**
```cmake
cmake_minimum_required(VERSION 3.10)
project(mylib)

# 生成动态库，但静态链接依赖库
add_library(mylib SHARED mylib.cpp)

# 查找静态库（如 libz.a）
find_library(ZLIB_STATIC_LIB z.a PATHS /usr/local/lib)

# 显式链接静态库
target_link_libraries(mylib PRIVATE ${ZLIB_STATIC_LIB})

# 或通过链接器标志（更灵活）
target_link_options(mylib PRIVATE
    "-Wl,-Bstatic -lz -llzma -Wl,-Bdynamic -lm -lpthread"
)
```

#### **验证动态库的依赖**
编译后检查动态库的依赖关系：
```bash
ldd libmylib.so  # 应显示动态库仍为 .so，但依赖的 libz/liblzma 不出现
nm libmylib.so | grep inflate  # 确认静态库符号已嵌入
```

---

### **4. 常见问题解决**
#### **问题 1：链接失败（`unable to find -lz`）**
- **原因**：未找到静态库 `libz.a`。  
- **解决**：确保静态库存在并正确指定路径：
  ```cmake
  find_library(ZLIB_STATIC_LIB z.a PATHS /usr/local/lib REQUIRED)
  ```

#### **问题 2：动态库仍依赖 `.so`**
- **原因**：未完全排除动态链接。  
- **解决**：调整链接顺序，确保 `-Wl,-Bstatic` 覆盖所有需静态的库：
  ```cmake
  target_link_options(mylib PRIVATE "-Wl,-Bstatic -lz -llzma -Wl,-Bdynamic")
  ```

#### **问题 3：符号冲突**
- **现象**：`multiple definition of symbol`。  
- **解决**：确保静态库与动态库的编译选项一致（如 `-fPIC`）。

---

### **5. 动态库 vs 静态库的混合链接**
| 目标类型       | 自身链接方式 | 依赖库链接方式       | 适用场景                     |
|----------------|--------------|----------------------|----------------------------|
| **可执行文件** | 动态         | 动态（默认）         | 依赖系统共享库              |
| **可执行文件** | 动态         | 静态（`-static`）    | 独立部署，避免依赖          |
| **动态库**     | 动态（.so）  | 静态（`-Wl,-Bstatic`） | 嵌入依赖，保持自身动态特性   |

---

### **总结**
- **动态库的静态依赖**：通过 `target_link_options` 或直接链接 `.a` 文件实现。  
- **避免系统库静态化**：用 `-Wl,-Bdynamic` 隔离 `glibc` 等关键库。  
- **验证方法**：`ldd` 检查动态库依赖，`nm` 确认符号嵌入。  

如果需要进一步帮助，请提供：  
1. 你的 `CMakeLists.txt` 内容。  
2. 具体的链接错误日志。

=======================================================
# 3. strip -S /lib/libz.so

### **关于 `strip -S /lib/libz.so` 的说明**

你尝试使用 `strip -S` 命令来移除 `libz.so` 的动态符号表（`.dynsym`），但需要注意以下几点：

---

### **1. `strip -S` 的作用**
- **`-S` 选项**：移除调试符号（`.symtab`），但保留动态符号表（`.dynsym`），以确保动态库仍能被 `ld.so` 加载。
- **效果**：
  - 减小文件体积（移除调试信息）。
  - **不影响动态库的功能**（仍可被其他程序动态链接）。

---

### **2. 正确使用方法**
#### **(1) 仅移除调试符号（推荐）**
```bash
strip -S /lib/libz.so
```
**验证**：
```bash
file /lib/libz.so  # 应仍显示 "shared object"
nm -D /lib/libz.so # 应仍显示动态符号（如 `inflate`）
```

#### **(2) 完全移除所有符号（慎用）**
如果目标是 **彻底减小体积**（但可能破坏动态库）：
```bash
strip --strip-all /lib/libz.so
```
⚠️ **风险**：可能导致动态库无法被加载（除非你知道自己在做什么）。

---

### **3. 常见问题**
#### **问题 1：`Permission denied`**
- **原因**：普通用户无权限修改 `/lib/` 下的文件。  
- **解决**：使用 `sudo` 或修改文件权限：
  ```bash
  sudo strip -S /lib/libz.so
  ```

#### **问题 2：动态库损坏**
- **现象**：`ldd /lib/libz.so` 报错或程序无法加载。  
- **恢复**：重新安装 `zlib`：
  ```bash
  sudo apt-get install --reinstall zlib1g
  ```

#### **问题 3：无效（文件大小未变）**
- **原因**：动态库可能已无调试符号。  
- **检查**：
  ```bash
  file /lib/libz.so  # 若显示 "stripped"，说明已无符号可移除
  ```

---

### **4. 替代方案：编译时移除符号**
在编译 `zlib` 时直接生成无调试符号的库：
```bash
./configure --strip
make && sudo make install
```

---

### **5. 总结**
| 命令                  | 作用                           | 适用场景                     |
|-----------------------|-------------------------------|----------------------------|
| `strip -S /lib/libz.so` | 移除调试符号，保留动态符号      | 发布优化后的动态库           |
| `strip --strip-all`    | 移除所有符号（危险！）          | 仅用于完全静态化的特殊需求    |
| `./configure --strip`  | 编译时直接生成无符号库          | 从源头控制文件大小           |

**推荐做法**：  
- 生产环境中使用 `strip -S` 安全优化动态库。  
- 调试阶段保留符号（不执行 `strip`）。  

如需进一步帮助，请提供：  
1. `file /lib/libz.so` 的输出。  
2. 你执行 `strip` 的具体目标（如减小体积或隐藏符号）。

==============================================
# 4. xx_LINKER_FLAGS优先级规则​​

优先级规则​​
如果同时设置了多个变量，CMake 会按以下顺序应用（后者覆盖前者）：

CMAKE_LINKER_FLAGS → CMAKE_EXE_LINKER_FLAGS 或 CMAKE_SHARED_LINKER_FLAGS → 目标专属的 LINKER_FLAGS

```cmake
set(CMAKE_SHARED_LINKER_FLAGS "-fPIC")  # 只影响共享库的链接
```
=======================================
# 5. -DCMAKE_SHARED_LINKER_FLAGS="-fPIC"  和  -DCMAKE_CXX_FLAGS="-fPIC"  和 -DCMAKE_C_FLAGS="-fPIC"  区别

这些 CMake 选项虽然都涉及 `-fPIC`（位置无关代码），但作用阶段和目标不同：

---

### **1. `-DCMAKE_SHARED_LINKER_FLAGS="-fPIC"`**
- **作用阶段**：**链接阶段**（生成共享库时）
- **影响范围**：仅影响共享库（`.so`/`.dll`）的链接过程
- **典型用途**：解决共享库链接时的特殊需求（但 `-fPIC` 通常是编译选项，此处可能无效）
- **注意**：`-fPIC` 本质是编译选项，通常不应放在链接器标志中（可能被忽略或报错）

---

### **2. `-DCMAKE_CXX_FLAGS="-fPIC"`**
- **作用阶段**：**C++ 编译阶段**
- **影响范围**：所有 C++ 源文件（`.cpp`/`.cc`）的编译
- **典型用途**：强制所有 C++ 代码生成位置无关代码（常用于共享库或静态库）
- **示例**：
  ```bash
  cmake -DCMAKE_CXX_FLAGS="-fPIC" ..
  ```

---

### **3. `-DCMAKE_C_FLAGS="-fPIC"`**
- **作用阶段**：**C 编译阶段**
- **影响范围**：所有 C 源文件（`.c`）的编译
- **典型用途**：强制所有 C 代码生成位置无关代码
- **示例**：
  ```bash
  cmake -DCMAKE_C_FLAGS="-fPIC" ..
  ```

---

### **关键区别**
| 选项                           | 作用阶段   | 影响语言 | 适用场景                  |
|--------------------------------|------------|----------|---------------------------|
| `CMAKE_SHARED_LINKER_FLAGS`    | 链接阶段   | 无       | 共享库链接器选项（少用）  |
| `CMAKE_CXX_FLAGS`              | 编译阶段   | C++      | C++ 代码的 PIC 编译        |
| `CMAKE_C_FLAGS`                | 编译阶段   | C        | C 代码的 PIC 编译          |

---

### **最佳实践**
1. **共享库必须用 `-fPIC`**  
   推荐同时设置 C 和 C++ 编译标志：
   ```bash
   cmake -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC" ..
   ```

2. **现代 CMake 的更好方式**  
   使用 `POSITION_INDEPENDENT_CODE` 属性：
   ```cmake
   # 对单个目标生效
   set_property(TARGET my_lib PROPERTY POSITION_INDEPENDENT_CODE ON)

   # 全局生效
   set(CMAKE_POSITION_INDEPENDENT_CODE ON)
   ```

3. **为什么不用 `CMAKE_SHARED_LINKER_FLAGS`**  
   `-fPIC` 是编译器选项，链接器无法处理它。如果将其放在链接器标志中，通常会收到类似警告：
   ```
   linker input file unused because linking not done
   ```

---

### **常见问题**
**Q：为什么静态库也需要 `-fPIC`？**  
A：当静态库被链接到共享库时，要求静态库必须用 `-fPIC` 编译，否则会报错：
```
relocation R_X86_64_PC32 against symbol ... can not be used when making a shared object
```