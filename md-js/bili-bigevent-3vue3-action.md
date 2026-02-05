黑马程序员SpringBoot3+Vue3全套视频教程，springboot+vue企业级全栈开发从基础、实战到面试一套通关

<https://www.bilibili.com/video/BV14z4y1N7pg?p=17&vd_source=4212b105520112daf65694a1e5944e23>

# P69实战篇-57_大事件_概述

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=69> ；； 05:39

## \#1.项目演示

演示网址： <https://fe-bigevent-web.itheima.net/login>

### \#1.1.登录页

<img src="./bili-bigevent-3vue3-action--imgs/image1.png" style="width:10.51736in;height:4.96042in" />

### \#1.2注册页

<img src="./bili-bigevent-3vue3-action--imgs/image2.png" style="width:8.25764in;height:4.28194in" />

### \#1.3登录成功

<img src="./bili-bigevent-3vue3-action--imgs/image3.png" style="width:4.30486in;height:2.3in" />

<img src="./bili-bigevent-3vue3-action--imgs/image4.png" style="width:4.40069in;height:2.35764in" />

### \#1.4文章分类页面

<img src="./bili-bigevent-3vue3-action--imgs/image5.png" style="width:5.28125in;height:2.83333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image6.png" style="width:5.13472in;height:2.75764in" />

<img src="./bili-bigevent-3vue3-action--imgs/image7.png" style="width:5.18264in;height:2.78264in" />

<img src="./bili-bigevent-3vue3-action--imgs/image8.png" style="width:5.76736in;height:3.09444in" />

### \#1.5文章管理页面

<img src="./bili-bigevent-3vue3-action--imgs/image9.png" style="width:5.75486in;height:3.08403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image10.png" style="width:5.76736in;height:3.08403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image11.png" style="width:4.39306in;height:2.35486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image12.png" style="width:5.76528in;height:3.08958in" />

### \#1.6个人信息

<img src="./bili-bigevent-3vue3-action--imgs/image13.png" style="width:4.14444in;height:2.21181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image14.png" style="width:5.14861in;height:2.76181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image15.png" style="width:5.76736in;height:3.11319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image16.png" style="width:5.76736in;height:3.11042in" />

## \#2.需求分析

<img src="./bili-bigevent-3vue3-action--imgs/image17.png" style="width:5.76806in;height:1.84931in" />

## \#3学习路径

1.环境准备

2.功能开发

\*注册

\*登录

\*文章分类

\*文章管理

\*个人中心

# P70实战篇-58_大事件_环境准备

10:04 注：参见《bili-bigevent-2vue3-basic.docx》P64实战篇-52_element_快速入门

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=70>

**1.环境准备**

## \#1.创建Vue工程

\> npm init vue@latest

<img src="./bili-bigevent-3vue3-action--imgs/image18.png" style="width:4.09792in;height:3.33958in" />

<img src="./bili-bigevent-3vue3-action--imgs/image19.png" style="width:3.69167in;height:3.12014in" />

## \#2.安装依赖

<img src="./bili-bigevent-3vue3-action--imgs/image20.png" style="width:3.83403in;height:0.74444in" />

》》Element-Plus

~/zdev\$ npm install element-plus --save

<img src="./bili-bigevent-3vue3-action--imgs/image21.png" style="width:5.76806in;height:0.52153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image22.png" style="width:4.81667in;height:2.26389in" />

》》Axios

~/zdev\$ npm install axios

<img src="./bili-bigevent-3vue3-action--imgs/image23.png" style="width:5.14583in;height:0.54861in" />

》》Sass

~/zdev\$ npm install sass -D

<img src="./bili-bigevent-3vue3-action--imgs/image24.png" style="width:5.12153in;height:0.55764in" />

## \#3.目录调整

**\*删除components下面自动生成的内容**

<img src="./bili-bigevent-3vue3-action--imgs/image25.png" style="width:5.54931in;height:0.71111in" />

**\*新建目录api、utils、views**

<img src="./bili-bigevent-3vue3-action--imgs/image26.png" style="width:5.45278in;height:1.21181in" />

？？？ src/utils/request.js

<img src="./bili-bigevent-3vue3-action--imgs/image27.png" style="width:4.02014in;height:0.55556in" />

\*将资料中的静态资源(如图片等)拷贝到assets目录下

<img src="./bili-bigevent-3vue3-action--imgs/image28.png" style="width:5.76319in;height:1.18681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image29.png" style="width:5.76389in;height:1.49792in" />

**\*删除App.uve中自动生成的内容**

<img src="./bili-bigevent-3vue3-action--imgs/image30.png" style="width:3.58333in;height:2.95139in" />

### \#3.1 src/utils/request.js

数据交互 - 请求工具request.js的设计

<img src="./bili-bigevent-3vue3-action--imgs/image31.png" style="width:5.76736in;height:1.33819in" />

<img src="./bili-bigevent-3vue3-action--imgs/image32.png" style="width:5.3125in;height:4.45833in" />

interceptors.response...result={  
    **"data"**: { **"code"**: **0**, **"message"**: **"操作成功"**, **"data"**: **null** },  
    **"status"**: **200**,  
    **"statusText"**: **"OK"**,  
    **"headers"**: {  
        **"access-control-allow-origin"**: **"\*"**,  
        **"connection"**: **"close"**,  
        **"content-type"**: **"application/json"**,  
        **"date"**: **"Sun, 12 Jan 2025 09:08:13 GMT"**,  
        **"transfer-encoding"**: **"chunked"**  
    },  
    **"config"**: {  
        **"transitional"**: {  
            **"silentJSONParsing"**: **true**,  
            **"forcedJSONParsing"**: **true**,  
            **"clarifyTimeoutError"**: **false**  
        },  
        **"adapter"**: \[ **"xhr"**, **"http"**, **"fetch"** \],  
        **"transformRequest"**: \[ **null** \],  
        **"transformResponse"**: \[ **null** \],  
        **"timeout"**: **0**,  
        **"xsrfCookieName"**: **"XSRF-TOKEN"**,  
        **"xsrfHeaderName"**: **"X-XSRF-TOKEN"**,  
        **"maxContentLength"**: **-1**,  
        **"maxBodyLength"**: **-1**,  
        **"env"**: { },  
        **"headers"**: {  
            **"Accept"**: **"application/json, text/plain, \*/\*"**,  
            **"Content-Type"**: **"application/x-www-form-urlencoded;charset=utf-8"**  
        },  
        **"baseURL"**: **"/api"**,  
        **"method"**: **"post"**,  
        **"url"**: **"/user/register"**,  
        **"data"**: **"username=abcd2222&password=123456&rePassword=123456"**  
    },  
    **"request"**: { }  
}

注：关于axios，参见<https://www.runoob.com/vue3/vue3-ajax-axios.html>

## \#4.启动项目

\>\>\> npm run dev

<img src="./bili-bigevent-3vue3-action--imgs/image33.png" style="width:4.70139in;height:0.70833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image34.png" style="width:3.5625in;height:1.3125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image35.png" style="width:5.75in;height:1.33333in" />

## 附1.vue3项目文件介绍

原文链接：<https://blog.csdn.net/weixin_47480200/article/details/145099919>

node_modules：项目的依赖文件

public：项目的公共资源文件

src：放置组件和入口文件

assets：项目的静态资源文件，存放图片或样式

components：存放自己封装组件的文件夹

router：项目路由文件夹

views：页面文件夹

> App.vue：项目主文件，所有页面都是在App.vue下进行切换的，也可以理解为所有路由是App.vue的子组件

main.js：项目的主入口文件，主要作用是初始化vue实例，并引入所需插件

.gitinore：git忽略文件，不上传提交的文件

（amd：异步加载，cmd：懒加载）

index.html：项目中唯一的html文件，项目的入口

package.json：项目的node配置文件，里面定义了项目的npm脚本，依赖包等信息

README.md：项目中的说明文件

vite.config.js：项目的配置文件

项目启动后调用顺序：index.html-\>main.js-\>App.vue-\>router/index.js-\>components。

<img src="./bili-bigevent-3vue3-action--imgs/image36.png" style="width:2.15972in;height:2.77778in" />

# P71实战篇-59_大事件_注册_页面搭建

22:56

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=71>

## \#1.vuejs常用开发步骤

<img src="./bili-bigevent-3vue3-action--imgs/image37.png" style="width:5.76597in;height:1.5625in" />

注：需要给注册页面的表单做 绑定数据和数据校验；需要给“注册”按钮绑定事件。

<img src="./bili-bigevent-3vue3-action--imgs/image38.png" style="width:5.76875in;height:2.76111in" />

## \#2.搭建页面

<img src="./bili-bigevent-3vue3-action--imgs/image39.png" style="width:3.82361in;height:1.86458in" alt="IMG_256" />

创建src/views/Login.vue ，

<img src="./bili-bigevent-3vue3-action--imgs/image40.png" style="width:4.53472in;height:1.64583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image41.png" style="width:3.10764in;height:0.5375in" />

<img src="./bili-bigevent-3vue3-action--imgs/image42.png" style="width:5.76389in;height:1.79097in" />

<img src="./bili-bigevent-3vue3-action--imgs/image43.png" style="width:4.95972in;height:1.57083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image44.png" style="width:5.76042in;height:1.94514in" />

<img src="./bili-bigevent-3vue3-action--imgs/image45.png" style="width:5.09375in;height:1.61319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image46.png" style="width:5.76736in;height:0.91667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image47.png" style="width:5.76181in;height:0.81111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image48.png" style="width:5.76181in;height:1.53542in" />

<img src="./bili-bigevent-3vue3-action--imgs/image49.png" style="width:5.25972in;height:1.85208in" />

修改src\App.vue的代码为：

<img src="./bili-bigevent-3vue3-action--imgs/image50.png" style="width:3.89583in;height:2.68056in" />

## \#3绑定数据

### \#3.1《大事件接口文档-V1.0》之注册接口

<img src="./bili-bigevent-3vue3-action--imgs/image51.png" style="width:2.78819in;height:2.53681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image52.png" style="width:5.7625in;height:2.3875in" />

<img src="./bili-bigevent-3vue3-action--imgs/image53.png" style="width:5.76319in;height:3.4in" />

### \#3.2 绑定数据registerData

Login.vue代码修改：

<img src="./bili-bigevent-3vue3-action--imgs/image54.png" style="width:5.76667in;height:1.43194in" />

<img src="./bili-bigevent-3vue3-action--imgs/image55.png" style="width:5.76597in;height:1.75903in" />

## \#4.表单校验

### \#4.1 element-plus官网中的表单校验代码

“表单校验”官方网页地址

<https://element-plus.org/zh-CN/component/form.html#%E8%A1%A8%E5%8D%95%E6%A0%A1%E9%AA%8C>

<img src="./bili-bigevent-3vue3-action--imgs/image56.png" style="width:5.76667in;height:2.40972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image57.png" style="width:5.49306in;height:4.22222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image58.png" style="width:3.02083in;height:2.5in" />

<img src="./bili-bigevent-3vue3-action--imgs/image59.png" style="width:5.76736in;height:2.50347in" />

“自定义校验规则”官方网页地址

<https://element-plus.org/zh-CN/component/form.html#%E8%87%AA%E5%AE%9A%E4%B9%89%E6%A0%A1%E9%AA%8C%E8%A7%84%E5%88%99>

<img src="./bili-bigevent-3vue3-action--imgs/image60.png" style="width:5.75694in;height:2.56597in" />

<img src="./bili-bigevent-3vue3-action--imgs/image61.png" style="width:5.11111in;height:2.02083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image62.png" style="width:2.27083in;height:1.11806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image63.png" style="width:4.78472in;height:1.07639in" />

### \#4.2 Login.vue中添加官方的表单代码

11:35

<img src="./bili-bigevent-3vue3-action--imgs/image64.png" style="width:5.76597in;height:2.82569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image65.png" style="width:4.34514in;height:1.95625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image66.png" style="width:5.76111in;height:2.39097in" />

注：从github下载的某个同学的代码中，用const rules 用const registerDataRules代替了，这是小事情！:)

### \#4.3浏览器中测试效果

<img src="./bili-bigevent-3vue3-action--imgs/image67.png" style="width:5.76389in;height:2.71597in" />

<img src="./bili-bigevent-3vue3-action--imgs/image68.png" style="width:5.76111in;height:2.76597in" />

<img src="./bili-bigevent-3vue3-action--imgs/image69.png" style="width:5.76806in;height:2.71319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image70.png" style="width:2.48264in;height:2.3in" /><img src="./bili-bigevent-3vue3-action--imgs/image71.png" style="width:2.4375in;height:2.2375in" />

## 5.小结

<img src="./bili-bigevent-3vue3-action--imgs/image72.png" style="width:5.76181in;height:1.72083in" />

# P72实战篇-60_大事件_注册_接口调用

12:24

## \#1. 本节内容简介

\#(1).《大事件接口文档-V1.0》之注册接口

<img src="./bili-bigevent-3vue3-action--imgs/image73.png" style="width:1.86944in;height:1.71042in" />

<img src="./bili-bigevent-3vue3-action--imgs/image74.png" style="width:4.37083in;height:2.10903in" />

<img src="./bili-bigevent-3vue3-action--imgs/image75.png" style="width:5.76319in;height:2.43403in" />

\#(2).前端代码相关文件：

<img src="./bili-bigevent-3vue3-action--imgs/image76.png" style="width:2.5in;height:1.84722in" />

## \#2准备工作--启动后台服务

\>\> java -jar bigevent-l.0-SNAPSHOT. jar

<img src="./bili-bigevent-3vue3-action--imgs/image77.png" style="width:5.7625in;height:1.36528in" />

<img src="./bili-bigevent-3vue3-action--imgs/image78.png" style="width:5.75972in;height:1.4625in" />

启动redis服务

<img src="./bili-bigevent-3vue3-action--imgs/image79.png" style="width:3.86667in;height:2.54792in" />

<img src="./bili-bigevent-3vue3-action--imgs/image80.png" style="width:5.75972in;height:2.4625in" />

## \#2+1\*启动MySQL和Redis

参见《bili-bigevent-1springboot3-action.docx》之“P14实战篇-02_开发模式和环境搭建”

**\#2.0.1 启动MySQL**

abel@Ubuntu2204:~\$ docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql

abel@Ubuntu2204:~\$ docker ps

abel@Ubuntu2204:~\$ mysql -h 127.0.0.1 -P 3306 -u root -p

**\#2.0.2 启动Redis**

**E:\programs\Redis-7.4.1-Windows-x64-msys2-with-Service\start.bat**

## \#3 src/api/user.js代码

创建src/api/user.js文件，代码如下：

<img src="./bili-bigevent-3vue3-action--imgs/image81.png" style="width:5.7625in;height:1.91806in" />

## \#4. src/views/Login.vue中代码修改

<img src="./bili-bigevent-3vue3-action--imgs/image82.png" style="width:5.76181in;height:1.50694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image83.png" style="width:5.76111in;height:2.49167in" />

## \#5.测试

测试时异常：

<img src="./bili-bigevent-3vue3-action--imgs/image84.png" style="width:5.75625in;height:2.64722in" />

原来是跨域错误：

<img src="./bili-bigevent-3vue3-action--imgs/image85.png" style="width:5.76042in;height:1.09167in" />

# P73实战篇-61_大事件_跨域解决

10:11

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=73>

## \#1.跨域问题的原理

### \#1.1 跨域问题产生的原因：

<img src="./bili-bigevent-3vue3-action--imgs/image86.png" style="width:5.76806in;height:3.46389in" />

### \#1.2跨域问题的解决方法：

<img src="./bili-bigevent-3vue3-action--imgs/image87.png" style="width:5.7625in;height:2.49861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image88.png" style="width:5.76181in;height:2.50486in" />

注：提示----5173是vuejs的默认端口；参见《P70实战篇-58_大事件_环境准备》#4.运行项目。

## \#2.代码实操

修改src\utils\request.js

<img src="./bili-bigevent-3vue3-action--imgs/image89.png" style="width:5.76528in;height:1.96319in" /><img src="./bili-bigevent-3vue3-action--imgs/image90.png" style="width:5.76319in;height:1.96528in" />

vite.config.js

<img src="./bili-bigevent-3vue3-action--imgs/image91.png" style="width:4.1875in;height:1.57639in" />

<img src="./bili-bigevent-3vue3-action--imgs/image92.png" style="width:4.96528in;height:2.14583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image93.png" style="width:5.47917in;height:2.04861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image94.png" style="width:5.76597in;height:3.08056in" />

## \#3.附--springboot、vite中配置https

springboot中配置https，见《SpringBoot-HTTPS.docx》“Ch7.openssl产生的p12证书用在springboot里”；

vite中配置https，见《SpringBoot-HTTPS.docx》“Ch8.vite项目配置本地开发使用https访问，3分钟搞定”

vite中配置https跨域，见《SpringBoot-HTTPS.docx》“ch6.vite.config.js https跨域”

# P74实战篇-62_大事件_登录

15:18 <https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=74>

## \#1.需求

<img src="./bili-bigevent-3vue3-action--imgs/image95.png" style="width:5.76597in;height:2.76944in" />

## \#2.代码实现

### \#(1)Login.vue中的登录相关代码

<img src="./bili-bigevent-3vue3-action--imgs/image96.png" style="width:4.52778in;height:1in" />

<img src="./bili-bigevent-3vue3-action--imgs/image97.png" style="width:3.375in;height:1.54167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image98.png" style="width:4.69444in;height:1.90278in" />

<img src="./bili-bigevent-3vue3-action--imgs/image99.png" style="width:5.76319in;height:2.46181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image100.png" style="width:5.70139in;height:2.47917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image101.png" style="width:5.09722in;height:2.36806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image102.png" style="width:2.875in;height:1.74306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image103.png" style="width:5.76181in;height:1.50139in" />

<img src="./bili-bigevent-3vue3-action--imgs/image104.png" style="width:5.75903in;height:1.62917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image105.png" style="width:5.76597in;height:1.56875in" />

### \#(2)user.js中的登录相关代码

参考接口文档，写userLoginservice函数

<img src="./bili-bigevent-3vue3-action--imgs/image106.png" style="width:2.16667in;height:1.86806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image107.png" style="width:5.76667in;height:1.98472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image108.png" style="width:3.30556in;height:0.76389in" />

<img src="./bili-bigevent-3vue3-action--imgs/image109.png" style="width:5.76458in;height:2.13333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image110.png" style="width:4.5625in;height:2.81944in" />

<img src="./bili-bigevent-3vue3-action--imgs/image111.png" style="width:4.04167in;height:1.65278in" />

## \#3.浏览器中验证

<img src="./bili-bigevent-3vue3-action--imgs/image112.png" style="width:5.76528in;height:3.04236in" />

<img src="./bili-bigevent-3vue3-action--imgs/image113.png" style="width:5.75694in;height:3.10764in" />

### \#3.1 clearRegisterData()函数的作用

如果下面的代码中没有clearRegisterData()函数

<img src="./bili-bigevent-3vue3-action--imgs/image114.png" style="width:5.76181in;height:1.48681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image115.png" style="width:5.76389in;height:0.97014in" />

则“登录”表单中点了 ”注册--\>”，或“注册”表单中点了 ”返回--\>”：

<img src="./bili-bigevent-3vue3-action--imgs/image116.png" style="width:5.76736in;height:1.75208in" />

这是注册表单和登录表单共用了一个数据模型registerData，切换后没有调用clearRegisterData()清空数据模型。调用clearRegisterData()

<img src="./bili-bigevent-3vue3-action--imgs/image117.png" style="width:2.43056in;height:0.72222in" />

# P75实战篇-63_大事件_axios响应拦截器优化

06:32

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=75>

## \#1.优化axios响应拦截器的需求

<img src="./bili-bigevent-3vue3-action--imgs/image118.png" style="width:5.76111in;height:2.59514in" />

## \#2.代码实现

### \#2.1 request.js中的拦截器

<img src="./bili-bigevent-3vue3-action--imgs/image119.png" style="width:3.33056in;height:1.53125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image120.png" style="width:5.17361in;height:3.99306in" />

### \#2.2src /views/Login.vue中的代码修改

<img src="./bili-bigevent-3vue3-action--imgs/image121.png" style="width:5.76458in;height:3.38611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image122.png" style="width:5.03472in;height:2.53472in" />

## \#3验证

<img src="./bili-bigevent-3vue3-action--imgs/image123.png" style="width:4.20625in;height:2.26042in" />

<img src="./bili-bigevent-3vue3-action--imgs/image124.png" style="width:4.29236in;height:2.24375in" />

## \#4.Message消息提示

### \#4.1element-plus官网地址

element-plus官网地址 <https://element-plus.org/zh-CN/component/message.html>

<img src="./bili-bigevent-3vue3-action--imgs/image125.png" style="width:5.76389in;height:2.24653in" />

<img src="./bili-bigevent-3vue3-action--imgs/image126.png" style="width:5.7625in;height:1.96597in" />

### \#4.2集成到request.js

<img src="./bili-bigevent-3vue3-action--imgs/image127.png" style="width:3.80556in;height:2.39583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image128.png" style="width:4.44306in;height:3.35347in" />

### \#4.3集成到Login.vue

<img src="./bili-bigevent-3vue3-action--imgs/image129.png" style="width:4.56944in;height:1.28472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image130.png" style="width:5.625in;height:2.86111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image131.png" style="width:5.11111in;height:2.65972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image132.png" style="width:5.7625in;height:2.49444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image133.png" style="width:5.75903in;height:2.89792in" />

# P76实战篇-64_大事件_主页面搭建

07:44

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=76>

## \#1.主页面布局效果图

<img src="./bili-bigevent-3vue3-action--imgs/image134.png" style="width:5.76736in;height:2.77847in" />

## \#2.代码实现

### \#2.1src/views/Layout.vue

<img src="./bili-bigevent-3vue3-action--imgs/image135.png" style="width:3.31528in;height:2.71944in" />

<img src="./bili-bigevent-3vue3-action--imgs/image136.png" style="width:5.76319in;height:1.26736in" />

<img src="./bili-bigevent-3vue3-action--imgs/image137.png" style="width:2.83472in;height:0.90486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image138.png" style="width:2.74375in;height:0.8625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image139.png" style="width:2.93681in;height:0.97917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image140.png" style="width:2.975in;height:0.84306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image141.png" style="width:2.96667in;height:0.87569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image142.png" style="width:2.53472in;height:0.86458in" />

<img src="./bili-bigevent-3vue3-action--imgs/image143.png" style="width:1.43056in;height:0.26597in" />

<img src="./bili-bigevent-3vue3-action--imgs/image144.png" style="width:2.53472in;height:0.375in" />

<img src="./bili-bigevent-3vue3-action--imgs/image145.png" style="width:3.18056in;height:1.31319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image146.png" style="width:5.76458in;height:1.22917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image147.png" style="width:5.76736in;height:0.98472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image148.png" style="width:4.76042in;height:0.78056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image149.png" style="width:2.65972in;height:0.72222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image150.png" style="width:5.76806in;height:1.24375in" />

<img src="./bili-bigevent-3vue3-action--imgs/image151.png" style="width:2.46944in;height:0.62014in" />

<img src="./bili-bigevent-3vue3-action--imgs/image152.png" style="width:3.54167in;height:1.13889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image153.png" style="width:2.99306in;height:0.77778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image154.png" style="width:3.11806in;height:2.07639in" />

<img src="./bili-bigevent-3vue3-action--imgs/image155.png" style="width:3in;height:1.27083in" />

### \#2.2 App.vue的临时修改

<img src="./bili-bigevent-3vue3-action--imgs/image156.png" style="width:3.97222in;height:3.11806in" />

### \#2.3.主页布局的显示效果

<img src="./bili-bigevent-3vue3-action--imgs/image157.png" style="width:5.76736in;height:3.06806in" />

# P77实战篇-65_大事件_路由基本使用

15:17

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=77>

## \#1.路由的理论

### \#1.1路由

\*路由，决定从起点到终点的路径的进程。

\*在前端工程中，路由指的是根据不同的访问路径，展示不同组件的内容。

\*Vue Router是Vue.js的官方路由。

<img src="./bili-bigevent-3vue3-action--imgs/image158.png" style="width:5.76389in;height:1.65625in" />

### \#1.2Vue Router

\*安装vue-router： npm install vue-router@4

\*在src/router/index.js中创建路由器，并导出

\*在vue应用实例中使用vue-router

\*声明router-view标签，展示组件内容

<img src="./bili-bigevent-3vue3-action--imgs/image159.png" style="width:5.76042in;height:2.75208in" />

注：导入src/router/index.js,只需写成import router from “@router”;

导入src/router/abc.js, 需写成import router from “@router/abc.js”;

## \#2.路由功能的实现

### \#2.1安装vue-router库

<img src="./bili-bigevent-3vue3-action--imgs/image160.png" style="width:5.76667in;height:0.60833in" />

### \#2.2 src /router / index.js

创建src /router / index.js文件，其代码为

<img src="./bili-bigevent-3vue3-action--imgs/image161.png" style="width:5.07639in;height:1.22222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image162.png" style="width:3.82639in;height:0.97222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image163.png" style="width:2.88889in;height:1.50694in" />

### \#2.3在vue应用实例中使用vue-router

<img src="./bili-bigevent-3vue3-action--imgs/image164.png" style="width:5.72917in;height:2.91667in" />

### \#2.4声明router-view标签

<img src="./bili-bigevent-3vue3-action--imgs/image165.png" style="width:2.81944in;height:2.31944in" />

### \#2.5测试

<img src="./bili-bigevent-3vue3-action--imgs/image166.png" style="width:4.43264in;height:2.36458in" />

<img src="./bili-bigevent-3vue3-action--imgs/image167.png" style="width:4.69722in;height:2.525in" />

## \#3登录成功后跳转到主页功能的实现

修改src/views/Login.vue代码

<img src="./bili-bigevent-3vue3-action--imgs/image168.png" style="width:5.55903in;height:1.69583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image169.png" style="width:5.76181in;height:2.78542in" />

### \#3.1测试

<img src="./bili-bigevent-3vue3-action--imgs/image170.png" style="width:4.625in;height:2.37778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image171.png" style="width:4.63056in;height:2.45833in" />

## \#4小结

<img src="./bili-bigevent-3vue3-action--imgs/image172.png" style="width:5.76042in;height:2.75972in" />

# P78实战篇-66_大事件_子路由

13:12

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=76>

## \#1.子路由的理论

右侧的显示内容要根据左侧菜单的点击而发生变化。

<img src="./bili-bigevent-3vue3-action--imgs/image173.png" style="width:4.78403in;height:2.29931in" />

<img src="./bili-bigevent-3vue3-action--imgs/image174.png" style="width:5.75694in;height:1.35764in" />

5个菜单项 点击后 对应展示的组件封装到5个vue文件中。

<img src="./bili-bigevent-3vue3-action--imgs/image175.png" style="width:5.76597in;height:2.76736in" />

配置子路由的步骤：

<img src="./bili-bigevent-3vue3-action--imgs/image176.png" style="width:5.75694in;height:2.67639in" />

## \#2.子路由的实战代码

\#2.1.复制资料中的五个组件到项目代码的src/views目录下

<img src="./bili-bigevent-3vue3-action--imgs/image177.png" style="width:5.76736in;height:2.56042in" />

<img src="./bili-bigevent-3vue3-action--imgs/image178.png" style="width:3.83333in;height:0.83333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image179.png" style="width:3.19444in;height:0.84028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image180.png" style="width:3.11111in;height:0.81944in" />

### \#2.2配置子路由

<img src="./bili-bigevent-3vue3-action--imgs/image181.png" style="width:5.09028in;height:1.13889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image182.png" style="width:5.76389in;height:1.00694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image183.png" style="width:5.7625in;height:2.31528in" />

<img src="./bili-bigevent-3vue3-action--imgs/image184.png" style="width:2.92361in;height:1.00694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image185.png" style="width:2.09028in;height:0.38194in" />

### \#2.3声明router-view标签

修改Layout.Vue

<img src="./bili-bigevent-3vue3-action--imgs/image186.png" style="width:5.76736in;height:2.16736in" />

<img src="./bili-bigevent-3vue3-action--imgs/image187.png" style="width:5.76528in;height:1.10764in" />

### \#2.4 为菜单项 el-menu-item 设置index属性

修改Layout.vue

<img src="./bili-bigevent-3vue3-action--imgs/image188.png" style="width:5.76111in;height:1.85486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image189.png" style="width:4.65278in;height:1.16667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image190.png" style="width:4.54167in;height:2.47917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image191.png" style="width:4.86111in;height:1.15278in" />

<img src="./bili-bigevent-3vue3-action--imgs/image192.png" style="width:4.70208in;height:1.49931in" />

### \#2.5测试1

<img src="./bili-bigevent-3vue3-action--imgs/image193.png" style="width:5.76111in;height:1.59931in" />

### \#2.5路由重定向

<img src="./bili-bigevent-3vue3-action--imgs/image194.png" style="width:5.75903in;height:2.90417in" />

<img src="./bili-bigevent-3vue3-action--imgs/image195.png" style="width:5.76528in;height:2.20972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image196.png" style="width:5.7625in;height:2.2125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image197.png" style="width:2.96528in;height:1.58333in" />

测试验证

<img src="./bili-bigevent-3vue3-action--imgs/image198.png" style="width:5.76389in;height:1.9in" />

## \#3小结

<img src="./bili-bigevent-3vue3-action--imgs/image199.png" style="width:5.75833in;height:2.34375in" />

### **首页整体路由设计**

https://blog.csdn.net/weixin_63681863/article/details/132523961

**实现目标:**

- 完成整体路由规划【搞清楚要做几个页面，它们分别在哪个路由下面，怎么跳转的…】

- 通过观察, 点击左侧导航, 右侧区域在切换, 那右侧区域内容一直在变, 那这个地方就是一个路由的出口

- 我们需要搭建嵌套路由

# P79实战篇-67_大事件_文章分类列表查询

09:20

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=79>

## \#1.文章分类列表的需求

<img src="./bili-bigevent-3vue3-action--imgs/image200.png" style="width:5.7625in;height:2.70764in" />

## \#2.实战代码

### \#2.1 ArticleCategory.vue

<img src="./bili-bigevent-3vue3-action--imgs/image201.png" style="width:4.57639in;height:1.31944in" />

<img src="./bili-bigevent-3vue3-action--imgs/image202.png" style="width:3.83333in;height:1.48611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image203.png" style="width:3.81944in;height:1.34722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image204.png" style="width:3.81944in;height:1.50694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image205.png" style="width:4.96528in;height:1.53472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image206.png" style="width:5.76667in;height:1.49444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image207.png" style="width:5.76597in;height:1.52639in" />

<img src="./bili-bigevent-3vue3-action--imgs/image208.png" style="width:5.76736in;height:0.96319in" />

### \#2.2 src/api/article.js

#### \#2.2.1《大事件接口文档-V1.0》2.1 文章分类列表

<img src="./bili-bigevent-3vue3-action--imgs/image209.png" style="width:3.92708in;height:2.17569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image210.png" style="width:2.44444in;height:0.98611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image211.png" style="width:4.47569in;height:2.02569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image212.png" style="width:2.74722in;height:1.69444in" />

#### \#2.2.2src/api/article.js代码

<img src="./bili-bigevent-3vue3-action--imgs/image213.png" style="width:4.17361in;height:1.38194in" />

## \#3测试验证

<img src="./bili-bigevent-3vue3-action--imgs/image214.png" style="width:5.75694in;height:3.06806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image215.png" style="width:5.76319in;height:1.08472in" />

# P80实战篇-68_大事件_pinia基本使用

15:12

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=80>

## \#1.Pinia状态管理库

Pinia是Vue的专属状态管理库，它允许你跨组件或页面共享状态。

<img src="./bili-bigevent-3vue3-action--imgs/image216.png" style="width:5.75972in;height:2.10139in" />

Pinia的使用步骤：

<img src="./bili-bigevent-3vue3-action--imgs/image217.png" style="width:5.76042in;height:2.92847in" />

## \#2.实战代码

### \#2.1安装pinia

\>\>\> npm install pinia

<img src="./bili-bigevent-3vue3-action--imgs/image218.png" style="width:5.14583in;height:1.90278in" />

### \#2.2在vue应用实例中使用pinia

<img src="./bili-bigevent-3vue3-action--imgs/image219.png" style="width:3.5625in;height:1.75694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image220.png" style="width:2.58333in;height:1.14583in" />

### \#2.3在src/stores/token.js中定义store

创建src/stores/文件夹和src/stores/token.js文件。

<img src="./bili-bigevent-3vue3-action--imgs/image221.png" style="width:5.76736in;height:0.75486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image222.png" style="width:4.21528in;height:1.13194in" />

<img src="./bili-bigevent-3vue3-action--imgs/image223.png" style="width:4.58333in;height:0.94444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image224.png" style="width:3.05556in;height:0.92361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image225.png" style="width:2.65972in;height:0.79861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image226.png" style="width:3.13889in;height:0.93056in" />

### \#2.4在组件中使用store

\#(1)修改src \>views\>Login.vue

<img src="./bili-bigevent-3vue3-action--imgs/image227.png" style="width:5.52083in;height:1.43056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image228.png" style="width:5.09722in;height:2.83333in" />

\#(2)修改src \>api\>article.js

<img src="./bili-bigevent-3vue3-action--imgs/image229.png" style="width:5.76597in;height:1.49792in" />

## \#3.测试

<img src="./bili-bigevent-3vue3-action--imgs/image230.png" style="width:4.45486in;height:2.04028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image231.png" style="width:3.63333in;height:1.42083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image232.png" style="width:5.75903in;height:3.07153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image233.png" style="width:5.76597in;height:2.67917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image234.png" style="width:5.76458in;height:2.52986in" />

<img src="./bili-bigevent-3vue3-action--imgs/image235.png" style="width:5.76736in;height:3.07639in" />

# P81实战篇-69_大事件_axios请求拦截器

05:43

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=81>

## \#1.axios请求拦截器

<img src="./bili-bigevent-3vue3-action--imgs/image236.png" style="width:5.76389in;height:1.84931in" />

axios请求拦截器的实现方法：

<img src="./bili-bigevent-3vue3-action--imgs/image237.png" style="width:5.76458in;height:4.67917in" />

## \#2.实战代码

### \#2.1 src \>utils \>request.js

<img src="./bili-bigevent-3vue3-action--imgs/image31.png" style="width:5.76736in;height:1.33819in" />

<img src="./bili-bigevent-3vue3-action--imgs/image238.png" style="width:3.84028in;height:2.11806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image239.png" style="width:4.98611in;height:3.38889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image240.png" style="width:3.20833in;height:1.75in" />

注：完整的instance.interceptors.response.use代码见《P75实战篇-63_大事件_axios响应拦截器优化》“#4.2集成到request.js”

### \#2.2修改src \>api\>article.js

<img src="./bili-bigevent-3vue3-action--imgs/image241.png" style="width:5.76736in;height:1.61944in" />

## \#3 测试

<img src="./bili-bigevent-3vue3-action--imgs/image242.png" style="width:5.75972in;height:2.81597in" />

<img src="./bili-bigevent-3vue3-action--imgs/image243.png" style="width:5.76111in;height:2.50833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image244.png" style="width:5.75694in;height:3.09167in" />

# P82实战篇-70_大事件_pinia持久化插件_persist

06:17

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=82>

## \#1.pinia持久化插件persist

### \#1.1为啥用persist 插件

为啥用persist 插件？是因为 文章列表**页面刷新**的bug：

<img src="./bili-bigevent-3vue3-action--imgs/image245.png" style="width:4.95903in;height:2.48889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image246.png" style="width:5.31458in;height:2.83056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image247.png" style="width:5.1in;height:2.72292in" />

<img src="./bili-bigevent-3vue3-action--imgs/image248.png" style="width:5.76319in;height:1.43958in" />

官方文档：https://prazdevs.github.io/pinia-plugin-persistedstate/zh/

### \#1.2如何使用Pinia持久化插件-persist

<img src="./bili-bigevent-3vue3-action--imgs/image249.png" style="width:5.76736in;height:2.57778in" />

## \#2.实战代码

### \#2.1安装persist 

\>\>\> npm install pinia-persistedstate-plugin

<img src="./bili-bigevent-3vue3-action--imgs/image250.png" style="width:5.76736in;height:1.59444in" />

### \#2.2在pinia中使用persist

src \>main.js

<img src="./bili-bigevent-3vue3-action--imgs/image251.png" style="width:5.64583in;height:1.92361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image252.png" style="width:3.61111in;height:0.61111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image253.png" style="width:2.09028in;height:1.00694in" />

### \#2.3定义状态Store时指定持久化配置参数

<img src="./bili-bigevent-3vue3-action--imgs/image254.png" style="width:4.63889in;height:1.61111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image255.png" style="width:3.05556in;height:1.84028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image256.png" style="width:3.15972in;height:1.34722in" />

## \#3测试验证

<img src="./bili-bigevent-3vue3-action--imgs/image257.png" style="width:5.76458in;height:2.87292in" />

<img src="./bili-bigevent-3vue3-action--imgs/image258.png" style="width:5.76319in;height:3.05208in" />

多次刷新，显示效果ok：

<img src="./bili-bigevent-3vue3-action--imgs/image259.png" style="width:5.75417in;height:3.07917in" />

# P83实战篇-71_大事件_未登录统一处理

05:45

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=83>

## \#1. 未登录的bug

从当前正在使用的chrome浏览器，拷贝地址：

<img src="./bili-bigevent-3vue3-action--imgs/image260.png" style="width:4.74931in;height:2.53194in" />

到edge浏览器里打开刚才拷贝的地址，发生 服务异常。<img src="./bili-bigevent-3vue3-action--imgs/image261.png" style="width:4.07778in;height:1.36319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image262.png" style="width:4.25347in;height:2.275in" />

实际上，edge浏览器的页面应该提示“未登录，请先登录”。

## \#2.未登录统一处理

<img src="./bili-bigevent-3vue3-action--imgs/image263.png" style="width:5.67361in;height:4.61806in" />

## \#3实战代码

src \>utils \>request.js

<img src="./bili-bigevent-3vue3-action--imgs/image264.png" style="width:4.74306in;height:0.72222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image265.png" style="width:3.14583in;height:1.36806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image266.png" style="width:5.59028in;height:1.31944in" />

<img src="./bili-bigevent-3vue3-action--imgs/image267.png" style="width:5.76597in;height:2.60278in" />

## \#4.测试1

<img src="./bili-bigevent-3vue3-action--imgs/image268.png" style="width:5.75694in;height:3.03681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image269.png" style="width:5.76181in;height:1.34792in" />

### \#4.1fix bug：Cannot read properties of undefined(reading "push'

<img src="./bili-bigevent-3vue3-action--imgs/image270.png" style="width:3.77083in;height:1.66667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image271.png" style="width:4.43542in;height:2.28403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image272.png" style="width:4.62708in;height:2.05903in" />

### \#测试2

重新刷新edge浏览器

<img src="./bili-bigevent-3vue3-action--imgs/image273.png" style="width:5.76319in;height:1.67083in" />

成功跳转到登录页面：

<img src="./bili-bigevent-3vue3-action--imgs/image274.png" style="width:5.75764in;height:1.87153in" />

# P84实战篇-72_大事件_文章分类添加

11:14

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=84>

## \#1.需求：添加文章分类

<img src="./bili-bigevent-3vue3-action--imgs/image275.png" style="width:5.1375in;height:2.47639in" />

## \#2代码实战

### \#2.1添加分类弹窗--搭建页面

**\#(1) src\>views\>article\>ArticleCategory.vue**

<img src="./bili-bigevent-3vue3-action--imgs/image276.png" style="width:5.27778in;height:2.00694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image277.png" style="width:2.60903in;height:1.43264in" />

<img src="./bili-bigevent-3vue3-action--imgs/image278.png" style="width:5.76528in;height:1.85556in" />

<img src="./bili-bigevent-3vue3-action--imgs/image279.png" style="width:5.76319in;height:1.55417in" />

<img src="./bili-bigevent-3vue3-action--imgs/image280.png" style="width:3.12847in;height:1.18056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image281.png" style="width:5.76111in;height:1.25347in" />

<img src="./bili-bigevent-3vue3-action--imgs/image282.png" style="width:4.31319in;height:1.13056in" />

**\#(2) 测试1**

<img src="./bili-bigevent-3vue3-action--imgs/image283.png" style="width:5.76042in;height:3.08333in" />

### \#2.2分类弹窗中“确认”按钮的click事件处理

**\#(1)《大事件接口文档-V1.0》2.2 新增文章分类**

<img src="./bili-bigevent-3vue3-action--imgs/image284.png" style="width:2.89583in;height:1.79861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image285.png" style="width:5.76042in;height:1.71667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image286.png" style="width:2.63889in;height:1.35417in" />

<img src="./bili-bigevent-3vue3-action--imgs/image287.png" style="width:5.76736in;height:2.09028in" />

**\#(2)“文章分类添加”接口函数articleCategoryAddservice**

**参考“《大事件接口文档-V1.0》2.2 新增文章分类”，写 “文章分类添加”接口函数：**

<img src="./bili-bigevent-3vue3-action--imgs/image288.png" style="width:5.76389in;height:2.38889in" />

**\#(3)使用articleCategoryAddservice()**

<img src="./bili-bigevent-3vue3-action--imgs/image289.png" style="width:5.76736in;height:1.58819in" />

<img src="./bili-bigevent-3vue3-action--imgs/image290.png" style="width:2.10417in;height:1.07917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image291.png" style="width:3.45278in;height:1.02083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image292.png" style="width:5.76597in;height:2.30069in" />

<img src="./bili-bigevent-3vue3-action--imgs/image293.png" style="width:4.20764in;height:2.49722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image294.png" style="width:5.75903in;height:2.36806in" />

**\#(3) 测试2**

<img src="./bili-bigevent-3vue3-action--imgs/image295.png" style="width:3.66667in;height:1.96667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image296.png" style="width:5.76458in;height:3.08472in" />

# P85实战篇-73_大事件_编辑分类_弹窗显示

08:02

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=85>

## \#1.需求：修改文章分类

<img src="./bili-bigevent-3vue3-action--imgs/image297.png" style="width:5.76736in;height:2.76736in" />

## \#2实战代码

### \#2.1实现点击编辑按钮显示弹窗

<img src="./bili-bigevent-3vue3-action--imgs/image298.png" style="width:5.76458in;height:2.90208in" />

<img src="./bili-bigevent-3vue3-action--imgs/image299.png" style="width:5.76389in;height:1.28125in" />

测试：

<img src="./bili-bigevent-3vue3-action--imgs/image300.png" style="width:5.75556in;height:3.03056in" />

### \#2.2修改弹窗的title

<img src="./bili-bigevent-3vue3-action--imgs/image301.png" style="width:5.76806in;height:2.75833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image302.png" style="width:5.76458in;height:1.37778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image303.png" style="width:5.76181in;height:1.49167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image304.png" style="width:5.76806in;height:2.43403in" />

### \#2.2弹窗中编辑框内容的初始显示

<img src="./bili-bigevent-3vue3-action--imgs/image305.png" style="width:5.04861in;height:2.6875in" />

<img src="./bili-bigevent-3vue3-action--imgs/image306.png" style="width:5.76806in;height:2.09444in" />

# P86实战篇-74_大事件_编辑分类_调用接口

08:46

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=86>

## \#1.需求：调用后台接口，实现分类数据更新

在编辑分类窗口的确认按钮点击事件中调用后台接口，实现分类数据更新

<img src="./bili-bigevent-3vue3-action--imgs/image307.png" style="width:5.75903in;height:2.78264in" />

## \#2代码实战

### \#2.1《大事件接口文档-V1.0》2.3 更新文章分类

<img src="./bili-bigevent-3vue3-action--imgs/image308.png" style="width:2.75694in;height:1.79167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image309.png" style="width:2.28472in;height:1in" />

<img src="./bili-bigevent-3vue3-action--imgs/image310.png" style="width:5.76319in;height:1.19792in" />

<img src="./bili-bigevent-3vue3-action--imgs/image311.png" style="width:2.84722in;height:1.61806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image312.png" style="width:2.33333in;height:1.09722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image313.png" style="width:5.76319in;height:1.21319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image314.png" style="width:2.56944in;height:1.63889in" />

### \#2.2**接口函数articleCategoryUpdateservice**

参考“#2.1《大事件接口文档-V1.0》2.3 更新文章分类”，写 “文章分类修改”接口函数articleCategoryUpdateservice

<img src="./bili-bigevent-3vue3-action--imgs/image315.png" style="width:5.76319in;height:3.20833in" />

### \#2.3使用接口函数articleCategoryUpdateservice

<img src="./bili-bigevent-3vue3-action--imgs/image316.png" style="width:5.76806in;height:1.28403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image317.png" style="width:3.58611in;height:0.90903in" />

<img src="./bili-bigevent-3vue3-action--imgs/image318.png" style="width:2.61111in;height:1.32986in" />

<img src="./bili-bigevent-3vue3-action--imgs/image319.png" style="width:4.15764in;height:1.29167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image320.png" style="width:5.47083in;height:1.98819in" />

<img src="./bili-bigevent-3vue3-action--imgs/image321.png" style="width:4.08611in;height:1.93056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image322.png" style="width:5.7625in;height:2.37917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image323.png" style="width:3.85417in;height:1.23611in" />

## \#3测试验证

<img src="./bili-bigevent-3vue3-action--imgs/image324.png" style="width:5.75764in;height:2.91111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image325.png" style="width:5.76181in;height:2.24583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image326.png" style="width:5.76181in;height:3.10556in" />

<img src="./bili-bigevent-3vue3-action--imgs/image327.png" style="width:5.76736in;height:3.08958in" />

# P87实战篇-75_大事件_删除分类

09:39

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=87>

## \#1.需求：删除文章分类

要完成2个事情：（1）弹窗的显示；（2）（点击弹窗中确定按钮时）删除接口的调用

<img src="./bili-bigevent-3vue3-action--imgs/image328.png" style="width:5.76042in;height:2.76389in" />

## \#2代码实战

### \#2.1删除按钮被点击后的**消息弹出框**

**(1)关于element-plus的消息弹出框**

https://element-plus.org/zh-CN/component/message-box.html

<img src="./bili-bigevent-3vue3-action--imgs/image329.png" style="width:5.75903in;height:2.34097in" />

<img src="./bili-bigevent-3vue3-action--imgs/image330.png" style="width:5.76736in;height:4.64861in" />

**\#(2)在ArticleCategory.vue 使用element-plus的消息弹出框**

src \>views \>article \>ArticleCategory.vue

<img src="./bili-bigevent-3vue3-action--imgs/image331.png" style="width:5.76319in;height:1.45in" />

<img src="./bili-bigevent-3vue3-action--imgs/image332.png" style="width:3.625in;height:2.70139in" />

<img src="./bili-bigevent-3vue3-action--imgs/image333.png" style="width:3.20139in;height:1.16667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image334.png" style="width:3.4375in;height:1.38681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image335.png" style="width:5.76181in;height:2.50486in" />

**\#(3)测试1**

<img src="./bili-bigevent-3vue3-action--imgs/image336.png" style="width:5.76458in;height:3.08681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image337.png" style="width:5.76528in;height:3.07917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image338.png" style="width:5.75972in;height:2.82292in" />

<img src="./bili-bigevent-3vue3-action--imgs/image339.png" style="width:5.75556in;height:3.07847in" />

### \#2.2调用后台的删除文章分类接口

\#(1)《大事件接口文档-V1.0》2.5 删除文章分类

<img src="./bili-bigevent-3vue3-action--imgs/image340.png" style="width:3.11111in;height:1.75in" />

<img src="./bili-bigevent-3vue3-action--imgs/image341.png" style="width:2.04167in;height:1.04861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image342.png" style="width:5.76319in;height:0.65347in" />

<img src="./bili-bigevent-3vue3-action--imgs/image343.png" style="width:1.22222in;height:0.84722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image344.png" style="width:2.3125in;height:1.05556in" />

<img src="./bili-bigevent-3vue3-action--imgs/image345.png" style="width:5.76111in;height:1.19514in" />

<img src="./bili-bigevent-3vue3-action--imgs/image346.png" style="width:1.87083in;height:1.19444in" />

\#(2) 接口函数articleCategoryDeleteService

<img src="./bili-bigevent-3vue3-action--imgs/image347.png" style="width:5.76736in;height:1.19028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image348.png" style="width:4.98611in;height:0.78472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image349.png" style="width:5.13194in;height:0.83333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image350.png" style="width:4.38889in;height:0.84028in" />

\#(3)调用articleCategoryDeleteService

<img src="./bili-bigevent-3vue3-action--imgs/image351.png" style="width:5.75903in;height:1.65347in" />

<img src="./bili-bigevent-3vue3-action--imgs/image352.png" style="width:2.23958in;height:0.57986in" />

<img src="./bili-bigevent-3vue3-action--imgs/image353.png" style="width:1.84306in;height:0.97431in" />

<img src="./bili-bigevent-3vue3-action--imgs/image354.png" style="width:3.39653in;height:1.01111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image355.png" style="width:4.05in;height:1.53681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image356.png" style="width:3.30556in;height:1.52153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image357.png" style="width:2.99583in;height:1.29236in" />

<img src="./bili-bigevent-3vue3-action--imgs/image358.png" style="width:2.44306in;height:0.61181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image359.png" style="width:4.79167in;height:1.00625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image360.png" style="width:4.20625in;height:2.27361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image361.png" style="width:5.76181in;height:1.91875in" />

<img src="./bili-bigevent-3vue3-action--imgs/image362.png" style="width:3.90764in;height:1.57083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image363.png" style="width:5.75903in;height:2.51597in" />

\#(4)测试

<img src="./bili-bigevent-3vue3-action--imgs/image364.png" style="width:5.76458in;height:3.00486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image365.png" style="width:5.75972in;height:3.06806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image366.png" style="width:5.7625in;height:2.82569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image367.png" style="width:5.76736in;height:3.08681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image368.png" style="width:5.75694in;height:3.08403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image369.png" style="width:5.10139in;height:2.72083in" />

# P88实战篇-76_大事件_文章列表查询_页面搭建

09:33

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=88>

## \#1需求：文章列表查询的页面搭建

<img src="./bili-bigevent-3vue3-action--imgs/image370.png" style="width:5.76389in;height:2.80139in" />

## \#2代码实战

### \#2.1 页面搭建ArticleManage.vue

<img src="./bili-bigevent-3vue3-action--imgs/image371.png" style="width:3.925in;height:2.19444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image372.png" style="width:5.76111in;height:3.0875in" />

<img src="./bili-bigevent-3vue3-action--imgs/image373.png" style="width:3.79861in;height:1.63889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image374.png" style="width:3.89583in;height:1.69444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image375.png" style="width:3.93056in;height:1.27778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image376.png" style="width:3.53681in;height:1.35139in" />

<img src="./bili-bigevent-3vue3-action--imgs/image377.png" style="width:2.00694in;height:0.84861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image378.png" style="width:5.76736in;height:1.45069in" />

<img src="./bili-bigevent-3vue3-action--imgs/image379.png" style="width:5.76736in;height:1.18681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image380.png" style="width:5.7625in;height:1.32361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image381.png" style="width:2.98611in;height:0.90278in" />

<img src="./bili-bigevent-3vue3-action--imgs/image382.png" style="width:3.04861in;height:1.70833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image383.png" style="width:3.92778in;height:1.48681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image384.png" style="width:5.76458in;height:2.23403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image385.png" style="width:5.76806in;height:2.12917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image386.png" style="width:5.76597in;height:2.38681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image387.png" style="width:5.7625in;height:0.71389in" />

### \#2.2 main.js

<img src="./bili-bigevent-3vue3-action--imgs/image388.png" style="width:5.76111in;height:1.99306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image389.png" style="width:5.7625in;height:1.28542in" />

<img src="./bili-bigevent-3vue3-action--imgs/image390.png" style="width:5.75903in;height:2.21597in" />

### \#2.3 从后台获取文章分类数据：

<img src="./bili-bigevent-3vue3-action--imgs/image391.png" style="width:3.74444in;height:2.26181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image392.png" style="width:5.75903in;height:3.05833in" />

# P89实战篇-77_大事件_文章列表查询_接口调用

12:59

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=89>

## \#1《大事件接口文档-V1.0》3.5 文章列表(条件分页)

<img src="./bili-bigevent-3vue3-action--imgs/image393.png" style="width:3.54861in;height:1.8125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image394.png" style="width:1.97917in;height:0.96528in" />

<img src="./bili-bigevent-3vue3-action--imgs/image395.png" style="width:5.76042in;height:1.49028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image396.png" style="width:4.1875in;height:0.85417in" />

<img src="./bili-bigevent-3vue3-action--imgs/image397.png" style="width:2.25in;height:1.02083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image398.png" style="width:5.76042in;height:2.32292in" />

<img src="./bili-bigevent-3vue3-action--imgs/image399.png" style="width:5.76597in;height:1.75764in" />

<img src="./bili-bigevent-3vue3-action--imgs/image400.png" style="width:2.59028in;height:1.40972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image401.png" style="width:5.7625in;height:3.30069in" />

## \#2**接口函数articleListService**

参考“#1《大事件接口文档-V1.0》3.5 文章列表(条件分页)”，写 “文章列表”接口函数**articleListService**

<img src="./bili-bigevent-3vue3-action--imgs/image402.png" style="width:5.76736in;height:1.60625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image403.png" style="width:4.89583in;height:0.77083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image404.png" style="width:5.13889in;height:0.76389in" />

<img src="./bili-bigevent-3vue3-action--imgs/image405.png" style="width:4.36806in;height:0.79167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image406.png" style="width:4.29167in;height:0.84028in" />

## \#3调用articleListService

在src \>views \>article\>ArticleManage.vue中

<img src="./bili-bigevent-3vue3-action--imgs/image407.png" style="width:5.7625in;height:1.23472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image408.png" style="width:5.76667in;height:2.40903in" />

<img src="./bili-bigevent-3vue3-action--imgs/image409.png" style="width:5.76667in;height:1.10278in" />

## \#4测试1

<img src="./bili-bigevent-3vue3-action--imgs/image410.png" style="width:5.7625in;height:3.07083in" />

## \#5.显示分类名称而非其id

<img src="./bili-bigevent-3vue3-action--imgs/image411.png" style="width:5.76389in;height:1.125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image412.png" style="width:5.76389in;height:4.34583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image413.png" style="width:2.19444in;height:0.74306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image414.png" style="width:5.55556in;height:1.90972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image415.png" style="width:5.76319in;height:1.03125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image416.png" style="width:5.76597in;height:1.10208in" />

<img src="./bili-bigevent-3vue3-action--imgs/image417.png" style="width:5.03472in;height:0.78472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image418.png" style="width:5.76389in;height:1.77292in" />

<img src="./bili-bigevent-3vue3-action--imgs/image419.png" style="width:5.75486in;height:2.82014in" />

# P90实战篇-78_大事件_文章列表查询_事件处理

03:20

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=90>

## \#1需求：文章管理页面的事件处理

<img src="./bili-bigevent-3vue3-action--imgs/image420.png" style="width:5.76042in;height:2.79167in" />

## \#2搜索按钮的点击事件处理

<img src="./bili-bigevent-3vue3-action--imgs/image421.png" style="width:5.39861in;height:3.21806in" />

测试结果：

<img src="./bili-bigevent-3vue3-action--imgs/image422.png" style="width:5.76667in;height:3.03958in" />

## \#3重置按钮的点击事件处理

<img src="./bili-bigevent-3vue3-action--imgs/image423.png" style="width:5.76181in;height:2.83472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image424.png" style="width:5.75694in;height:1.49722in" />

## \#4分页条事件处理

<img src="./bili-bigevent-3vue3-action--imgs/image425.png" style="width:4.35417in;height:2.13889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image426.png" style="width:5.76458in;height:0.77014in" />

测试结果：

<img src="./bili-bigevent-3vue3-action--imgs/image427.png" style="width:5.75764in;height:3.04444in" />

# P91实战篇-79_大事件_添加文章_页面搭建

06:32

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=91>

## \#1需求：添加文章的页面搭建

点击“添加文章”按钮后，右侧会出现一个抽屉组件：

<img src="./bili-bigevent-3vue3-action--imgs/image428.png" style="width:5.76181in;height:2.77917in" />

## \#2.ArticleManage.vue中添加抽屉组件

<img src="./bili-bigevent-3vue3-action--imgs/image429.png" style="width:4.27083in;height:2.54167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image430.png" style="width:5.76597in;height:1.40625in" />

。。。。。。。。

<img src="./bili-bigevent-3vue3-action--imgs/image431.png" style="width:5.76111in;height:0.54236in" />

<img src="./bili-bigevent-3vue3-action--imgs/image432.png" style="width:5.75972in;height:1.72153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image433.png" style="width:5.7625in;height:2.12083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image434.png" style="width:1.65972in;height:0.35417in" />

<img src="./bili-bigevent-3vue3-action--imgs/image435.png" style="width:3.54167in;height:2.38194in" />

<img src="./bili-bigevent-3vue3-action--imgs/image436.png" style="width:2.54653in;height:1.55833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image437.png" style="width:5.76528in;height:1.90903in" />

<img src="./bili-bigevent-3vue3-action--imgs/image438.png" style="width:5.10833in;height:0.85139in" />

<img src="./bili-bigevent-3vue3-action--imgs/image439.png" style="width:4.20139in;height:2.04722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image440.png" style="width:2.21597in;height:1.48056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image441.png" style="width:5.75833in;height:1.82708in" />

## \#3.添加富文本编辑器

文章内容需要使用到富文本编辑器，这里咱们使用一个开源的富文本编辑器 Quill

官网地址 <https://vueup.github.io/vue-quill/>

### \#3.1安装vue-qui11 

npm insta1l @vueup/vue-qui11@latest --save

<img src="./bili-bigevent-3vue3-action--imgs/image442.png" style="width:5.76736in;height:1.07569in" />

### \#3.2导入组件和样式:

<img src="./bili-bigevent-3vue3-action--imgs/image443.png" style="width:4.29167in;height:2.90972in" />

### \#3.3页面上使用quill组件

<img src="./bili-bigevent-3vue3-action--imgs/image444.png" style="width:5.76111in;height:4.30764in" />

### \#3.4测试验证

<img src="./bili-bigevent-3vue3-action--imgs/image445.png" style="width:5.75903in;height:3.08958in" />

# P92实战篇-80_大事件_添加文章_文章封面图片上传

06:47

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=92>

## \#1需求：图片上传

点击打开窗口的打开按钮时，要调用图片上传接口把图片上传到服务器：

<img src="./bili-bigevent-3vue3-action--imgs/image446.png" style="width:5.75625in;height:3.10556in" />

## \#2.实战代码

### \#2.1《大事件接口文档-V1.0》4.1 文件上传

<img src="./bili-bigevent-3vue3-action--imgs/image447.png" style="width:2.08403in;height:1.27431in" />

<img src="./bili-bigevent-3vue3-action--imgs/image448.png" style="width:2.05139in;height:0.77639in" />

<img src="./bili-bigevent-3vue3-action--imgs/image449.png" style="width:5.76597in;height:0.63542in" />

<img src="./bili-bigevent-3vue3-action--imgs/image450.png" style="width:1.04167in;height:0.63194in" />

<img src="./bili-bigevent-3vue3-action--imgs/image451.png" style="width:1.75in;height:0.78542in" />

<img src="./bili-bigevent-3vue3-action--imgs/image452.png" style="width:5.76806in;height:1.20278in" />

<img src="./bili-bigevent-3vue3-action--imgs/image453.png" style="width:5.76319in;height:1.30417in" />

### \#2.2完善el-upload代码

<img src="./bili-bigevent-3vue3-action--imgs/image454.png" style="width:4.22222in;height:2.24931in" />

<img src="./bili-bigevent-3vue3-action--imgs/image455.png" style="width:5.76458in;height:1.85556in" />

<img src="./bili-bigevent-3vue3-action--imgs/image456.png" style="width:5.76042in;height:2.54722in" />

<img src="./bili-bigevent-3vue3-action--imgs/image457.png" style="width:5.7625in;height:3.09167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image458.png" style="width:5.75764in;height:3.07569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image459.png" style="width:5.76042in;height:1.10694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image460.png" style="width:5.75972in;height:1.94792in" />

# P93实战篇-81_大事件_添加文章_接口调用

07:39

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.videopod.episodes&p=92>

## \#1《大事件接口文档-V1.0》3.1 发布文章

<img src="./bili-bigevent-3vue3-action--imgs/image461.png" style="width:3.11111in;height:1.77778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image462.png" style="width:2.25in;height:0.99306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image463.png" style="width:5.76319in;height:1.76042in" />

<img src="./bili-bigevent-3vue3-action--imgs/image464.png" style="width:5.76597in;height:1.67153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image465.png" style="width:2.25694in;height:0.98611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image466.png" style="width:5.76597in;height:1.19236in" />

<img src="./bili-bigevent-3vue3-action--imgs/image467.png" style="width:2.47222in;height:1.5in" />

## \#2**接口函数articleAddService**

参考“#1《大事件接口文档-V1.0》3.1 发布文章”，写 “文章添加”接口函数**articleAddService**

<img src="./bili-bigevent-3vue3-action--imgs/image468.png" style="width:5.25694in;height:1.89583in" />

<img src="./bili-bigevent-3vue3-action--imgs/image469.png" style="width:4.40278in;height:0.79861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image470.png" style="width:4.31944in;height:0.79861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image471.png" style="width:4.22917in;height:0.96528in" />

## \#3调用articleAddService

<img src="./bili-bigevent-3vue3-action--imgs/image472.png" style="width:5.76736in;height:3.10903in" />

views/article/ArticleManage.vue:

<img src="./bili-bigevent-3vue3-action--imgs/image473.png" style="width:5.76667in;height:1.04375in" />

<img src="./bili-bigevent-3vue3-action--imgs/image474.png" style="width:3.55972in;height:2.73403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image475.png" style="width:2.28472in;height:0.45833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image476.png" style="width:4.35417in;height:0.58333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image477.png" style="width:2.99306in;height:1.97222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image478.png" style="width:4.32639in;height:1.75in" />

<img src="./bili-bigevent-3vue3-action--imgs/image479.png" style="width:5.23611in;height:3.45833in" />

<img src="./bili-bigevent-3vue3-action--imgs/image480.png" style="width:5.76458in;height:1.72917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image481.png" style="width:5.75694in;height:3.06319in" />

<img src="./bili-bigevent-3vue3-action--imgs/image482.png" style="width:4.37639in;height:1.53264in" />

<img src="./bili-bigevent-3vue3-action--imgs/image483.png" style="width:5.76736in;height:3.1in" />

# P94实战篇-82_大事件_顶部导航栏信息显示

12:12；注：文章的修改和删除功能交给学员练习。

## \#1需求：顶部导航栏信息显示

<img src="./bili-bigevent-3vue3-action--imgs/image484.png" style="width:5.75833in;height:2.79514in" />

## \#2.创建src/stores/userinfo.js

<img src="./bili-bigevent-3vue3-action--imgs/image485.png" style="width:3.86042in;height:3.4625in" />

## \#3.《大事件接口文档-V1.0》1.3 获取用户详细信息

<img src="./bili-bigevent-3vue3-action--imgs/image486.png" style="width:2.55417in;height:1.15in" />

<img src="./bili-bigevent-3vue3-action--imgs/image487.png" style="width:1.7in;height:0.53056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image488.png" style="width:1.57222in;height:0.72986in" />

<img src="./bili-bigevent-3vue3-action--imgs/image489.png" style="width:3.66597in;height:1.27569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image490.png" style="width:3.64653in;height:0.92222in" />

<img src="./bili-bigevent-3vue3-action--imgs/image491.png" style="width:5.22917in;height:3.43056in" />

## \#4**接口函数**userInfo**Service**

参考“#3《大事件接口文档-V1.0》1.3 获取用户详细信息”，写 接口函数userInfoService

<img src="./bili-bigevent-3vue3-action--imgs/image492.png" style="width:4.54167in;height:2.46528in" />

<img src="./bili-bigevent-3vue3-action--imgs/image493.png" style="width:3.96528in;height:1.53472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image494.png" style="width:3.54167in;height:0.79861in" />

## \#5调用userInfo**Service**

\$ src/views/Layout.vue

<img src="./bili-bigevent-3vue3-action--imgs/image495.png" style="width:3.55139in;height:2.33611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image496.png" style="width:4.40278in;height:0.5625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image497.png" style="width:3.625in;height:1.86806in" />

<img src="./bili-bigevent-3vue3-action--imgs/image498.png" style="width:3.77083in;height:1.125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image499.png" style="width:5.76319in;height:0.78681in" />

<img src="./bili-bigevent-3vue3-action--imgs/image500.png" style="width:5.7625in;height:1in" />

<img src="./bili-bigevent-3vue3-action--imgs/image501.png" style="width:5.76458in;height:1.34375in" />

<img src="./bili-bigevent-3vue3-action--imgs/image502.png" style="width:5.75694in;height:3.08403in" />

# P95实战篇-83_大事件_顶部导航栏_下拉菜单功能实现

10:27

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=95>

## \#1需求：下拉菜单功能实现

<img src="./bili-bigevent-3vue3-action--imgs/image503.png" style="width:5.75903in;height:2.51944in" />

## \#2修改views/Layout.vue中的下拉菜单代码

<img src="./bili-bigevent-3vue3-action--imgs/image504.png" style="width:5.75903in;height:2.8625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image505.png" style="width:3.32153in;height:0.98819in" />

<img src="./bili-bigevent-3vue3-action--imgs/image506.png" style="width:5.76806in;height:1.93611in" />

测试结果ok：

<img src="./bili-bigevent-3vue3-action--imgs/image507.png" style="width:5.7625in;height:3.07917in" />

## \#3.实现退出登录功能

之前已经在ArticleCategory.vue中使用了确认框代码：

<img src="./bili-bigevent-3vue3-action--imgs/image508.png" style="width:3.53681in;height:3.89931in" />

使用和ArticleCategory.vue中一样的确认框代码

<img src="./bili-bigevent-3vue3-action--imgs/image509.png" style="width:4.47917in;height:2.28472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image510.png" style="width:3.61111in;height:1.33333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image511.png" style="width:4.36806in;height:1in" />

<img src="./bili-bigevent-3vue3-action--imgs/image512.png" style="width:3.39583in;height:2.43056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image513.png" style="width:4.125in;height:2.67361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image514.png" style="width:3.96528in;height:2.30556in" />

<img src="./bili-bigevent-3vue3-action--imgs/image515.png" style="width:5.76389in;height:1.37361in" />

<img src="./bili-bigevent-3vue3-action--imgs/image516.png" style="width:5.75694in;height:2.02153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image517.png" style="width:5.76736in;height:1.34861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image518.png" style="width:5.76736in;height:1.32569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image519.png" style="width:5.76458in;height:1.97639in" />

<img src="./bili-bigevent-3vue3-action--imgs/image520.png" style="width:3.60764in;height:1.95972in" />

# P96实战篇-84_大事件_基本资料修改

09:42

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=96>

## \#1需求：基本资料修改

<img src="./bili-bigevent-3vue3-action--imgs/image521.png" style="width:5.75972in;height:2.55694in" />

## \#2.基本资料页面搭建views/user/Userlnfo.vue

<img src="./bili-bigevent-3vue3-action--imgs/image522.png" style="width:2.32153in;height:1.24861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image523.png" style="width:5.33819in;height:2.53403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image524.png" style="width:2.32778in;height:0.91458in" />

<img src="./bili-bigevent-3vue3-action--imgs/image525.png" style="width:5.42153in;height:2.45625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image526.png" style="width:1.5625in;height:0.38194in" />

### \#2.1测试验证1

<img src="./bili-bigevent-3vue3-action--imgs/image527.png" style="width:5.76528in;height:3.08125in" />

## \#3.数据回显

<img src="./bili-bigevent-3vue3-action--imgs/image528.png" style="width:5.76528in;height:4.05208in" />

<img src="./bili-bigevent-3vue3-action--imgs/image529.png" style="width:5.7625in;height:3.91736in" />

### \#3.1测试结果ok

<img src="./bili-bigevent-3vue3-action--imgs/image530.png" style="width:5.76736in;height:1.92917in" />

## \#4“提交修改”按钮功能的实现

### \#4.1《大事件接口文档-V1.0》1.4 更新用户基本信息

<img src="./bili-bigevent-3vue3-action--imgs/image531.png" style="width:4.63889in;height:1.78472in" />

<img src="./bili-bigevent-3vue3-action--imgs/image532.png" style="width:2.29861in;height:0.86111in" />

<img src="./bili-bigevent-3vue3-action--imgs/image533.png" style="width:5.76597in;height:1.48889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image534.png" style="width:2.64583in;height:1.83333in" />

<img src="./bili-bigevent-3vue3-action--imgs/image535.png" style="width:2.25in;height:0.98611in" />

<img src="./bili-bigevent-3vue3-action--imgs/image536.png" style="width:5.76597in;height:1.18542in" />

<img src="./bili-bigevent-3vue3-action--imgs/image537.png" style="width:2.52778in;height:1.54167in" />

### \#4.2接口函数userInfoUpdateService

参考“#4.1《大事件接口文档-V1.0》1.4 更新用户基本信息”，写 接口函数userInfoUpdate**Service**

<img src="./bili-bigevent-3vue3-action--imgs/image538.png" style="width:3.92431in;height:2.12153in" />

<img src="./bili-bigevent-3vue3-action--imgs/image539.png" style="width:3.23056in;height:1.23403in" />

<img src="./bili-bigevent-3vue3-action--imgs/image540.png" style="width:3.52778in;height:0.8125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image541.png" style="width:4.63194in;height:0.8125in" />

### \#4.3调用userInfoUpdateService

<img src="./bili-bigevent-3vue3-action--imgs/image542.png" style="width:5.76389in;height:3.8625in" />

<img src="./bili-bigevent-3vue3-action--imgs/image543.png" style="width:5.25in;height:2.27083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image544.png" style="width:5.76736in;height:3.79097in" />

<img src="./bili-bigevent-3vue3-action--imgs/image545.png" style="width:3.89167in;height:2.10764in" />

<img src="./bili-bigevent-3vue3-action--imgs/image546.png" style="width:4.71319in;height:2.53542in" />

# P97实战篇-85_大事件_用户头像修改

14:30

<https://www.bilibili.com/video/BV14z4y1N7pg?vd_source=4212b105520112daf65694a1e5944e23&spm_id_from=333.788.player.switch&p=97>

## \#1需求：用户头像修改

<img src="./bili-bigevent-3vue3-action--imgs/image547.png" style="width:5.75764in;height:2.54444in" />

## \#2.页面搭建views/user/UserAvatar.vue

<img src="./bili-bigevent-3vue3-action--imgs/image548.png" style="width:4.73611in;height:1.18056in" />

<img src="./bili-bigevent-3vue3-action--imgs/image549.png" style="width:1.98611in;height:0.77083in" />

<img src="./bili-bigevent-3vue3-action--imgs/image550.png" style="width:3.27083in;height:1.29861in" />

<img src="./bili-bigevent-3vue3-action--imgs/image551.png" style="width:5.76319in;height:1.83889in" />

<img src="./bili-bigevent-3vue3-action--imgs/image552.png" style="width:5.75972in;height:1.21667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image553.png" style="width:4.59722in;height:2.45556in" />

## \#3.用户头像回显

<img src="./bili-bigevent-3vue3-action--imgs/image554.png" style="width:3.95347in;height:2.21042in" />

<img src="./bili-bigevent-3vue3-action--imgs/image555.png" style="width:5.7625in;height:3.17778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image556.png" style="width:5.75417in;height:2.25417in" />

## \#4图片上传

<img src="./bili-bigevent-3vue3-action--imgs/image557.png" style="width:4.70139in;height:1.52778in" />

<img src="./bili-bigevent-3vue3-action--imgs/image558.png" style="width:4.34028in;height:0.94444in" />

<img src="./bili-bigevent-3vue3-action--imgs/image559.png" style="width:3.04861in;height:0.91667in" />

<img src="./bili-bigevent-3vue3-action--imgs/image560.png" style="width:5.76528in;height:3.65208in" />

<img src="./bili-bigevent-3vue3-action--imgs/image561.png" style="width:5.75903in;height:3.85in" />

<img src="./bili-bigevent-3vue3-action--imgs/image562.png" style="width:5.76042in;height:3.67153in" />

## \#5更新图像

### \#5.1《大事件接口文档-V1.0》1.5 更新用户头像

<img src="./bili-bigevent-3vue3-action--imgs/image563.png" style="width:3.38889in;height:1.50694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image564.png" style="width:2.00694in;height:0.99306in" />

<img src="./bili-bigevent-3vue3-action--imgs/image565.png" style="width:5.76319in;height:0.66181in" />

<img src="./bili-bigevent-3vue3-action--imgs/image566.png" style="width:5.76806in;height:0.95694in" />

<img src="./bili-bigevent-3vue3-action--imgs/image567.png" style="width:2.25in;height:0.97917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image568.png" style="width:5.7625in;height:1.18958in" />

<img src="./bili-bigevent-3vue3-action--imgs/image569.png" style="width:2.52778in;height:1.50694in" />

### \#5.2接口函数userAvatarUpdateService

根据“#5.1《大事件接口文档-V1.0》1.5 更新用户头像”，写 接口函数userAvatarUpdateService

<img src="./bili-bigevent-3vue3-action--imgs/image570.png" style="width:4.61111in;height:2.5in" />

<img src="./bili-bigevent-3vue3-action--imgs/image571.png" style="width:4.02083in;height:1.51389in" />

<img src="./bili-bigevent-3vue3-action--imgs/image572.png" style="width:3.5625in;height:0.75in" />

<img src="./bili-bigevent-3vue3-action--imgs/image573.png" style="width:4.625in;height:0.8125in" />

<img src="./bili-bigevent-3vue3-action--imgs/image574.png" style="width:4.5in;height:1.13889in" />

### \#5.3调用userAvatarUpdateService

<img src="./bili-bigevent-3vue3-action--imgs/image575.png" style="width:4.73611in;height:2.15972in" />

<img src="./bili-bigevent-3vue3-action--imgs/image576.png" style="width:3.92361in;height:1.34028in" />

<img src="./bili-bigevent-3vue3-action--imgs/image577.png" style="width:5.125in;height:2.47917in" />

<img src="./bili-bigevent-3vue3-action--imgs/image578.png" style="width:5.76181in;height:3.54167in" />

<img src="./bili-bigevent-3vue3-action--imgs/image579.png" style="width:3.69167in;height:2.97569in" />

<img src="./bili-bigevent-3vue3-action--imgs/image580.png" style="width:5.76458in;height:3.85486in" />

<img src="./bili-bigevent-3vue3-action--imgs/image581.png" style="width:5.76736in;height:3.10556in" />

# P98面试篇-01_面试篇导学

06:25

P99面试篇-02_前置知识_ApplicationContextInitializer

12:21

P100面试篇-03_前置知识_ApplicationListener

06:31

P101面试篇-04_前置知识_BeanFactory

13:04

P102面试篇-05_前置知识_BeanDefinition

09:16

P103面试篇-06_前置知识_BeanFactoryPostProcessor

09:28

P104面试篇-07_前置知识_Aware

06:43

P105面试篇-08_前置知识_InitilizingBean-DisposableBean

07:33

P106面试篇-09_前置知识_BeanPostProcessor

05:40

P107面试篇-10_面试题_SpringBoot启动流程

31:34

P108面试篇-11_面试题_IOC容器初始化流程

22:29

P109面试篇-12_面试题_Bean生命周期

39:14

P110面试篇-13_面试题_Bean循环依赖

36:51

P111面试篇-14_面试题_SpringMvc执行流程

42:46

P112课程完结

02:39

# 附1 相关链接

## \#1.黑马大事件前端资料（附源代码）

<https://blog.csdn.net/2201_76122930/article/details/140161280>

## \#2.黑马程序员大事件springboot3+vue3

想进厂的小猫 已于 2024-08-03 15:43:41

原文链接：<https://blog.csdn.net/qq_62892403/article/details/140846703>

## \#3.大事件管理系统 -- 黑马

H_落雨关注IP属地: 山东

2023.11.29 21:11:29字数 103阅读 1,054

<https://www.jianshu.com/p/8229827b6693>

## \#4.黑马 大事件项目 笔记

珊珊而川 已于 2024-03-26 10:37:48 修改

原文链接：https://blog.csdn.net/weixin_63681863/article/details/132523961

1.  1.[后台数据管理系统 - 项目架构设计](https://blog.csdn.net/weixin_63681863/article/details/132523961#t0)

    1.  1.1[项目页面介绍](https://blog.csdn.net/weixin_63681863/article/details/132523961#t1)

    2.  1.2[pnpm 包管理器 - 创建项目](https://blog.csdn.net/weixin_63681863/article/details/132523961#t2)

    3.  1.3[ESLint & prettier 配置代码风格](https://blog.csdn.net/weixin_63681863/article/details/132523961#t3)

    4.  1.4[基于 husky 的代码检查工作流](https://blog.csdn.net/weixin_63681863/article/details/132523961#t4)

    5.  

    6.  1.5[调整项目目录](https://blog.csdn.net/weixin_63681863/article/details/132523961#t5)

    7.  1.6[VueRouter4 路由代码解析](https://blog.csdn.net/weixin_63681863/article/details/132523961#t6)

    8.  1.7[引入 element-ui 组件库](https://blog.csdn.net/weixin_63681863/article/details/132523961#t7)

    9.  1.8[Pinia - 构建用户仓库 和 持久化](https://blog.csdn.net/weixin_63681863/article/details/132523961#t8)

        1.  1.8.1[建仓库](https://blog.csdn.net/weixin_63681863/article/details/132523961#t9)

        2.  1.8.2[持久化](https://blog.csdn.net/weixin_63681863/article/details/132523961#t10)

    10. 1.9[Pinia - 配置仓库统一管理](https://blog.csdn.net/weixin_63681863/article/details/132523961#t11)

    11. 1.10[数据交互 - 请求工具设计](https://blog.csdn.net/weixin_63681863/article/details/132523961#t12)

        1.  [1. 创建 axios 实例](https://blog.csdn.net/weixin_63681863/article/details/132523961#t13)

        2.  [2. 完成 axios 基本配置](https://blog.csdn.net/weixin_63681863/article/details/132523961#t14)

    12. 1.11[首页整体路由设计](https://blog.csdn.net/weixin_63681863/article/details/132523961#t15)

2.  2.[登录注册页面 \[element-plus 表单 & 表单校验\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t16)

    1.  2.1[注册登录 静态结构 & 基本切换](https://blog.csdn.net/weixin_63681863/article/details/132523961#t17)

    2.  <img src="./bili-bigevent-3vue3-action--imgs/image39.png" style="width:5.76736in;height:2.81181in" alt="IMG_256" />

    3.  2.2[注册功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t18)

        1.  2.2.1[实现注册校验](https://blog.csdn.net/weixin_63681863/article/details/132523961#t19)

        2.  2.2.2[注册前的预校验](https://blog.csdn.net/weixin_63681863/article/details/132523961#t20)

        3.  2.2.3[封装 api 实现注册功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t21)

    4.  2.3[登录功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t22)

        1.  2.3.1[实现登录校验](https://blog.csdn.net/weixin_63681863/article/details/132523961#t23)

        2.  2.3.2[登录前的预校验 & 登录成功](https://blog.csdn.net/weixin_63681863/article/details/132523961#t24)

3.  3.[首页 layout 架子 \[element-plus 菜单\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t25)

    1.  3.1[基本架子拆解](https://blog.csdn.net/weixin_63681863/article/details/132523961#t26)

    2.  \<el-menu active-text-color="#ffd04b" background-color="#232323"

        :default-active="\$route.path" text-color="#fff" router \>

        :default-active=“\$route.path” 配置默认高亮的菜单项  
        router router选项开启，el-menu-item 的 index 就是点击跳转的路径

    3.  3.2[登录访问拦截](https://blog.csdn.net/weixin_63681863/article/details/132523961#t27)

        // 需求：只有登录页，可以未授权的时候访问，其他所有页面，都需要先登录再访问

        // router / index.js

        // 登录访问拦截 默认直接放行 根据返回值决定，是放行，还是拦截

        // 登录访问拦截 =\> 默认是直接放行的,不是next了

        // 根据返回值决定，是放行还是拦截

        // 返回值：

        // 1. undefined / true 直接放行

        // 2. false 拦回from的地址页面

        // 3. 具体路径 或 路径对象 拦截到对应的地址

        // '/login' { name: 'login' }

        router.beforeEach((to) =\> {

        // 如果没有token, 且访问的是非登录页，拦截到登录，其他情况正常放行

        const useStore = useUserStore()

        if (!useStore.token && to.path !== '/login') return '/login'

        })

    4.  3.3[用户基本信息获取&渲染](https://blog.csdn.net/weixin_63681863/article/details/132523961#t28)

    5.  3.4[退出功能 \[element-plus 确认框\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t29)

4.  4.[文章分类页面 - \[element-plus 表格\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t30)

5.  4.1[基本架子 - PageContainer](https://blog.csdn.net/weixin_63681863/article/details/132523961#t31)

6.  4.2[文章分类渲染](https://blog.csdn.net/weixin_63681863/article/details/132523961#t32)

    1.  4.2.1[封装API - 请求获取表格数据](https://blog.csdn.net/weixin_63681863/article/details/132523961#t33)

    2.  4.2.2[el-table 表格动态渲染](https://blog.csdn.net/weixin_63681863/article/details/132523961#t34)

    3.  4.2.3[el-table 表格 loading 效果](https://blog.csdn.net/weixin_63681863/article/details/132523961#t35)

    4.  4.2.4[el-empty 空状态](https://blog.csdn.net/weixin_63681863/article/details/132523961#t36)

7.  4.3[文章分类添加编辑 \[element-plus 弹层\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t37)

    1.  4.3.1[点击显示弹层](https://blog.csdn.net/weixin_63681863/article/details/132523961#t38)

    2.  4.3.2[封装弹层组件 ChannelEdit](https://blog.csdn.net/weixin_63681863/article/details/132523961#t39)

    3.  4.3.3[准备弹层表单](https://blog.csdn.net/weixin_63681863/article/details/132523961#t40)

    4.  4.3.4[确认提交](https://blog.csdn.net/weixin_63681863/article/details/132523961#t41)

8.  4.4[文章分类删除](https://blog.csdn.net/weixin_63681863/article/details/132523961#t42)

9.  5.[文章管理页面 - \[element-plus 强化\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t43)

10. 5.1[文章列表渲染](https://blog.csdn.net/weixin_63681863/article/details/132523961#t44)

    1.  5.1.1[基本架子搭建](https://blog.csdn.net/weixin_63681863/article/details/132523961#t45)

    2.  5.1.2[中英国际化处理](https://blog.csdn.net/weixin_63681863/article/details/132523961#t46)

    3.  5.1.3[文章分类选择](https://blog.csdn.net/weixin_63681863/article/details/132523961#t47)

    4.  5.1.4[封装 API 接口，请求渲染](https://blog.csdn.net/weixin_63681863/article/details/132523961#t48)

    5.  5.1.5[分页渲染 \[element-plus 分页\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t49)

    6.  5.1.6[添加 loading 处理](https://blog.csdn.net/weixin_63681863/article/details/132523961#t50)

    7.  5.1.7[搜索 和 重置功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t51)

11. 5.2[文章发布&修改 \[element-plus - 抽屉\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t52)

    1.  5.2.1[点击显示抽屉](https://blog.csdn.net/weixin_63681863/article/details/132523961#t53)

    2.  5.2.2[封装抽屉组件 ArticleEdit](https://blog.csdn.net/weixin_63681863/article/details/132523961#t54)

    3.  5.2.3[完善抽屉表单结构](https://blog.csdn.net/weixin_63681863/article/details/132523961#t55)

    4.  5.2.4[上传文件 \[element-plus - 文件预览\]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t56)

    5.  5.2.5[富文本编辑器 \[ vue-quill \]](https://blog.csdn.net/weixin_63681863/article/details/132523961#t57)

    6.  5.2.6[添加文章功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t58)

    7.  5.2.7[添加完成后的内容重置](https://blog.csdn.net/weixin_63681863/article/details/132523961#t59)

    8.  5.2.8[编辑文章回显](https://blog.csdn.net/weixin_63681863/article/details/132523961#t60)

    9.  5.2.9[编辑文章功能](https://blog.csdn.net/weixin_63681863/article/details/132523961#t61)

12. 5.3[文章删除](https://blog.csdn.net/weixin_63681863/article/details/132523961#t62)

13. 6.[ChatGPT & Copilot](https://blog.csdn.net/weixin_63681863/article/details/132523961#t63)

14. 6.1[AI 的认知 & 讲解内容说明](https://blog.csdn.net/weixin_63681863/article/details/132523961#t64)

15. 6.2[ChatGPT 的基本使用 - Prompt 优化](https://blog.csdn.net/weixin_63681863/article/details/132523961#t65)

16. 6.2.1[案例 - 前端简历](https://blog.csdn.net/weixin_63681863/article/details/132523961#t66)

17. 6.3[工具 Github Copilot 智能生成代码的使用](https://blog.csdn.net/weixin_63681863/article/details/132523961#t67)

18. 6.3.1[安装步骤](https://blog.csdn.net/weixin_63681863/article/details/132523961#t68)

19. 6.3.2[使用说明](https://blog.csdn.net/weixin_63681863/article/details/132523961#t69)

7[个人中心项目实战 - 基本资料](https://blog.csdn.net/weixin_63681863/article/details/132523961#t70)

7.1[个人中心项目实战 - 基本资料](https://blog.csdn.net/weixin_63681863/article/details/132523961#t70)

7.1.1[静态结构 + 校验处理](https://blog.csdn.net/weixin_63681863/article/details/132523961#t71)

7.1..2[封装接口，更新个人信息](https://blog.csdn.net/weixin_63681863/article/details/132523961#t72)

7.2[个人中心项目实战 - 更换头像](https://blog.csdn.net/weixin_63681863/article/details/132523961#t73)

7.2.1[静态结构](https://blog.csdn.net/weixin_63681863/article/details/132523961#t74)

7.2.2[选择预览图片](https://blog.csdn.net/weixin_63681863/article/details/132523961#t75)

7.2.3[上传头像](https://blog.csdn.net/weixin_63681863/article/details/132523961#t76)

7.3[个人中心项目实战 - 重置密码](https://blog.csdn.net/weixin_63681863/article/details/132523961#t77)

7.3.1[静态结构 + 校验处理](https://blog.csdn.net/weixin_63681863/article/details/132523961#t78)

7.3.2[封装接口，更新密码信息](https://blog.csdn.net/weixin_63681863/article/details/132523961#t79)

7.4[个人中心项目实战 - 更换头像](https://blog.csdn.net/weixin_63681863/article/details/132523961#t149)

7.4.1[静态结构](https://blog.csdn.net/weixin_63681863/article/details/132523961#t150)
