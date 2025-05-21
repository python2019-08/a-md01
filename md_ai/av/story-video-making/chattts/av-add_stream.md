# 1.python的av库 的add_stream

在 Python 的 `av` 库中，`add_stream` 是 `av.container.OutputContainer` 对象的一个方法，用于向输出容器（如视频文件、音频文件等）中添加一个新的流（可以是视频流、音频流或字幕流）。以下是关于它的详细介绍：

### 基本用法
下面是一个简单的使用 `add_stream` 方法创建视频文件的示例：
```python
import av
import numpy as np

# 创建一个输出容器
output_container = av.open('output.mp4', 'w')

# 添加一个视频流，使用 H.264 编解码器
video_stream = output_container.add_stream('h264', rate=25)
video_stream.width = 640
video_stream.height = 480
video_stream.pix_fmt = 'yuv420p'

# 模拟生成一些帧数据
for i in range(100):
    frame = av.VideoFrame(width=640, height=480)
    for plane in frame.planes:
        np.fill(plane.array, i % 256)

    # 将帧编码并写入流
    for packet in video_stream.encode(frame):
        output_container.mux(packet)

# 刷新编码器，写入剩余的数据包
for packet in video_stream.encode(None):
    output_container.mux(packet)

# 关闭输出容器
output_container.close()
```
### 代码解释
1. **打开输出容器**：
```python
output_container = av.open('output.mp4', 'w')
```
使用 `av.open` 函数以写入模式打开一个名为 `output.mp4` 的文件，创建一个输出容器对象。

2. **添加视频流**：
```python
video_stream = output_container.add_stream('h264', rate=25)
video_stream.width = 640
video_stream.height = 480
video_stream.pix_fmt = 'yuv420p'
```
使用 `add_stream` 方法添加一个视频流，指定编解码器为 `h264`，帧率为 25 帧每秒。然后设置视频流的宽度、高度和像素格式。

3. **生成并编码帧数据**：
```python
for i in range(100):
    frame = av.VideoFrame(width=640, height=480)
    for plane in frame.planes:
        np.fill(plane.array, i % 256)

    for packet in video_stream.encode(frame):
        output_container.mux(packet)
```
模拟生成 100 帧视频数据，将每帧数据编码为数据包，并使用 `mux` 方法将数据包写入输出容器。

4. **刷新编码器并关闭容器**：
```python
for packet in video_stream.encode(None):
    output_container.mux(packet)

output_container.close()
```
调用 `encode(None)` 刷新编码器，确保所有剩余的数据包都被写入输出容器。最后关闭输出容器。

### `add_stream` 方法的参数
`add_stream` 方法的定义如下：
```python
add_stream(codec_name, rate=None, options=None, **kwargs)
```
- **`codec_name`**：指定要使用的编解码器的名称，如 `'h264'`、`'aac'` 等。
- **`rate`**：可选参数，指定流的帧率（对于视频流）或采样率（对于音频流）。可以是整数或 `fractions.Fraction` 对象。
- **`options`**：可选参数，一个字典，用于传递编解码器的额外选项。
- **`**kwargs`**：可变关键字参数，用于传递其他配置选项。

### 注意事项
- **编解码器支持**：不同的编解码器可能需要不同的配置选项，确保你使用的编解码器被 `av` 库支持，并且正确配置了相关参数。
- **资源管理**：在使用完输出容器后，一定要调用 `close` 方法关闭它，以释放相关资源。

通过 `add_stream` 方法，你可以方便地向输出容器中添加不同类型的流，并进行数据的编码和写入操作。