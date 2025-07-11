# 1 .ubuntu  cursor

在Ubuntu上安装Cursor编辑器可通过下载AppImage文件并赋予执行权限完成，具体步骤包括下载、授权、运行及可选配置桌面快捷方式。
## ‌下载Cursor AppImage文件‌
访问Cursor官网（https://www.cursor.com/en/download），选择Linux版本的AppImage文件下载。‌‌ 
根据系统架构选择x86_64或ARM版本，建议保存到~/Downloads或/opt目录。‌‌
 
## ‌***授权与运行‌***

1.打开终端，进入下载目录，执行以下命令赋予执行权限：
```bash 
chmod +x Cursor-*.AppImage
```‌‌

2. 直接运行（需添加--no-sandbox参数以避免报错）：

```bash
./Cursor-*.AppImage --no-sandbox
```‌‌
 

##  ‌可选配置‌

1.‌创建桌面快捷方式‌：
编辑.desktop文件（示例路径：/usr/share/applications/cursor.desktop），内容如下：
```ini 
[Desktop Entry]
Name=Cursor
Exec=/path/to/Cursor.AppImage --no-sandbox
Icon=/opt/cursor.png
Type=Application
Categories=Development;
‌‌``` 
2. ‌解决依赖问题‌：

若运行报错，需安装libfuse2（Ubuntu 22.04及以上版本）：
```bash 
sudo apt update && sudo apt install libfuse2
```