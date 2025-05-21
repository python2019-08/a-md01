#+++++++++++ male +++++++++++++
edge-tts --voice zh-CN-YunxiNeural --file ./edge-tts-input-demo.txt --write-media hello_in_cn.mp3 --write-subtitles hello_in_cn.srt
#+++++++++++++ female +++++++++++++
edge-tts --voice zh-CN-XiaoxiaoNeural  --file ./edge-tts-input-demo.txt --write-media hello_in_cn.mp3 --write-subtitles hello_in_cn.srt


#+++++++++++++ male +++++++++++++
work_dir=./
# edge-tts --voice zh-CN-YunxiNeural --file ./edge-tts-input-demo-fragment.txt --write-media male_cn_frag.mp3
edge-tts --voice zh-CN-YunxiNeural --file ./edge-tts-input-demo-fragment.txt --write-media story_male_cn.mp3 --write-subtitles story_male_cn.srt

ffmpeg -i ${work_dir}/story_male_cn.mp3 -ar 16000 -ac 1 -c:a pcm_s16le ${work_dir}/story_male_cn.wav
ffmpeg -i ./story_male_cn.mp3 -ar 16000 -ac 1 -c:a pcm_s16le ./story_male_cn.wav