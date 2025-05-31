# 开启图像生成之旅：ComfyUI在Ubuntu上的安装全攻略

[北上ing][已于 2025-04-30 16:20:20 修改]  
于 2025-04-30 07:11:49 首次发布
 

本文链接：[https://blog.csdn.net/qq_34348690/article/details/147623498](https://blog.csdn.net/qq_34348690/article/details/147623498) 

> 笔者于2025.4在Ubuntu18.04上搭建ComfyUI，作此记录给大家参考于交流用。
>
> 对于如何增加常用插件，则另起篇章讲述。
>
> 项目原址：[Github 73K](https://github.com/comfyanonymous/ComfyUI)

### 一、ComfyUI

#### #1. ComfyUI的概念

ComfyUI是一个开源的、基于节点的Web应用。它允许用户根据一系列文本提示（Prompt）生成图像。

ComfyUI使用[扩散模型]作为基础模型，并结合ControlNet、Lora和LCM低阶自适应等模型，每个工具都由程序中的一个节点表示。如下图所示：

![请添加图片描述](./comfyui-ubuntu-install_files/bc1f42049b524c4baf00054ca8620c47.png)

这是ComfyUI的工作界面，其中每一个大框都是「节点」。

注：本SD基础模型引自合囤科技，[该模型](https://www.liblib.art/modelinfo/50e25a71c40347c783dfe2e90f55c1b3?from=search&versionUuid=39dfb44c5f974bdc9bfadd4ec123717a){rel="nofollow"}开源可供下载。

####  #2. 搭建流程图

 ![comfyui-ubuntu-install_files/setup-flow.png](comfyui-ubuntu-install_files/setup-flow.png)
------------------------------------------------------------------------
 

###  二、开发环境搭建

####  #1.下载项目

```sh
git clone https://github.com/comfyanonymous/ComfyUI.git
mv ComfyUI comfyui 
```

SD权重路径默认为：`models/checkpoints`

VAE文件路径默认为：`models/vae`

插件路径默认为：`custom_nodes`

------------------------------------------------------------------------

#### #2.配置虚拟环境

```sh
conda create -n comfyui python=3.10 # 官方推荐该python3.12但ComfyUI的常用插件不支持
conda activate comfyui

# torch
pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121   # 我用cuda12.1

# other lib
pip install -r requirements.txt 
```

------------------------------------------------------------------------
###  三、测试启动

```sh
# 进入项目根路径
cd comfyui
# 测试启动
python main.py 
```

其他参数解析：（这里仅介绍笔者觉得最常用的）
-   `--listen`：是否进本地可访问
-   `--port`：服务的端口
-   `--preview-method auto`：开启预览VAE解码前的图像

然后访问网页测试效果，如下图所示：

![请添加图片描述](./comfyui-ubuntu-install_files/d2aeec9c119e407ba88e5713323874cd.png)

------------------------------------------------------------------------

\

###  四、配置 && Debug

#### #1. 修改模型文件的路径为sdwebui的模型存放地址

将`extra_model_paths.yaml.example`重命名为`extra_model_paths.yaml`以启用该文件，

然后修改文件中的`base_paths`并设置为`stablediffusion-webui`的项目路径。重启服务后出现以下信息就是成功读取：

``` {.set-code-show .prettyprint index="3"}
Adding extra search path checkpoints ../sd-webui/models/Stable-diffusion
Adding extra search path configs ../sd-webui/models/Stable-diffusion
Adding extra search path vae ../sd-webui/models/VAE
Adding extra search path loras ../sd-webui/models/Lora
Adding extra search path loras ../sd-webui/models/LyCORIS
Adding extra search path upscale_models ../sd-webui/models/ESRGAN
Adding extra search path upscale_models ../sd-webui/models/RealESRGAN
Adding extra search path upscale_models ../sd-webui/models/SwinIR
Adding extra search path embeddings ../sd-webui/embeddings
Adding extra search path hypernetworks ../sd-webui/models/hypernetworks
Adding extra search path controlnet ../sd-webui/models/ControlNet
Checkpoint files will always be loaded safely. 
```

------------------------------------------------------------------------

#### #2. 安装插件管理器ComfyUI-Manager（可选）

在`comfyui/custom_nodes`下执行：

``` {.set-code-show .prettyprint index="4"}
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager 
```

> 该操作需翻墙，否则控制台会跳出`Failed to perform initial fetching 'model-list.json': Cannot connect to host raw.githubusercontent.com:443 ssl:default`

------------------------------------------------------------------------

#### #3. （了解即可）技术细节的浅尝辄止

> 笔者遇到了「ComfyUI资源请求异常」，死磕这块好一会...

与StableDiffusion-webui基于Gradio构建Web应用不同，ComfyUI并不基于Gradio开发。

ComfyUI使用aiohttp完成异步网络服务，如下图所示：

``` {.set-code-show .prettyprint index="5"}
@routes.get("/userdata/{file}")
async def get_userdata(request):
    path = get_user_data_path(request, check_exists=True)
    if not isinstance(path, str):
        return path

    return web.FileResponse(path) 
```

其中：

-   `@routes.get()`就是路由设置，用于匹配url请求；
-   `async def`是匹配成功后调用的函数，它用于处理URL请求。举个栗子：上面这个函数就是在请求获取工作流文件等资源。

> 到底咯，如果这篇文章对您有些许帮助，请帮忙点个赞👍或收个藏📃。您的支持是我继续创作的动力💪！
>
> ------------------------------------------------------------------------
>
> **当暴风雨⚡️过去，你不会记得自己是如何度过的，你甚至不确定暴风雨是否真的结束了。但你已经不再是当初走进暴风雨的那个人了，这就是暴风雨的意义💪。**
 
