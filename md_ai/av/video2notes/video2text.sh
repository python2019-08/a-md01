#!/bin/bash

work_dir=/home/abner/abner2/zdev/sh/work04
if [ ! -d "$work_dir" ];then 
    echo "------1"
    mkdir -p $work_dir
    echo  "create folder $work_dir"
fi

echo "1----------------download mp4 from bilibili---------------------------------------"
fileList=$( ls $work_dir/*.mp4 )
echo "1...fileList== $fileList.............."
if [ -z  "$fileList" ]; then
    echo  "mp4 fileList is empty, so use you-get to download mp4"
    mp4Url="https://www.bilibili.com/video/BV12G4y1k76a/?vd_source=4212b105520112daf65694a1e5944e23"   
    you-get -o "${work_dir}"  $mp4Url
fi

echo "2-------------------------------------------------------"
fileList=$( ls $work_dir/*.mp4 )
echo "2...fileList== $fileList.............."
for fileName in "${fileList}"
do
    echo "....fileName=$fileName"
    mv "$fileName"  "$work_dir/input.mp4"  
done

fileList=$( ls $work_dir/*.mp4 )
echo "2.1..fileList== $fileList.............."
if [ -z  "$fileList" ]; then
    exit -2
fi
echo "3-------------------------------------------------------"

 
# 从mp4中抽取 音频信息，转成mp3
# ffmpeg -i input.mp4 -vn -acodec libmp3lame output.mp3
input_mp4_path=${work_dir}/input.mp4
ffmpeg -i ${input_mp4_path}   -vn -acodec libmp3lame ${work_dir}/output.mp3

#---从mp3 转成 wav
#--- the [whisper-cli] currently **runs only with 16-bit WAV** files.
# ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav
ffmpeg -i ${work_dir}/output.mp3 -ar 16000 -ac 1 -c:a pcm_s16le ${work_dir}/output.wav

# whisper.cpp把 音频 转成 文字, output 例子见 whisper_cpp_subtitles_cn.txt && whisper_cpp_subtitles_en.txt
# ./build/bin/whisper-cli   -l zh  -m  models/ggml-medium.bin   -f ~/abner2/zdev/ai/av/video2note/output.wav
whisper_cpp_rootDir=/mnt/disk2/abner/zdev/ai/av/whisper.cpp
# ${whisper_cpp_rootDir}/build/bin/whisper-cli   -l zh  -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  -f  ${work_dir}/output.wav > ${work_dir}/out_subtitles_cn.txt

${whisper_cpp_rootDir}/build/bin/whisper-cli   -l en  -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  -f  ${work_dir}/output.wav > ${work_dir}/out_subtitles_en.txt
#${whisper_cpp_rootDir}/build/bin/whisper-cli  -l en  -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  -f  ./output.wav > ${work_dir}/out_subtitles_en.txt
