#!/bin/bash
# 
# (base) abner@abner-XPS:~/Downloads/compu-shd$ ls
# chname.py                                       P1.-003-Welcome-to-the-course.mp4           
# dd.sh                                           P11.-006-Challenge-Draw-a-polygon-.mp.mp4   
# P10.-005-Mesh-deformation.mp3                   P12.-001-Setting-up-the-rendering-.mp.mp4   
# P10.-005-Mesh-deformation.mp4                   P13.-002-A-simple-blur-effect.mp4           
# P10.-005-Mesh-deformation_out_subtitles_en.txt  P14.-003-Night-vision-lenses.mp4           
# P10.-005-Mesh-deformation.wav                   P15.-004-A-HUD-overlay---part-1.mp4        


work_dir=$(pwd)
echo "workDir=${work_dir}"

fileList=("$work_dir"/*.mp4)
# 检查数组是否为空
if [ ${#fileList[@]} -eq 0 ]; then
    echo "fileList..is empty"
    exit 1
else
    echo "fileList..is NOT empty,${#fileList[@]}"     
fi
  

for fn in "${fileList[@]}"; do 
    echo "..........................................."
    baseName=$(basename "$fn" .mp4)
    baseName1="${fn%.*}"
    echo "....jpg_file=$fn,,,,baseName=$baseName,,,,baseName1=${baseName1}"

    
    input_mp4_path=${work_dir}/${baseName}.mp4
    ffmpeg -i ${input_mp4_path} -vn -acodec libmp3lame ${work_dir}/${baseName}.mp3

    #---从mp3 转成 wav
    #--- the [whisper-cli] currently **runs only with 16-bit WAV** files. 
    ffmpeg -i ${work_dir}/${baseName}.mp3 -ar 16000 -ac 1 -c:a pcm_s16le ${work_dir}/${baseName}.wav

    rm ${work_dir}/${baseName}.mp3

    # whisper.cpp把 音频 转成 文字, output 例子见 whisper_cpp_subtitles_cn.txt && whisper_cpp_subtitles_en.txt
    whisper_cpp_rootDir=/mnt/disk2/abner/zdev/ai/av/whisper.cpp
    ${whisper_cpp_rootDir}/build/bin/whisper-cli   -l zh  \
            -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  \
            -f  ${work_dir}/${baseName}.wav \
            --max-line-count 1 > ${work_dir}/${baseName}_out_subtitles_cn.txt

    # ${whisper_cpp_rootDir}/build/bin/whisper-cli -l en  \
    #         -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  \
    #         -f  ${work_dir}/${baseName}.wav > ${work_dir}/${baseName}_out_subtitles_en.txt

    #${whisper_cpp_rootDir}/build/bin/whisper-cli  -l en  -m  ${whisper_cpp_rootDir}/models/ggml-medium.bin  -f  ${work_dir}/${baseName}.wav > ${work_dir}/${baseName}_out_subtitles_en.txt

    break
done

