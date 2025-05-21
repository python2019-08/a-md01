#!/bin/bash

# 输入视频文件
input_file="input.mp4"

# 临时文件，用于存储帧信息
info_file="frames_info.txt"

# 提取关键帧并保存帧信息
ffmpeg -skip_frame nokey -i "$input_file" -vsync vfr -q:v 2 -vf "showinfo" -f null - 2> "$info_file"

# 逐行读取帧信息文件
while IFS= read -r line; do
    if [[ $line == *"iskey:1"* ]]; then
        # 提取时间戳
        timestamp=$(echo "$line" | grep -oP 'pts_time:\K[^ ]+')
        # 生成输出文件名
        output_file="kf/${timestamp//./_}.jpg"
        # 提取关键帧并保存
        ffmpeg -ss "$timestamp" -i "$input_file" -vframes 1 -q:v 2 "$output_file"
    fi
done < "$info_file"

# 删除临时文件
rm "$info_file"

echo "关键帧已提取并保存，文件名以时间戳命名。"