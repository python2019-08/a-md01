# 1. Cargo.toml 讲解
`Cargo.toml` 是 Rust 项目的**清单配置文件**，放在项目根目录，Cargo（Rust官方包管理器+构建工具）读取这个文件，管理项目名称、版本、依赖、编译选项、元信息。
> 配套还有 `Cargo.lock`，**不要手动修改**，Cargo自动生成，锁定依赖库的精确版本，保证不同机器编译结果一致。

## 基础完整示例
```toml
[package]
name = "my_gis_demo"
version = "0.1.0"
edition = "2021"
description = "简单的GIS瓦片工具demo"
license = "MIT"

[dependencies]
# 普通依赖，直接写库名 = "版本"
versatiles = "0.12"
martin = "0.11"
tokio = { version = "1.0", features = ["full"] }

[dev-dependencies]
# 仅开发、单元测试才会引入，打包发布不会带进去
criterion = "0.5"

[profile.release]
# release编译配置
opt-level = 3
debug = false
```

## 分块详解
### 1. `[package]` 项目元数据（必选）
```toml
[package]
name = "demo"       # 项目名字，crates.io发布时的包名，只能字母、数字、下划线
version = "0.2.1"   # 语义化版本 major.minor.patch
edition = "2021"    # Rust版本：2018 / 2021，决定编译器语法特性
description = ""    # 包描述，发布用
license = "MIT"     # 开源协议
authors = ["xxx <xxx@mail.com>"]
```
- `edition` **非常关键**：不同edition语法有差异，新项目一律写`2021`。

### 2. `[dependencies]` 运行时依赖
项目编译运行需要的第三方库。

几种写法：
```toml
# 写法1：最简单，兼容该大版本下最新小版本
martin = "0.11"

# 写法2：指定features，开启库的可选功能（Rust很常用！很多库功能是feature开关）
tokio = { version = "1.0", features = ["rt‑multi‑thread", "macros"] }

# 写法3：本地路径依赖（本地未发布的库，本地开发调试）
my_lib = { path = "../my_lib" }

# 写法4：github直接拉仓库代码
versatiles = { git = "https://github.com/versatiles‑org/versatiles‑rs" }
```
> Rust没有全局系统库，**所有依赖全部写在Cargo.toml**，cargo自动下载。

### 3. `[dev‑dependencies]` 开发依赖
只在 `cargo test` / `cargo bench` 使用，**正式构建release二进制不会打包进去**。
比如单元测试库、压测库。

### 4. `[build‑dependencies]` 构建阶段依赖
仅编译构建过程使用，运行程序不需要。比如代码生成工具。

### 5. `[profile.*]` 编译配置
两套默认profile：`dev`(cargo run 默认)、`release`(cargo build --release)
```toml
[profile.release]
opt‑level = 3   # 优化等级0~3，数字越大优化越强，编译更慢
debug = false   # 是否携带调试符号
lto = true      # 链接时优化，二进制更小速度更快（GIS工具经常打开）
```

### 6. `[bin]` / `[lib]` 产出配置
- `[lib]`：控制库怎么编译
- `[[bin]]`：可以定义多个可执行程序，一个项目输出多个exe
```toml
[[bin]]
name = "gis_server"
path = "src/main.rs"
```

## 高频实操命令 和Cargo.toml关系
```bash
cargo add martin        # 自动把martin写入Cargo.toml的[dependencies]
cargo add --dev pretty_assertions # 写入dev‑dependencies
cargo remove martin     # 删除依赖
cargo build             # 读取toml，下载依赖，编译
cargo run               # 编译并运行
cargo test              # 包含dev‑dependencies执行单元测试
cargo build --release   # 使用[profile.release]配置编译
```

## 容易踩坑点
1. **features**：很多Rust库默认关闭大部分能力，需要手动开启feature，比如GIS库数据库支持，不开启就没有PostGIS功能。
2. `Cargo.lock`：应用程序项目提交git；**库项目不要提交lock文件**。
3. 版本号 `"0.11"` 含义：兼容 `0.11.x`，不会升级到0.12；Rust语义化版本0.x大版本改动视为破坏性变更。
4. 不要手动修改`Cargo.lock`，全部交给cargo工具维护。

如果你需要，我可以拿 Martin / Versatiles 的真实Cargo.toml片段给你看GIS项目真实写法。

================================================

# 2.下面的versatiles‑rs的Cargo.toml 采用了workspace,请讲解这种模式的Cargo.toml
```toml
[workspace]
members = [
	"versatiles",
	"versatiles_container",
	"versatiles_core",
	"versatiles_derive",
	"versatiles_geometry",
	"versatiles_image",
	"versatiles_node",
	"versatiles_pipeline",
]
resolver = "2"

[workspace.package]
authors = ["Michael Kreil <versatiles@michael-kreil.de>"]
categories = [
	"command-line-utilities",
	"science::geo",
	"web-programming::http-server",
]
description = "A toolbox for converting, checking and serving map tiles in various formats."
edition = "2024"
homepage = "https://versatiles.org"
keywords = ["versatiles", "mbtiles", "pmtiles", "tiles", "map"]
license = "MIT"
readme = "README.md"
repository = "https://github.com/versatiles-org/versatiles-rs"
version = "4.6.1"
exclude = [
	".githooks/",
	".github/",
	".gitignore",
	".prettierignore",
	".vscode/",
	"/docker",
	"/scripts",
	"/testdata",
]

[workspace.lints.rust]
unused_imports = "deny"
unexpected_cfgs = { level = "warn", check-cfg = ['cfg(coverage)'] }

[workspace.lints.clippy]
# Enable pedantic lints for code quality
pedantic = { level = "deny", priority = -1 }

# Allow noisy/stylistic lints that don't improve safety
missing_errors_doc = "allow"
missing_panics_doc = "allow"
module_name_repetitions = "allow"
similar_names = "allow"
doc_markdown = "allow"

# Warn when return values should have #[must_use]
must_use_candidate = "deny"

# Allow reasonable casting patterns in container code
cast_precision_loss = "allow"

# Allow stylistic patterns used consistently in codebase
duration_suboptimal_units = "allow"
ignored_unit_patterns = "allow"
items_after_statements = "allow"
iter_without_into_iter = "allow"
match_wildcard_for_single_variants = "allow"
missing_fields_in_debug = "allow"
return_self_not_must_use = "allow"
trivially_copy_pass_by_ref = "allow"
unnecessary_debug_formatting = "allow"
unnecessary_literal_bound = "allow"
unnecessary_wraps = "allow"
unreadable_literal = "allow" # Domain-specific values (coordinates, binary test data) are clearer without separators
used_underscore_binding = "allow"

[workspace.metadata.release]
allow-branch = ["main"]
consolidate-commits = true
dependent-version = "upgrade"
pre-release-commit-message = "release: v{{version}}"
shared-version = true
sign-commit = true
sign-tag = true
tag-name = "v{{version}}"

[profile.dev]
opt-level = 1
debug = true
rpath = false
lto = false
debug-assertions = true
panic = "unwind"
incremental = true
overflow-checks = true

[profile.test]
opt-level = 1
lto = false
incremental = true

[profile.release]
opt-level = 3
debug = false
rpath = false
lto = true
debug-assertions = false
codegen-units = 1
panic = "unwind"
incremental = false
overflow-checks = false
strip = true

[workspace.dependencies]
# Core dependencies
anyhow = { version = "1.0.104", default-features = false, features = ["std"] }
async-trait = { version = "0.1.91", default-features = false }
byteorder = { version = "1.5.0", default-features = false, features = ["std"] }
enumset = { version = "1.1.14", default-features = false }
futures = { version = "0.3.33", features = ["default"] }
itertools = { version = "0.15.0", default-features = false }
log = { version = "0.4.33", default-features = false }
num_cpus = { version = "1.17.0", default-features = false }
regex = { version = "1.13.1", default-features = false, features = [
	"std",
	"unicode-case",
	"unicode-perl",
] }
serde = { version = "1.0.229", features = ["derive"] }
tokio = { version = "1.53.1", features = ["rt-multi-thread", "sync"] }

# CLI dependencies
clap = { version = "4.6.4", features = ["default", "derive", "wrap_help"] }
env_logger = { version = "0.11.11" }

# Container/archive dependencies
tar = { version = "0.4.46", default-features = false }

# HTTP/Server dependencies
axum = { version = "0.8.9", default-features = false }
reqwest = { version = "0.13.4", default-features = false, features = ["default-tls"] }

# Image processing dependencies
imageproc = { version = "0.27.0", default-features = false }

# Geometry dependencies
geo = { version = "0.33.1" }
geo-types = { version = "0.7.19" }
rstar = { version = "0.13.0", default-features = false }

# Utility dependencies
wildmatch = { version = "2.6.1", default-features = false }

# Multithreading optimization dependencies
moka = { version = "0.12", features = ["future"] }  # Lock-free LRU cache
dashmap = "6.2"                                     # Concurrent HashMap
parking_lot = "0.12"                                # Fast synchronization
arc-swap = "1.9"                                    # Lock-free updates

# Development dependencies
approx = { version = "0.5.1", default-features = false, features = ["std"] }
assert_fs = "1.1.4"
pretty_assertions = "1.4.1"
rstest = { version = "0.26.1", default-features = false }
tempfile = "3.27.0"

versatiles = { version = "4.6.1", path = "versatiles", default-features = false }
versatiles_container = { version = "4.6.1", path = "versatiles_container", default-features = false }
versatiles_core = { version = "4.6.1", path = "versatiles_core", default-features = false }
versatiles_derive = { version = "4.6.1", path = "versatiles_derive", default-features = false }
versatiles_geometry = { version = "4.6.1", path = "versatiles_geometry", default-features = false }
versatiles_image = { version = "4.6.1", path = "versatiles_image", default-features = false }
versatiles_pipeline = { version = "4.6.1", path = "versatiles_pipeline", default-features = false }
```

### workspace 模式整体概念
Rust Workspace（工作空间）用来管理**一个仓库下多个相互关联的子crate（子包）**，versatiles‑rs 就是典型多crate单体仓库：顶层`Cargo.toml`是工作空间根配置，每个members下面的子目录，各自包含一份独立的`Cargo.toml`子配置。
所有子crate共享顶层workspace的依赖、版本、编译配置、lint规则，避免大量重复拷贝配置，子包之间可以互相引用。

### [workspace]
```toml
[workspace]
members = [
	"versatiles",
	"versatiles_container",
	"versatiles_core",
	"versatiles_derive",
	"versatiles_geometry",
	"versatiles_image",
	"versatiles_node",
	"versatiles_pipeline",
]
resolver = "2"
```
- `members`：声明工作空间包含哪些子crate，值为子目录相对路径，每个目录内部必须存在自己的`Cargo.toml`。
- `resolver = "2"`：使用Cargo新版依赖解析算法，解决依赖feature冲突问题，Rust项目workspace几乎都开启。

> 目录结构示意
```
versatiles‑rs/
├─ Cargo.toml       # workspace根文件
├─ versatiles/      # 子crate，内部有Cargo.toml
├─ versatiles_core/ # 子crate，内部有Cargo.toml
└─ ...
```

### [workspace.package]
这是**工作空间共享包元数据**，子crate的`Cargo.toml`中可以写`inherit = "workspace"`，直接继承这里全部字段，不需要每个子包重复写`version`、`edition`、`license`、`authors`。
- `version = "4.6.1"`：所有子crate统一版本号，这是monorepo常用方式，所有组件同步升级。
- `edition = "2024"`：统一Rust语言版本。
- `authors / license / repository / homepage / keywords`：发布crates.io需要的元信息，全部统一在这里。
- `exclude`：发布包时需要排除的目录，测试数据、脚本、github配置不打包上传。

> 子crate内Cargo.toml示例片段
```toml
[package]
name = "versatiles_core"
inherit = "workspace"
```
只写name，其余全部继承顶层`workspace.package`。

### [workspace.lints.rust] 与 [workspace.lints.clippy]
统一全局代码检查规则，**全部子crate自动继承**，不用每个子包重复写lint配置。
- `deny`：当成编译错误，不允许代码出现这类问题；
- `warn`：编译警告，不阻断编译；
- `allow`：关闭这条检查，忽略该类提示。

`[workspace.lints.rust]` 是rustc原生编译器检查；`[workspace.lints.clippy]`是clippy静态分析工具。
versatiles这里开启`pedantic = "deny"`做严格质量校验，同时把部分过于繁琐、不适合GIS项目的规则设置为`allow`放行。

### [workspace.metadata.release]
不属于cargo原生配置，是第三方工具 `cargo‑release` 的元数据，用于自动化发布版本：
- `shared‑version = true`：workspace所有子crate版本保持同步；
- `allow‑branch = ["main"]`：只允许在main分支执行版本发布；
- `sign‑commit / sign‑tag`：GPG签名提交和tag；
- `dependent‑version = "upgrade"`：子包互相依赖时，版本号跟随自动升级。

### profile 编译配置（[profile.dev] / [profile.test] / [profile.release]）
写在workspace根目录，**全局生效，所有子crate编译共用这套编译参数**。
- `[profile.dev]`：`cargo run / cargo build` 默认开发模式；`opt‑level=1`适度优化，保留调试信息，编译速度快。
- `[profile.test]`：`cargo test`执行单元测试的编译配置。
- `[profile.release]`：`cargo build --release`生产构建；`lto=true`、`codegen‑units=1`开启强链接时优化；`strip=true`直接剥离二进制调试符号，缩小程序体积，GIS服务类项目常用。

> 子crate也可以在自己toml覆盖profile，优先级子包高于workspace。

### [workspace.dependencies]
workspace最核心能力：**统一管理所有子crate用到的第三方依赖，子包通过`inherit = "workspace"`引用，版本只写一次**。

分为两类：
1. 外部第三方依赖：`anyhow`、`tokio`、`axum`、`geo`等，在这里统一锁版本、配置features。
2. 内部子crate互相依赖：
```toml
versatiles_core = { version = "4.6.1", path = "versatiles_core" }
```
子crate之间互相调用，直接引用workspace里定义好的内部包。

子crate的Cargo.toml里面写法示例：
```toml
[dependencies]
anyhow = { inherit = "workspace" }
versatiles_core = { inherit = "workspace" }
```
不需要写版本、path、features，全部继承顶层`workspace.dependencies`，版本变更只需要修改顶层一处，不会出现各个子包版本不一致。

### 子crate的Cargo.toml极简示例（versatiles_core/Cargo.toml）
```toml
[package]
name = "versatiles_core"
inherit = "workspace"

[dependencies]
anyhow = { inherit = "workspace" }
geo = { inherit = "workspace" }
```

### workspace模式优缺点（versatiles项目体现）
#### 优点
- 多crate项目，版本、依赖、lint、编译配置集中维护，避免复制粘贴；
- 子crate之间本地路径引用，本地开发不需要发布到crates.io，直接互相调用；
- 可以整体执行`cargo build`、`cargo test`，一次性编译全部子包；
- 统一版本号，适合monorepo架构，versatiles把功能拆成core、geometry、image、pipeline多个crate做模块拆分。

#### 注意点
1. 顶层workspace的`[workspace.dependencies]`只是依赖定义，**不会自动引入**；子crate必须显式写`inherit = "workspace"`才会真正使用该依赖。
2. `Cargo.lock`生成在workspace根目录，所有子crate共用同一个lock文件。
3. 如果子crate需要某个依赖特殊feature，可以在子包toml局部覆盖，会覆盖workspace的配置。

### 常用workspace命令
```bash
# 在仓库根目录执行，编译全部子crate
cargo build
# 运行全部子crate单元测试
cargo test
# 只编译其中一个子crate
cargo build -p versatiles_core
# 给workspace添加第三方依赖（写入顶层workspace.dependencies）
cargo add anyhow --workspace
```

如果你需要，我可以对比：workspace模式 vs 普通单crate项目，以及说明GIS项目什么场景适合拆 workspace 。