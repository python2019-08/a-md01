
# Ubuntu 24.04 中文输入法安装（两种方案）
Ubuntu24.04 默认GNOME+Wayland，分 **IBus（新手最简单，系统原生）**、**Fcitx5（流畅、自定义强，推荐重度打字）**

## 方案一：IBus 智能拼音（零折腾，新手首选）
### 1. 安装依赖
```bash
sudo apt update
sudo apt install ibus-libpinyin ibus-wayland ibus-gtk4 -y
```

### 2. 安装中文语言包（必做）
打开 设置 → 区域与语言 → 管理已安装语言
点击「安装」补全语言包；
勾选 `Chinese (simplified)` 简体中文，应用安装。



### 3. 添加中文输入源
设置 → 键盘 → 输入源 → 点「+」
选择 **中文(中国) → Chinese(Intelligent Pinyin) 智能拼音**



### 4. 使用切换
- 全局切换快捷键：`Super + 空格`（Win键+空格）
- 中英文切换：`Shift`

### 常见问题
VS Code/浏览器不出候选框：注销重新登录即可。

---

## 方案二：Fcitx5 输入法（Wayland完美兼容，推荐）
优势：云拼音、模糊音、词库自学习、VS Code/Electron软件无兼容bug
### 1. 一键安装全套
```bash
sudo apt update
sudo apt install -y fcitx5 fcitx5-chinese-addons fcitx5-frontend-all fcitx5-config-qt fcitx5-module-cloudpinyin
```

### 2. 配置系统默认输入法框架
1. 打开「管理已安装语言」
底部 **键盘输入法系统** 从IBus改为 `Fcitx 5`，应用到整个系统



2. 写入环境变量（关键，否则软件无法调用）
```bash
gedit ~/.pam_environment
```
粘贴下面4行（等号**不能加空格**）：
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```
保存关闭，**注销并重新登录**。

### 3. 添加拼音输入法
终端打开配置面板：
```bash
fcitx5-configtool
```
右侧可用输入法找到「拼音」，点左箭头添加到左侧启用列表



### 4. 切换快捷键设置
在「全局选项」自定义切换：
- 切换输入法：`Ctrl + 空格`
- 中英文：`Shift`



### 5. 启用云拼音联想
右键右上角托盘fcitx5图标 → 配置 → 附加组件 → 开启云拼音，重启fcitx5生效。

---

## 补充：中州韵Rime（Fcitx5下最强输入，五笔/全拼/双拼）
适合需要高度自定义词库用户
```bash
sudo apt install fcitx5-rime
```
在fcitx5-configtool添加「中州韵」，可搭配雾凇词库。

## 避坑提醒
1. Ubuntu24.04不建议装旧版搜狗fcitx4，Wayland下大量兼容崩溃；
2. 修改输入法框架/环境变量后，**必须注销重登**，只重启软件无效；
3. IBus和Fcitx5不要同时启用，会冲突。

## 卸载切换方案
### 卸载Fcitx5切回IBus
```bash
sudo apt purge fcitx5*
rm ~/.pam_environment
```
语言支持里把输入法系统改回IBus，注销登录。

=====================================================

# Ubuntu24.04 fcitx5开机不自启完整修复方案（按顺序操作）
## 一、先清理冲突：彻底禁用ibus（根源冲突）
ibus和fcitx5共存会抢占输入法服务，导致fcitx5无法自启
```bash
sudo apt purge ibus* -y
systemctl --user stop ibus
systemctl --user disable ibus
```

## 二、用im-config把系统输入法框架强制设为fcitx5
```bash
im-config -n fcitx5
```
弹出窗口直接选 `fcitx5`，确认。

## 三、修复环境变量（Ubuntu24.04 pam_env有坑，双保险配置）
### 方案A：写入 ~/.profile（推荐，Wayland登录必加载）
```bash
gedit ~/.profile
```
在文件末尾粘贴：
```bash
# Fcitx5 输入法环境变量
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx
# 登录自动启动fcitx5
fcitx5 -d --replace &
```
保存关闭，执行生效：
```bash
source ~/.profile
```

### 方案B：补充 ~/.pam_environment（兜底）
```bash
gedit ~/.pam_environment
```
**严格无空格**：
```
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE DEFAULT=fcitx
XMODIFIERS DEFAULT=@im=fcitx
SDL_IM_MODULE DEFAULT=fcitx
```

## 四、配置GNOME开机自启动（最关键一步）
### 方式1：图形界面添加（新手友好）
1. 安装启动程序工具
```bash
sudo apt install gnome-startup-applications -y
```
2. 打开「启动应用程序」→ 添加
- 名称：Fcitx5 Input
- 命令：`fcitx5 -d --replace`
- 注释：中文输入法框架
保存关闭。

### 方式2：命令生成自启动文件（稳定无bug）
```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/fcitx5-autostart.desktop << EOF
[Desktop Entry]
Type=Application
Name=Fcitx5 Input Method
Exec=fcitx5 -d --replace
Icon=fcitx
Terminal=false
X-GNOME-Autostart-enabled=true
StartupNotify=false
EOF
```

## 五、启用systemd用户服务（深层守护，防止闪退）
```bash
systemctl --user enable --now fcitx5-autostart.service
# 查看运行状态
systemctl --user status fcitx5-autostart.service
```
显示 `active (running)` 代表正常。

## 六、重置fcitx5损坏配置（如果之前乱配置过）
旧配置损坏会导致开机启动失败
```bash
# 备份旧配置
mv ~/.config/fcitx5 ~/.config/fcitx5.bak
# 重启生成干净配置
fcitx5 -d
```

## 七、最后一步：注销/重启系统测试
全部配置完成后**必须注销当前用户重新登录**，不要只重启软件。

### 验证是否开机自动运行
登录后打开终端输入：
```bash
fcitx5-remote
```
返回数字 `0` = fcitx5已正常运行；
返回 `1` = 未启动，回到上面步骤排查。

## 常见踩坑说明
1. **为什么打开fcitx5-configtool才会运行？**
   configtool只是**手动唤醒进程**，没有持久开机配置，重启失效。
2. ~/.pam_environment失效？
   Ubuntu24.04新版PAM弱化了该文件，**必须搭配 ~/.profile 自启命令**双保险。
3. Wayland下托盘不显示图标？
   安装kimpanel扩展：
```bash
sudo apt install gnome-shell-extension-kimpanel
```
重启GNOME（Alt+F2输入r回车）。
4. 开机fcitx5闪退
   删掉旧fcitx5配置文件夹，重新生成干净配置（第六步）。