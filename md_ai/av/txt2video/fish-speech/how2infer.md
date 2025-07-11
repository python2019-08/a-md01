## refer to docs/zh/inference.md

python fish_speech/models/vqgan/inference.py \
    -i "data/1_output.wav" \
    --checkpoint-path "checkpoints/fish-speech-1.5/firefly-gan-vq-fsq-8x1024-21hz-generator.pth"


python fish_speech/models/text2semantic/inference.py \
    --text "山东日照，有这么一位徐公子，到京城办事，他父亲和当朝宰相是老同窗，嘱咐他无论如何也要去拜见一下老伯。徐公子办完了事，就来到相府。相爷说，你这遭回乡，替我捎三千两银子回去。徐公子这就带着银子上了路。" \
    --prompt-text "人间灯火倒映湖中，她的渴望让静水泛起涟漪。若代价只是孤独，那就让这份愿望肆意流淌。流入她所注视的世间，也流入她如湖水般澄澈的目光。" \
    --prompt-tokens "fake.npy" \
    --checkpoint-path "checkpoints/fish-speech-1.5" \
    --num-samples 2 \
    --compile
 

/usr/local/cuda/targets/x86_64-linux/lib/stubs/libcuda.so
/usr/local/cuda-12.8/targets/x86_64-linux/lib/stubs/libcuda.so


python fish_speech/models/vqgan/inference.py \
    -i "temp/codes_0.npy" \
    --checkpoint-path "checkpoints/fish-speech-1.5/firefly-gan-vq-fsq-8x1024-21hz-generator.pth"