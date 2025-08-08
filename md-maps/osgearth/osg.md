# 1. osg data download url

osg data download url:
https://openscenegraph.github.io/OpenSceneGraphDotComBackup/OpenSceneGraph/www.openscenegraph.com/index.php/download-section/data.html

===========================================
# 2.如何在osgEarth中使用Cesium Native？

在osgEarth中使用Cesium Native，需要先构建Cesium Native库，再配置osgEarth使其找到该库，最后通过相关配置加载数据，具体步骤如下：
1. **构建Cesium Native**：
    - 使用Git克隆Cesium Native仓库，命令为`git clone --branch v0.37.0 git@github.com:cesiumgs/cesium-native.git --recurse-submodules`。
    - 进入克隆后的仓库目录，使用CMake进行配置，例如`cmake -b build -s. -G "Visual Studio 17 2022" -a x64 -DCMAKE_INSTALL_PREFIX=install -DCESIUM_TESTS_ENABLED=off -DCMAKE_POSITION_INDEPENDENT_CODE=on`，这里根据实际情况选择编译器和相关参数。
    - 构建并安装Cesium Native，命令为`cmake --build build --config relwithdebinfo`和`cmake --install build --config relwithdebinfo`。构建完成后，Cesium Native的库和头文件会位于`cesium-native/install`目录下。
2. **构建osgEarth并配置Cesium Native**：
    - 按照osgEarth的正常构建流程进行操作，但在使用CMake配置时，需要传入参数`-DCESIUM_NATIVE_DIR=/path/to/cesium-native/install`指定Cesium Native的安装目录，同时传入`-DOSGEARTH_BUILD_CESIUM_NODEKIT=on`，让osgEarth知道如何找到Cesium Native的库和头文件。
3. **设置访问密钥（可选）**：
    - 如果要从Cesium Ion加载数据，需要设置`osgearth_cesiumion_key`环境变量，将其设置为你的Cesium Ion访问密钥。在Windows系统中使用`set osgearth_cesiumion_key=your_key`，在Linux或macOS系统中使用`export osgearth_cesiumion_key=your_key`。
4. **加载数据**：
    - Cesium Native通过`cesiumnative3dtiles`图层在earth文件中提供3D Tiles数据的流式传输功能。可以在earth文件中配置相关节点来加载3D Tiles数据集。如果是加载非Cesium Ion托管的数据集，直接设置`url`为根瓦片集的地址；如果是从Cesium Ion加载资产，则设置相应的`asset id`。
    - 例如，要加载带有Bing影像覆盖的Cesium世界地形，可以在earth文件中添加相应配置。另外，Cesium Native有一个信用系统，若要启用，需在场景中添加一个Cesium信用节点。

=======================================================
# 3.在ubuntu编译了Osg源码后，如何用 find_package(OpenSceneGraph REQUIRED COMPONENTS ...)

## 问题
在ubuntu上编译了OpenSceneGraph的源码后，
如何用 find_package(OpenSceneGraph REQUIRED COMPONENTS osgManipulator osgShadow osgSim osgViewer osgGA osgUtil osgText osgDB osg OpenThreads)

## 元宝答案


在 Ubuntu 上编译 **OpenSceneGraph (OSG)** 后，要让 `find_package(OpenSceneGraph)` 正确工作，需要确保 OSG 的安装路径能被 CMake 找到。以下是详细步骤：

---

## **1. 确保 OSG 已正确安装**
假设你已经通过源码编译并安装了 OSG：
```bash
# 编译安装（假设安装在默认路径 /usr/local/）
cd OpenSceneGraph
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install  # 默认安装到 /usr/local/
```

### **验证安装**
检查 OSG 是否安装成功：
```bash
# 查看 OSG 核心库是否在标准路径
ls /usr/local/lib/libosg*
ls /usr/local/include/osg/Version
```

---

## **2. 让 CMake 找到 OSG**
CMake 通过 `FindOpenSceneGraph.cmake` 模块查找 OSG，它会搜索以下路径：
- **库路径**：`/usr/local/lib`、`/usr/lib`
- **头文件路径**：`/usr/local/include`、`usr/include`
- **CMake 配置文件**：`/usr/local/lib/cmake/OpenSceneGraph/OpenSceneGraphConfig.cmake`

如果 OSG 安装在非标准路径（如 `/opt/OSG`），需通过 `CMAKE_PREFIX_PATH` 指定路径：
```bash
cmake -DCMAKE_PREFIX_PATH=/opt/OSG ..
```

---

## **3. 在 CMake 项目中正确使用 `find_package`**
在你的 `CMakeLists.txt` 中：
```cmake
cmake_minimum_required(VERSION 3.10)
project(MyOSGProject)

# 可选：手动指定 OSG 安装路径（如果不在默认位置）
# set(CMAKE_PREFIX_PATH "/opt/OSG")

# 查找 OSG 及其组件
find_package(OpenSceneGraph REQUIRED 
    COMPONENTS 
        osgManipulator 
        osgShadow 
        osgSim 
        osgViewer 
        osgGA 
        osgUtil 
        osgText 
        osgDB 
        osg 
        OpenThreads
)

# 检查是否找到
if(OpenSceneGraph_FOUND)
    message(STATUS "Found OpenSceneGraph: ${OpenSceneGraph_VERSION}")
    include_directories(${OPENSCENEGRAPH_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "OpenSceneGraph not found!")
endif()

# 创建可执行文件
add_executable(myapp main.cpp)
target_link_libraries(myapp ${OPENSCENEGRAPH_LIBRARIES})
```

---

## **4. 常见问题解决**
### **问题 1：CMake 找不到 OSG**
**错误信息**：
```
Could not find a package configuration file provided by "OpenSceneGraph".
```

**解决方法**：
1. 确保 OSG 已安装到标准路径（如 `/usr/local/`）。
2. 手动指定 `CMAKE_PREFIX_PATH`：
   ```bash
   cmake -DCMAKE_PREFIX_PATH=/path/to/OSG ..
   ```

### **问题 2：缺少某些组件**
**错误信息**：
```
Could not find OpenSceneGraph component: osgManipulator
```

**解决方法**：
1. 确认编译 OSG 时启用了所有所需组件（默认全启用）。
2. 检查组件库文件是否存在：
   ```bash
   ls /usr/local/lib/libosgManipulator.so
   ```

### **问题 3：链接错误**
**错误信息**：
```
undefined reference to `osg::Node::Node()'
```

**解决方法**：
确保 `target_link_libraries` 包含所有依赖库：
```cmake
target_link_libraries(myapp 
    ${OPENSCENEGRAPH_LIBRARIES}
    # 可能需要额外链接系统库
    pthread dl
)
```

---

## **5. 高级配置（非标准安装路径）**
如果 OSG 安装在自定义路径（如 `/opt/OSG`），需在 CMake 中显式指定：
```cmake
set(OpenSceneGraph_DIR "/opt/OSG/lib/cmake/OpenSceneGraph")
find_package(OpenSceneGraph REQUIRED COMPONENTS ...)
```

或在命令行中传递路径：
```bash
cmake -DOpenSceneGraph_DIR=/opt/OSG/lib/cmake/OpenSceneGraph ..
```

---

## **总结**
1. **编译安装 OSG**：确保 `make install` 将文件安装到标准路径（如 `/usr/local/`）。
2. **CMake 配置**：使用 `find_package` 并列出所有需要的组件。
3. **路径问题**：如果安装到非标准路径，通过 `CMAKE_PREFIX_PATH` 或 `OpenSceneGraph_DIR` 指定。
4. **验证**：检查 `OpenSceneGraph_FOUND` 和 `${OPENSCENEGRAPH_LIBRARIES}`。

按照以上步骤，你的项目应该能正确找到并链接 OpenSceneGraph！
==============================================
 
# 4.build/ubuntu/configure/OpenSceneGraphConfig.cmake是如何产生的

在 **OpenSceneGraph (OSG)** 的构建过程中，`build/ubuntu/configure/OpenSceneGraphConfig.cmake` 文件的生成是由 **CMake 的导出机制** 自动完成的。以下是它的生成原理和具体流程：

---

## **1. 为什么会有 `OpenSceneGraphConfig.cmake`？**
CMake 提供了 `install(EXPORT)` 和 `configure_package_config_file()` 机制，允许项目在安装时生成一个 **`<PackageName>Config.cmake`** 文件。这个文件的作用是：
- **记录库的安装路径**（头文件、库文件、依赖项等）。
- **供其他项目通过 `find_package(OpenSceneGraph)` 正确找到 OSG**。

---

## **2. `OpenSceneGraphConfig.cmake` 是如何生成的？**
### **步骤 1：OSG 的 CMakeLists.txt 定义了导出规则**
在 OpenSceneGraph 源码的 `CMakeLists.txt` 中，会有类似以下代码：
```cmake
# 定义导出目标
install(
    TARGETS osg osgDB osgViewer ...  # 所有 OSG 库目标
    EXPORT OpenSceneGraphTargets     # 导出目标名称
    LIBRARY DESTINATION lib          # 库文件安装路径
    ARCHIVE DESTINATION lib          # 静态库路径
    RUNTIME DESTINATION bin          # 可执行文件路径（如工具）
    INCLUDES DESTINATION include     # 头文件路径
)

# 生成并安装 OpenSceneGraphConfig.cmake
install(
    EXPORT OpenSceneGraphTargets
    FILE OpenSceneGraphTargets.cmake
    DESTINATION lib/cmake/OpenSceneGraph
)

# 生成包的配置文件（通常由 configure_package_config_file 生成）
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/OpenSceneGraphConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/OpenSceneGraphConfig.cmake
    INSTALL_DESTINATION lib/cmake/OpenSceneGraph
)

# 安装 OpenSceneGraphConfig.cmake
install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/OpenSceneGraphConfig.cmake
    DESTINATION lib/cmake/OpenSceneGraph
)
```

### **步骤 2：编译安装时生成文件**
当执行以下命令时：
```bash
cd OpenSceneGraph
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  # 指定安装路径
make
sudo make install
```
CMake 会：
1. **编译 OSG 库**（生成 `.so`/`.a` 文件）。
2. **在构建目录（`build/`）中生成临时文件**：
   - `OpenSceneGraphTargets.cmake`（记录库的导出目标）。
   - `OpenSceneGraphConfig.cmake`（基于 `.in` 模板生成）。
3. **安装时复制到指定路径**：
   - `/usr/local/lib/cmake/OpenSceneGraph/OpenSceneGraphConfig.cmake`
   - `/usr/local/lib/cmake/OpenSceneGraph/OpenSceneGraphTargets.cmake`

### **步骤 3：你的案例路径（`build/ubuntu/configure/`）**
如果你的 OSG 编译到 `build/ubuntu/` 但未执行 `make install`，那么：
- **临时生成的 `OpenSceneGraphConfig.cmake`** 可能位于 `build/ubuntu/configure/` 下。
- 这是 CMake 在构建过程中生成的 **未安装版本**，通常用于开发调试。

---

## **3. 文件内容解析**
生成的 `OpenSceneGraphConfig.cmake` 通常包含：
```cmake
# 定义 OSG 的版本
set(OpenSceneGraph_VERSION 3.6.5)

# 导入编译目标（如 osg、osgDB）
include("${CMAKE_CURRENT_LIST_DIR}/OpenSceneGraphTargets.cmake")

# 设置变量供 find_package 使用
set(OpenSceneGraph_LIBRARIES osg;osgDB;osgViewer...)  # 所有库目标
set(OpenSceneGraph_INCLUDE_DIRS "/usr/local/include")
```

---

## **4. 为什么你的路径是 `build/ubuntu/configure/`？**
可能的原因：
1. **未执行 `make install`**  
   - 如果你只编译（`make`）但未安装（`make install`），CMake 会在构建目录中生成临时配置文件。
   - 这些文件通常用于 **开发阶段**，但正式使用时建议 `make install`。

2. **自定义了 `CMAKE_INSTALL_PREFIX`**  
   - 如果编译时指定了 `-DCMAKE_INSTALL_PREFIX=/opt/somelib_code/build/ubuntu`，配置文件会直接生成在该路径下。

3. **OSG 的构建脚本特殊处理**  
   - 某些 OSG 分支或自定义构建脚本可能会修改配置文件的生成路径。

---

## **5. 如何正确使用这个文件？**
### **情况 1：未安装，直接引用构建目录**
```cmake
# 直接指定构建目录中的 Config.cmake
set(OpenSceneGraph_DIR "/opt/somelib_code/build/ubuntu/configure")
find_package(OpenSceneGraph REQUIRED)
```

### **情况 2：正式安装后使用**
```bash
# 先执行安装
sudo make install
```
然后默认路径会是：
```cmake
find_package(OpenSceneGraph REQUIRED)  # 自动搜索 /usr/local/lib/cmake/OpenSceneGraph/
```

---

## **6. 总结**
- **生成机制**：`OpenSceneGraphConfig.cmake` 由 CMake 的导出命令（`install(EXPORT)`）和配置文件模板（`.in` 文件）生成。
- **你的路径**：`build/ubuntu/configure/` 下的文件是 **构建阶段的临时文件**，正式使用建议 `make install`。
- **正确用法**：通过 `OpenSceneGraph_DIR` 或 `CMAKE_PREFIX_PATH` 指定该文件所在目录。

如果目标是部署 OSG，建议完整执行 `make install`。若仅用于开发调试，可直接引用构建目录中的配置文件。

===================================================
# 5. 编写FindOpenSceneGraph.cmake 文件，能让find_package优先找到自定义的osg库而非系统 APT 安装的版本

  <!-- see: md_CMake/professional-cmake/23find_package--append.md -->

## 问题
现在我的ubuntu上有两套 OpenSceneGraph 的库。一套是用 apt install 安装的，另一套是我用 OSG源码编译出来的、放在OSG 源码的 build 目录下。
现在我想用 Cmake 构建一个自己的项目MyPrj，是否可以在MyPrj中 手动编写一个针对我基于源码编译的 OSG 库的 FindOpenSceneGraph.cmake 文件，能让find_package(OpenSceneGraph) 优先找到源码编译的build目录下的库和头文件，避免使用系统 APT 安装的版本 ？

## 元宝

是的，你可以通过手动编写一个 **自定义的 `FindOpenSceneGraph.cmake`** 文件，并利用 CMake 的搜索机制，确保 `find_package(OpenSceneGraph)` 优先使用你从源码编译的 OSG 版本（而非系统 APT 安装的版本）。以下是具体实现方法：

---

### **1. 创建自定义 `FindOpenSceneGraph.cmake`**
在你的项目 `MyPrj` 中创建一个 `cmake/` 目录，并编写 `FindOpenSceneGraph.cmake` 文件：
```cmake
# MyPrj/cmake/FindOpenSceneGraph.cmake
#
# 手动指定源码编译的 OSG 路径（替换为你的实际路径）
set(OSG_SOURCE_BUILD_DIR "/path/to/OpenSceneGraph/build/ubuntu")

# 强制设置头文件和库路径
set(OpenSceneGraph_INCLUDE_DIRS
    "${OSG_SOURCE_BUILD_DIR}/include"
    "${OSG_SOURCE_BUILD_DIR}/include/osg"
)

# 查找所有需要的库文件（根据你的 OSG 组件列表调整）
find_library(OSG_LIBRARY osg PATHS "${OSG_SOURCE_BUILD_DIR}/lib" NO_DEFAULT_PATH)
find_library(OSGDB_LIBRARY osgDB PATHS "${OSG_SOURCE_BUILD_DIR}/lib" NO_DEFAULT_PATH)
# ... 添加其他所需组件（osgViewer、osgUtil 等）

# 检查是否找到所有库
if(OSG_LIBRARY AND OSGDB_LIBRARY)
    set(OpenSceneGraph_LIBRARIES
        ${OSG_LIBRARY}
        ${OSGDB_LIBRARY}
        # ... 其他库
    )
    set(OpenSceneGraph_FOUND TRUE)
else()
    set(OpenSceneGraph_FOUND FALSE)
endif()

# 标记为高级变量（可选）
mark_as_advanced(OpenSceneGraph_INCLUDE_DIRS OpenSceneGraph_LIBRARIES)
```

---

### **2. 在 `CMakeLists.txt` 中优先使用自定义查找脚本**
在 `MyPrj` 的 `CMakeLists.txt` 中，通过 `CMAKE_MODULE_PATH` 指定优先使用你的 `FindOpenSceneGraph.cmake`：
```cmake
cmake_minimum_required(VERSION 3.10)
project(MyPrj)

# 优先使用项目内的 cmake/ 目录下的自定义查找脚本
list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_SOURCE_DIR}/cmake")

# 此时 find_package 会优先使用你的 FindOpenSceneGraph.cmake
find_package(OpenSceneGraph REQUIRED
    COMPONENTS osg osgDB osgViewer osgUtil  # 按需添加组件
)

if(OpenSceneGraph_FOUND)
    message(STATUS "Using manually compiled OSG from: ${OSG_SOURCE_BUILD_DIR}")
    include_directories(${OpenSceneGraph_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "Custom OSG not found!")
endif()

add_executable(my_app main.cpp)
target_link_libraries(my_app ${OpenSceneGraph_LIBRARIES})
```

---

### **3. 关键点说明**
#### **为什么能覆盖系统的 OSG？**
1. **`CMAKE_MODULE_PATH` 优先级**  
   - 通过 `list(INSERT CMAKE_MODULE_PATH 0 ...)` 将你的 `cmake/` 目录插入到搜索路径的**最前面**，确保 CMake 优先使用你的 `FindOpenSceneGraph.cmake`，而不是系统的 `/usr/share/cmake-<version>/Modules/FindOpenSceneGraph.cmake`。

2. **`NO_DEFAULT_PATH` 选项**  
   - 在 `find_library` 中指定 `NO_DEFAULT_PATH`，避免 CMake 搜索系统默认路径（如 `/usr/lib`）。

#### **验证是否生效**
在 CMake 配置时检查输出：
```bash
cmake ..
```
如果成功，你会看到类似日志：
```
-- Using manually compiled OSG from: /path/to/OpenSceneGraph/build/ubuntu
```

#### **处理依赖冲突**
如果你的项目依赖的其他库（如 `osgPlugins`）也需要链接到自定义 OSG，需确保：
```cmake
# 设置插件路径（如果需要）
set(OSG_PLUGIN_PATH "${OSG_SOURCE_BUILD_DIR}/lib/osgPlugins-<version>")
set(ENV{OSG_LIBRARY_PATH} ${OSG_PLUGIN_PATH})
```

---

### **4. 替代方案（无需手动写 Find 脚本）**
如果源码编译的 OSG 已生成 `OpenSceneGraphConfig.cmake`（通常在 `build/ubuntu/lib/cmake/OpenSceneGraph/` 下），可以直接指定路径：
```cmake
# 直接指向自定义 OSG 的 Config.cmake 目录
set(OpenSceneGraph_DIR "/path/to/OpenSceneGraph/build/ubuntu/lib/cmake/OpenSceneGraph")
find_package(OpenSceneGraph REQUIRED)
```
此方法更简洁，但前提是 OSG 的构建系统正确生成了配置文件。

---

### **5. 总结**
| **方法**               | 优点                          | 缺点                          |
|-------------------------|-------------------------------|-------------------------------|
| **自定义 `FindOpenSceneGraph.cmake`** | 完全控制路径，强制覆盖系统版本 | 需手动维护库列表和路径        |
| **直接指定 `OpenSceneGraph_DIR`**    | 自动解析依赖，更简洁          | 需确保 OSG 生成了 Config.cmake |

推荐优先尝试 **方法 2**（指定 `OpenSceneGraph_DIR`），如果无效再使用方法 1。

===============================================================
# 6.OpenSceneGraph/build/ubuntu/configure/OpenSceneGraphConfig.cmake中OpenSceneGraph_FIND_COMPONENTS什么适合被赋值的

在 **CMake** 的 `find_package` 机制中，`OpenSceneGraph_FIND_COMPONENTS` 是一个由 CMake 自动赋值的变量，用于记录用户在 `find_package` 中请求的组件（`COMPONENTS`）。你**通常不需要手动赋值它**，而是由 CMake 在调用 `find_package` 时自动处理。

---

## **1. `OpenSceneGraph_FIND_COMPONENTS` 的作用**
当你在 `CMakeLists.txt` 中这样调用：
```cmake
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgViewer osgUtil)
```
CMake 会自动：
1. 将 `osgDB`, `osgViewer`, `osgUtil` 赋值给 `OpenSceneGraph_FIND_COMPONENTS`。
2. 在 `FindOpenSceneGraph.cmake` 或 `OpenSceneGraphConfig.cmake` 中检查这些组件是否存在。

---

## **2. `OpenSceneGraph_FIND_COMPONENTS` 的赋值时机**
### **（1）由 `find_package` 自动赋值**
- **调用 `find_package` 时**，CMake 会自动解析 `COMPONENTS` 列表，并赋值给 `OpenSceneGraph_FIND_COMPONENTS`。
- 例如：
  ```cmake
  find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgViewer)
  ```
  此时 `OpenSceneGraph_FIND_COMPONENTS` 的值会是 `osgDB;osgViewer`（CMake 的列表格式）。

### **（2）在 `OpenSceneGraphConfig.cmake` 中使用**
- `OpenSceneGraphConfig.cmake` 通常会检查 `OpenSceneGraph_FIND_COMPONENTS`，并验证这些组件是否可用。
- 例如：
  ```cmake
  # OpenSceneGraphConfig.cmake 的典型逻辑
  foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
      if(NOT TARGET OpenSceneGraph::${component})
          set(OpenSceneGraph_${component}_FOUND FALSE)
          set(OpenSceneGraph_FOUND FALSE)
      endif()
  endforeach()
  ```

---

## **3. 什么时候需要手动干预 `OpenSceneGraph_FIND_COMPONENTS`？**
### **情况 1：自定义 `FindOpenSceneGraph.cmake`**
如果你自己编写 `FindOpenSceneGraph.cmake`（而不是用官方的 `Config.cmake`），你可能需要：
- **读取 `OpenSceneGraph_FIND_COMPONENTS`** 来决定查找哪些库。
- **示例**：
  ```cmake
  # 在 FindOpenSceneGraph.cmake 中
  message(STATUS "Requested components: ${OpenSceneGraph_FIND_COMPONENTS}")

  # 遍历并查找每个组件
  foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
      find_library(OSG_${component}_LIBRARY
          NAMES osg${component}
          PATHS "/path/to/osg/build/lib"
          NO_DEFAULT_PATH
      )
      if(OSG_${component}_LIBRARY)
          list(APPEND OpenSceneGraph_LIBRARIES ${OSG_${component}_LIBRARY})
      else()
          message(WARNING "Could not find OSG component: ${component}")
      endif()
  endforeach()
  ```

### **情况 2：调试或强制覆盖**
如果 CMake 没有正确传递 `COMPONENTS`，你可以手动赋值（但不推荐）：
```cmake
# 仅用于调试！（正常情况下不需要）
set(OpenSceneGraph_FIND_COMPONENTS osgDB osgViewer)
```

---

## **4. 最佳实践**
1. **不要手动赋值 `OpenSceneGraph_FIND_COMPONENTS`**  
   - 它应该由 `find_package` 自动管理。
   - 手动赋值可能导致组件检查失效。

2. **在 `FindOpenSceneGraph.cmake` 中正确处理组件**  
   - 使用 `${OpenSceneGraph_FIND_COMPONENTS}` 遍历请求的组件。
   - 对每个组件调用 `find_library` 或检查目标是否存在。

3. **确保 `OpenSceneGraphConfig.cmake` 能处理组件**  
   - 如果是官方提供的 `Config.cmake`，它应该已经支持 `COMPONENTS`。
   - 如果是自己编译的 OSG，确保 CMake 导出逻辑正确（参考 https://github.com/openscenegraph/OpenSceneGraph/blob/master/CMakeLists.txt）。

---

## **5. 示例：完整流程**
### **（1）`CMakeLists.txt` 调用**
```cmake
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgViewer)
```

### **（2）`OpenSceneGraphConfig.cmake` 的逻辑**
```cmake
# 自动接收 OpenSceneGraph_FIND_COMPONENTS = "osgDB;osgViewer"
foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
    if(NOT TARGET OpenSceneGraph::${component})
        message(FATAL_ERROR "OSG component missing: ${component}")
    endif()
endforeach()
```

### **（3）自定义 `FindOpenSceneGraph.cmake` 的逻辑**
```cmake
foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
    find_library(OSG_${component}_LIBRARY
        NAMES osg${component}
        PATHS "/path/to/osg/build/lib"
        NO_DEFAULT_PATH
    )
    if(OSG_${component}_LIBRARY)
        list(APPEND OpenSceneGraph_LIBRARIES ${OSG_${component}_LIBRARY})
    else()
        message(FATAL_ERROR "Could not find OSG component: ${component}")
    endif()
endforeach()
```

---

## **总结**
- `OpenSceneGraph_FIND_COMPONENTS` **由 `find_package` 自动赋值**，无需手动干预。
- 在自定义 `FindOpenSceneGraph.cmake` 或 `OpenSceneGraphConfig.cmake` 中，**读取该变量**以检查请求的组件。
- 只有在调试或特殊情况下才手动覆盖（通常不需要）。

=======================================================
# 7.为什么OpenSceneGraphConfig.cmake中用“if(NOT TARGET OpenSceneGraph::${component})”而 FindOpenSceneGraph.cmake中用find_library(OSG_${component}_LIBRARY

在 CMake 中，`OpenSceneGraphConfig.cmake` 和 `FindOpenSceneGraph.cmake` 是两种不同的机制，它们处理组件（`COMPONENTS`）的方式不同，主要原因如下：

---

## **1. `OpenSceneGraphConfig.cmake` 使用 `TARGET` 检查**
### **适用场景**
- **现代 CMake（>= 3.0）**，库通过 `install(TARGETS ... EXPORT)` 导出目标。
- **OSG 官方构建**：如果 OpenSceneGraph 使用 CMake 正确导出，它会生成 `OpenSceneGraphTargets.cmake`，定义了一组 `IMPORTED` 目标（如 `OpenSceneGraph::osg`、`OpenSceneGraph::osgDB` 等）。

### **为什么用 `if(NOT TARGET OpenSceneGraph::${component})`**
1. **目标（TARGET）已存在**  
   - `OpenSceneGraphConfig.cmake` 会 `include()` 对应的 `OpenSceneGraphTargets.cmake`，其中已经定义了所有导出的目标（如 `OpenSceneGraph::osgDB`）。
   - 直接检查目标是否存在即可，无需手动查找库文件。

2. **更高级的依赖管理**  
   - 目标（`OpenSceneGraph::osgDB`）可能包含：
     - 预定义的编译选项（`INTERFACE_COMPILE_OPTIONS`）
     - 依赖关系（`INTERFACE_LINK_LIBRARIES`）
     - 头文件路径（`INTERFACE_INCLUDE_DIRECTORIES`）
   - 直接链接目标会自动处理这些依赖。

3. **示例逻辑**
   ```cmake
   # OpenSceneGraphConfig.cmake
   include("${CMAKE_CURRENT_LIST_DIR}/OpenSceneGraphTargets.cmake")  # 导入目标

   foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
       if(NOT TARGET OpenSceneGraph::${component})
           set(OpenSceneGraph_FOUND FALSE)
           message(FATAL_ERROR "OSG component '${component}' not found!")
       endif()
   endforeach()
   ```

---

## **2. `FindOpenSceneGraph.cmake` 使用 `find_library`**
### **适用场景**
- **传统 CMake 或非现代库**：库未提供 `Config.cmake` 或 `TARGETS` 导出。
- **自定义查找逻辑**：手动定位库文件和头文件。

### **为什么用 `find_library`**
1. **库未导出为目标**  
   - 如果 OSG 未通过 CMake 的 `install(EXPORT)` 生成目标，则需要手动查找 `.so`/`.a` 文件。

2. **兼容旧版本或非 CMake 构建的库**  
   - 某些库可能直接通过 `make install` 安装，未生成 `Config.cmake`。

3. **灵活性**  
   - 可以自定义搜索路径（如优先查找源码编译的版本，而非系统版本）。

4. **示例逻辑**
   ```cmake
   # FindOpenSceneGraph.cmake
   foreach(component ${OpenSceneGraph_FIND_COMPONENTS})
       find_library(OSG_${component}_LIBRARY
           NAMES osg${component}  # 例如 libosgDB.so
           PATHS "/opt/OSG/build/lib"  # 指定自定义路径
           NO_DEFAULT_PATH          # 避免搜索系统路径
       )
       if(OSG_${component}_LIBRARY)
           list(APPEND OpenSceneGraph_LIBRARIES ${OSG_${component}_LIBRARY})
       else()
           set(OpenSceneGraph_FOUND FALSE)
       endif()
   endforeach()
   ```

---

## **3. 关键区别对比**
| **特性**               | `OpenSceneGraphConfig.cmake` (现代 CMake)       | `FindOpenSceneGraph.cmake` (传统方式)          |
|------------------------|------------------------------------------------|-----------------------------------------------|
| **底层机制**           | 基于 CMake 的 `TARGET` 导出系统                | 基于 `find_library` 和 `find_path` 手动搜索   |
| **依赖管理**           | 自动处理编译选项、链接依赖、头文件路径          | 需手动设置 `include_directories` 和链接库      |
| **适用场景**           | 库官方提供 `Config.cmake`                      | 库未提供 CMake 支持或需自定义查找逻辑          |
| **典型代码**           | `if(NOT TARGET OpenSceneGraph::osgDB)`         | `find_library(OSG_osgDB_LIBRARY NAMES osgDB)` |
| **维护性**             | 更简洁，依赖库的 CMake 导出逻辑                | 需手动维护库路径和组件列表                    |

---

## **4. 如何选择？**
### **优先使用 `Config.cmake`（如果可用）**
```cmake
# 直接指向自定义编译的 OSG 的 Config.cmake
set(OpenSceneGraph_DIR "/opt/OSG/build/ubuntu/lib/cmake/OpenSceneGraph")
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB osgViewer)
```
**优点**：自动处理所有依赖，无需手动写 `Find` 脚本。

### **退回到 `FindOpenSceneGraph.cmake`（如果必须）**
```cmake
# 手动编写 FindOpenSceneGraph.cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
find_package(OpenSceneGraph REQUIRED COMPONENTS osgDB)
```
**适用场景**：
- OSG 未生成 `Config.cmake`。
- 需要强制覆盖系统路径（如优先使用源码编译的版本）。

---

## **5. 总结**
- **`OpenSceneGraphConfig.cmake` 用 `TARGET`**：因为现代 CMake 库会导出目标，直接检查目标是否存在即可。
- **`FindOpenSceneGraph.cmake` 用 `find_library`**：因为需要手动定位库文件，适用于未导出的库或自定义路径。
- **最佳实践**：尽量让库提供 `Config.cmake`，避免手动维护 `Find` 脚本。

==========================================================
# 8. ./build/ubuntu/bin/osgviewer  ./Data340/cow.osg 显示的牛是黑色的

## 问题：
$HOME/OpenSceneGraph是osg源码路径，  $HOME/OpenSceneGraph/build/ubuntu/是编译结果文件夹，$HOME/OpenSceneGraph/build/ubuntu/bin和$HOME/OpenSceneGraph/build/ubuntu/lib分别是生成的可执行文件和so文件夹，
但是 $HOME/OpenSceneGraph$   ./build/ubuntu/bin/osgviewer  ./Data340/cow.osg 显示的牛是黑色的

## 元宝

