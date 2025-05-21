#!/bin/bash


if [ $# > 0 ]; then
    echo "param-count=$# ...  param1=$1 -----------------"
fi 
 

work_dir=/home/abner/abner2/zdev/sh/work
if [ ! -d ${work_dir} ]; then
    echo "work_dir..1==${work_dir} not exist, to create it."
    mkdir -p ${work_dir}
fi

 
if [ -d ${work_dir} ]; then
    echo "work_dir..2==${work_dir} is created."
fi

 
input_file="input.mp4" # 输入视频文件
fileList=$(ls ${work_dir}/*.mp4)
if [ -z fileList ]; then
    echo "fileList..is empty"
else
    echo "fileList..1==${fileList}"
    input_file=${fileList[0]}
    echo "input_file..1==${input_file}"
fi



keyFrame_dir=${work_dir}/kf
if [ ! -d ${keyFrame_dir} ]; then
    echo "keyFrame_dir..1==${keyFrame_dir} not exist, to create it."
    mkdir -p ${keyFrame_dir}
else
    echo "keyFrame_dir..1==${keyFrame_dir} exist, to rm *."
    isClean0=$1
    isClean=${isClean0:=0}
    echo "isClean=${isClean}"
    if [ isClean!=0 ]; then
        rm ${keyFrame_dir}/*
        # exit
    fi
fi

 
  
# 运行 ffmpeg 命令并将输出保存到文件
# ffmpeg -skip_frame nokey -i "$input_file" -vsync vfr -q:v 2 -f image2 -update 1 "$output_image" -vf "showinfo" -an -f null - 2> keyframes_info.txt

ffmpeg -skip_frame nokey -i "${input_file}" -vsync vfr -q:v 2 -vf "showinfo"  -an   ${keyFrame_dir}/output_%03d.jpg 2>${work_dir}/keyframes_info.txt


# 提取关键帧的时间点
grep "iskey:1" ${work_dir}/keyframes_info.txt | awk '{print $4}' | cut -d ':' -f 2 > ${work_dir}/keyframes_timestamps.txt

echo "关键帧信息已保存到 ${work_dir}/keyframes_info.txt"
echo "关键帧时间点已保存到 ${work_dir}/keyframes_timestamps.txt"

# ----------------------------------------
# ----------------------------------------
# work_dir=/home/abner/abner2/zdev/sh/work
# keyFrame_dir=${work_dir}/kf


# 将指定目录下的所有 .jpg 文件存储到数组中
keyFrameList=("$keyFrame_dir"/*.jpg)
# 检查数组是否为空
if [ ${#keyFrameList[@]} -eq 0 ]; then
    echo "keyFrameList..is empty"
    exit 1
else
    echo "keyFrameList..is NOT empty,${#keyFrameList[@]}"     
fi
 
rm $work_dir/note.md 


jpg_file="input.jpg" # 输入视频文件
for jpg_file in "${keyFrameList[@]}"
do
    filename=$(basename "$jpg_file")
    echo "....jpg_file=$jpg_file,filename=$filename"
    
    echo  "![$filename](kf/$filename)" >> "$work_dir/note.md"  
done

