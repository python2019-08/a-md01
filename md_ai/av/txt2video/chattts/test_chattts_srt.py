# 学习记录：chattts文本转语音，同步生成字幕文件
# PyAIGCMaster  已于 2024-12-13 06:34:33 修改                         
# 原文链接：https://blog.csdn.net/weixin_42771529/article/details/144425015
import torch
import numpy as np
import torchaudio
import re
import time
 
 
 
# 设置环境变量以避免内存碎片化
import os, sys
os.environ['PYTORCH_CUDA_ALLOC_CONF'] = 'expandable_segments:True'

now_dir = os.getcwd()
sys.path.append(now_dir)

import ChatTTS
 
# 使用 CPU 进行计算
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
 
chat = ChatTTS.Chat()
chat.load(compile=False)  # Set to True for better performance
# 记录开始时间
start_time = time.time()
print(f"Start Time: {start_time}")
text = """
[uv_break][uv_break][uv_break][uv_break][uv_break][uv_break][uv_break][uv_break][uv_break]猴侠[uv_break][uv_break][uv_break][uv_break]
山东日照，有这么一位徐公子，到京城办事，他父亲和当朝宰相是老同窗，嘱咐他无论如何也要去拜见一下老伯。徐公子办完了事，就来到相府。相爷说，你这遭回乡，替我捎三千两银子回去。
 
徐公子这就带着银子上了路。带那么多银钱可不是闹着玩儿的，他打定主意，只走大道，不走小路，只走白天，不走夜路，好歹把人家的银子原封送到。

出京城不久，徐公子看到一个大汉，身高八尺，腰粗十围，眼似铜铃，发似钢针，心想，这人长得咋恁凶恶。再看他挑的担子，好家伙，这担子不知装些什么，也就说不上有多少分量，大汉用一条铁扁担挑着，忽闪闪乱颤。徐公子想，这人真是神力，为什么不当兵为将，却在民间当挑夫?大白天的，惊叹了一番，也不再当回事。

走了三五天，怪了，徐公子看那挑铁扁担的大汉总和他走一路，他走，大汉也走;他宿下，大汉也宿下。有时大汉前头走了，徐公子望不见他的背影，心里说，人家走人家的，别自个儿吓唬自个儿。可是到了前边宿下，一留心，那大汉偏巧也先住在这儿啦。也有时大汉明明循岔路走了，可待徐公子天晚宿上店，不等洗完脸，那大汉准来这家店住宿。

这天，刚在一家店里宿下，天就下小雨。徐公子心里烦闷，弄一壶酒慢慢地喝。掌柜的是个老头儿，人挺实在，走过来小声说：“公子，别太贪杯了，你是不是带了钱财，让人家盯上了?那铁扁担汉子可不是良善之辈呢!”公子说：“我不走小路，不走夜道，谁能把我吃了?”掌柜的叹口气：“傻话!我看他今夜是要下手，你没见他早早睡下了?”

果然那大汉老早睡下，铁扁担靠在门边，锃亮。大汉打呼噜像打雷，把那铁扁担震得铮铮作响。 
"""
 
# 使用固定音色
guding_spk = torch.load("timbre-pt/man-good1-seed_1703_restored_emb.pt", map_location=device, weights_only=True)
 
# 相关参数，见文档说明
params_infer_code = ChatTTS.Chat.InferCodeParams(
    spk_emb=guding_spk,  # add sampled speaker
    temperature=.3,     # using custom temperature
    top_P=0.7,          # top P decode
    top_K=20,           # top K decode,
)
 
# 根据效果自行选择
# use oral_(0-9), laugh_(0-2), break_(0-7)
# to generate special token in text to synthesize.
params_refine_text = ChatTTS.Chat.RefineTextParams(
    prompt='[oral_0][laugh_0][break_4]',
)
 
 
def number_to_chinese(num):
    if not isinstance(num, int) or num < 0 or num >= 10 ** 9:
        raise ValueError("Number must be an integer between 0 and 999,999,999 inclusive.")
 
    units = ["", "十", "百", "千", "万", "十", "百", "千", "亿"]
    digits = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
 
    def convert_chunk(chunk):
        result = ""
        zero_flag = False
        for i, digit in enumerate(reversed(str(chunk))):
            d = int(digit)
            if d == 0:
                if not zero_flag:
                    result = digits[d] + result
                    zero_flag = True
            else:
                result = digits[d] + units[i] + result
                zero_flag = False
        return result
 
    if num == 0:
        return digits[0]
 
    result = ""
    if num >= 100000000:
        result += convert_chunk(num // 100000000) + units[8]
        num %= 100000000
        if num == 0:
            return result
 
    if num >= 10000:
        result += convert_chunk(num // 10000) + units[4]
        num %= 10000
        if num == 0:
            return result
 
    result += convert_chunk(num)
 
    # Remove trailing zeros
    result = result.rstrip(digits[0])
 
    # Replace multiple zeros with a single zero
    result = re.sub(r'零+', digits[0], result)
 
    return result
def percentage_to_chinese(percent):
    if not isinstance(percent, int) or percent < 0 or percent > 100:
        raise ValueError("Percentage must be an integer between 0 and 100 inclusive.")
    return f"百分之{number_to_chinese(percent)}"
 
 
def replace_numbers_with_chinese(text):
    def replace(match):
        num = int(match.group())
        return number_to_chinese(num)
 
    # Use regex to find all numbers in the text
    return re.sub(r'\d+', replace, text)
 
def replace_percentages_with_chinese(text):
    def replace(match):
        num = int(match.group(1))
        return percentage_to_chinese(num)
 
    # Use regex to find all percentages in the text
    return re.sub(r'(\d+)%', replace, text)
 
def replace_special_characters(text):
    """
    将文本中的特殊字符替换为对应的汉字。
    目前支持将 '+' 替换为 '加'。
    """
    replacements = {
        '+': '加',
        '×': '乘',
        '÷': '除',
        # '.': '点'
    }
    for char, replacement in replacements.items():
        text = text.replace(char, replacement)
    return text
 
 
 
 
def remove_bracketed_content(text):
    """
    移除文本中所有以 [ 开头和 ] 结尾的内容，包括字母、数字和中文字符。
    """
    return re.sub(r'\[.*?\]', '', text)
 
def replace_punctuation_with_uv_break(text):
    """
    将文本中的标点符号替换为 [uv_break]。
    """
    # 定义常见的标点符号
    punctuation_pattern = r'[！@#￥（）；;·：“”【】《》、…：—！？]'
    return re.sub(punctuation_pattern, ' ', text)
 
text = remove_bracketed_content(text)
 
 
def text_to_sentences(text, max_length=18):
    # 去除多余的空行和缩进
    text = re.sub(r'\s+', ' ', text).strip()
 
    # 使用正则表达式根据中英文标点符号分割句子
    punctuation_pattern = re.compile(r'[，。！？.,!?]')
    raw_sentences = punctuation_pattern.split(text)
    # print(f'首次分割后的句子数量：{len(raw_sentences)}，其中为空句子数量：{raw_sentences.count("")}，{raw_sentences}')
 
    sentences = []
    current_sentence = ""
 
    for sentence in raw_sentences:
        sentence = sentence.strip()
        if not sentence:
            continue
 
        # 如果当前句子加上新句子超过 max_length，则先保存当前句子
        if len(current_sentence) + len(sentence) + 1 > max_length:
            if current_sentence:
                sentences.append(current_sentence)
                current_sentence = ""
 
        # 如果当前句子为空，则直接赋值
        if not current_sentence:
            current_sentence = sentence
        else:
            current_sentence += ", " + sentence
 
    # 添加最后一个句子
    if current_sentence:
        sentences.append(current_sentence)
 
    return sentences
 
 
 
 
# 将文本分割成列表
#去除最后的[]标注内容
text = remove_bracketed_content(text)
# 替换文本中的百分比
text = replace_percentages_with_chinese(text)
# print(f"百分数：{text}")
# 替换文本中的数字
text = replace_numbers_with_chinese(text)
# print(f"数：{text}")
text=replace_special_characters(text)
# print(f"特殊字符：{text}")
texts = text_to_sentences(text)
print(f"列表：{texts}")
 
wavs = []
 
subtitle_lines = []
 
current_time = 0.0  # 当前时间戳，单位为秒
 
for index, text in enumerate(texts):
    text=replace_punctuation_with_uv_break(text)
    wavList = chat.infer(text, skip_refine_text=True, params_refine_text=params_refine_text, params_infer_code=params_infer_code)
    
    for wav in wavList:
        # 确保音频数据是一维数组
        
        if wav.ndim > 1:
            wav = wav.squeeze()
        wavs.append(wav)
    
        # 计算音频持续时间
        sample_rate = 24000  # 假设采样率为24000 Hz
        duration = len(wav) / sample_rate
    
        # 生成 SRT 格式的字幕行
        start_time = current_time
        end_time = current_time + duration
    
        start_time_str = time.strftime('%H:%M:%S,', time.gmtime(start_time)) + f"{int((start_time % 1) * 1000):03d}"
        end_time_str = time.strftime('%H:%M:%S,', time.gmtime(end_time)) + f"{int((end_time % 1) * 1000):03d}"
    
        subtitle_line = f"{index + 1}\n{start_time_str} --> {end_time_str}\n{text}\n"
        subtitle_lines.append(subtitle_line)
    
        # 更新当前时间戳
        current_time = end_time
 
def merge_wavs(wavs, output_file, sample_rate=24000):
    # 将所有wav数据连接成一个numpy数组
    merged_wav = np.concatenate(wavs, axis=0)
 
    # 转换为torch张量并添加通道维度
    merged_wav_tensor = torch.from_numpy(merged_wav).unsqueeze(0)
 
    # 保存合并后的音频文件
    torchaudio.save(output_file, merged_wav_tensor, sample_rate)
 
try:
    merge_wavs(wavs, "wwww.wav", 24000)
except Exception as e:
    print(f"Error merging wavs: {e}")
finally:
    # 释放未使用的缓存
    torch.cuda.empty_cache()
 
 
# 写入字幕文件
with open("wwww.srt", "w", encoding="utf-8") as subtitle_file:
    subtitle_file.writelines(subtitle_lines)
 
# 记录结束时间
end_time = time.time()
print(f"End Time: {end_time}")  # 添加调试信息
 
# 计算并打印耗时
elapsed_time = end_time - start_time
print(f"Total time taken: {elapsed_time:.2f} seconds")