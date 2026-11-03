# ch00.OpenCode / Cline / DeepCode 横向对比
 OpenCode / Cline / DeepCode 横向对比（开源BYOK编程Agent，全部工具本体免费，只付模型token费用）
> BYOK = Bring Your Own Key，自己提供大模型API密钥，都可以接入DeepSeek、Ollama本地模型等。

## 基础信息总表
| 项目 | OpenCode | Cline | DeepCode（deepcode-cli） |
|---|---|---|---|
| **定位** | 终端TUI优先，附带桌面端+IDE插件，Go语言 | VSCode插件为主，配套CLI/SDK，Apache2.0 | 轻量CLI+VSCode插件，Node.js，专门针对DeepSeek V4优化 |
| 开源协议 | MIT | Apache-2.0 | MIT |
| 核心入口 | 终端TUI，适合服务器、远程开发 | VSCode内使用，IDE优先 | 命令行为主，VSCode为辅 |
| 模型支持 | 75+服务商，兼容OpenAI协议，支持Ollama本地模型 | 50+服务商，MCP协议，支持本地Ollama | 主打DeepSeek系列，也兼容OpenAI协议 |
| 安全机制 | 会话级授权，可并行多Agent | **默认每一步操作都需要人工审批**（文件修改、执行命令，适合企业涉密项目） | 轻量审批，配置简单，偏向快速开发 |
| 特色能力 | LSP深度集成、多会话并行、内置免费模型通道Zen | 任务Checkpoint、子Agent、浏览器自动化、MCP插件生态最强 | 原生适配DeepSeek V4思考开关、前缀缓存省token，轻量 |
| 适合场景 | 服务器远程开发、CI/CD、喜欢终端操作、私有化部署 | VSCode重度用户、企业项目、代码审计、涉密工程 | 专门用DeepSeek做开发、轻量化脚本、ROS/机器人小项目 |
| 缺点 | IDE体验弱，复杂工程长任务容易返工 | 审批步骤多，自动化时需要手动确认，操作偏繁琐 | 生态最小，社区体量小，只针对DeepSeek优化，其他模型优势不大 |

## 逐个简介
### 1. OpenCode

Go写的终端优先开源Agent，MIT协议。
- 主打**TUI终端界面**，可以直接在Linux服务器上跑，不需要IDE；也有桌面客户端、VSCode插件
- 支持并行多Agent，LSP AST解析代码，理解项目结构能力很强
- 自带Zen网关，可直接使用免费模型（商用涉密代码不建议走Zen网关）
- 私有化友好，代码本地留存，支持Ollama本地大模型离线跑
> 选型：你经常SSH远程服务器、在容器/ROS服务器做开发，优先OpenCode。

### 2. Cline（原RooCode分支演化）
目前**VSCode生态最火的开源编程Agent**，Apache2.0协议。
- 核心优势：**每一步修改都预览diff，命令执行必须人工确认**，企业项目安全可控，可审计，适合标书、央企项目、涉密代码
- 支持MCP插件，可扩展联网、浏览器、数据库调用，子Agent能力强
- 有CLI版本，也可以脱离VSCode在终端使用；支持JetBrains插件
- 模型兼容性极强，DeepSeek、Claude、GPT、本地Ollama全部通吃
> 选型：日常在VSCode写代码、做大型工程重构、需要安全审计，优先Cline。

### 3. DeepCode（lessweb/deepcode-cli，不是Snyk安全扫描那个DeepCode）
轻量Node.js的CLI+VSCode插件，**专门为DeepSeek V4深度优化**，MIT协议。
- 核心亮点：原生控制DeepSeek `thinking` 开关，支持前缀缓存，**降低DeepSeek token消耗**
- 轻量简洁，配置简单，没有复杂的MCP重型框架，上手快
- 生态最小，社区规模远小于Cline/OpenCode，模型适配偏向DeepSeek，其他模型只是基础兼容
> 选型：你主力API是DeepSeek，追求轻量化、省token，机器人/ROS小项目快速开发，选DeepCode。

## 选型一句话总结
1. 日常VSCode开发、企业项目、需要安全审计 → **Cline**
2. SSH远程服务器、容器、CI流水线、喜欢终端开发 → **OpenCode**
3. 固定用DeepSeek API，想要轻量、降低DeepSeek token开销 → **DeepCode**

## 共性重点（写标书可以直接复制）
三者**软件本体全部免费开源，无订阅费**；成本只来自你调用的大模型API（DeepSeek等），可以私有化部署、本地Ollama接入，无厂商锁定。
> 注意：OpenCode Zen免费通道不适合涉密商业代码，数据会经过第三方网关。

=========================================================== 
# ch01.OpenCode 如何安装和使用
OpenCode 是一款大火的开源 AI 编程助手与 Agent（智能体）工具。它不仅支持直接在终端命令行（CLI）里运行，还提供桌面客户端（Desktop）以及 VS Code / Cursor / Windsurf 等全套主流 IDE 的插件集成。 [1, 2, 3, 4] 
由于它完美支持接入 DeepSeek，且对长文本的上下文管理非常出色，许多开发者会选择它来代替日常高成本的商业编程 Agent。以下是完整的安装与使用指南： [2, 5] 
------------------------------
## 一、 安装 OpenCode
为了获得最稳定的 DeepSeek V4.1 系列模型适配，建议通过以下官方渠道安装最新版本（版本号需 ≥ v1.14.24）： [2, 6] 
## 1. 命令行版 (CLI)
你可以通过以下任一命令将其全局安装到你的电脑终端（请确保电脑已预装 Node.js 或对应包管理器）： [2, 3] 

* 
* 使用 Node.js (最通用)：
```sh
npm install -g @opencode/cli
```
* 使用 macOS (Homebrew)：
```sh
brew install anomalyco/tap/opencode-v2
```
* 使用一键脚本 (Linux/macOS)： [3] 
```sh
curl -fsSL https://opencode.ai/v2/install | bash
```
* 

## 2. 桌面客户端 (Desktop)
如果你更习惯用可视化界面，可以直接前往 [OpenCode 官方下载页](https://opencode.ai/download)，根据你的操作系统（Windows x64 / macOS Apple Silicon 或 Intel）下载 .exe 或 .dmg 独立安装包直接安装。 [3, 7] 
## 3. 编辑器插件
在 VS Code、Cursor 或 Windsurf 的扩展商店（Extensions）中，直接搜索 OpenCode 并点击安装即可。 [3] 
------------------------------
## 二、 接入并配置 DeepSeek
OpenCode 启动后，可以通过内置的斜杠命令非常简单地将 AI 大脑切换为 DeepSeek。 [2] 

   1. 进入你的项目目录，并在终端中输入以下命令启动：
   
   opencode
   
   2. 连接 AI 供应商：
   在 OpenCode 交互输入框内输入快捷命令：
   
   /connect
   
   3. 选择供应商：在弹出的供应商列表中，输入并选择 deepseek。
   4. 填入 API Key：前往 [DeepSeek 开放平台](https://platform.deepseek.com/api_keys) 申请并复制你的专属 Key，然后粘贴在提示框内并回车。
   5. 选择模型：推荐选择最新的 DeepSeek-V4.1-Flash（如果是老版本可选 DeepSeek-V4-Pro），即可完成全套配置！ [2, 6] 

------------------------------
## 三、 核心功能与使用技巧
OpenCode 并不是只能“聊天”的问答机器人，它是一个拥有自主执行权限的编程 Agent。你可以直接在输入框用大白话安排它干活： [2] 

* 
* 自动化需求实现：

📥 提示词举例：“帮我用 HTML + CSS + Tailwind 写一个完全响应式的游戏宣传落地页，带上平滑的滚动动画，页面要有惊喜感。”
(它会自动在当前目录下创建、读取并写好相关的代码文件。)

[2] 
* 代码 Debug 与跑测：

📥 提示词举例：“帮我检查一下 main.py 的异步报错，修好以后直接在终端运行测试确保没有问题。”
(它会自己读取文件代码、修改它，然后通过本地 Shell 运行测试指令并根据报错自动纠错。)

* 使用斜杠命令控制状态：
* /connect：用于重新配置或更换 AI 供应商（如切回 OpenAI、Claude 等）。
   * /upgrade：在线升级 OpenCode 至最新版本。 [2, 8] 
* 

请问你平时主要的开发语言是哪一种（例如 Python、JavaScript/TypeScript、Go）？如果在安装过程中遇到了 Node.js 环境报错、或者是 API 连不上的问题，可以随时告诉我，我来帮你排查。

[1] [https://api-docs.deepseek.com](https://api-docs.deepseek.com/quick_start/agent_integrations/opencode)
[2] [https://www.runoob.com](https://www.runoob.com/opencode/opencode-deepseek.html)
[3] [https://opencode.ai](https://opencode.ai/download)
[4] [https://www.youtube.com](https://www.youtube.com/watch?v=8toBNmRDO90)
[5] [https://www.reddit.com](https://www.reddit.com/r/DeepSeek/comments/1uyvmp4/the_opencode_go_is_cheaper_than_deepseek_api/)
[6] [https://www.deepseek.com](https://www.deepseek.com/en/news/deepseek-v4-1-flash/)
[7] [https://www.kimi.ai](https://www.kimi.ai/resources/opencode-install)
[8] [https://api-docs.deepseek.com](https://api-docs.deepseek.com/zh-cn/quick_start/agent_integrations/opencode/)

======================================= 
# ch02.DeepCode
<!-- abner: 消耗token费用太快. -->
Deep Code 是一款专为 DeepSeek（尤其是最新的 DeepSeek-V4 系列模型）进行深度优化、深度适配的开源终端 AI 编程助手与 Agent（智能体）工具。 [1] 
由于其强大的自动化代码操作能力、原生适配 DeepSeek 的技术特性，且被 [DeepSeek 官方 API 文档](https://api-docs.deepseek.com/zh-cn/quick_start/agent_integrations/deepcode) 选入并正式推荐，被许多开发者形象地称为 “DeepSeek 版的 Claude Code”。 [2, 3] 
该工具由国内的开源团队 lessweb 开发，目前在开源社区受到极高关注。它在 DeepSeek 编程应用中扮演着极其核心的“双手”角色，具备以下几个关键特征： [4] 
## 1. 核心定位：不仅是“聊天窗口”，而是“自动化 Agent”
市面上绝大多数 AI 编程插件（如旧款的普通对话框）属于“一问一答”模式，无法直接影响本地文件。而 Deep Code 是一个主动型 Agent： [3] 

* 
* 🛠️ 读写文件与执行命令：你可以直接在终端给它下达指令，例如 “帮我重构 auth.py，修好报错后在终端跑一下单元测试”。它能够自己理解、修改本地项目文件、运行 Shell 命令并查看报错，直到将任务彻底修好。 [2, 3] 
* 🔄 真正的“连续协作”：它会按照项目本地的系统文件自动保存会话状态。这意味着即使你关闭终端或隔天打开，它依然记得上一次讨论到哪里、整个项目结构是什么，无需每次都重新粘贴上下文。 [2, 3] 
* 

## 2. 专为 DeepSeek 性能与钱包深度调优
普通的通用 AI 工具在使用 DeepSeek 时容易遇到长文本丢失、无法完美利用思考链等问题。Deep Code 的底座完全围绕 DeepSeek 构建： [4] 

* 
* 🧠 原生控制推理强度：完美支持 DeepSeek 的深度思考模式（Thinking Mode），允许开发在配置文件中对推理强度进行控制（如设置 thinkingEnabled: true 和 reasoningEffort: "max"）。 [5, 6] 
* 🪙 上下文缓存优化（Context Caching）：在编写大型项目代码时，通过深度适配 DeepSeek 的上下文缓存机制，可以大幅削减重复读取项目代码产生的 Token 消耗，最高可帮开发者节省近 90% 的 API 费用。 [5] 
* 

## 3. 多种使用形态与安全机制

* 
* 💻 多端联动：它提供终端命令行（CLI）和 VS Code 插件两种形态。两端共享同一套配置文件（~/.deepcode/settings.json），你可以在终端输命令，也可以在编辑器里无缝切换无缝编写。
* 🛡️ 细粒度权限控制：作为能执行 Shell 命令的 Agent，安全至关重要。Deep Code 内置了严格的权限拦截，对于修改 Git 历史、删除文件、访问网络等高危行为，你可以设置为“每次询问”、“只读”或“直接拒绝”，防止 AI 误删代码。
* 🔌 扩展能力：支持 MCP（模型上下文协议）以及 Agent Skills 技能市场，可以连接 GitHub、数据库、浏览器或自定义的 Slack 通知脚本。 [2, 3, 5, 7] 
* 

------------------------------
## 💡 如何快速上手？
Deep Code 的安装和使用非常极客，只需要通过 Node.js 即可全局部署：

   1. 一键安装（全局 CLI）：
   
   npm install -g @vegamo/deepcode-cli
   
   2. 配置 API Key：
   在本地创建或修改 ~/.deepcode/settings.json 文件，填入你的 DeepSeek API Key：
   
   {
     "env": {
       "MODEL": "deepseek-v4-pro",
       "BASE_URL": "https://api.deepseek.com",
       "API_KEY": "你的sk-密钥",
       "thinkingEnabled": true,
       "reasoningEffort": "max"
     }
   }
   
   3. 在项目启动：
   进入任何你的代码工程目录，直接输入 deepcode 即可唤醒这个 AI 编程助手。 [5, 6] 


[1] [https://api-docs.deepseek.com](https://api-docs.deepseek.com/zh-cn/quick_start/agent_integrations/deepcode)
[2] [https://hk.finance.yahoo.com](https://hk.finance.yahoo.com/news/deepseek-%E7%94%9F%E6%85%8B%E8%A3%9C%E5%BC%B7-%E9%96%8B%E6%BA%90ai%E7%A8%8B%E5%BC%8F%E5%8A%A9%E6%89%8Bdeep-code%E4%B8%8A%E7%B7%9A-123009124.html)
[3] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/2057779111112733449)
[4] [https://www.woshipm.com](https://www.woshipm.com/ai/6432610.html)
[5] [https://github.com](https://github.com/lessweb/deepcode-cli)
[6] [https://api-docs.deepseek.com](https://api-docs.deepseek.com/quick_start/agent_integrations/deepcode/)
[7] [https://github.com](https://github.com/lessweb/deepcode-cli/blob/main/README-en.md)


=============================================

# ch03.cline 如何安装和使用

Cline（原名 Claude Dev）是目前在 VS Code 及其衍生编辑器（如 Cursor、Windsurf）上最火爆的开源 AI 自动代理（Agent）插件。 [1, 2] 
它之所以强大，是因为它不仅能陪你“聊天”，而且拥有读写本地文件、自动运行终端 Shell 命令、甚至用无头浏览器测试网页的真实系统权限。只要给它一个明确的需求，它就能自动建目录、写代码、排查 Bug 并直到把程序跑通。 [2, 3, 4] 
以下是 Cline 的安装、配置（以接入 DeepSeek 为例）与日常使用的完整指南：
------------------------------
## 一、 如何安装 Cline
Cline 完美支持 Windows、macOS 与 Linux 系统的 IDE 环境。 [5] 

   1. 打开 VS Code。
   2. 进入扩展市场：点击左侧活动栏的“方块积木”图标，或使用快捷键 Ctrl + Shift + X（Mac 上为 Cmd + Shift + X）。
   3. 搜索并安装：在搜索框中输入 Cline，认准由作者 saoudrizwan 发布、带有卡通章鱼/小猪鼻图标的官方正版，点击 安装 (Install)。
   4. 唤醒插件：安装完成后，VS Code 左侧活动栏会多出一个小机器人（或章鱼）图标，点击它即可打开 Cline 的工作面板。 [4, 5, 6, 7, 8, 9] 

------------------------------
## 二、 配置大模型（以接入 DeepSeek 为例）
Cline 本身是开源免费的，但它需要消耗 AI 模型的 API 额度。由于目前 DeepSeek 的高性价比，它是 Cline 用户的首选底座。 [2, 10] 

   1. 获取 API Key：登录 [DeepSeek 开放平台](https://platform.deepseek.com/api_keys)，创建并复制你的 sk-... 密钥。 [11] 
   2. 进入 Cline 设置：点击 Cline 面板右上角的 ⚙️ (齿轮设置) 按钮。 [6] 
   3. 填写参数：
   * API Provider (服务商)：直接在下拉菜单中选择 DeepSeek（若无该独立选项，可选择 OpenAI Compatible）。
      * Base URL：若选了 OpenAI Compatible，则手动填入 https://deepseek.com。
      * API Key：粘贴你刚刚复制的 DeepSeek 密钥。
      * Model (模型选择)：
      * 如果是日常高频编码、改小 Bug，选择 deepseek-chat（即 V3/V4 标准版，响应快、极省钱）。
         * 如果是遇到极其硬核的代码报错、复杂系统架构设计，选择 deepseek-reasoner（即 R1 系列思维链推理模型）。 [6, 11, 12] 
      4. 保存配置，点击 Done 或 Let's go 即可。 [6, 11] 

💡 高级权限安全建议（Auto-approve）：
在设置页面下方，有 Auto-approve（自动批准）选项。默认情况下，Cline 每修改一个文件、每执行一行终端命令，都需要你手动点击允许。如果你信任它，可以勾选 Read files 和 Write files 以实现完全自动化编码，但建议不要无条件勾选“自动执行终端高危命令”，以防 AI 误删本地关键数据。 [4, 6] 

------------------------------
## 三、 如何在日常开发中使用 Cline
完成配置后，在 VS Code 中打开你准备开发的工程文件夹，就可以像导师给实习生派发任务一样用“大白话”命令它了： [7] 
## 1. 全自动构建新功能（Vibe Coding）
在 Cline 聊天框直接输入：

📥 “帮我用 Python 编写一个贪吃蛇游戏。要在本地自动创建一个 snake/ 文件夹，把代码归类写好，并创建一个 requirements.txt。写完后在终端帮我运行起来。”

Cline 的执行逻辑：
它会先自行通过终端 mkdir 创建目录，接着用 writeFile 编写对应的代码，再通过终端命令运行。如果执行报错，它会自动捕捉控制台的报错信息，自我修正代码，直到游戏成功运行。 [2, 4] 
## 2. 全局重构与排查 Bug
如果你现有项目出了问题，你可以直接选中代码，或者让它通读整个目录：

📥 “检查一下我这个项目里的 auth.js 模块，为什么用户登录时总是报 JWT 格式错误？请找出来并直接帮我修好它。”

Cline 的执行逻辑：
它会去使用 readFile 搜索和阅读整个项目有关 auth 的上下文，分析逻辑漏洞，修改完毕后向你提交一个代码 Diff（差异对比），并在你授权后合并代码。 [4] 
## 3. 核心快捷命令

* 
* @ 符号添加上下文：在聊天框输入 @，可以直接把本地的某个特定文件、甚至当前浏览器的屏幕截图作为上下文塞给 Cline，让它针对性分析。
* /clear：当一个任务已经彻底做完后，输入 /clear 可以清空当前的对话记忆。这样可以避免下一次对话时携带了太长的前文，从而大幅节约你的 API Token 资费。 [4] 
* 

请问在安装或配置过程中，你是否有遇到诸如 API 连接超时 或 VS Code 提示无权限 等报错？你需要我为你补充 Ollama 本地离线运行的模型配置步骤 吗？

[1] [https://docs.cline.bot](https://docs.cline.bot/getting-started/installing-cline)
[2] [https://blog.csdn.net](https://blog.csdn.net/u011186532/article/details/147643642)
[3] [https://www.youtube.com](https://www.youtube.com/watch?v=KjqQC4AnJ1I)
[4] [https://apifox.com](https://apifox.com/apiskills/how-to-use-vscode-cline/)
[5] [https://www.deployhq.com](https://www.deployhq.com/guides/cline)
[6] [https://newsletters.raven.tw](https://newsletters.raven.tw/p/ep-10-vs-code-cline-deepseek-cline)
[7] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/1934562929929327849)
[8] [https://fast.io](https://fast.io/resources/how-to-use-cline/)
[9] [https://apidog.com](https://apidog.com/blog/free-deepseek-r1-vscode-cline/)
[10] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/20137386829)
[11] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/17795804526)
[12] [https://apifox.com](https://apifox.com/apiskills/how-to-setting-deepseek-in-vscode/)


===========================================
