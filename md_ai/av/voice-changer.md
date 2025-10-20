# 1.请列举几个不用人工智能技术的 变声器的 GitHub

以下是一些不依赖人工智能（AI）技术、基于传统信号处理或音频编辑原理实现的变声器相关GitHub项目，主要通过调整音调、频率、波形等方式实现变声效果：

0. soundtouch
    - the latest source codes and release tarballs:     https://codeberg.org/soundtouch/soundtouch
    - https://www.surina.net/soundtouch/download.html
    - SoundTouch is an open-source audio processing library for changing the Tempo, Pitch and Playback Rates of audio streams or audio files. The library additionally supports estimating stable beats-per-minute rates for audio tracks.
   

1. **Audacity（开源音频编辑软件，含变声功能）**  
   - 地址：https://github.com/audacity/audacity  
   - 简介：知名开源音频编辑工具，支持通过“改变音高”“改变速度”“反转”等传统音频处理功能实现变声，无需AI模型，适合基础变声需求。


2. **sox（Sound eXchange，音频处理命令行工具）**  
   - 地址：https://github.com/chirlu/sox  
   - 简介：经典的命令行音频处理工具，可通过参数调整音调（pitch）、速率（tempo）、频率过滤等实现变声，广泛用于脚本或程序集成，纯信号处理实现。


3. **VoiceChanger（轻量级实时变声器）**  
   - 地址：https://github.com/wayne931121/VoiceChanger  
   - 简介：基于PortAudio和音频滤波技术的实时变声器，支持调整音调、音量、添加回声等效果，无AI训练或推理过程，适合简单实时变声场景。

3.1  VoiceChanger
https://github.com/yangningbo/VoiceChanger.git   
基于SoundTouch语音变声库，实现男声变女声，女声变男生，机器音，tom猫音等


3.2 VoiceChanger_Android
 https://github.com/xiaobinlzy/VoiceChanger_Android
安卓音频压缩和变声功能库

4. **SoundFlower + 音频路由变声方案（依赖传统音频驱动）**  
   - 地址（SoundFlower）：https://github.com/mattingalls/SoundFlower  
   - 简介：SoundFlower是音频路由驱动，配合Audacity等工具通过硬件级音频转发+传统音效处理实现变声，核心是音频流控制而非AI。


5. **AlsaMixer + 命令行音频处理（Linux平台）**  
   - 地址（Alsa相关工具）：https://github.com/alsa-project/alsa-utils  
   - 简介：Linux下的音频控制工具集，可通过命令行调整麦克风输入的音调、增益等参数，结合简单脚本实现基础变声，依赖底层音频驱动而非AI。


这些项目均基于传统音频信号处理技术，不涉及机器学习模型或AI推理，适合对实时性、轻量性要求较高，或不需要复杂音色转换（如人声转特定角色声）的场景。