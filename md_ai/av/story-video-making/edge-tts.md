# 1.python edge-tts库实现文字转语音
菲宇  编辑于 2023-11-29 16:13・IP 属地广东
https://zhuanlan.zhihu.com/p/669473903

## 1.1关于edge-tts库

Edge-TTS是一个Python库，允许您从 Python 代码中使用 Microsoft Edge 的在线文本转语音服务或使用提供的 or 命令。它使用微软的Azure Cognitive Services来实现文本到语音转换（TTS）。该库提供了一个简单的API，可以将文本转换为语音，并且支持多种语言和声音，输出的音频文件更接近正常人的发音。

## 1.2安装 edge-tts库
```sh
pip install edge-tts
```

## 1.3查看edge-tts的命令

> usage: edge-tts [-h] [-t TEXT] [-f FILE] [-v VOICE] [-l]
>                 [--rate RATE] [--volume VOLUME] [--pitch PITCH]
>                 [--words-in-cue WORDS_IN_CUE] [--write-media WRITE_MEDIA] 
>                 [--write-subtitles WRITE_SUBTITLES][--proxy PROXY]
> edge-tts: error: one of the arguments -t/--text 
>                 -f/--file -l/--list-voices is required

参数说明
> --text 【参数】 指明要保存的mp3的文本。
> --write-media 【参数】 指明保存的mp3文件路径。
> --voice 【参数】指明了使用哪种语音和风格的发音人，例如zh-CN-YunjianOnlineNatural。系统中可以通过edge-tts --list-voices 查看更多的语音和风格。
> --rate 【参数】调整语速，例如-50%，慢速了50%。
> --volume 【参数】 调整音量 例如+10% ，声音提高了10%。
> -f 【参数】指明要转换语音的文本文件，例如一个txt文件。

## 1.4语音列表
查看edge-tts支持的语音列表命令：edge-tts --list-voices，使用edge-tts --voice 语音Name即可以使用。

以下是支持中文的语音：

> Name: zh-CN-XiaoxiaoNeural
> Gender: Female
> 
> Name: zh-CN-XiaoyiNeural
> Gender: Female
> 
> Name: zh-CN-YunjianNeural
> Gender: Male
> 
> Name: zh-CN-YunxiNeural
> Gender: Male
> 
> Name: zh-CN-YunxiaNeural
> Gender: Male
> 
> Name: zh-CN-YunyangNeural
> Gender: Male
> 
> Name: zh-CN-liaoning-XiaobeiNeural
> Gender: Female
> 
> Name: zh-CN-shaanxi-XiaoniNeural
> Gender: Female
> 
> Name: zh-HK-HiuGaaiNeural
> Gender: Female
> 
> Name: zh-HK-HiuMaanNeural
> Gender: Female

## 1.5 常用命令实例

```
#使用命令行Edge-TTS来产生语音
edge-tts --text "Hello, world!" --write-media hello.mp3

#edge-tts查看支持的语音。
edge-tts --list-voices

#添加--voice命令，指定输出的语音。
edge-tts --voice zh-CN-YunxiNeural --text "hello 大家好" --write-media hello.mp3

#添加rate与volume指令调整语速与音量
edge-tts --voice zh-CN-YunxiNeural --rate=-4% --text "hello 大家好" --write-media hello1.mp3
edge-tts --voice zh-CN-YunxiNeural --volume=-4% --text "hello 大家好" --write-media hello1.mp3
rate=-4% 意思是语速降低4%，volume=-4%意思是音量降低4%，当然若是加号，便是增加多少。
```

## 1.6使用示例

```
edge-tts --voice zh-CN-YunxiNeural --rate=-4% --text "hello 大家好,我是Python与
Django学习的小编，欢迎大家阅读我的文章，如果喜欢请点赞收藏转发！谢谢您！" --write-media hello1.mp3
#输出结果
WEBVTT

00:00:00.102 --> 00:00:03.592
hello 大家 好 我 是 Python 与 Django 学习 的

00:00:03.605 --> 00:00:07.563
小编 欢迎 大 家阅读 我 的 文章 如果 喜欢 请

00:00:07.563 --> 00:00:10.039
点赞 收藏 转发 谢谢 您

```
输出的mp3,大家请试听

## 1.7批量实现文本转换为语音

通过打开本地 demo.txt 文本，将其传递传递给edge-tts进行语音转化。通过decode函数转换一下，是为了字符类型报错。
```python
import edge_tts
import asyncio
TEXT = ""
with open ('demo.txt','rb') as f:
    data = f.read()
    TEXT = data.decode('utf-8')
print(TEXT)
voice = 'zh-CN-YunxiNeural'
output = 'demo.mp3'
rate = '-4%'
volume = '+0%'
async def my_function():
    tts = edge_tts.Communicate(text = TEXT,voice = voice,rate = rate,volume=volume)
    await tts.save(output)
if __name__ == '__main__':
    asyncio.run(my_function())
```    
使用async进行异步请求，若是直接运行，会提示如下错误

RuntimeWarning: coroutine 'Communicate.save' was never awaited
  tts.save(output)
RuntimeWarning: Enable tracemalloc to get the object allocation traceback
将本文第一段转换成语音。

项目地址：https://github.com/rany2/edge-tts
 
===================================================
===================================================
# 2.为edge-tts生成的字幕srt文件加上标点符号
下面的命令 生成的字幕srt文件没有标点符号，请对照 edge-tts-input-demo-fragment.txt 给story_male_cn.srt加上标点符号，可以用shell或python编码实现
```sh
edge-tts --voice zh-CN-YunxiNeural --file ./edge-tts-input-demo-fragment.txt --write-media story_male_cn.mp3 --write-subtitles story_male_cn.srt
```

下面我为你提供一个Python脚本，可以根据原始文本文件中的标点，为edge-tts生成的SRT字幕文件添加正确的标点符号。这个脚本会比对时间戳和文本内容，智能地将标点符号插入到合适的位置。
```python
import re
import sys
from pathlib import Path

def read_srt_file(srt_path):
    """读取SRT文件并解析为条目列表"""
    srt_items = []
    with open(srt_path, 'r', encoding='utf-8') as f:
        content = f.read().strip()
        items = re.split(r'\n\s*\n', content)
        
        for item in items:
            if not item.strip():
                continue
                
            parts = item.strip().split('\n')
            if len(parts) < 3:
                continue
                
            index = parts[0].strip()
            timecode = parts[1].strip()
            text_lines = parts[2:]
            
            srt_items.append({
                'index': index,
                'timecode': timecode,
                'text': ' '.join(text_lines).replace('\n', ' ').strip()
            })
            
    return srt_items

def read_original_text(text_path):
    """读取原始文本文件并处理"""
    with open(text_path, 'r', encoding='utf-8') as f:
        content = f.read()
        # 移除多余的空白字符但保留段落结构
        # content = re.sub(r'[ \t]+', ' ', content)
        # content = re.sub(r'\n+', '\n', content)
        content = re.sub(r'[\s]', '', content)        
        return content.strip()

def find_best_matching_segment(aOriginalText, aSrtText, aStartPos_originalTextNoPunct=0):
    """在原始文本中找到最匹配SRT片段的位置"""
    aSrtText = aSrtText.strip()
    if not aSrtText:
        return (0, 0, "")
    # ---------------------------------
    # # 移除SRT文本中的标点符号以进行初始匹配
    srt_text_no_punct = re.sub(r'[^\w\s]', '', aSrtText)
    original_text_no_punct = re.sub(r'[^\w\s]', '', aOriginalText) 
    
    # 使用滑动窗口找到最佳匹配位置
    window_size = len(srt_text_no_punct)
    best_score = 0
    best_start = aStartPos_originalTextNoPunct
    best_end = aStartPos_originalTextNoPunct
    
    # 限制搜索范围，避免在整个文本中查找
    search_end = min(aStartPos_originalTextNoPunct + window_size * 3, 
                     len(original_text_no_punct) )
    
    rangeStart = max(0, aStartPos_originalTextNoPunct - window_size)
    for i in range(rangeStart, search_end - window_size + 1):
        window = original_text_no_punct[i:i+window_size]
        # 计算匹配字符数
        match_count = sum(1 for a, b in zip(window, srt_text_no_punct) if a == b)
        score = match_count / window_size
        
        if score > best_score:
            best_score = score
            best_start = i
            best_end = i + window_size

    # ---------------------------------
    # 映射回原始文本中的位置（含标点）
    original_start = 0
    count = 0
    for pos, char in enumerate(aOriginalText):
        if re.match(r'\w', char):
            if count == best_start:
                original_start = pos
                break
            count += 1
    
    original_end = original_start
    count = 0
    for pos in range(original_start, len(aOriginalText)):
        dbgLetter00 = aOriginalText[pos]
        print(dbgLetter00)
        if re.match(r'\w', aOriginalText[pos]):
            if count == window_size - 1:
                # # 扩展到完整单词
                # while pos < len(aOriginalText) and re.match(r'\w', aOriginalText[pos]):
                #     dbgLetter01 = aOriginalText[pos]
                #     print(dbgLetter01)
                #     pos += 1

                original_end = pos
                break
            count += 1
    
    # 获取包含标点的文本片段
    original_segment = aOriginalText[original_start : original_end + 1]
    
    # 如果匹配度太低，可能是错误匹配
    if best_score < 0.7:
        return (0, 0, "")
    
    return (best_start,best_end,original_segment)

def insert_punctuation_keep_length(srt_text, original_segment):
    """在保持原有文字数量不变的情况下插入标点符号"""
    if not srt_text or not original_segment:
        return srt_text
    
    # 移除原始片段中的空白字符以便分析标点位置
    original_no_whitespace = re.sub(r'\s', '', original_segment)
    srt_no_whitespace = re.sub(r'\s', '', srt_text)
    
    # # 如果文本内容不匹配，直接返回原文本
    # if len(srt_no_whitespace) != len(original_no_whitespace):
    #     return srt_text
    original_segment = original_no_whitespace
    srt_text = srt_no_whitespace
    
    # 记录原始文本中的标点位置和符号
    punct_positions = {}
    original_pos = 0
    for i, char in enumerate(original_segment):
        if not char.isspace():
            if not char.isalnum():  # 非字母数字字符视为标点
                punct_positions[original_pos] = char
            original_pos += 1
    
    # 在SRT文本的对应位置插入标点
    result = []
    srt_pos = 0
    for char in srt_text:
        if char.isspace():
            result.append(char)
        else:
            # 检查是否需要在当前位置插入标点
            if srt_pos in punct_positions:
                result.append(punct_positions[srt_pos])
            result.append(char)
            srt_pos += 1
    
    # 检查末尾是否有标点
    if srt_pos in punct_positions:
        result.append(punct_positions[srt_pos])
    
    return ''.join(result)

def restore_punctuation(srt_items, original_text):
    """恢复SRT字幕中的标点符号，保持原有文字数量不变"""
    current_pos = 0
    new_srt_items = []
    
    for item in srt_items:
        srt_text = item['text']
        itemIdx = item["index"]
        if (itemIdx == '23'):
            pass

        # 移除SRT文本中的标点符号 
        srt_text_1 = re.sub(r'[^\w\s]', '', srt_text) 
        # 移除SRT文本中的空字符 
        srt_text_1 = re.sub(r'[\s]', '', srt_text_1)    

        start, end, original_segment = find_best_matching_segment(
            original_text, srt_text_1, current_pos
        )
        
        if original_segment:
            # 保持原有文字数量不变，只插入标点
            # new_text = insert_punctuation_keep_length(srt_text, original_segment)
            new_text = original_segment
            
            new_srt_items.append({
                'index': item['index'],
                'timecode': item['timecode'],
                'text': new_text
            })
            current_pos = end
        else:
            # 如果找不到匹配，使用原始SRT文本
            new_srt_items.append(item)
    
    return new_srt_items

def write_srt_file(srt_items, output_path):
    """将处理后的SRT条目写入文件"""
    with open(output_path, 'w', encoding='utf-8') as f:
        for item in srt_items:
            f.write(f"{item['index']}\n")
            f.write(f"{item['timecode']}\n")
            f.write(f"{item['text']}\n\n")

def main():
    import argparse
    parser = argparse.ArgumentParser(description='为edge-tts生成的SRT字幕恢复标点符号，保持文字数量不变')
    parser.add_argument('--input-srt', required=True, help='edge-tts生成的SRT文件路径')
    parser.add_argument('--original-text', required=True, help='原始文本文件路径')
    parser.add_argument('--output-srt', help='输出的SRT文件路径，默认在原文件名后加_punct')
    
    args = parser.parse_args()
    
    input_srt = Path(args.input_srt)
    original_text = Path(args.original_text)
    
    if not args.output_srt:
        output_srt = input_srt.parent / f"{input_srt.stem}_punct{input_srt.suffix}"
    else:
        output_srt = Path(args.output_srt)
    
    try:
        # 读取文件
        srt_items = read_srt_file(input_srt)
        original_content = read_original_text(original_text)
        
        # 恢复标点
        new_srt_items = restore_punctuation(srt_items, original_content)
        
        # 写入结果
        write_srt_file(new_srt_items, output_srt)
        
        print(f"已成功恢复标点并保存到: {output_srt}")
        
    except Exception as e:
        print(f"处理过程中出错: {str(e)}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()    
```

使用方法：
1. 保存脚本为 `restore_srt_punctuation.py`
2. 运行命令：
```bash
python restore_srt_punctuation.py --input-srt story_male_cn.srt --original-text edge-tts-input-demo-fragment.txt
```
3. 脚本会生成一个新的SRT文件 `story_male_cn_punct.srt`，其中包含恢复的标点符号

这个脚本的工作原理是：
1. 读取原始文本文件和edge-tts生成的SRT文件
2. 分析每个字幕片段在原始文本中的最佳匹配位置
3. 从原始文本中提取包含标点的对应片段
4. 生成新的SRT文件，保留原有的时间码和序号

如果需要调整匹配的精度，可以修改脚本中的 `best_score` 阈值（默认0.7）。

===============================================================
# 3. edge-tts 的srt文件输出合理化

针对 edge-tts 生成的 SRT 文件时间轴与语音停顿不匹配的问题，我可以提供一个 Python 脚本解决方案。这个脚本会分析音频的能量分布，识别静音段作为自然停顿点，并据此重新分割字幕，使字幕时间轴更符合人类听觉习惯。

### 解决方案：音频能量分析重排字幕

这个方案需要使用 `pydub` 库来分析音频的能量分布，识别静音段作为自然停顿点：

```python
# edge_tts_srt_refiner.py
import argparse
import os
from pydub import AudioSegment
from pydub.silence import detect_silence
import srt
import datetime

def analyze_audio(audio_file, min_silence_len=500, silence_thresh=-40):
    """分析音频文件，识别静音段作为潜在的字幕分割点"""
    audio = AudioSegment.from_file(audio_file)
    # 检测静音段，返回静音段的起始和结束时间（毫秒）
    silent_ranges = detect_silence(
        audio,
        min_silence_len=min_silence_len,
        silence_thresh=silence_thresh,
        seek_step=100
    )
    return silent_ranges, len(audio)

def refine_srt(srt_file, silent_ranges, audio_length, max_line_duration=8000):
    """根据音频分析结果优化SRT文件"""
    with open(srt_file, 'r', encoding='utf-8') as f:
        subs = list(srt.parse(f.read()))
    
    refined_subs = []
    current_sub_index = 0
    
    # 处理每个检测到的静音段
    for start_silence, end_silence in silent_ranges:
        # 转换为datetime格式
        start_time = datetime.timedelta(milliseconds=start_silence)
        end_time = datetime.timedelta(milliseconds=end_silence)
        
        # 找到包含此静音段的字幕
        while current_sub_index < len(subs) and subs[current_sub_index].end < start_time:
            current_sub_index += 1
        
        if current_sub_index >= len(subs):
            break
        
        current_sub = subs[current_sub_index]
        
        # 如果静音段在字幕中间，分割字幕
        if current_sub.start < start_time < current_sub.end:
            # 创建新的前半段子字幕
            part1 = srt.Subtitle(
                index=len(refined_subs) + 1,
                start=current_sub.start,
                end=start_time,
                content=current_sub.content
            )
            
            # 创建新的后半段子字幕
            part2 = srt.Subtitle(
                index=len(refined_subs) + 2,
                start=end_time,
                end=current_sub.end,
                content=current_sub.content
            )
            
            refined_subs.append(part1)
            refined_subs.append(part2)
            current_sub_index += 1
        else:
            # 如果静音段不在字幕中间，保留原字幕
            refined_subs.append(current_sub)
            current_sub_index += 1
    
    # 添加剩余的字幕
    while current_sub_index < len(subs):
        refined_subs.append(subs[current_sub_index])
        current_sub_index += 1
    
    # 检查并拆分过长的字幕
    final_subs = []
    for sub in refined_subs:
        duration = (sub.end - sub.start).total_seconds() * 1000
        if duration > max_line_duration:
            # 过长的字幕需要进一步拆分
            parts = split_long_subtitle(sub, max_line_duration)
            final_subs.extend(parts)
        else:
            final_subs.append(sub)
    
    # 重新编号
    for i, sub in enumerate(final_subs):
        sub.index = i + 1
    
    return final_subs

def split_long_subtitle(sub, max_duration):
    """拆分过长的字幕"""
    content = sub.content
    lines = content.split('\n')
    parts = []
    
    # 简单地按行分割
    current_start = sub.start
    max_ms = datetime.timedelta(milliseconds=max_duration)
    
    for line in lines:
        if not line.strip():
            continue
            
        # 估计这一行的持续时间
        line_duration = len(line) * 200  # 假设每字符200ms，可根据实际情况调整
        line_duration = min(line_duration, max_duration)
        line_end = current_start + datetime.timedelta(milliseconds=line_duration)
        
        # 如果这一行会使字幕过长，则调整结束时间
        if line_end > sub.end:
            line_end = sub.end
        
        part = srt.Subtitle(
            index=0,  # 稍后会重新编号
            start=current_start,
            end=line_end,
            content=line
        )
        parts.append(part)
        
        current_start = line_end
        
        # 如果已经到达原字幕的结束时间，停止分割
        if current_start >= sub.end:
            break
    
    return parts

def main():
    parser = argparse.ArgumentParser(description='优化edge-tts生成的SRT文件')
    parser.add_argument('--audio', required=True, help='音频文件路径')
    parser.add_argument('--srt', required=True, help='原始SRT文件路径')
    parser.add_argument('--output', required=True, help='输出优化后的SRT文件路径')
    parser.add_argument('--min-silence', type=int, default=500, help='最小静音长度(ms)')
    parser.add_argument('--silence-thresh', type=int, default=-40, help='静音阈值(dBFS)')
    parser.add_argument('--max-duration', type=int, default=8000, help='单个字幕最大持续时间(ms)')
    
    args = parser.parse_args()
    
    # 分析音频
    silent_ranges, audio_length = analyze_audio(
        args.audio, 
        min_silence_len=args.min_silence, 
        silence_thresh=args.silence_thresh
    )
    
    # 优化SRT
    refined_subs = refine_srt(args.srt, silent_ranges, audio_length, args.max_duration)
    
    # 写入新的SRT文件
    with open(args.output, 'w', encoding='utf-8') as f:
        f.write(srt.compose(refined_subs))
    
    print(f"优化完成，已保存到 {args.output}")

if __name__ == "__main__":
    main()    
```
    


### 使用方法

1. 安装依赖库：
```bash
pip install pydub srt argparse
```

2. 运行脚本：
```bash
python srt_refiner.py --audio 语音文件.mp3 --srt 原始字幕.srt --output 优化后字幕.srt
```

### 参数说明

- `--audio`：edge-tts生成的音频文件路径
- `--srt`：对应的原始SRT文件路径
- `--output`：优化后的SRT文件保存路径
- `--min-silence`：最小静音长度（毫秒），默认500ms
- `--silence-thresh`：静音阈值（dBFS），默认-40dBFS
- `--max-duration`：单个字幕最大持续时间（毫秒），默认8000ms

### 工作原理

这个脚本通过以下步骤优化字幕：

1. **音频分析**：使用 `pydub` 检测音频中的静音段，这些静音段通常对应自然的语音停顿
2. **字幕分割**：根据静音段位置，将过长的字幕分割成多个更短的字幕
3. **持续时间控制**：确保每个字幕不会过长，避免观众阅读压力过大
4. **内容调整**：智能分割字幕内容，保持语义完整性

通过这种方式生成的SRT文件会更符合人类听觉习惯，字幕出现和消失的时间点与语音停顿更加匹配，提升观看体验。