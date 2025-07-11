from modelscope import snapshot_download

# 不写绝对路径就会保存在这个位置 C:\Users\Administrator\.cache\modelscope\hub\pzc163
model_dir = snapshot_download('pzc163/chatTTS')

