# ----------------------------------------
work_dir=/home/abner/abner2/zdev/sh/work
keyFrame_dir=${work_dir}/kf

jpg_file="input.jpg" # 输入视频文件

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

for jpg_file in "${keyFrameList[@]}"
do
    filename=$(basename "$jpg_file")
    echo "....jpg_file=$jpg_file,filename=$filename"
    
    echo  "![$filename](kf/$filename)" >> "$work_dir/note.md"  
done
