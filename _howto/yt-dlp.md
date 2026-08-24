# 1.yt-dlp

⚠️重要提醒：`you‑get`对 Youtube 支持已经比较老旧，很多时候解析失败。**更推荐 `yt‑dlp` 作为替代**，对 YouTube 适配更好。

### ✅正确安装命令（conda base环境，Ubuntu）
```bash
pip install yt-dlp
```

>推荐完整版（带上全套依赖，处理youtube分片、加密更好）：
```bash
pip install -U "yt-dlp[default]"
```

验证是否装好：
```bash
yt-dlp --version
```

### 下载YouTube播放列表示例（**URL必须加双引号**）
```bash
yt-dlp "https://www.youtube.com/watch?v=J2mkbDb8b4k&list=PLGHe6Moaz52My7w7pr3jpDL_2FqzljfWd"
```

### 使用代理（和之前you-get一样，替换为你的本地代理端口）
```bash
yt-dlp --proxy http://127.0.0.1:7890 "https://www.youtube.com/watch?v=J2mkbDb8b4k&list=PLGHe6Moaz52My7w7pr3jpDL_2FqzljfWd"
```

### 必备：安装ffmpeg（合并音视频分片，否则只有画面/只有声音）
Ubuntu：
```bash
sudo apt update
sudo apt install ffmpeg
```

>法律提示：仅下载你拥有版权或已获得授权的资源，遵守网站用户协议与著作权法。

---
### 常见小坑
1. 复制网页文本经常把 `-` 变成长破折号，手敲一遍 `yt-dlp` 最稳妥。
2. conda环境下如果提示command not found，用 `python -m yt_dlp` 调用。
3. yt‑dlp自动识别playlist链接，不需要额外加`--playlist`参数。

需要我给你一份yt‑dlp高频常用参数速查表吗？


=============================================

# 2.yt-dlp 字幕完整用法
>前提：**FFmpeg必须装好**，否则无法转换、嵌入字幕。
>区分两类字幕：
1. `--write‑subs`：作者**手动上传字幕**（CC字幕，质量高）
2. `--write‑auto‑subs`：YouTube**机器自动生成字幕**（大部分无CC的视频有这个）

>⚠️ `--embed‑subs`：是**软字幕（字幕轨道，播放器可以开关）**，不是烧录硬字幕，MP4/MKV支持；MP4对多字幕轨道兼容性一般，MKV最佳。

## ✅最稳妥完整命令（YouTube，同时获取手动+自动字幕，中英，嵌入视频，输出mkv）
```bash
yt-dlp \
--write-subs \
--write-auto-subs \
--sub-langs "zh-Hans,zh‑CN,en" \
--convert-subs srt \
--embed-subs \
--merge-output-format mkv \
--proxy http://127.0.0.1:7897 \
"https://www.youtube.com/watch?v=J2mkbDb8b4k&list=PLGHe6Moaz52My7w7pr3jpDL_2FqzljfWd"

#-----------
yt-dlp --write-subs --write-auto-subs --sub-langs "en" --convert-subs srt \
--embed-subs --merge-output-format mkv \
--proxy http://127.0.0.1:7897 \
"https://www.youtube.com/watch?v=pHlmN9Q28XM"

```
参数解释：
- `--write‑subs`：下载作者上传字幕
- `--write‑auto‑subs`：下载油管AI自动字幕（很多视频只有这个）
- `--sub‑langs "zh‑Hans,zh‑CN,en"`：优先简体中文、英文；写`all`下载全部语言
- `--convert‑subs srt`：把原生vtt字幕转成通用srt格式
- `--embed‑subs`：把字幕封装进视频文件内（软字幕）
- `--merge‑output‑format mkv`：输出mkv，多字幕轨道兼容性最好；如果一定要mp4，改成`mp4`，但mp4对多字幕支持差。

## 只想下载字幕文件（不下载视频）
```bash
yt-dlp --write-subs --write-auto-subs --sub-langs "zh-Hans,en" --convert-subs srt --skip-download "视频链接"
```

## 先查看这个视频到底有哪些字幕（排错神器）
```bash
yt-dlp --list-subs "视频链接"
```
会列出所有可用字幕：手动、自动生成，语言代码。没有显示=该视频没有字幕资源，工具无法凭空生成字幕。

## 播放列表下载
上面命令直接给playlist链接即可，yt‑dlp自动遍历全部视频。

## 常见坑
### 1). **字幕没有嵌入视频**
- 确认安装ffmpeg；mkv格式比mp4更适合多字幕轨道。
- `--embed‑subs`必须配合`--write‑subs / --write‑auto‑subs`，只写embed不写write不会下载字幕。

### 2). 只有英文自动字幕，没有中文：YouTube没有生成该视频的中文自动字幕，工具无法翻译。

### 3). 想要**硬字幕（画面烧进去，不能关闭）**
yt‑dlp本身不做烧录，下载完srt字幕之后，用ffmpeg手动烧录：
```bash
ffmpeg -i input.mkv -vf subtitles="input.srt" output_hardsub.mp4
```

### 4). 播放端看不到字幕：
mkv用VLC/MPV播放器；普通mp4播放器很多不识别内嵌字幕轨道。

>法律提示：仅下载你拥有版权或已获得授权的资源，遵守网站用户协议和著作权法。

如果你需要，我给你整理一份可以直接复制的yt‑dlp最佳实践模板（下载播放列表+字幕+代理）。
