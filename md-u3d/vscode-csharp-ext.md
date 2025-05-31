# 1.vscode 安装新版C#插件问题(c# Language & c# Dev Kit Extension...)
## 1.1 .NET SDK Download timeout
安装新版c#插件 遇到 自动下载超时 无法自动下载

## 1.2解决方法
手动安装SDK 指向本地已经存在的SDK
.NET SDK download webpage:  https://dotnet.microsoft.com/en-us/download/dotnet
   
dotnet-sdk-9.0 download link: https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.203/dotnet-sdk-9.0.203-linux-x64.tar.gz


## 1.3 步骤

在setting中搜索 配置项 existingDotnetPath 进入setting.json中
添加 指定哪几个扩展需要指向本地的sdk

Tip: 个人遇到的是安装 "C#" 插件 和 "C# Dev Kit" 这两个插件都会出现自动下载的问题
所以这两个插件 需要在下面这个配置项中配置

```json in windows
{
    "dotnetAcquisitionExtension.existingDotnetPath": [
    {
      "extensionId": "ms-dotnettools.csharp",
      "path": "C:\\Program Files\\dotnet\\dotnet.exe"
    },
    {
      "extensionId": "ms-dotnettools.csdevkit",
      "path": "C:\\Program Files\\dotnet\\dotnet.exe"
    }
  ]
}
```

[linux settings.json]( ~/.config/Code/User/settings.json ) 

```json linux
{
    "terminal.integrated.inheritEnv": false,
    "makefile.configureOnOpen": true,
    "editor.minimap.renderCharacters": false,
    "security.workspace.trust.untrustedFiles": "open",
    "grunt.autoDetect": "on",
    "omnisharp.dotnetPath": "/home/abner/programs/dotnet-sdk/dotnet-sdk-9.0.203",
 
    "dotnetAcquisitionExtension.sharedExistingDotnetPath": "/home/abner/programs/dotnet-sdk/dotnet-sdk-9.0.203",
    "dotnetAcquisitionExtension.allowInvalidPaths":true,
    "dotnetAcquisitionExtension.existingDotnetPath": [ 
         
         {
            "extensionId": "ms-dotnettools.csharp",
            "path": "/home/abner/programs/dotnet-sdk/dotnet-sdk-9.0.203/dotnet"
          },
          {
            "extensionId": "ms-dotnettools.csdevkit",
            "path": "/home/abner/programs/dotnet-sdk/dotnet-sdk-9.0.203/dotnet"
          }         
    ],
    "omnisharp.monoPath": "/home/abner/programs/dotnet-sdk/dotnet-sdk-9.0.203" 
}
```


验证配置是否生效
控制台中可以看到log 在尝试下载时 读取到配置后 就没有再尝试下载了

原文：

Downloading the .NET Runtime.
Using configured .NET path: C:\Program Files\dotnet\dotnet.exe
Downloading the .NET Runtime.
Using configured .NET path: C:\Program Files\dotnet\dotnet.exe
后续就可以正常使用了，可以发现项目已经 自动还原nuget包了
## 1.4 参考

[在VSCode中开始使用C#](https://vscode.github.net.cn/docs/csharp/get-started)

<++++++++++++++++++++++++++++++++++++++++++++++++++++++>
========================================================
# 2.VSCode C#项目 开发步骤
在Ubuntu上使用VSCode开发C#项目的步骤如下，包含环境配置、项目创建、调试等核心环节：


### **1. 安装必要工具**
```bash
# 安装 .NET SDK（支持 C# 编译运行）
sudo apt-get update
sudo apt-get install -y dotnet-sdk-7.0  # 根据需要选择版本

# 安装 Visual Studio Code
sudo snap install --classic code

# 安装 C# 扩展（在 VSCode 中操作）
# 1. 打开 VSCode
# 2. 按 Ctrl+Shift+X 打开扩展面板
# 3. 搜索 "C#" 并安装 "C# for Visual Studio Code"
```


### **2. 创建 C# 项目**
#### **方式1：使用命令行创建**
```bash
# 创建控制台应用
dotnet new console -n MyConsoleApp
cd MyConsoleApp

# 创建类库项目
dotnet new classlib -n MyClassLibrary

# 创建 ASP.NET Core Web 应用
dotnet new web -n MyWebApp
```

#### **方式2：通过 VSCode 创建**
1. 打开 VSCode，按 `Ctrl+Shift+P` 打开命令面板
2. 输入 `>.NET: New Project`
3. 选择项目模板（如 Console App）
4. 指定项目名称和位置


### **3. 打开项目并编辑代码**
1. 在 VSCode 中打开项目文件夹：
   ```bash
   code .  # 在当前目录打开 VSCode
   ```

2. 主要文件结构：
   - `Program.cs`：程序入口点（控制台应用）
   - `.csproj`：项目配置文件
   - `obj/` 和 `bin/`：编译输出目录


### **4. 配置调试环境**
1. 按 `F5` 或点击左侧调试图标
2. 选择 `.NET Core` 环境
3. VSCode 会自动生成 `.vscode/launch.json` 和 `.vscode/tasks.json`
4. 示例 `launch.json`（控制台应用）：
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": ".NET Core Launch (console)",
      "type": "coreclr",
      "request": "launch",
      "preLaunchTask": "build",
      "program": "${workspaceFolder}/bin/Debug/net7.0/MyConsoleApp.dll",
      "args": [],
      "cwd": "${workspaceFolder}",
      "console": "internalConsole",
      "stopAtEntry": false
    }
  ]
}
```


### **5. 编译和运行项目**
#### **方式1：使用命令行**
```bash
dotnet build    # 编译项目
dotnet run      # 运行项目
```

#### **方式2：使用 VSCode 调试**
1. 在代码中设置断点（点击行号左侧）
2. 按 `F5` 启动调试
3. 使用调试工具栏（继续、暂停、单步执行等）


### **6. 管理 NuGet 包**
1. 打开命令面板：`Ctrl+Shift+P`
2. 输入 `>.NET: Manage NuGet Packages`
3. 选择项目
4. 搜索并安装所需包（如 `Newtonsoft.Json`）
   ```bash
   # 或通过命令行安装
   dotnet add package Newtonsoft.Json
   ```


### **7. 常见项目类型配置**
#### **ASP.NET Core Web 应用**
- 默认启动配置会自动创建
- 访问 `http://localhost:5000` 测试应用

#### **类库项目**
- 需创建引用该类库的客户端项目（如控制台应用）
- 在客户端项目中添加引用：
  ```bash
  dotnet add reference ../MyClassLibrary/MyClassLibrary.csproj
  ```


### **8. 推荐扩展**
- **C# Extensions**：提供代码生成、重构等功能
- **NuGet Package Manager**：可视化管理 NuGet 包
- **.NET Core Test Explorer**：运行和调试单元测试
- **Code Runner**：快速运行代码片段
- **GitLens**：增强 Git 集成


### **9. 故障排除**
- **无法找到 SDK**：
  ```bash
  # 检查 SDK 是否已安装
  dotnet --list-sdks
  ```

- **调试器无法启动**：
  1. 确保 `launch.json` 配置正确
  2. 尝试删除 `.vscode` 文件夹并重新生成
  3. 检查项目能否通过 `dotnet build` 编译


按照以上步骤，你可以在 Ubuntu 上高效地使用 VSCode 开发 C# 项目。如需特定类型项目（如 Web API、EF Core）的详细配置，可以进一步说明！