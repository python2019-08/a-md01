# ffmpeg 合并多个wav

FFmpeg 是一个强大的开源音视频处理工具，可使用它来合并多个 WAV 文件。下面为你介绍几种常见的合并方法。

### 方法一：使用 `concat` 协议
这种方法适用于合并多个连续播放的 WAV 文件。

#### 步骤
1. **创建文件列表**：把要合并的 WAV 文件路径记录在一个文本文件里，每行一个文件路径。示例如下：
```plaintext
file 'file1.wav'
file 'file2.wav'
file 'file3.wav'
```
将上述内容保存为 `list.txt`。

2. **执行合并命令**：在终端中运行以下命令来合并这些文件：
```bash
ffmpeg -f concat -safe 0 -i list.txt -c copy output.wav
```
#### 命令解释
- `-f concat`：指定输入文件的格式为 `concat`，也就是文件列表格式。
- `-safe 0`：允许使用绝对路径。若文件路径为相对路径，可省略此参数。
- `-i list.txt`：指定文件列表的路径。
- `-c copy`：直接复制音频流，不进行重新编码，这样可以加快合并速度，同时保证音频质量。
- `output.wav`：指定合并后的输出文件路径。

### 方法二：使用 `amix` 滤镜
这种方法适用于将多个 WAV 文件混合成一个音频文件，实现音频的叠加效果。

#### 命令示例
```bash
ffmpeg -i file1.wav -i file2.wav -i file3.wav -filter_complex amix=inputs=3:duration=longest output.wav
```
#### 命令解释
- `-i file1.wav -i file2.wav -i file3.wav`：依次指定要合并的 WAV 文件。
- `-filter_complex amix=inputs=3:duration=longest`：使用 `amix` 滤镜进行音频混合。`inputs=3` 表示参与混合的音频流数量为 3；`duration=longest` 表示以最长的音频文件时长作为输出音频的时长。
- `output.wav`：指定合并后的输出文件路径。

### 注意事项
- **音频参数一致性**：为避免合并后出现音频问题，建议确保所有要合并的 WAV 文件具有相同的采样率、声道数和位深度等参数。
- **文件路径问题**：若文件路径包含空格或特殊字符，需使用引号将路径括起来。

通过以上方法，你可以使用 FFmpeg 合并多个 WAV 文件，根据具体需求选择合适的合并方式。 

