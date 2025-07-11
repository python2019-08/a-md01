# 1.ubuntu 上已经安装好android studio emulator，如何手动启动 Emulator

若Ubuntu系统中已安装好Android Studio Emulator，可按以下步骤手动启动模拟器：


### 一、确认环境变量配置
要保证Android SDK的工具路径已添加到系统环境变量里。你可以通过编辑`~/.bashrc`或者`~/.zshrc`文件来实现，添加如下内容：
```bash
# 需将路径修改为你自己的Android SDK路径
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```
修改完成后，执行下面的命令使配置生效：
```bash
source ~/.bashrc  # 若使用的是bash
# 或者
source ~/.zshrc   # 若使用的是zsh
```


### 二、查看可用的模拟器设备
在终端输入以下命令，查看已创建的模拟器设备列表：
```bash
emulator -list-avds
```
如果之前已经在Android Studio中创建过AVD（Android Virtual Device），这里会显示其名称，例如`Pixel_4_API_30`。


### 三、启动模拟器
使用以下命令启动指定的模拟器设备（将`设备名称`替换为上一步得到的AVD名称）：
```bash
emulator -avd 设备名称
```
举个例子：
```bash
emulator -avd Pixel_4_API_30
```

### 四、常见参数选项
启动模拟器时，可以添加一些参数来优化性能或者实现特定功能：
- **指定GPU加速**：
  ```bash
  emulator -avd 设备名称 -gpu auto  # 自动选择GPU加速方式
  emulator -avd 设备名称 -gpu host  # 使用主机GPU进行加速
  ```
- **以头less模式启动**（不显示模拟器窗口）：
  ```bash
  emulator -avd 设备名称 -no-window
  ```
- **调整内存分配**：
  ```bash
  emulator -avd 设备名称 -memory 2048  # 分配2GB内存
  ```


### 五、可能遇到的问题及解决办法
1. **缺少依赖库**：
如果启动时提示缺少`libGL.so`等库文件，可通过以下命令安装：
  ```bash
  sudo apt-get install libgl1-mesa-dev
  ```

2. **KVM加速未启用**：
若遇到性能不佳或者启动报错的情况，可检查KVM是否已启用：
  ```bash
  kvm-ok  # 检查KVM支持情况
  ```
若未启用，需按照以下步骤设置：
  ```bash
  sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
  sudo adduser $USER kvm  # 将当前用户添加到kvm组
  ```

3. **无法找到emulator命令**：
要是出现“command not found”的错误，说明环境变量配置可能有问题。此时，需要确认`ANDROID_HOME`路径是否正确，或者尝试使用绝对路径启动：
  ```bash
  $ANDROID_HOME/emulator/emulator -avd 设备名称
  ```


### 六、创建新的AVD（若没有可用设备）
若`emulator -list-avds`没有显示任何设备，你可以通过命令行创建一个新的AVD。不过，这需要先下载系统镜像。以下是一个示例命令：
```bash
# 创建名为MyAndroid的AVD，使用API 30的x86_64系统镜像
avdmanager create avd -n MyAndroid -k "system-images;android-30;google_apis;x86_64"
```
执行上述命令后，按照提示完成创建过程，然后再使用`emulator -avd MyAndroid`启动模拟器。


### 七、从GUI界面启动（可选）
如果你觉得命令行操作比较麻烦，也可以通过Android Studio的图形界面来启动模拟器：
1. 打开Android Studio。
2. 点击工具栏中的“AVD Manager”图标（或依次选择Tools → AVD Manager）。
3. 在AVD列表中，点击对应设备的“Play”按钮来启动模拟器。

通过以上步骤，你就能在Ubuntu上手动启动Android Studio Emulator了。如果在启动过程中遇到其他问题，可以提供具体的错误信息，以便进一步排查。

===========================================================
# 2. fanqienovel.apk已经下载到计算机本地，如何 在 emulator 中安装fanqienovel.apk

要在Android Emulator中安装本地下载的番茄小说App APK(fanqienovel.apk)，可以通过以下步骤操作：
 

### **一、启动Android Emulator**
先确保你的模拟器已成功启动并运行（参考上一轮对话解决KVM启动问题）。在终端中执行：
```bash
emulator -avd <设备名称>  # 例如：emulator -avd Pixel_4_API_30
```


### **二、安装APK文件**
有两种方法可以将APK安装到模拟器中：


#### **方法一：使用命令行（推荐）**
1. **确认模拟器已启动并识别**  
   打开新终端，运行以下命令检查模拟器是否被ADB（Android Debug Bridge）识别：
   ```bash
   adb devices
   ```
   输出应显示类似：
   ```
   List of devices attached
   emulator-5554   device
   ```
   若未显示设备，请确保模拟器已完全启动。

2. **安装APK文件**  
   使用`adb install`命令安装本地APK（将`/path/to/fanqienovel.apk`替换为你的APK文件路径）：
   ```bash
   adb install /path/to/fanqienovel.apk
   ```
   - **示例**：若APK位于下载目录：
     ```bash
     adb install ~/Downloads/fanqienovel_1.2.3.apk
     ```
   - **输出结果**：
     ```
     Performing Streamed Install
     Success
     ```
     显示`Success`表示安装成功。


#### **方法二：拖放安装（图形界面）**
1. 启动模拟器后，打开文件管理器找到APK文件。
2. 直接将APK文件拖放到模拟器窗口中。
3. 模拟器会弹出安装确认界面，点击**安装**按钮完成安装。


### **三、验证安装结果**
1. 在模拟器主屏幕或应用列表中查找**番茄小说**App图标。
2. 也可以通过ADB命令检查应用是否已安装：
   ```bash
   adb shell pm list packages | grep fanqie
   ```
   若输出包含类似`package:com.dragon.read`的结果，则表示安装成功。


### **四、常见问题及解决方法**
1. **ADB未找到设备**  
   - 重启模拟器和ADB服务：
     ```bash
     adb kill-server  # 停止ADB服务
     adb start-server  # 重启ADB服务
     ```
   - 检查模拟器是否正常运行（无崩溃或黑屏）。

2. **安装失败（错误代码）**  
   - **INSTALL_FAILED_ALREADY_EXISTS**：应用已安装，可先卸载再重新安装：
     ```bash
     adb uninstall com.dragon.read
     ```
   - **INSTALL_FAILED_INSUFFICIENT_STORAGE**：模拟器存储空间不足，需清理或增大存储：
     ```bash
     # 增大AVD存储容量（关闭模拟器后执行）
     avdmanager delete avd -n <设备名称>  # 删除原有AVD
     avdmanager create avd -n <设备名称> -k <系统镜像> --sdcard 2048M  # 创建新AVD并分配2GB SD卡空间
     ```
   - **其他错误**：尝试使用`-r`（覆盖安装）或`-s`（安装到SD卡）参数：
     ```bash
     adb install -r -s /path/to/fanqienovel.apk
     ```

3. **模拟器无法联网**  
   确保模拟器网络设置正常（可尝试重启模拟器或切换网络模式）。


### **五、从Android Studio安装（可选）**
若你使用Android Studio，可以通过以下步骤安装APK：
1. 打开Android Studio，点击工具栏中的**AVD Manager**。
2. 启动目标模拟器。
3. 选择**File → Profile or Debug APK**。
4. 选择本地APK文件，点击**OK**。
5. Android Studio会自动将APK安装到模拟器中。


### **六、卸载应用**
若需卸载已安装的番茄小说App，可执行：
```bash
adb uninstall com.dragon.read
```


通过以上步骤，你应该能够成功在Android Emulator中安装番茄小说App的APK文件。如果遇到其他问题，请提供具体的错误信息以便进一步排查。