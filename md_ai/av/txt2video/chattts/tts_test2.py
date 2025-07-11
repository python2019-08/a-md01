import scipy
 
import ChatTTS
from IPython.display import Audio
 
chat = ChatTTS.Chat()
chat.load_models(source='local', local_path='ChatTTS')
 
params_infer_code = {'prompt':'[speed_5]', 'temperature':.3}
params_refine_text = {'prompt':'[oral_2][laugh_0][break_6]'}
 
texts = ["四川美食可多了，[uv_break] 有麻辣火锅、宫保鸡丁、麻婆豆腐、[uv_break] 担担面、回锅肉、夫妻肺片等， [uv_break] 每样都让人垂涎三尺。"]
 
wav = chat.infer(texts, \
    params_refine_text=params_refine_text, params_infer_code=params_infer_code)
 
#texts = ["This is a test of the ChatTTS script.  Peter Piper picked a peck of pickled peppers.  Red leather.  Yellow leather.  Red leather.  Yellow leather.  Red leather.  Yellow leather.",]
 
# wavs = chat.infer(texts, use_decoder=True)
Audio(wav[0], rate=24_000, autoplay=True)
scipy.io.wavfile.write(filename = "output.wav", rate = 24_000, data = wav[0].T)
