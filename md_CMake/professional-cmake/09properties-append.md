# 1.如何get_target_properties 获取某个target 链接的库

要通过 CMake 的 `get_target_properties` 命令获取某个目标（target）所链接的库，需要明确目标链接库的 **不同类型**（如私有、公开、接口库），并结合 CMake 提供的特定属性来查询。以下是详细的操作方法、原理和示例。


### 一、核心原理：明确目标链接库的属性类型
CMake 中，目标的链接库通过 `target_link_libraries` 命令设置，且分为 **3种作用域**，对应不同的 CMake 属性，查询时需针对性使用：

| 链接库作用域 | 说明 | 对应 CMake 属性 | 适用场景 |
|--------------|------|----------------|----------|
| `PRIVATE`    | 仅目标自身编译/链接时使用，不传递给依赖该目标的其他目标 | `LINK_LIBRARIES` | 目标内部依赖的库（如工具类库） |
| `PUBLIC`     | 目标自身使用 + 传递给依赖该目标的其他目标（依赖方需链接） | `INTERFACE_LINK_LIBRARIES` | 目标对外暴露的核心依赖（如 GDAL 依赖的 PROJ、GEOS） |
| `INTERFACE`  | 仅传递给依赖该目标的其他目标，目标自身不使用 | `INTERFACE_LINK_LIBRARIES` | 接口库（如仅提供头文件的库） |

> 关键结论：  
> - 查 **目标自身链接的所有库**（含 PRIVATE/PUBLIC）：用 `LINK_LIBRARIES` 属性；  
> - 查 **目标对外传递的库**（含 PUBLIC/INTERFACE）：用 `INTERFACE_LINK_LIBRARIES` 属性；  
> - 查 **最终需要链接的所有库**（含传递依赖）：需结合 `LINK_LIBRARIES` + `INTERFACE_LINK_LIBRARIES`，或用 `get_link_dependencies`（CMake 3.19+）。


### 二、具体操作步骤
#### 1. 基础用法：通过 `get_target_property` 查询单个属性
`get_target_property` 是查询目标属性的核心命令，语法如下：
```cmake
get_target_property(<输出变量> <目标名> <属性名>)
```
- `<输出变量>`：存储查询结果的变量（若查询失败，变量会被设为 `NOTFOUND`）；  
- `<目标名>`：要查询的目标（如你示例中的 `GDAL::GDAL` 或 `${GDAL_LIB_TARGET_NAME}`）；  
- `<属性名>`：需查询的属性（如 `LINK_LIBRARIES` 或 `INTERFACE_LINK_LIBRARIES`）。


#### 2. 示例1：查询 GDAL 目标的链接库
以你提供的 `GDAL::GDAL` 目标为例，查询其链接的库：
```cmake
# 1. 定义要查询的目标（可替换为你的目标名，如 ${GDAL_LIB_TARGET_NAME}）
set(TARGET_TO_QUERY "GDAL::GDAL")

# 2. 查询目标自身链接的库（PRIVATE + PUBLIC）
get_target_property(GDAL_LINK_LIBS ${TARGET_TO_QUERY} LINK_LIBRARIES)
if(GDAL_LINK_LIBS)
  message(STATUS "【${TARGET_TO_QUERY} 自身链接的库】: ${GDAL_LINK_LIBS}")
else()
  message(STATUS "【${TARGET_TO_QUERY}】未设置 LINK_LIBRARIES 属性")
endif()

# 3. 查询目标对外传递的库（PUBLIC + INTERFACE，即你示例中 GDAL-targets.cmake 里的 INTERFACE_LINK_LIBRARIES）
get_target_property(GDAL_INTERFACE_LINK_LIBS ${TARGET_TO_QUERY} INTERFACE_LINK_LIBRARIES)
if(GDAL_INTERFACE_LINK_LIBS)
  message(STATUS "【${TARGET_TO_QUERY} 对外传递的库】: ${GDAL_INTERFACE_LINK_LIBS}")
else()
  message(STATUS "【${TARGET_TO_QUERY}】未设置 INTERFACE_LINK_LIBRARIES 属性")
endif()
```

**输出效果**（类似你生成的 `GDAL-targets.cmake` 内容）：
```
-- 【GDAL::GDAL 自身链接的库】: ${GDAL_PRIVATE_LINK_LIBRARIES};${GDAL_EXTRA_LINK_LIBRARIES}
-- 【GDAL::GDAL 对外传递的库】: $<LINK_ONLY:ZLIB::ZLIB>;$<LINK_ONLY:dl>;$<LINK_ONLY:CURL::libcurl>;...（其他依赖库）
```


#### 3. 示例2：查询所有传递依赖（含间接依赖）
若需查询目标的 **所有依赖库（含间接依赖，如 GDAL→PROJ→SQLite）**，CMake 3.19+ 提供了更便捷的 `get_link_dependencies` 命令：
```cmake
# 要求 CMake 版本 ≥ 3.19
cmake_minimum_required(VERSION 3.19)

# 查询目标的所有链接依赖（递归包含间接依赖）
get_link_dependencies(GDAL_ALL_DEPENDENCIES ${TARGET_TO_QUERY})
message(STATUS "【${TARGET_TO_QUERY} 所有依赖库】: ${GDAL_ALL_DEPENDENCIES}")
```

**输出效果**：
```
-- 【GDAL::GDAL 所有依赖库】: GDAL::GDAL;PROJ::proj;GEOS::GEOS;ZLIB::ZLIB;CURL::libcurl;SQLite::SQLite3;...
```


#### 4. 进阶：遍历输出所有链接库
若查询结果是列表（如多个库），可通过 `foreach` 遍历输出，更清晰：
```cmake
# 遍历输出对外传递的库
if(GDAL_INTERFACE_LINK_LIBS)
  message(STATUS "【${TARGET_TO_QUERY} 对外传递的库（详细）】:")
  foreach(LIB IN LISTS GDAL_INTERFACE_LINK_LIBS)
    message(STATUS "  - ${LIB}")
  endforeach()
endif()
```

**输出效果**：
```
-- 【GDAL::GDAL 对外传递的库（详细）】:
--   - $<LINK_ONLY:ZLIB::ZLIB>
--   - $<LINK_ONLY:dl>
--   - $<LINK_ONLY:CURL::libcurl>
--   - $<LINK_ONLY:Threads::Threads>
--   - ...
```


### 三、常见问题与注意事项
1. **查询结果为 `NOTFOUND`？**  
   - 检查目标名是否正确（如是否存在拼写错误，或目标是否已定义）；  
   - 检查属性是否适用（如接口库没有 `LINK_LIBRARIES` 属性，仅 `INTERFACE_LINK_LIBRARIES`）；  
   - 确保在目标被定义后再查询（如 `add_library` 或 `find_package` 之后）。

2. **结果包含生成器表达式（如 `$<LINK_ONLY:...>`）？**  
   这是正常现象（如你示例中的 `$<LINK_ONLY:ZLIB::ZLIB>`），生成器表达式用于控制编译/链接阶段的条件逻辑（如 `LINK_ONLY` 表示仅链接不传递包含路径），无需手动处理，CMake 会自动解析。

3. **如何区分静态库/动态库？**  
   可结合 `TYPE` 属性先判断目标类型，再查询链接库：
   ```cmake
   # 查询目标类型（STATIC_LIBRARY/DYNAMIC_LIBRARY/INTERFACE_LIBRARY）
   get_target_property(GDAL_TARGET_TYPE ${TARGET_TO_QUERY} TYPE)
   message(STATUS "【${TARGET_TO_QUERY} 类型】: ${GDAL_TARGET_TYPE}")
   ```


### 四、总结
| 需求场景 | 推荐命令 + 属性 | CMake 版本要求 |
|----------|-----------------|----------------|
| 查目标自身链接的库（PRIVATE+PUBLIC） | `get_target_property(..., LINK_LIBRARIES)` | 无（全版本支持） |
| 查目标对外传递的库（PUBLIC+INTERFACE） | `get_target_property(..., INTERFACE_LINK_LIBRARIES)` | 无（全版本支持） |
| 查所有依赖库（含间接依赖） | `get_link_dependencies(...)` | ≥ 3.19 |

通过上述方法，可精准获取目标的链接库信息，尤其适合调试 CMake 依赖配置（如排查“链接库缺失”“依赖传递异常”等问题）。