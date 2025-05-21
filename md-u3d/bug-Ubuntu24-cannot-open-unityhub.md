# Ubuntu24 打不开UnityHub的解决方案

Coco94joker 于 2024-07-02 18:57:16 发布

# 1.前置操作
## 1.1安装UnityHub
```sh
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb

sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb

sudo sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

wget -qO - https://hub.unity3d.com/linux/keys/public | sudo tee /etc/apt/trusted.gpg.d/unityhub.asc

sudo apt update
sudo apt install unityhub
```

## 1.2编写配置
### 创建配置文件
```sh
touch /etc/apparmor.d/unityhub
```

将以下内容写入文件：
```
abi <abi/4.0>,
include <tunables/global>

profile unityhub /opt/unityhub/unityhub-bin flags=(unconfined) {
userns,

# Site-specific additions and overrides. See local/README for details.
include if exists <local/unityhub>
}
```

执行操作
```sh
sudo systemctl restart apparmor.service
```

然后就能打开unityhub了

原链接为：https://forum.unity.com/threads/unity-hub-and-x-ubuntu-24-04-not-starting-workaround.1586640/

要是还打不开试试：

```sh
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```