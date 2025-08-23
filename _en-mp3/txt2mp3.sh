#!/bin/bash
#----
 
startTm=$(date)   
# 添加 Conda 检查：先检查 Conda 是否可用，避免后续命令报错。
# 初始化 Conda（如果尚未初始化）
if ! command -v conda &> /dev/null; then
    echo "错误：未找到 Conda。请确保 Conda 已安装。"
    exit 1
fi

# 初始化 Conda shell 环境：
# 使用 eval "$(conda shell.bash hook)" 初始化当前脚本的 shell 环境，这是激活 Conda 环境的正确方式。
eval "$(conda shell.bash hook)"


# activate env 
conda activate base
# #+++++++++++ male +++++++++++++
if false; then # This block never run. 
#+++++++++++++ male +++++++++++++
edge-tts --voice zh-CN-YunxiNeural --file ./edge-tts-input-demo.txt \
        --write-media hello_in_cn.mp3 --write-subtitles hello_in_cn.srt
#+++++++++++++ female +++++++++++++
edge-tts --voice zh-CN-XiaoxiaoNeural  --file ./edge-tts-input-demo.txt \
        --write-media hello_in_cn.mp3 --write-subtitles hello_in_cn.srt
fi

# ++++++++++++++++++++++++++++++++++++++++
file_path="$0"
dir_path=$(dirname "$file_path")
echo "$dir_path"
 
work_dir=${dir_path}/037stress
filePrefix=L037
echo "work_dir=${work_dir}"

for idx in $(seq  2   2); do
    if [ ! -f "${work_dir}/${filePrefix}-${idx}.txt" ]; then
        echo "${work_dir}/${filePrefix}-${idx}.txt NOT exist..."
        continue
    fi

    echo "edge-tts --file  ${work_dir}/${filePrefix}-${idx}.txt ......."

    edge-tts --voice en-US-AnaNeural   \
            --file        ${work_dir}/${filePrefix}-${idx}.txt  \
            --write-media ${work_dir}/${filePrefix}-${idx}.mp3
done

# ++++++++++++++++++++++++++++++++++++++++
endTm=$(date) 
echo "${startTm}\n ${endTm}"