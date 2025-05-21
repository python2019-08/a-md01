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
