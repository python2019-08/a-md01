# 1.you-get 下载列表

## 1.1 question
you-get https://www.bilibili.com/video/BV1oW4y1j7ia?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=3
和https://www.bilibili.com/video/BV1oW4y1j7ia?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes获取的视频都是一个，如何处理
注：实际上这两个链接不是一个视频

如果使用`you-get`时发现这两个链接获取的不是同一个视频（尽管看起来相似），以下是一些可以尝试的处理方法：

1. **确认视频差异**：
   手动在浏览器中打开这两个链接，仔细查看视频内容，确认它们在集数（`p`参数相关）、时长、标题等方面的具体差异，以便明确需要获取的准确内容。

2. **使用`you-get`参数**：
   - `you-get`有一些参数可以帮助更好地获取视频。例如，`-i`参数可以先查看视频的可用格式和质量信息，然后再决定下载。比如运行 
   `you-get -i https://www.bilibili.com/video/BV1oW4y1j7ia?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes`  和 
   `you-get -i https://www.bilibili.com/video/BV1oW4y1j7ia?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=3`，
   然后根据显示的信息选择合适的格式和质量进行下载。
   
   - 如果视频有多个分P，你可以使用`--playlist`参数下载整个视频集（如果有的话）。例如 `you-get --playlist https://www.bilibili.com/video/BV1oW4y1j7ia?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes`，这样可能会确保获取到所有相关的视频内容。

3. **处理下载失败或错误**：
   如果`you-get`在下载过程中出现错误（比如无法解析链接等），你可以尝试更新`you-get`到最新版本，因为新版本可能修复了一些解析问题。你可以使用 `pip install --upgrade you-get` 来进行更新（前提是你是通过`pip`安装的`you-get`）。

4. **考虑其他下载工具**：
   如果`you-get`无法满足需求，还可以考虑使用其他视频下载工具，如B站官方的下载工具（如果支持你所需的视频下载），或者一些通用的视频下载器如Downie（Mac）、Video DownloadHelper（浏览器插件）等。

5. **检查视频权限和地区限制**：
   有些视频可能有地区限制或权限问题，导致`you-get`无法正确下载。你可以尝试使用代理（如果符合法律和平台规定）来绕过地区限制，或者确认自己是否有下载该视频的权限。 


