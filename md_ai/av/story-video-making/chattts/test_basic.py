import ChatTTS
import torch
import torchaudio
import soundfile

chat = ChatTTS.Chat()
chat.load(compile=False) # Set to True for better performance

texts = ["关于人性，你最想讲的一个故事是什么？", "他告诉我这卤鹅的美味秘诀在于那浓香乌黑的陈卤。"]

wavs = chat.infer(texts)

# torchaudio.save("output1.wav", torch.from_numpy(wavs[0]), 24000)
# torchaudio.save("./output1.wav", torch.from_numpy(wavs[0]), 24000, format="wav")
soundfile.write("output1.wav", wavs[0], 24000)