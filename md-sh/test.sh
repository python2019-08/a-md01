workDir=$(pwd)
date
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

date
WHISPER_LANG=zh
WHISPER_LANG="${WHISPER_LANG:-en}";
echo $WHISPER_LANG