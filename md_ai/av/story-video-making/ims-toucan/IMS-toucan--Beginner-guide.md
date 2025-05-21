# 1. IMS-Toucan入门指南-多语言可控文本转语音工具包
Ray 2024年9月10日 11:03 
 
IMS-Toucan是一款由斯图加特大学自然语言处理研究所(IMS)开发的多语言文本转语音(TTS)工具包。它具有以下特点:
支持7000多种语言的语音合成
基于纯Python和PyTorch实现,易于上手和使用
提供了交互式演示和预生成的音频样本
可以克隆说话人的语音风格
支持低资源语言的语音合成


## 1.1 安装指南
### 1.1.1克隆GitHub仓库到本地机器:
git clone https://github.com/DigitalPhonetics/IMS-Toucan.git

### 1.1.2创建并激活虚拟环境:
python -m venv toucan_env
source toucan_env/bin/activate  # Linux/Mac
toucan_env\Scripts\activate.bat  # Windows  

### 1.1.3安装依赖:
pip install -r requirements.txt

### 1.1.4下载预训练模型:
python run_model_downloader.py

## 1.2 快速开始
### 1.2.1使用交互式演示:
python run_interactive_demo.py

### 1.2.2或使用文本到文件的转换:
python run_text_to_file_reader.py

## 1.3 学习资源
官方GitHub仓库: https://github.com/DigitalPhonetics/IMS-Toucan

多语言演示: https://huggingface.co/spaces/Flux9665/MassivelyMultilingualTTS

语音风格克隆演示: https://huggingface.co/spaces/Flux9665/SpeechCloning

人工编辑诗歌朗读演示: https://huggingface.co/spaces/Flux9665/PoeticTTS

## 1.4 相关论文
IMS Toucan系统简介: https://github.com/DigitalPhonetics/IMS-Toucan/releases/tag/v1.0

添加发音特征和元学习预训练: https://github.com/DigitalPhonetics/IMS-Toucan/releases/tag/v1.1

精确韵律克隆功能: https://github.com/DigitalPhonetics/IMS-Toucan/releases/tag/v2.2

语言嵌入和单词边界: https://github.com/DigitalPhonetics/IMS-Toucan/releases/tag/v2.2

可控说话人嵌入生成: https://github.com/DigitalPhonetics/IMS-Toucan/releases/tag/v2.3

IMS-Toucan为研究人员和开发者提供了一个强大而灵活的TTS工具包。无论您是想要实现多语言语音合成,还是探索低资源语言的TTS技术,IMS-Toucan都是一个值得尝试的选择。欢迎访问官方GitHub仓库,了解更多详细信息并开始您的语音合成之旅!

<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
==================================================================
# 2. IMS Toucan 开源项目教程

谭勇牧Queen  于 2024-08-10 08:28:52 发布
原文链接：https://blog.csdn.net/gitblog_00726/article/details/141083643

 
IMS Toucan 开源项目教程
IMS-Toucan : Text-to-Speech Toolkit of the Speech and Language Technologies Group at the University of Stuttgart. Objectives of the development are simplicity, modularity, controllability and multilinguality.
项目地址:https://gitcode.com/gh_mirrors/im/IMS-Toucan

## 2.1. 项目目录结构及介绍
IMS Toucan 的目录结构是典型的Python项目布局，主要包含以下几个部分：

* src：这个目录存储了项目的主要源代码。
    tts: TTS引擎的核心代码。
    controllers: 控制器模块，用于处理输入和输出交互。
    models: 包含不同的语音合成模型。
    utils: 辅助工具函数。
    data: 存储训练数据和预处理后的数据集。

* config: 配置文件所在的目录。
* scripts: 含有用于数据处理、训练模型以及运行样例脚本的独立脚本。
* tests: 单元测试和集成测试的代码。
* requirements.txt: 项目的依赖项列表。
* README.md: 项目的说明文件。
* LICENSE: 许可证文件。
* .gitignore: Git 忽略规则。

## 2.2. 项目的启动文件介绍
在IMS Toucan项目中，通常使用命令行界面或脚本来启动应用。虽然没有明确的main.py作为启动文件，但你可以通过以下方式运行：

命令行接口： 通过Python解析命令行参数来调用相应的功能，例如训练模型或进行文本转语音。具体命令可能类似于：

python src/controllers/tts_controller.py --mode synthesis --input "你好，世界" --model_path models/model.h5
脚本执行： 可以从scripts目录下的脚本启动特定任务，如train.py来训练模型。

请确保先安装所有依赖（使用pip install -r requirements.txt），并根据你的需求调整命令或脚本中的参数。

## 2.3. 项目的配置文件介绍
配置文件位于config目录下，这些文件用于设置程序运行时的各项参数。常见的配置文件包括：

config.yml: 主配置文件，包含全局设置，如模型路径、数据集路径等。
model_params.json: 模型相关的参数，如网络架构、学习率等。
audio_params.json: 语音输出的参数，如采样率、音量等。
当你需要修改默认行为时，可以编辑这些配置文件。例如，要更改默认的语音合成模型，你需要更新config.yml中的相关选项。在使用配置文件前，请确认已备份原文件，以免影响项目正常运行。

完成以上步骤后，你应该对IMS Toucan项目有了基本的了解，可以开始搭建环境、配置参数，并按需运行项目。如果你遇到任何问题，可以查看项目仓库中的README或其他文档，或者在GitHub上向开发者提交问题。

IMS-Toucan
Text-to-Speech Toolkit of the Speech and Language Technologies Group at the University of Stuttgart. Objectives of the development are simplicity, modularity, controllability and multilinguality.
项目地址:https://gitcode.com/gh_mirrors/im/IMS-Toucan
 
<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
==================================================================
 # 3. ToucanTTSInterface.set_language
To change the language of the TTS, simply pass the corresponding
ISO 639-3 code to the `set_language` method of the `ToucanTTSInterface` instance.
This will change both the language the text is assumed to be in, and the accent.

If you want to change the language of the text and the accent independent of
one another, you can do so by passing the respective ISO 639-3 codes to the

`set_phonemizer_language` and `set_accent_language` methods individually.

<br><br>

| ISO 639-3 Code | Full Name of the Language                   |
|----------------|---------------------------------------------|
| cmn            | Mandarin Chinese                            | 

## 3.1 language_list.md
A list of supported languages can be found here:  Utility/language_list.md
 
<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
==================================================================
# 4. IMS_Toucan github urls

### (1)IMS_Toucan_V24_French:  
    https://github.com/Ca-ressemble-a-du-fake/IMS_Toucan_V24_French.git

### (2) spaonser/Toucan 
    https://github.com/spaonser/Toucan.git

### (3)CherokeeLanguage/IMS-Toucan
    https://github.com/CherokeeLanguage/IMS-Toucan.git

### (4) DigitalPhonetics/IMS-Toucan
    https://github.com/DigitalPhonetics/IMS-Toucan.git

<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++>
==================================================================
# 5. resource urls

https://huggingface.co/Flux9665

### （1）
https://huggingface.co/spaces/Flux9665/EnglishToucan/blob/main/female_high_voice.wav    

https://huggingface.co/spaces/Flux9665/EnglishToucan/blob/main/Models/ToucanTTS_Meta/best.pt

### (2)
audios/speaker_references_for_testing/female_mid_voice.wav

https://pixabay.com/sound-effects/search/female-voice/