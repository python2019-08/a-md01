#!/bin/bash
echo "param 0=$0"
echo "dirname=$(dirname "$0")"

readonly base_name="$(basename "$0")"
echo "base_name= $base_name..."
# --------------
BASE_PATH=$(cd "$(dirname "$0")"; pwd)
echo $BASE_PATH

ARGS_PRIVATE_REPO=${1-}
echo ARGS_PRIVATE_REPO=$ARGS_PRIVATE_REPO

# -----------------------------
workDir=$(pwd)
startTm=$(date +%Y/%m/%d--%H:%M:%S)
image_pattern=""

coverImgList=("${workDir}/cover.png"  
               "$workDir"/cover.jpeg
               "$workDir"/cover.jpg )
for imgItem in "${coverImgList[@]}" 
do
  echo "imgItem=${imgItem}"  
  if [ -f "$imgItem" ]; then
    image_pattern=${imgItem}  
  fi
done
echo "image_pattern=${image_pattern}"
if [ -z "$image_pattern" ]; then
    echo "plugin_list is not exist"
fi


WHISPER_LANG=zh
WHISPER_LANG="${WHISPER_LANG:-en}";
echo $WHISPER_LANG

endTm=$(date +%Y/%m/%d--%H:%M:%S)
printf "${startTm}----${endTm}\n"  