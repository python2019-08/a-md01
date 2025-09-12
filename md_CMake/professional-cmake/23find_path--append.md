# 1.只有当 ZLIB_INCLUDE_DIR 未被手动设置时，find_path 才会执行自动搜索

## Q
findZlib.cmake 代码如下：
```
#.......
set(_ZLIB_SEARCHES)

# Search ZLIB_ROOT first if it is set.
if(ZLIB_ROOT)
  set(_ZLIB_SEARCH_ROOT PATHS ${ZLIB_ROOT} NO_DEFAULT_PATH)
  list(APPEND _ZLIB_SEARCHES _ZLIB_SEARCH_ROOT)
endif()

#.......

if(ZLIB_USE_STATIC_LIBS)
  set(ZLIB_NAMES zlibstatic zlibstat zlib z)
  set(ZLIB_NAMES_DEBUG zlibstaticd zlibstatd zlibd zd)
else()
  set(ZLIB_NAMES z zlib zdll zlib1 zlibstatic zlibwapi zlibvc zlibstat)
  set(ZLIB_NAMES_DEBUG zd zlibd zdlld zlibd1 zlib1d zlibstaticd zlibwapid zlibvcd zlibstatd)
endif()

# Try each search configuration.
foreach(search ${_ZLIB_SEARCHES})
  find_path(ZLIB_INCLUDE_DIR NAMES zlib.h ${${search}} PATH_SUFFIXES include)
endforeach()

# Allow ZLIB_LIBRARY to be set manually, as the location of the zlib library
if(NOT ZLIB_LIBRARY)
  if(DEFINED CMAKE_FIND_LIBRARY_PREFIXES)
    set(_zlib_ORIG_CMAKE_FIND_LIBRARY_PREFIXES "${CMAKE_FIND_LIBRARY_PREFIXES}")
  else()
    set(_zlib_ORIG_CMAKE_FIND_LIBRARY_PREFIXES)
  endif()
  if(DEFINED CMAKE_FIND_LIBRARY_SUFFIXES)
    set(_zlib_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES "${CMAKE_FIND_LIBRARY_SUFFIXES}")
  else()
    set(_zlib_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES)
  endif()
  # Prefix/suffix of the win32/Makefile.gcc build
  if(WIN32)
    list(APPEND CMAKE_FIND_LIBRARY_PREFIXES "" "lib")
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ".dll.a")
  endif()
  # Support preference of static libs by adjusting CMAKE_FIND_LIBRARY_SUFFIXES
  if(ZLIB_USE_STATIC_LIBS)
    if(WIN32)
      set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    else()
      set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
    endif()
  endif()

  foreach(search ${_ZLIB_SEARCHES})
    find_library(ZLIB_LIBRARY_RELEASE NAMES ${ZLIB_NAMES} NAMES_PER_DIR ${${search}} PATH_SUFFIXES lib)
    find_library(ZLIB_LIBRARY_DEBUG NAMES ${ZLIB_NAMES_DEBUG} NAMES_PER_DIR ${${search}} PATH_SUFFIXES lib)
  endforeach()

  # Restore the original find library ordering
  if(DEFINED _zlib_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES)
    set(CMAKE_FIND_LIBRARY_SUFFIXES "${_zlib_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES}")
  else()
    set(CMAKE_FIND_LIBRARY_SUFFIXES)
  endif()
  if(DEFINED _zlib_ORIG_CMAKE_FIND_LIBRARY_PREFIXES)
    set(CMAKE_FIND_LIBRARY_PREFIXES "${_zlib_ORIG_CMAKE_FIND_LIBRARY_PREFIXES}")
  else()
    set(CMAKE_FIND_LIBRARY_PREFIXES)
  endif()

  include(${CMAKE_CURRENT_LIST_DIR}/SelectLibraryConfigurations.cmake)
  select_library_configurations(ZLIB)
endif()

unset(ZLIB_NAMES)
unset(ZLIB_NAMES_DEBUG)

mark_as_advanced(ZLIB_INCLUDE_DIR)

if(ZLIB_INCLUDE_DIR AND EXISTS "${ZLIB_INCLUDE_DIR}/zlib.h")
  file(STRINGS "${ZLIB_INCLUDE_DIR}/zlib.h" ZLIB_H REGEX "^#define ZLIB_VERSION \"[^\"]*\"$")
  if(ZLIB_H MATCHES "ZLIB_VERSION \"(([0-9]+)\\.([0-9]+)(\\.([0-9]+)(\\.([0-9]+))?)?)")
    set(ZLIB_VERSION_STRING "${CMAKE_MATCH_1}")
    set(ZLIB_VERSION_MAJOR "${CMAKE_MATCH_2}")
    set(ZLIB_VERSION_MINOR "${CMAKE_MATCH_3}")
    set(ZLIB_VERSION_PATCH "${CMAKE_MATCH_5}")
    set(ZLIB_VERSION_TWEAK "${CMAKE_MATCH_7}")
  else()
    set(ZLIB_VERSION_STRING "")
    set(ZLIB_VERSION_MAJOR "")
    set(ZLIB_VERSION_MINOR "")
    set(ZLIB_VERSION_PATCH "")
    set(ZLIB_VERSION_TWEAK "")
  endif()
  set(ZLIB_MAJOR_VERSION "${ZLIB_VERSION_MAJOR}")
  set(ZLIB_MINOR_VERSION "${ZLIB_VERSION_MINOR}")
  set(ZLIB_PATCH_VERSION "${ZLIB_VERSION_PATCH}")
  set(ZLIB_VERSION "${ZLIB_VERSION_STRING}")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB REQUIRED_VARS ZLIB_LIBRARY ZLIB_INCLUDE_DIR
                                       VERSION_VAR ZLIB_VERSION
                                       HANDLE_COMPONENTS)

if(ZLIB_FOUND)
    set(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})

    if(NOT ZLIB_LIBRARIES)
      set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
    endif()

    if(NOT TARGET ZLIB::ZLIB)
      add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
      set_target_properties(ZLIB::ZLIB PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")

      if(ZLIB_LIBRARY_RELEASE)
        set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
          IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(ZLIB::ZLIB PROPERTIES
          IMPORTED_LOCATION_RELEASE "${ZLIB_LIBRARY_RELEASE}")
      endif()

      if(ZLIB_LIBRARY_DEBUG)
        set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
          IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(ZLIB::ZLIB PROPERTIES
          IMPORTED_LOCATION_DEBUG "${ZLIB_LIBRARY_DEBUG}")
      endif()

      if(NOT ZLIB_LIBRARY_RELEASE AND NOT ZLIB_LIBRARY_DEBUG)
        set_property(TARGET ZLIB::ZLIB APPEND PROPERTY
          IMPORTED_LOCATION "${ZLIB_LIBRARY}")
      endif()
    endif()
endif()
```

为何 运行下面的命令没有搜索 头文件？       
```sh
cmake -S${SrcDIR_lib} -B ${BuildDIR_lib} --debug-find \
            -DCMAKE_MODULE_PATH="${INSTALL_PREFIX_zlib}/lib/cmake/zlib" \
            -DCMAKE_PREFIX_PATH="${cmk_prefixPath}" \
            -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX_png} \
            -DZLIB_ROOT="${INSTALL_PREFIX_zlib}" \
            -DZLIB_LIBRARY=${INSTALL_PREFIX_zlib}/lib/libz.a \
            -DZLIB_INCLUDE_DIR=${INSTALL_PREFIX_zlib}/include 
```
## A-DoubaoAI

要理解为何你的 CMake 命令没有“搜索”头文件，需要结合 `findZlib.cmake` 的逻辑和你传递的参数来分析——核心原因是**你直接手动指定了 `ZLIB_INCLUDE_DIR`，跳过了 CMake 的自动搜索流程**，而非 CMake 没有搜索头文件。


### 第一步：先看懂 `findZlib.cmake` 中“搜索头文件”的逻辑
`findZlib.cmake` 中专门负责“搜索 zlib 头文件（`zlib.h`）”的代码是这部分：
```cmake
# 1. 构建搜索路径列表（_ZLIB_SEARCHES）
# - 如果设置了 ZLIB_ROOT，优先从 ZLIB_ROOT 搜索
if(ZLIB_ROOT)
  set(_ZLIB_SEARCH_ROOT PATHS ${ZLIB_ROOT} NO_DEFAULT_PATH)
  list(APPEND _ZLIB_SEARCHES _ZLIB_SEARCH_ROOT)
endif()
.....
# 2. 遍历搜索路径，调用 find_path 查找 zlib.h（核心搜索逻辑）
foreach(search ${_ZLIB_SEARCHES})
  find_path(ZLIB_INCLUDE_DIR NAMES zlib.h ${${search}} PATH_SUFFIXES include)
endforeach()
```
- **`find_path` 是关键**：它会在指定的路径（`${${search}}`）下，结合 `PATH_SUFFIXES include`（即路径后追加 `include` 子目录），查找名为 `zlib.h` 的文件。
- **搜索触发条件**：只有当 `ZLIB_INCLUDE_DIR` 未被手动设置时，`find_path` 才会执行自动搜索；如果 `ZLIB_INCLUDE_DIR` 已存在（比如你手动传了参数），`find_path` 会直接跳过搜索（因为 CMake 认为“用户已经指定了路径，无需自动找”）。


### 第二步：分析你的 CMake 命令为何“跳过搜索”
你的命令中明确传递了 **`-DZLIB_INCLUDE_DIR=${INSTALL_PREFIX_zlib}/include`**，这直接给 `ZLIB_INCLUDE_DIR` 赋了值：
```bash
cmake -S${SrcDIR_lib} -B ${BuildDIR_lib} --debug-find \
    -DCMAKE_MODULE_PATH="${INSTALL_PREFIX_zlib}/lib/cmake/zlib" \
    -DCMAKE_PREFIX_PATH="${cmk_prefixPath}" \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX_png} \
    -DZLIB_ROOT="${INSTALL_PREFIX_zlib}" \
    -DZLIB_LIBRARY=${INSTALL_PREFIX_zlib}/lib/libz.a \
    -DZLIB_INCLUDE_DIR=${INSTALL_PREFIX_zlib}/include  # 这里手动指定了头文件路径
```
结合 `findZlib.cmake` 的逻辑：
1. 你手动设置了 `ZLIB_INCLUDE_DIR`，CMake 会认为“用户已经明确告诉了头文件在哪”；
2. 因此，`findZlib.cmake` 中 `foreach(search ${_ZLIB_SEARCHES})` 循环里的 `find_path` 会**跳过自动搜索**（因为目标变量 `ZLIB_INCLUDE_DIR` 已存在）；
3. 最终表现为“没有搜索头文件”——本质是“你手动指定了路径，所以不需要搜索”。


### 第三步：验证与补充说明
#### 1. 如何让 CMake“执行搜索”？
如果你想让 `findZlib.cmake` 自动搜索头文件（而非手动指定），只需**删除 `-DZLIB_INCLUDE_DIR=...` 参数**，并确保 `ZLIB_ROOT` 正确（你的命令中已传 `-DZLIB_ROOT=${INSTALL_PREFIX_zlib}`）：
```bash
# 修改后的命令（删除 ZLIB_INCLUDE_DIR 手动指定）
cmake -S${SrcDIR_lib} -B ${BuildDIR_lib} --debug-find \
    -DCMAKE_MODULE_PATH="${INSTALL_PREFIX_zlib}/lib/cmake/zlib" \
    -DCMAKE_PREFIX_PATH="${cmk_prefixPath}" \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX_png} \
    -DZLIB_ROOT="${INSTALL_PREFIX_zlib}" \  # 优先从 ZLIB_ROOT 搜索
    -DZLIB_LIBRARY=${INSTALL_PREFIX_zlib}/lib/libz.a
```
此时 `findZlib.cmake` 会：
- 先从 `ZLIB_ROOT` 下的 `include` 目录（即 `${INSTALL_PREFIX_zlib}/include`）搜索 `zlib.h`；
- 如果没找到，再从常规路径（如 `ProgramFiles`）搜索；
- 最终将找到的路径赋值给 `ZLIB_INCLUDE_DIR`。


#### 2. 为何你手动指定后，`findZlib.cmake` 仍能正常工作？
虽然跳过了搜索，但只要你传递的 `-DZLIB_INCLUDE_DIR` 路径下**确实存在 `zlib.h`**，`findZlib.cmake` 后续逻辑（如版本检查、生成 `ZLIB::ZLIB` 目标）仍能正常执行：
```cmake
# 检查头文件是否存在，并提取版本
if(ZLIB_INCLUDE_DIR AND EXISTS "${ZLIB_INCLUDE_DIR}/zlib.h")
  file(STRINGS "${ZLIB_INCLUDE_DIR}/zlib.h" ZLIB_H REGEX "^#define ZLIB_VERSION \"[^\"]*\"$")
  # ... 提取版本号逻辑 ...
endif()

# 验证是否找到 zlib（依赖 ZLIB_LIBRARY 和 ZLIB_INCLUDE_DIR）
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB REQUIRED_VARS ZLIB_LIBRARY ZLIB_INCLUDE_DIR ...)
```
只要 `ZLIB_INCLUDE_DIR` 路径有效，这部分代码就能正常运行，不会影响最终构建。


### 总结
你的 CMake 命令“没有搜索头文件”的原因是：
- **你通过 `-DZLIB_INCLUDE_DIR` 手动指定了头文件路径**，`findZlib.cmake` 中的 `find_path` 因目标变量已存在而跳过自动搜索；
- 这不是 CMake 的“问题”，而是“用户手动指定路径优先于自动搜索”的设计逻辑；
- 若想触发自动搜索，删除 `-DZLIB_INCLUDE_DIR` 参数即可（`ZLIB_ROOT` 会引导 CMake 优先搜索正确路径）。