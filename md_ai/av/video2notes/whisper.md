# 1.whisper、whisper.cpp、faster-whisper的比较

Finger_ebic  于 2024-03-28 22:36:46 发布
原文链接：https://blog.csdn.net/KQe397773106/article/details/137126629

让我们比较一下当前的whisper、whisper.cpp和faster-whisper。

OpenAI / Whisper 自发布以来，似乎在各个方面都发生了变化，例如在 2022 年 12 月增加了 large-v2 模型和各种版本升级。

whisper.cpp是用 CPU 的 C/C++ 编写的。 它似乎是Core ML支持，所以它对于Mac用户有强烈的感觉。

而 faster-whisper是基于 CTranslate2 重写了 Whisper 模型，似乎它的速度比原版的快 4 倍，精度也相同，并且使用的内存更少。

以下是测试音频 （WAV）（48 秒）的测试示例。

## 1.1.结果

Faster-whisper 的 GPU 和传闻中的一样快。
Faster-whisper CPU运算速度更快，GPU的速度也从85.62秒→23.9秒加快。
whisper.cpp 效果反而不是很好。 可能真正的价值体现在支持Mac CoreML加速上。

Implementation | Device | Time | 结果
---------------|--------|------|---
openai/whisper | CPU | 3分1秒 | 上午和今天的东京股市，日经平均指数小幅走高，收于11.72日元，比昨天上涨22.72日元。 是088.58日元，最初价格上涨的股票数量为1146只，而下跌的股票数量为368只，保持不变的股票数量为104只股票，以下是礼物的公告： 在这个节目中，将抽签选出10人来接收每月出版的月报4月号，申请在东京通过电话03-0107-837303-0107-8373
openai/whisper | GPU | 23.9秒 | 上午和今天的东京股市，日经平均指数小幅走高，收于11.72日元，比昨天上涨22.72日元。 是088.58日元，最初价格上涨的股票数量为1146只，而下跌的股票数量为368只，保持不变的股票数量为104只股票，以下是礼物的公告： 在这个节目中，将抽签选出10人来接收每月出版的月报4月号，申请在东京通过电话03-0107-837303-0107-8373
whisper.cpp | CPU | 7分13秒 | 上午和今天的东京股市，日经平均指数小幅走高，收于11.72日元，比昨天上涨22.72日元。 是088.58日元，最初价格上涨的股票数量为1146只，但价格下跌了368只，104只股票保持不变，这是礼物公告该计划将通过抽签将月度报告4月号赠送给10人申请，请致电东京03-0107-8373,03-0107-8373
faster-whisper | CPU（Float32） | 4分 18秒 | 我是浅野智美 今天东京股市的日经平均指数略高 收盘价为11,088.58日元，比昨天上涨22.72日元 最初价格上涨的股票数量为1146只，而价格下跌的股票数量为368只股票保持不变 104只股票 以下是礼物的公告： 在本节目中，出版了月度报告4月号。 我们将通过抽签将其赠送给 10 人 申请，请致电东京 03-0107-8373 03-0107-8373 以上是该计划的公告
faster-whisper | CPU（int8） | 2分 27秒 | 我是浅野智美 今天东京股市的日经平均指数略高 收盘价为11,088.58日元，比昨天上涨22.72日元 最初价格上涨的股票数量为1146只，而价格下跌的股票数量为368只股票保持不变 104只股票 以下是礼物的公告： 在本节目中，出版了月度报告4月号。 我们将通过抽签将其赠送给 10 人 申请时，请致电东京0301078373 0301078373 以上是该计划的公告。
faster-whisper | GPU（Float16） | 5.22 秒 | 我是浅野智美 今天东京股市的日经平均指数略高 收盘价为11,088.58日元，比昨天上涨22.72日元 最初价格上涨的股票数量为1146只，而价格下跌的股票数量为368只股票保持不变 104只股票 以下是礼物的公告： 在本节目中，出版了月度报告4月号。 我们将通过抽签将其赠送给 10 人 申请，请致电东京 03-0107-8373 03-0107-8373 以上是该计划的公告
faster-whisper | GPU（int8_float16） | 4.73 秒 | 我是浅野智美 今天东京股市的日经平均指数略高 收盘价为11,088.58日元，比昨天上涨22.72日元 最初价格上涨的股票数量为1146只，而价格下跌的股票数量为368只股票保持不变 104只股票 以下是礼物的公告： 在本节目中，出版了月度报告4月号。 我们将通过抽签将其赠送给 10 人 申请时，请致电东京0301078373 0301078373 以上是该计划的公告。


## 1.2.Whisper
安装
```sh
!pip install -U openai-whisper
```

模型加载
```python
import whisper
model = whisper.load_model("large", device="cpu")
```

执行
```py
%%time
result = model.transcribe("sampleTokyo.WAV")
print(result["text"])
```

## 1.3.whisper.cpp
安装
```sh
!git clone https://github.com/ggerganov/whisper.cpp.git
%cd whisper.cpp
!bash ./models/download-ggml-model.sh large
!make
```

转换为 16kHz 的 WAV
```sh
!ffmpeg -i ../sampleTokyo.WAV -ar 16000 sampleTokyo.wav
```
 
执行
```sh
%%time
!./main -f ./sampleTokyo.wav -nt -l ja -m models/ggml-large.bin
```

## 1.4.faster-whisper
安装
```sh
!pip install faster-whisper
```

模型加载
```py
from faster_whisper import WhisperModel
model_size = "large-v2"

model = WhisperModel(model_size, device="cpu", compute_type="float32")
#model = WhisperModel(model_size, device="cpu", compute_type="int8")
#model = WhisperModel(model_size, device="cuda", compute_type="float16")
#model = WhisperModel(model_size, device="cuda", compute_type="int8_float16")
```

```python
%%time
segments, info = model.transcribe("sampleTokyo.WAV", beam_size=5, language='ja')
results = list(segments)
print(' '.join([result.text for result in results]))
```

Finger_ebic
                        
<--------------------------------------------------------------------->
<--------------------------------------------------------------------->
# 2.whisper-cli  如何把 wav 转成 中文文字

要使用 `whisper-cli` 把 WAV 音频文件转换为中文文字，可以按照以下步骤操作：

## 2.1. 安装 `whisper.cpp`
`whisper-cli` 是 `whisper.cpp` 项目中的一个命令行工具，你得先安装 `whisper.cpp`。按照下面的步骤克隆仓库并编译项目：

```bash
# 克隆 whisper.cpp 仓库
git clone https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp

# 编译项目
make
```

## 2.2. 下载中文识别模型
你需要下载适合中文识别的模型。以 `ggml-medium.bin` 模型为例，运行下面的命令下载：

```bash
bash ./models/download-ggml-model.sh medium
```

## 2.3. 使用 `whisper-cli` 进行中文语音识别
使用 `whisper-cli` 命令把 WAV 文件转换为中文文字。要确保指定正确的模型路径和语言参数。

```bash
./main -m ./models/ggml-medium.bin -l zh -f /path/to/your/audio.wav
```

在上述命令里：
- `-m`：用于指定模型文件的路径，这里是 `./models/ggml-medium.bin`。
- `-l`：用于指定识别的语言，`zh` 代表中文。
- `-f`：用于指定要识别的 WAV 音频文件的路径，你需要把 `/path/to/your/audio.wav` 替换成实际的文件路径。

### 2.3.1 whisper-cli currently runs only with 16-bit WAV

Note that the [whisper-cli](examples/cli) example currently **runs only with 16-bit WAV** files, so make sure to convert your input before running the tool.
For example, you can use `ffmpeg` like this:

```bash
ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav
```

## 2.4. 完整示例
下面是一个完整的示例，涵盖了克隆仓库、编译项目、下载模型以及进行语音识别的步骤：

```bash
# 克隆 whisper.cpp 仓库
git clone https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp

# 编译项目
make

# 下载模型
bash ./models/download-ggml-model.sh medium

# 进行中文语音识别
./main -m ./models/ggml-medium.bin -l zh -f /path/to/your/audio.wav
```

按照以上步骤操作，你就能使用 `whisper-cli` 把 WAV 音频文件转换为中文文字。 

## 2.5 my示例
```sh
#!/bin/bash
work_dir=/home/abner/abner2/dev_78/j60hkd/ 

# 从mp4中抽取 音频信息，转成mp3
# ffmpeg -i input.mp4 -vn -acodec libmp3lame output.mp3
input_mp4_path=${work_dir}/hkd126c-0402.mp4 
ffmpeg -i ${input_mp4_path}   -vn -acodec libmp3lame ${work_dir}/output.mp3

# 从mp3 转成 wav
# ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav
ffmpeg -i ${work_dir}/output.mp3 -ar 16000 -ac 1 -c:a pcm_s16le ${work_dir}/output.wav

# whisper.cpp把 音频 转成 文字
# ./build/bin/whisper-cli   -l zh  -m  models/ggml-medium.bin   -f ~/abner2/zdev/ai/av/video2note/output.wav
whisper_cpp_rootDir=/mnt/disk2/abner/zdev/ai/av/whisper.cpp
${whisper_cpp_rootDir}/build/bin/whisper-cli   -l zh  -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  -f  ${work_dir}/output.wav
```

<--------------------------------------------------------------------->
<--------------------------------------------------------------------->
=====================================================================
# 3.whisper.cpp 把音频 转成 文字时，如何使得 输出的文字语句的停顿合理化

要优化 whisper.cpp 的文字输出停顿，可以通过调整参数、后处理和使用额外工具来实现。以下是具体方法：


### **1. 调整 whisper.cpp 参数**
whisper.cpp 提供了几个关键参数来控制文本分割和停顿：

#### **(1) `--max-line-length`**
限制每行文本的最大长度（按字符数），强制在接近该长度处断句。  
```bash
./main -m models/ggml-base.en.bin -f audio.wav --max-line-length 40
```
- **作用**：避免生成过长的句子，使停顿更合理。
- **建议值**：30-60 字符（根据语言和场景调整）。

#### **(2) `--max-line-count`**
限制每行的最大句子数量，超过则强制换行。  
```bash
./main -m models/ggml-base.en.bin -f audio.wav --max-line-count 1
```
- **作用**：确保每行一个完整句子，适合生成 SRT 字幕。

#### **(3) `--no-timestamps`**
禁用时间戳输出，仅保留文本（配合后处理工具效果更佳）。  
```bash
./main -m models/ggml-base.en.bin -f audio.wav --no-timestamps > output.txt
```


### **2. 后处理优化停顿**
生成文本后，可以使用 Python 脚本进一步优化停顿：

#### **(1) 基于标点符号调整停顿**
根据句号、逗号等标点自动插入适当的停顿标记。  
```python
import re

def refine_pauses(text, pause_duration="0.5s"):
    # 在句号、问号、感叹号后添加较长停顿
    text = re.sub(r'([.?!])', r'\1<break time="1s"/>', text)
    # 在逗号后添加中等停顿
    text = re.sub(r'(,)', r'\1<break time="0.5s"/>', text)
    return text

# 使用示例
with open("whisper_output.txt", "r", encoding="utf-8") as f:
    text = f.read()
refined_text = refine_pauses(text)
with open("refined_output.txt", "w", encoding="utf-8") as f:
    f.write(refined_text)
```

#### **(2) 基于音频能量分析分割文本**
结合音频的静音段检测，更精准地分割文本（需安装 `pydub` 库）：  
```python
from pydub import AudioSegment
from pydub.silence import detect_silence

def split_text_by_audio(audio_file, text, min_silence_len=500, silence_thresh=-40):
    audio = AudioSegment.from_file(audio_file)
    silent_ranges = detect_silence(audio, min_silence_len, silence_thresh)
    
    # 将静音段时间映射到文本位置（简化版，实际需更复杂的对齐算法）
    text_segments = []
    current_pos = 0
    
    for start, end in silent_ranges:
        # 估算对应的文本位置（示例中简单按比例分割）
        ratio = start / len(audio)
        split_pos = int(len(text) * ratio)
        text_segments.append(text[current_pos:split_pos])
        current_pos = split_pos
    
    text_segments.append(text[current_pos:])
    return text_segments
```


### **3. 生成 SRT 字幕（含时间戳）**
使用 whisper.cpp 生成带时间戳的 SRT 文件，再用工具优化：

#### **(1) 生成 SRT**
```bash
./main -m models/ggml-base.en.bin -f audio.wav --output-srt
```

#### **(2) 使用 srt 库优化时间轴**
```python
import srt

def optimize_srt(srt_file, min_duration=2000, max_duration=8000):
    with open(srt_file, "r", encoding="utf-8") as f:
        subs = list(srt.parse(f.read()))
    
    optimized_subs = []
    for sub in subs:
        # 确保字幕不会过短或过长
        duration = (sub.end - sub.start).total_seconds() * 1000
        if duration < min_duration:
            # 与下一个字幕合并（简化处理）
            if optimized_subs:
                prev_sub = optimized_subs.pop()
                new_sub = srt.Subtitle(
                    index=prev_sub.index,
                    start=prev_sub.start,
                    end=sub.end,
                    content=f"{prev_sub.content}\n{sub.content}"
                )
                optimized_subs.append(new_sub)
            else:
                # 如果是第一个字幕，延长持续时间
                sub.end = sub.start + datetime.timedelta(milliseconds=min_duration)
                optimized_subs.append(sub)
        elif duration > max_duration:
            # 分割过长的字幕（需更复杂的文本分割算法）
            pass
        else:
            optimized_subs.append(sub)
    
    with open("optimized.srt", "w", encoding="utf-8") as f:
        f.write(srt.compose(optimized_subs))
```


### **4. 高级技巧：微调模型参数**
如果你有能力编译 whisper.cpp，可以尝试修改源码中的参数：

#### **(1) 调整 `whisper.cpp` 中的 `params`**
在 `whisper.cpp` 文件中找到 `whisper_full_default_params()` 函数，修改以下参数：  
```cpp
params.token_timestamps = true;    // 启用token级时间戳
params.max_len = 60;               // 最大句子长度（token数）
params.word_thold = 0.01f;         // 词置信度阈值
params.single_segment = false;     // 禁用单段模式
```

#### **(2) 使用更大的模型**
使用 `medium` 或 `large` 模型通常能提供更准确的停顿预测：  
```bash
./main -m models/ggml-large.bin -f audio.wav ...
```


### **总结**
通过结合 whisper.cpp 的参数调整、后处理脚本和音频分析，可以显著提升文字输出的停顿合理性。对于专业场景，建议使用 Python 脚本进行更精细的控制，特别是结合音频能量分析和机器学习方法。

=====================================================================
=====================================================================
# 4.whisper-cli的帮助 中 有 output script for generating karaoke video

Whisper CLI中的`--output-srt`或`--output-vtt`选项可生成字幕文件，这些文件可用于制作卡拉OK视频。以下是具体步骤和示例：


### 1. **生成字幕文件**
使用Whisper CLI生成SRT或VTT格式的字幕：
```bash
whisper audio.mp3 --model medium --output-srt
# 或生成VTT格式
whisper audio.mp3 --model medium --output-vtt
```
这将生成`audio.srt`或`audio.vtt`文件，包含精确的时间戳和歌词。


### 2. **使用字幕制作卡拉OK视频**
以下是一个使用FFmpeg结合字幕文件制作卡拉OK效果的Python脚本：
```py
# karaoke_generator.py
import os
import subprocess
import argparse
from pathlib import Path

def create_karaoke_video(audio_file, subtitle_file, output_file=None, background=None):
    """
    基于Whisper生成的字幕文件创建卡拉OK视频
    
    参数:
        audio_file: 输入音频文件路径
        subtitle_file: 字幕文件路径(SRT/VTT)
        output_file: 输出视频文件名，默认为音频文件名+_karaoke.mp4
        background: 背景图片/视频路径，默认为黑色背景
    """
    # 设置输出文件名
    if not output_file:
        base_name = os.path.splitext(audio_file)[0]
        output_file = f"{base_name}_karaoke.mp4"
    
    # 确定字幕格式
    subtitle_ext = os.path.splitext(subtitle_file)[1].lower()
    subtitle_format = "srt" if subtitle_ext == ".srt" else "webvtt" if subtitle_ext == ".vtt" else ""
    
    if not subtitle_format:
        raise ValueError("不支持的字幕格式，仅支持SRT和VTT")
    
    # 构建FFmpeg命令
    cmd = [
        "ffmpeg",
        "-y",  # 覆盖已存在的文件
        "-i", audio_file,  # 输入音频
    ]
    
    # 添加背景
    if background:
        if background.endswith(('.jpg', '.jpeg', '.png', '.bmp')):
            # 图片背景
            cmd.extend(["-loop", "1", "-i", background])
            # 设置图片持续时间为音频长度
            cmd.extend(["-t", f"{get_audio_duration(audio_file)}"])
        else:
            # 视频背景
            cmd.extend(["-i", background])
    else:
        # 默认黑色背景
        cmd.extend([
            "-f", "lavfi", 
            "-i", "color=c=black:s=1920x1080:d=" + str(get_audio_duration(audio_file))
        ])
    
    # 添加字幕滤镜
    cmd.extend([
        "-filter_complex",
        f"[1:v]scale=1920:1080[bg];[bg][0:a]drawtext=text='':fontsize=36:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:enable='between(t,0,0)',subtitles={os.path.abspath(subtitle_file)}:force_style='Fontsize=36,PrimaryColour=&HFFFFFF,OutlineColour=&H0,BackColour=&H80000000,MarginV=50,Alignment=2'[outv]"
    ])
    
    # 设置输出参数
    cmd.extend([
        "-map", "[outv]",
        "-map", "0:a",
        "-c:v", "libx264",
        "-preset", "medium",
        "-crf", "23",
        "-c:a", "aac",
        "-b:a", "192k",
        "-shortest",
        output_file
    ])
    
    # 执行命令
    print("正在生成卡拉OK视频...")
    print(" ".join(cmd))
    subprocess.run(cmd, check=True)
    print(f"卡拉OK视频已生成: {output_file}")

def get_audio_duration(audio_file):
    """获取音频文件的时长（秒）"""
    result = subprocess.run(
        [
            "ffprobe", 
            "-v", "error", 
            "-show_entries", "format=duration", 
            "-of", "default=noprint_wrappers=1:nokey=1",
            audio_file
        ],
        capture_output=True,
        text=True
    )
    return float(result.stdout.strip())

def main():
    parser = argparse.ArgumentParser(description='基于Whisper字幕生成卡拉OK视频')
    parser.add_argument('--audio', required=True, help='输入音频文件')
    parser.add_argument('--subtitle', required=True, help='字幕文件(SRT/VTT)')
    parser.add_argument('--output', help='输出视频文件')
    parser.add_argument('--background', help='背景图片或视频')
    
    args = parser.parse_args()
    create_karaoke_video(args.audio, args.subtitle, args.output, args.background)

if __name__ == "__main__":
    main()    
```   



### 3. **使用方法**
1. **安装依赖**：
   ```bash
   pip install ffmpeg-python  # 用于调用FFmpeg
   ```

2. **基本用法**：
   ```bash
   python karaoke_generator.py --audio audio.mp3 --subtitle audio.srt
   ```

3. **高级选项**：
   ```bash
   # 指定输出文件名
   python karaoke_generator.py --audio audio.mp3 --subtitle audio.srt --output karaoke.mp4

   # 使用图片作为背景
   python karaoke_generator.py --audio audio.mp3 --subtitle audio.srt --background bg.jpg

   # 使用视频作为背景
   python karaoke_generator.py --audio audio.mp3 --subtitle audio.srt --background bg_video.mp4
   ```


### 4. **效果说明**
- 脚本会将Whisper生成的精确字幕逐行显示在视频上
- 支持自定义背景（纯色、图片或视频）
- 字幕样式可通过修改`force_style`参数调整（字体、颜色、大小等）


### 5. **注意事项**
- 需要预先安装FFmpeg（确保命令行可调用）
- 字幕文件必须与音频匹配
- 视频分辨率默认为1920×1080，可在脚本中修改
- 如需更复杂的效果（如歌词逐字变色），可扩展脚本中的滤镜设置

==============================================
==============================================
 
# 5.语音识别神器 Whisper 的几个小技巧_如何设定whisper只输出中文 
 
 2024-06-24 09:00:00 发布
https://blog.csdn.net/abcd51685168/article/details/139904153       
### 1、前言

[OpenAI]开源的免费离线[语音识别] 神器[Whisper] ，我在安装使用后发现一些问题，于是搜了半天最终汇总了这几个[主要的]小技巧，希望对大家有帮助，不用满世界再搜了。

我主要用于中文的识别，所以就只说中文相关的了，我的环境是：
-   系统：Ubuntu22.04
-   Python:3.9.9(conda)

具体怎么正常使用或者怎么安装，官方MD很详细了，不行再搜搜也就有了，我就没记录。

官方github：[GitHub - openai/whisper: Robust Speech Recognition via
Large-Scale Weak
Supervision](https://github.com/openai/whisper "GitHub - openai/whisper: Robust Speech Recognition via Large-Scale Weak Supervision")

###  2、模型选哪个

        whisper提供了5个模型，见下表：

![](./Whisper-tricks_files/592cd1d92438f467400048ca35f61643.png) 
Size | Parameters | English-only model | Multilingual model | Required VRAM | Relative speed
-----|------------|--------------------|--------------------|---------------|---------------
tiny | 39 M       | tiny.en           | tiny    | ~1 GB   | ~32x| 
base | 74 M       | base.en           | base    | ~1 GB   | ~16x| 
small | 244 M     | small.en          | small   | ~2 GB   | ~6x | 
medium | 769 M    | medium.en         | medium  | ~5 GB   | ~2x| 
large | 1550 M    | N/A                | large  | ~10 GB  | 1x  |   

       
每个模型具体要求都在表里了，我试过前4个，对于中文识别，我的体会是，必须得medium，前3个中文识别有点差。medium足够用，虽然也会有错误的情况，但不多了。我推测large肯定会更上一层楼，然而large有点大且显存占得大就没下载。
        所以，medium性价比最高。

### 3、whisper 加标点符号的问题
         我使用时，发现输出的文件里中文完全没有标点符号哎，这可咋整 ，找了半天程序里也没这参数啊。不断大海捞针地搜了搜，发现有篇文章写了个方法说要通过prompt，告诉程序个例子。于是通过测试，总结了一个成功的方法是这样的：

        运行时加这个参数 initial_prompt，它的值要写上对当前识别音频的内容总结（自己提前知道），最后还要加上句号，效果最佳。比如我要识别一段会议的录音，所以这个参数就这么写：

        initial_prompt = "这是一段会议记录。"

        哦对了，我是在程序里调接口用，如果用命令号，就直接加 --initial_prompt "这是一段会议记录。" （应该是这么写，不对的话再调整调整格式）

        于是标点符号的问题解决了。

###  4、whisper  中文简体繁体字的问题

        标点符号问题解决了，结果有时候识别出来的内容突然有一段变成了繁体字，于是又开始一顿搜寻，最终解决方法还是要在initial_prompt里给出例子。

        就是要在prompt里加上这句：“以下是普通话的句子。”，注意，这里要全部用简体中文写，程序就造了。

        所以如果想输出繁体字，那这句话就用繁体写：“以下是普通話的句子。”

### 5、总结
    综述所述，最后就固定一个prompt的写法，就能解决这俩问题。
    initial_prompt = "以下是普通话的句子，这是一段会议记录。"

    - 如果想输出繁体字，上面内容就全用繁体字写。
    - 后半句写语音的内容概括，并且一定要加上句号。
        祝大家成功！
                                                  
========================================
# 6.https://github.com/openai/whisper/blob/main/whisper/tokenizer.py#L10

```py

import tiktoken

LANGUAGES = {
    "en": "english",
    "zh": "chinese",
    "de": "german",
    "es": "spanish",
    "ru": "russian",
    "ko": "korean",
    "fr": "french",
    "ja": "japanese",
    "pt": "portuguese",
    "tr": "turkish",
    "pl": "polish",
    "ca": "catalan",
    "nl": "dutch",
    "ar": "arabic",
    "sv": "swedish",
    "it": "italian",
    "id": "indonesian",
    "hi": "hindi",
    "fi": "finnish",
    "vi": "vietnamese",
    "he": "hebrew",
    "uk": "ukrainian",
    "el": "greek",
    "ms": "malay",
    "cs": "czech",
    "ro": "romanian",
    "da": "danish",
    "hu": "hungarian",
    "ta": "tamil",
    "no": "norwegian",
    "th": "thai",
    "ur": "urdu",
    "hr": "croatian",
    "bg": "bulgarian",
    "lt": "lithuanian",
    "la": "latin",
    "mi": "maori",
    "ml": "malayalam",
    "cy": "welsh",
    "sk": "slovak",
    "te": "telugu",
    "fa": "persian",
    "lv": "latvian",
    "bn": "bengali",
    "sr": "serbian",
    "az": "azerbaijani",
    "sl": "slovenian",
    "kn": "kannada",
    "et": "estonian",
    "mk": "macedonian",
    "br": "breton",
    "eu": "basque",
    "is": "icelandic",
    "hy": "armenian",
    "ne": "nepali",
    "mn": "mongolian",
    "bs": "bosnian",
    "kk": "kazakh",
    "sq": "albanian",
    "sw": "swahili",
    "gl": "galician",
    "mr": "marathi",
    "pa": "punjabi",
    "si": "sinhala",
    "km": "khmer",
    "sn": "shona",
    "yo": "yoruba",
    "so": "somali",
    "af": "afrikaans",
    "oc": "occitan",
    "ka": "georgian",
    "be": "belarusian",
    "tg": "tajik",
    "sd": "sindhi",
    "gu": "gujarati",
    "am": "amharic",
    "yi": "yiddish",
    "lo": "lao",
    "uz": "uzbek",
    "fo": "faroese",
    "ht": "haitian creole",
    "ps": "pashto",
    "tk": "turkmen",
    "nn": "nynorsk",
    "mt": "maltese",
    "sa": "sanskrit",
    "lb": "luxembourgish",
    "my": "myanmar",
    "bo": "tibetan",
    "tl": "tagalog",
    "mg": "malagasy",
    "as": "assamese",
    "tt": "tatar",
    "haw": "hawaiian",
    "ln": "lingala",
    "ha": "hausa",
    "ba": "bashkir",
    "jw": "javanese",
    "su": "sundanese",
    "yue": "cantonese",
}

# language code lookup by name, with a few language aliases
TO_LANGUAGE_CODE = {
    **{language: code for code, language in LANGUAGES.items()},
    "burmese": "my",
    "valencian": "ca",
    "flemish": "nl",
    "haitian": "ht",
    "letzeburgesch": "lb",
    "pushto": "ps",
    "panjabi": "pa",
    "moldavian": "ro",
    "moldovan": "ro",
    "sinhalese": "si",
    "castilian": "es",
    "mandarin": "zh",
}
```