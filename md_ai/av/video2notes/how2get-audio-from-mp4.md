<<如何从mp4分离出 音频>>

从 MP4 文件中分离出音频可以借助多种工具实现，下面为你介绍不同系统和平台下常用的方法。

# 1. 使用 FFmpeg（跨平台）
 FFmpeg 是一款强大的开源音视频处理工具，能在 Windows、macOS、Linux 等多种操作系统上使用。
## 1.1安装 FFmpeg
Windows：从 FFmpeg 官网 下载 Windows 版本的压缩包，解压后将 ffmpeg 所在目录添加到系统环境变量 PATH 中。
macOS：可以使用 Homebrew 进行安装，在终端中执行命令 brew install ffmpeg。
Linux：以 Ubuntu 为例，在终端中执行命令 sudo apt-get install ffmpeg。

## 1.2分离音频
在安装好 FFmpeg 后，打开终端或命令提示符，执行以下命令来分离 MP4 文件中的音频：
```bash
ffmpeg -i input.mp4 -vn -acodec copy output.aac
```
-i input.mp4：指定输入的 MP4 文件。
-vn：表示不处理视频流，即只提取音频。
-acodec copy：表示直接复制音频编码，不进行重新编码，这样可以加快处理速度。
output.aac：指定输出的音频文件，这里使用 AAC 格式，你也可以将其改为其他常见的音频格式，如 MP3、WAV 等。若要输出 MP3 格式，可使用以下命令：
```bash
ffmpeg -i input.mp4 -vn -acodec libmp3lame output.mp3
```

## 1.3 mp3 转wav
```sh
ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav
```
 
## 1.4 ffmpeg 从mp4 分离出音频保存为 wav

你可以使用 `ffmpeg` 工具从 MP4 文件中分离出音频并保存为 WAV 格式。`ffmpeg` 是一个强大的开源音视频处理工具，以下是具体的命令示例：

### 1.4.1基本命令
```bash
ffmpeg -i input.mp4   -vn -acodec pcm_s16le -ar 44100 -ac 2 output.wav 
```
### 1.4.2命令解释
- `-i input.mp4`：指定输入的 MP4 文件，你需要将 `input.mp4` 替换为你实际的 MP4 文件名称。
- `-vn`：表示不处理视频流，即只提取音频。
- `-acodec pcm_s16le`：设置音频编码格式为 PCM 16 位小端格式，这是 WAV 文件常用的无损编码格式。
- `-ar 44100`：设置音频采样率为 44100 Hz，这是常见的音频采样率。
- `-ac 2`：设置音频通道数为 2，即立体声。
- `output.wav`：指定输出的 WAV 文件名称，你可以根据需要修改。
 
### 1.4.3注意事项
- 确保你已经安装了 `ffmpeg` 工具。如果未安装，可以根据你的操作系统进行安装，例如在 Ubuntu 上可以使用 `sudo apt-get install ffmpeg` 进行安装。
- 命令中的参数可以根据你的具体需求进行调整，例如更改采样率、通道数等。 


<------------------------------------------------------->
<------------------------------------------------------->
# 2.python 代码如何从mp4分离出 音频
在 Python 中，可以借助pydub库或者调用ffmpeg命令来从 MP4 文件里分离出音频。以下为你详细介绍这两种方法：

## 2.1方法一：使用pydub库
pydub是一个简单易用的音频处理库，不过它依赖于ffmpeg，所以在使用前要确保系统已经安装了ffmpeg。

### 2.1.1安装依赖
‵‵`bash
pip install pydub
```

示例代码
```python
from pydub import AudioSegment

def extract_audio_from_mp4(input_file, output_file):
    # 加载 MP4 文件
    video = AudioSegment.from_file(input_file, format="mp4")
    # 导出音频文件
    video.export(output_file, format="mp3")

# 示例调用
input_file = "input.mp4"
output_file = "output.mp3"
extract_audio_from_mp4(input_file, output_file)
```


### 2.1.2代码解释
AudioSegment.from_file(input_file, format="mp4")：从指定的 MP4 文件加载音频数据。
video.export(output_file, format="mp3")：将加载的音频数据导出为 MP3 格式的文件。你可以根据需求把 format 参数修改为其他音频格式，像 wav、aac 等。

## 2.2方法二：调用ffmpeg命令
可以使用subprocess模块在 Python 中调用ffmpeg命令来实现音频分离。

### 2.2.1示例代码
```python
import subprocess

def extract_audio_ffmpeg(input_file, output_file):
    command = [
        'ffmpeg',
        '-i', input_file,
        '-vn',
        '-acodec', 'copy',
        output_file
    ]
    try:
        subprocess.run(command, check=True)
        print("音频提取成功！")
    except subprocess.CalledProcessError as e:
        print(f"音频提取失败: {e}")

# 示例调用
input_file = "input.mp4"
output_file = "output.aac"
extract_audio_ffmpeg(input_file, output_file)
```


### 2.2.2代码解释
subprocess.run(command, check=True)：执行ffmpeg命令。command 列表包含了ffmpeg命令及其参数，-i 指定输入文件，-vn 表示不处理视频流，-acodec copy 表示直接复制音频编码，不进行重新编码。
try-except 块用于捕获并处理可能出现的错误。

## 2.3注意事项
* 若使用pydub库，要确保系统中已经正确安装了ffmpeg，并且pydub能找到ffmpeg的可执行文件。
* 若使用subprocess调用ffmpeg命令，要确保ffmpeg已经安装并且可以在系统的PATH环境变量中找到。