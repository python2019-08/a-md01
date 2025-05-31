#!/bin/bash
# 批量改名
# mv ./noup-bug-fix.txt   bug-fix.txt
# mv ./noup-work-note.txt  work-note.txt
startTm=$(date +%Y/%m/%d--%H:%M:%S)

fileList=(./noup*)
for fn in "${fileList[@]}"
do
    echo ${fn}----${fn#./noup-}
    mv  ${fn} ${fn#./noup-}
done 

endTm=$(date +%Y/%m/%d--%H:%M:%S)
printf "${startTm}----${endTm}\n"  