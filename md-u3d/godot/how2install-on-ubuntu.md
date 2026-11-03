# Ubuntu 安装 Godot4
> Godot Linux 本质是**单文件可执行程序，不需要传统安装**，下载解压直接运行。
> 两个版本区分：
> - **Standard标准版**：只支持GDScript
> - **.NET版本**：支持GDScript + C#，体积更大

## 官方二进制包（最推荐，自由度最高，适合开发、切换版本）
1. 先安装系统依赖（Ubuntu22.04/24.04）
```bash
sudo apt update
sudo apt install libxcursor1 libxinerama1 libxi6 libxrandr2 libgl1 libvulkan1 mesa-vulkan-drivers unzip wget
```
> NVIDIA显卡务必装好官方闭源驱动，否则Vulkan后端会报错无法启动Godot4。

2. 去官网下载：https://godotengine.org/download/linux/
- x86_64 Linux：标准版 / .NET版二选一，下载zip压缩包。

3. 解压，赋予执行权限
```bash
unzip Godot_v4.x.x-stable_linux.x86_64.zip
chmod +x Godot_v4.x.x-stable_linux.x86_64
./Godot_v4.x.x-stable_linux.x86_64
```

4.（可选）放到系统PATH全局调用
```bash
mv Godot_v4.x.x-stable_linux.x86_64 ~/.local/bin/godot
godot # 终端任意位置直接启动
```

> 如果用**.NET版本**，系统还需要安装 dotnet‑sdk‑8.0：
```bash
sudo apt install dotnet-sdk-8.0
```
 
---

## 常见问题
1. **Godot4打不开、报Vulkan错误**
检查显卡驱动：
```bash
vulkaninfo
```
NVIDIA显卡不要使用开源nouveau驱动，安装专有NVIDIA驱动。

2. `.NET版本报错找不到hostfxr`
Ubuntu源自带dotnet路径和Godot预期路径不一致，建议用微软官方dotnet‑install.sh脚本安装.NET SDK 8.0。

3. headless无界面导出项目
```bash
godot --headless --export‑release "Linux" project.godot
```

## 选型建议
- 做开发、需要GDExtension C++扩展、经常切换版本 → **官方zip二进制包**
- 只想快速用，不想管更新 → Flatpak
- 尽量避开Snap版本，存在不少沙盒兼容性问题。

如果你需要，我可以简单演示：**Godot‑as‑library** 在Ubuntu编译的大体步骤。