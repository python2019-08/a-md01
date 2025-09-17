# 1.CMakeLists.txt 中UNIX和 ANDROID 变量是cmake内置变量吗

### **关于 CMake 变量 `UNIX` 和 `ANDROID` 的权威解释**

#### **1. 变量性质**
| 变量名     | 类型       | 定义者       | 典型值  | 作用域         |
|------------|------------|--------------|---------|----------------|
| **`UNIX`** | **内置变量** | CMake 自动定义 | `TRUE`/`FALSE` | 全局可用       |
| **`ANDROID`** | **非内置变量** | 通常由用户或工具链定义 | `1`/`ON`/空值 | 需显式设置或通过工具链传递 |

---

### **2. `UNIX` 变量详解**
#### **定义时机**
- 当 CMake 检测到当前系统为 **类 Unix 系统**（Linux、macOS、BSD 等）时自动定义
- **不适用于 Windows**（即使使用 WSL）

#### **典型用法**
```cmake
if(UNIX)
  message(STATUS "Running on Unix-like system")
  add_definitions(-DPOSIX_COMPLIANT)
endif()
```

#### **验证方法**
```bash
cmake -P - <<EOF
message("UNIX = ${UNIX}")
EOF
# 在 Linux/macOS 输出: UNIX = TRUE
# 在 Windows 输出: UNIX = 
```

---

### **3. `ANDROID` 变量详解**
#### **定义来源**
1. **Android 工具链文件**  
   当使用 `-DCMAKE_TOOLCHAIN_FILE=android.toolchain.cmake` 时，NDK 会定义该变量
   ```cmake
   # NDK 工具链中通常包含
   set(ANDROID TRUE CACHE INTERNAL "")
   ```

2. **手动定义**  
   ```bash
   cmake -DANDROID=ON ..
   ```

#### **典型用法
```cmake
if(ANDROID)
  add_library(native-lib SHARED src/main/cpp/native-lib.cpp)
  target_link_libraries(native-lib log)
endif()
```

#### **验证方法**
```bash
# 检查是否被定义
cmake -P - <<EOF
if(DEFINED ANDROID)
  message("ANDROID = ${ANDROID}")
else()
  message("ANDROID is NOT defined")
endif()
EOF
```

---

### **4. 关键区别对比**
| 特性                | `UNIX`                  | `ANDROID`               |
|---------------------|-------------------------|--------------------------|
| **定义方**          | CMake 自动检测          | 需工具链或手动设置       |
| **系统覆盖范围**    | 所有 Unix-like 系统     | 仅 Android 平台          |
| **典型用途**        | 跨平台条件编译          | Android 特定逻辑         |
| **可靠性**          | 100% 可靠               | 依赖外部定义             |

---

### **5. 最佳实践建议**
#### **对于 `UNIX`**
```cmake
# 优先使用现代 CMake 方式
if(CMAKE_SYSTEM_NAME MATCHES "Linux|Darwin|BSD")
  # 更精确的 Unix 系统判断
endif()
```

#### **对于 `ANDROID`**
```cmake
# 显式检查定义（避免未定义警告）
if(DEFINED ANDROID AND ANDROID)
  # Android 专用配置
endif()

# 或使用 CMake 官方推荐方式
include(CheckPlatform)
if(CMAKE_SYSTEM_NAME STREQUAL "Android")
  # ...
endif()
```

---

### **6. 调试技巧**
#### **查看所有平台相关变量**
```bash
cmake -P - <<EOF
get_cmake_property(_vars VARIABLES)
foreach(_var IN LISTS _vars)
  if(_var MATCHES "UNIX|ANDROID|CMAKE_SYSTEM")
    message("${_var} = ${${_var}}")
  endif()
endforeach()
EOF
```

#### **强制定义 ANDROID 变量**
```bash
cmake -DANDROID=ON -DCMAKE_SYSTEM_NAME=Android ..
```

---

### **7. 版本兼容性**
| CMake 版本 | `UNIX` 行为 | `ANDROID` 支持 |
|------------|-------------|----------------|
| < 3.0      | 完全支持     | 需手动定义      |
| ≥ 3.4      | 新增 `APPLE` 等子类 | NDK 自动定义   |
| ≥ 3.21     | 增强 Android 检测   | 官方工具链集成 |

---

### **总结**
1. **`UNIX` 是 CMake 内置变量**：自动检测类 Unix 系统  
2. **`ANDROID` 不是内置变量**：需通过工具链或手动定义  
3. **生产环境建议**：
   ```cmake
   # 更健壮的判断方式
   if(CMAKE_SYSTEM_NAME MATCHES "Linux|Darwin|BSD")
     # Unix 逻辑
   elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
     # Android 逻辑
   endif()
   ```

4. **验证命令**：
   ```bash
   cmake -P - <<EOF
   message("UNIX=${UNIX}")
   message("ANDROID=${ANDROID}")
   EOF
   ```