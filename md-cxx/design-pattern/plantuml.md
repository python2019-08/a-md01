# ch1.使用vscode+plantuml作UML图

https://blog.csdn.net/zhxx120/article/details/126569269

云端看夕阳  已于 2022-08-28 14:42:06 修改

首先是要把vscode软件安装好，网上有很多教程，里不再赘述，下面是基于vscode软件安装好之后的步骤。

## 1、安装两个插件
要想在vscode上作uml图，则必然是需要安装plantuml语言的插件，在安装插件里搜索栏里搜索plantuml安装如下所示

只安装plantuml还不行，因为想要把uml图显示出来，还必须要有绘图插件才行，这里就需要graphviz插件，安装如下

这两个插件安装好之后，就可以在vscode上通过plantuml语言作uml图，alt+d可把plantuml语言以图形形式更新展现出来


## 2、用plantuml语言作uml图示例


新建一个wsd格式的文档，plantuml语言文档后缀，在该文档里编辑如下

```uml
@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response
Alice -> Bob: Another authentication Request
Alice <-- Bob: Another authentication Response
@enduml
```
写好以上的语言后，按ALT+D键即可生成以下UML图

## 3、UML图的保存及拷贝


目前暂时没有找到直接保存uml图的命令，但在生成的uml预览图上有一个拷贝命令，可通过此方式把图保存到本地；亦或者是直接保存plantuml语言，在可使用该语言的地方能直接使用显示出uml图。如下图红色圈住的图标就是拷贝命令

