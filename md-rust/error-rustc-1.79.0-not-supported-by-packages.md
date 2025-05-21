# 1.error: rustc 1.79.0 is not supported by the following packages

```sh
$ cargo run -p maplibre-demo
error: rustc 1.79.0 is not supported by the following packages:
  home@0.5.11 requires rustc 1.81
  icu_collections@2.0.0 requires rustc 1.82
  icu_locale_core@2.0.0 requires rustc 1.82
  icu_normalizer@2.0.0 requires rustc 1.82
```  
你遇到的错误是由于项目依赖的某些Crate需要比你当前使用的Rust编译器更新的版本。具体来说，`maplibre-demo`项目依赖的几个包（如`home`、`icu_*`）要求Rust编译器至少为**1.82.0**版本，而你当前使用的是**1.79.0**。


### **解决方案**

#### 1. **升级Rust编译器到最新稳定版**
使用`rustup`（Rust的版本管理工具）升级：
```bash
rustup update stable
```
升级后检查版本：
```bash
rustc --version
```
确保输出为`rustc 1.82.0`或更高。


#### 2. **使用nightly版本（临时方案）**
如果升级稳定版仍无法满足依赖，可以尝试使用nightly版本：
```bash
rustup install nightly
cargo +nightly run -p maplibre-demo
```


#### 3. **指定工具链版本（Cargo.toml）**
在项目根目录创建`rust-toolchain.toml`文件，指定所需的Rust版本：
```toml
# rust-toolchain.toml
[toolchain]
channel = "1.82.0"  # 或 "stable"
```


#### 4. **降级依赖版本**
如果无法升级Rust，可以尝试降低依赖版本。编辑项目的`Cargo.toml`，指定兼容的版本范围：
```toml
[dependencies]
home = "0.5.10"  # 使用兼容rustc 1.79的版本
icu_collections = "1.9.0"  # 降低到兼容版本
# 其他依赖...
```
然后更新锁文件：
```bash
cargo update
```


#### 5. **使用Rust固定版本（Rustfix）**
如果依赖的Crate有兼容旧版本Rust的分支，可以通过`Cargo.toml`指定：
```toml
[dependencies]
home = { git = "https://github.com/rust-lang/home.git", branch = "compatible-branch" }
```


### **为什么会出现这个问题？**
Rust的Crate生态遵循**SemVer**（语义化版本），新版本可能引入对更新Rust编译器的依赖：
- **edition 2021**：Rust 2021版需要至少**1.56.0**。
- **min_rust_version**：Crate可指定最低支持的Rust版本。
- **新语言特性**：某些Crate可能使用了较新版本Rust的特性。


### **推荐做法**
1. **保持Rust更新**：定期运行`rustup update`以避免版本冲突。
2. **使用工具链文件**：在项目中添加`rust-toolchain.toml`确保团队成员使用一致的版本。
3. **检查依赖兼容性**：在添加新依赖前，查看其文档或Crate页面的`min_rust_version`。

通过以上方法，你应该能解决版本不兼容问题。如果仍然遇到困难，建议查看项目的GitHub仓库是否有关于Rust版本要求的说明，或提交issue寻求帮助。

===============================================================
# 2.rustup update stable

```sh
$ rustup update stable
info: syncing channel updates for 'stable-x86_64-unknown-linux-gnu'

  stable-x86_64-unknown-linux-gnu unchanged - rustc 1.86.0 (05f9846f8 2025-03-31)

info: checking for self-update
```
看起来你的Rust编译器已经成功更新到最新的稳定版本（1.86.0），这应该能解决之前的版本兼容性问题。接下来你可以尝试重新运行项目：

```bash
cargo clean  # 清除之前的构建缓存
cargo run -p maplibre-demo
```

如果仍然遇到问题，可能是因为：

1. **缓存问题**：有时候旧的依赖会被缓存，可以尝试删除`target`目录和`Cargo.lock`文件后重新构建：
   ```bash
   rm -rf target
   rm Cargo.lock
   cargo build
   ```

2. **项目本地工具链冲突**：检查项目根目录下是否有`rust-toolchain`或`rust-toolchain.toml`文件，如果有，确保其内容与你当前使用的Rust版本一致。

3. **依赖版本锁定**：某些依赖可能被锁定在不兼容的版本，可以尝试更新所有依赖：
   ```bash
   cargo update
   ```

4. **特定依赖的兼容性**：如果某个依赖特别顽固，可以尝试在`Cargo.toml`中指定兼容的版本范围，例如：
   ```toml
   [dependencies]
   home = ">=0.5.11,<0.6.0"  # 根据实际兼容性调整
   ```

如果问题仍然存在，请提供具体的错误信息，我们可以进一步诊断问题所在。

=============================================================
# 3.但是 “rustc 1.79.0 (129f3b996 2024-06-10)”
```sh
$ rustc -V
rustc 1.79.0 (129f3b996 2024-06-10)
```
根据你的输出，尽管执行了 `rustup update stable`，但 `rustc -V` 仍显示旧版本（1.79.0）。这表明你的系统可能存在 Rust 版本管理冲突。以下是详细的排查步骤：


### **问题原因分析**
1. **多 Rust 安装共存**：系统中可能同时存在通过 `rustup` 和其他方式（如包管理器）安装的 Rust。
2. **环境变量冲突**：`PATH` 环境变量可能优先指向旧版本的 Rust。
3. **本地工具链覆盖**：项目目录下的 `rust-toolchain` 或 `rust-toolchain.toml` 文件可能指定了旧版本。


### **解决方案**

#### 1. **检查并清理非 `rustup` 的 Rust 安装**
如果你通过其他方式（如 `apt`、`yum` 或直接下载）安装过 Rust，请卸载它们：
```bash
# Ubuntu/Debian
sudo apt remove rustc cargo

# CentOS/RHEL
sudo yum remove rustc cargo

# macOS (Homebrew)
brew uninstall rust
```

#### 2. **验证 `rustup` 工具链**
确保 `rustup` 正确管理你的 Rust 版本：
```bash
rustup show  # 显示当前活动的工具链

# 手动切换到稳定版
rustup default stable
```

#### 3. **检查环境变量**
确保 `PATH` 中 `rustup` 的路径优先。在终端中执行：
```bash
echo $PATH
```
确认输出中包含类似 `/home/your_username/.cargo/bin` 的路径，且排在其他 Rust 路径之前。

如果路径不正确，编辑你的 shell 配置文件（如 `~/.bashrc`、`~/.zshrc`），添加：
```bash
export PATH="$HOME/.cargo/bin:$PATH"
```
然后重启终端或执行：
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

#### 4. **查找并删除本地工具链文件**
检查项目根目录或上级目录是否存在 `rust-toolchain` 或 `rust-toolchain.toml` 文件：
```bash
find . -name "rust-toolchain*"  # 在当前目录及子目录中查找
```
如果找到，删除或修改这些文件以匹配所需版本。

#### 5. **重新安装 `rustup`**
如果以上方法无效，尝试彻底卸载并重新安装 `rustup`：
```bash
# 卸载
rustup self uninstall

# 重新安装（按照提示操作）
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```


### **验证修复结果**
```bash
rustc -V  # 应显示 rustc 1.86.0 (05f9846f8 2025-03-31)
which rustc  # 应输出类似 /home/your_username/.cargo/bin/rustc
```

如果仍然显示旧版本，请提供 `rustup show` 和 `echo $PATH` 的输出，以便进一步分析。

=============================================================
# 4.active because: overridden by 'maplibre-rs/rust-toolchain.toml'

```sh
$ rustup show 
Default host: x86_64-unknown-linux-gnu
rustup home:  /home/abner/.rustup

installed toolchains
--------------------
stable-x86_64-unknown-linux-gnu (default)
1.79-x86_64-unknown-linux-gnu (active)

active toolchain
----------------
name: 1.79-x86_64-unknown-linux-gnu
active because: overridden by '/mnt/disk2/abner/zdev/rust/maplibre-rs/rust-toolchain.toml'
installed targets:
  x86_64-unknown-linux-gnu
```

问题找到了！根据 `rustup show` 的输出，虽然默认工具链是 **stable (1.86.0)**，但当前项目被 `/mnt/disk2/abner/zdev/rust/maplibre-rs/rust-toolchain.toml` 文件覆盖为 **1.79.0**。这就是为什么你执行 `cargo run` 时仍然使用旧版本的原因。


### **解决方案**

#### 1. **临时覆盖项目工具链**
在命令行中强制使用 stable 版本：
```bash
cargo +stable run -p maplibre-demo
```
这会忽略项目的 `rust-toolchain.toml` 设置。


#### 2. **修改项目的工具链配置**
编辑 `/mnt/disk2/abner/zdev/rust/maplibre-rs/rust-toolchain.toml` 文件，将版本改为兼容的版本（如 1.86.0）：
```toml
# rust-toolchain.toml
[toolchain]
channel = "stable"  # 或直接写 "1.86.0"
```


#### 3. **移除项目工具链覆盖**
如果你不需要为这个项目单独指定版本，可以删除该文件：
```bash
rm /mnt/disk2/abner/zdev/rust/maplibre-rs/rust-toolchain.toml
```


### **验证修改结果**
再次检查当前工具链：
```bash
rustup show
```
应该显示：
```
active toolchain
----------------
stable-x86_64-unknown-linux-gnu (default)
```

然后重新运行项目：
```bash
cargo clean  # 清除缓存
cargo run -p maplibre-demo
```


### **为什么会出现这个问题？**
- **项目特定需求**：有些项目需要特定版本的 Rust 来保证兼容性。
- **版本锁定**：`rust-toolchain.toml` 会强制项目使用指定版本，即使全局默认版本不同。
- **团队协作**：为确保所有开发者使用相同的工具链，项目可能会包含此文件。

通过上述修改，你可以解决版本冲突并顺利编译项目。