# 0. 启动 Codex Cli  
  - 终端输入：codex --dangerously-bypass-approvals-and-sandbox 
  - 或者codex --yolo 这两条命令随便哪条命令都可以
  - 这是免安全审批的Codex的启动命令（就是不需要批准自动执行）


# 1. pytest/clock/clock.py
python -X pycache_prefix=/tmp/_pycache  -O -u  /home/abner/a2/zdev/ai/pytest/clock/clock.py
> -O：优化模式，生成更精简的.pyc文件
> -u：无缓冲输出  
<--------------------------------------->

# 2.    snipaste
    https://zh.snipaste.com/ 
    
<--------------------------------------->

# 3. ocr-text/multi-images-2-txt.sh
  /home/abner/a2/zdev/ai/av/a-story-video-maker/ocr-text/multi-images-2-txt.sh

<--------------------------------------->
# 4.my list
(1) ai + ffmpeg +   
    /home/abner/a2/zdev/ai/av/stability-ai/comfyui
    /home/abner/a2/zdev/ai/lm/langchain2025-quick-start

    slam + pointcloud + nerf + GaussianSplatting + SAM 
(2) mapsme-organicmaps2024-1112/CMakeLists.txt  
    CMake-Cookbook-master 
    doc-cmake/Professional-CMake.docx
 
    Geographical-Adventures    +    Unity-Shader_rumen-jingyao.pdf
 
 
<--------------------------------------->
# 5.docker run -i -t 
docker run -i -t -v ./:/guopu:rw --gpus all --shm-size 16G nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04  /bin/bash
 

<--------------------------------------->
# 6.
abner@abner-XPS:~$ sudo mkdir /mnt/mdisk2t
abner@abner-XPS:~$ sudo mount -t ntfs-3g /dev/sdc1 /mnt/mdisk2t
abner@abner-XPS:~$ sudo umount /mnt/mdisk2t 

<--------------------------------------->
# 7.OpenJUMP
/home/abner/programs/OpenJUMP-2.4.0-r5303[6c9a02d]-PLUS/bin/oj_linux.sh

------------------------------------------
# 8.how to read code in github 
https://github.com/ultralytics/ultralytics
把前缀github改成 deepwiki：
https://deepwiki.com/ultralytics/ultralytics




<--------------------------------------->
# 8.conda init
# (1)source activate
【解决】CommandNotFoundError: Your shell has not been properly configured to use conda activate
 
已于 2023-01-17 17:01:51 修改
 ———————————————— 
原文链接：https://blog.csdn.net/Caesar6666/article/details/125962432
在linux系统中，安装了anaconda，配置了conda环境变量，也使用conda命令创建了新的环境my_env，但在使用conda激活时，报错。

## 报错问题
输入：
```sh
conda activate my_env
``` 
报错：
> CommandNotFoundError: Your shell has not been properly configured to use ‘conda activate’.
> To initialize your shell, run
> 
> $ conda init <SHELL_NAME>
> 
> Currently supported shells are:
> 
> bash
> fish
> tcsh
> xonsh
> zsh
> powershell
> See ‘conda init --help’ for more information and options.
> 
> IMPORTANT: You may need to close and restart your shell after running ‘conda init’.

## 解决方法
> 在终端执行以下两条命令：
> 
> source activate
> source deactivate
----------------------------------------

# (2) install pytorch 

```sh
$  conda create -n pytorch-py36 python=3.6 -c conda-forge
> 
> To activate this environment, use
> 
>     $ conda activate pytorch-py36
> 
> To deactivate an active environment, use
> 
>     $ conda deactivate


pip3 install torch torchvision torchaudio
conda install pytorch::pytorch torchvision torchaudio -c pytorch
```

（2.1）delete env
```sh
conda remove -n your_env_name --all
conda remove -n pytorch-py36 --all
```
----------------------------------------
# 10.golang env var 
export GOROOT=$HOME/programs/go
export GOPATH=$HOME/abner2/zdev/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

----------------------------------------
# 11. DYLD_FALLBACK_LIBRARY_PATH in macOS
export DYLD_FALLBACK_LIBRARY_PATH=/Users/xxx/_work/prj/build/mac/nn/Debug/
 
-----------------------------------------
# 12. 
```sh
(base) abner@abner-XPS:~/.local/share/unity3d/Asset Store-5.x$ pwd
    /home/abner/.local/share/unity3d/Asset Store-5.x 
(base) abner@abner-XPS:~/.local/share/unity3d$ cd ~
(base) abner@abner-XPS:~$ ls ~/.local/share/unity3d/Asset\ Store-5.x/  
```