【log4】c++日志工具之——log4cpp
1、log4cpp概述

      Log4cpp是一个开源的C++类库，它提供了C++程序中使用日志和跟踪调试的功能，它的优点如下：

        提供应用程序运行上下文，方便跟踪调试；
        可扩展的、多种方式记录日志，包括命令行、文件、回卷文件、内存、syslog服务器、Win事件日志等；
        可以动态控制日志记录级别，在效率和功能中进行调整；
        所有配置可以通过配置文件进行动态调整；
        多语言支持，包括Java（log4j），C++（log4cpp、log4cplus），C（log4c），python（log4p）等；

类似日志工具：glog、boost.log、spdlog