# 1.如何写代码在运行状态（非调试状态）下把错误信息输出?qInfo qDebug做不到

在Qt中，`qInfo()` 和 `qDebug()` 主要用于开发和调试阶段的信息输出，这些信息在发布版本中默认会被忽略。如果你需要在运行状态下捕获和记录错误信息，可以使用以下方法：


### **1. 使用 `qCritical()`、`qWarning()` 或 `qFatal()`**
Qt提供了专门用于错误处理的日志级别，这些信息即使在发布版本中也会被输出：

```cpp
#include <QDebug>

// 警告信息（非致命错误）
qWarning() << "This is a warning:" << errorString;

// 严重错误（可能导致程序异常）
qCritical() << "Critical error occurred:" << errorCode;

// 致命错误（程序无法继续运行）
qFatal("Fatal error: application will terminate!"); // 会终止程序
```

**特点**：
- 这些函数在Release版本中仍然有效。
- 输出位置取决于平台（如Windows的调试输出窗口、Linux的标准错误）。


### **2. 自定义消息处理函数**
通过 `qInstallMessageHandler()` 注册自定义日志处理器，将错误信息写入文件或发送到远程服务器：

```cpp
#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QDateTime>

// 自定义消息处理函数
void myMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg) {
    // 输出到标准错误
    QByteArray localMsg = msg.toLocal8Bit();
    switch (type) {
    case QtDebugMsg:
        fprintf(stderr, "Debug: %s (%s:%u, %s)\n", localMsg.constData(), context.file, context.line, context.function);
        break;
    case QtInfoMsg:
        fprintf(stderr, "Info: %s (%s:%u, %s)\n", localMsg.constData(), context.file, context.line, context.function);
        break;
    case QtWarningMsg:
        fprintf(stderr, "Warning: %s (%s:%u, %s)\n", localMsg.constData(), context.file, context.line, context.function);
        break;
    case QtCriticalMsg:
        fprintf(stderr, "Critical: %s (%s:%u, %s)\n", localMsg.constData(), context.file, context.line, context.function);
        break;
    case QtFatalMsg:
        fprintf(stderr, "Fatal: %s (%s:%u, %s)\n", localMsg.constData(), context.file, context.line, context.function);
        abort();
    }

    // 同时写入日志文件
    QFile file("application.log");
    if (file.open(QIODevice::Append | QIODevice::Text)) {
        QTextStream out(&file);
        out << QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss") << " ";
        switch (type) {
        case QtDebugMsg:
            out << "Debug: ";
            break;
        case QtInfoMsg:
            out << "Info: ";
            break;
        case QtWarningMsg:
            out << "Warning: ";
            break;
        case QtCriticalMsg:
            out << "Critical: ";
            break;
        case QtFatalMsg:
            out << "Fatal: ";
            break;
        }
        out << msg << " (" << context.file << ":" << context.line << ", " << context.function << ")" << endl;
        file.close();
    }
}

// 在main函数中注册消息处理函数
int main(int argc, char *argv[]) {
    // 注册自定义消息处理函数
    qInstallMessageHandler(myMessageHandler);

    QApplication a(argc, argv);
    // ... 程序代码
    return a.exec();
}
```

**特点**：
- 可以同时输出到控制台和文件。
- 包含更详细的上下文信息（文件名、行号、函数名）。
- 即使在Release版本中也能捕获所有日志信息。


### **3. 捕获异常和崩溃**
对于未处理的异常和程序崩溃，可以使用平台特定的方法捕获：

```cpp
#include <QCoreApplication>
#include <QDebug>
#include <csignal>
#include <cstdlib>

// Windows平台捕获崩溃
#ifdef Q_OS_WIN
#include <Windows.h>
LONG WINAPI MyUnhandledExceptionFilter(struct _EXCEPTION_POINTERS* ExceptionInfo) {
    qCritical() << "Application crashed!";
    // 可以在这里生成崩溃转储文件
    return EXCEPTION_EXECUTE_HANDLER;
}
#endif

// Linux平台捕获信号
#ifdef Q_OS_LINUX
void signalHandler(int signum) {
    qCritical() << "Caught signal:" << signum;
    // 处理信号（如SIGSEGV、SIGABRT）
    exit(signum);
}
#endif

int main(int argc, char *argv[]) {
    // Windows平台设置异常处理
    #ifdef Q_OS_WIN
    SetUnhandledExceptionFilter(MyUnhandledExceptionFilter);
    #endif

    // Linux平台设置信号处理
    #ifdef Q_OS_LINUX
    signal(SIGSEGV, signalHandler);
    signal(SIGABRT, signalHandler);
    #endif

    QApplication a(argc, argv);
    // ... 程序代码
    return a.exec();
}
```


### **4. 使用Qt的异常机制**
在关键代码段使用 `try-catch` 块捕获异常：

```cpp
try {
    // 可能抛出异常的代码
    QFile file("nonexistent_file.txt");
    if (!file.open(QIODevice::ReadOnly)) {
        throw std::runtime_error("Failed to open file");
    }
} catch (const std::exception &e) {
    qCritical() << "Exception caught:" << e.what();
}
```


### **5. 结合日志库（如spdlog）**
对于更复杂的日志需求，可以集成第三方日志库：

```cpp
#include <spdlog/spdlog.h>
#include <spdlog/sinks/rotating_file_sink.h>

// 初始化日志
void initLogger() {
    auto logger = spdlog::rotating_logger_mt("app_logger", "application.log", 1024*1024*5, 3);
    logger->set_level(spdlog::level::debug);
    spdlog::set_default_logger(logger);
}

// 使用示例
int main(int argc, char *argv[]) {
    initLogger();
    
    try {
        // 业务逻辑
        spdlog::info("Application started");
        
        // 错误处理
        if (errorCondition) {
            spdlog::error("An error occurred: {}", errorMessage);
        }
    } catch (...) {
        spdlog::critical("Uncaught exception");
    }
    
    return 0;
}
```


### **总结**
- **临时调试**：使用 `qDebug()`、`qInfo()`（发布版本中无效）。
- **运行时错误**：使用 `qWarning()`、`qCritical()`、`qFatal()`。
- **自定义日志**：通过 `qInstallMessageHandler()` 记录到文件。
- **崩溃捕获**：结合平台API（如Windows的 `SetUnhandledExceptionFilter`）。

选择适合你需求的方法，确保在发布版本中也能有效捕获和记录错误信息。

===========================================================
# 2.无法打开数据库

```
ubuntu上，
$ ls -l /home/abner/abner2/zdev/qt/qtmis/qtmis.db
-rwxrwxrwx 1 abner abner 40960  5月  1 19:12 home/abner/abner2/zdev/qt/qtmis/qtmis.db

但是qt程序中：
无法打开数据库 "/home/abner/abner2/zdev/qt/qtmis/qtmis.db" ,lastError: ""
```

根据你提供的信息，SQLite数据库文件权限为`-rwxrwxrwx`（所有人可读写执行），但Qt程序仍无法打开数据库且错误信息为空，这可能是由以下原因导致的：


### **可能的原因及解决方案**

#### 1. **SQLite驱动加载失败**
虽然之前检查过驱动存在，但可能未正确初始化。尝试在打开数据库前手动加载驱动：

```cpp
// 检查SQLite驱动是否可用
if (!QSqlDatabase::isDriverAvailable("QSQLITE")) {
    qDebug() << "SQLite驱动不可用！";
    // 尝试手动加载驱动插件
    QPluginLoader loader("sqldrivers/libqsqlite.so"); // Linux路径
    if (!loader.load()) {
        qDebug() << "插件加载失败:" << loader.errorString();
    }
}
```


#### 2. **路径问题**
确保路径在Qt程序中被正确解析。使用绝对路径或相对路径时需注意：

```cpp
// 使用QDir处理路径，避免硬编码
QString dbPath = QDir::homePath() + "/abner2/zdev/qt/qtmis/qtmis.db";
qDebug() << "尝试打开数据库:" << dbPath;

QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
db.setDatabaseName(dbPath);

if (!db.open()) {
    qDebug() << "数据库错误:" << db.lastError().text();
    qDebug() << "数据库错误代码:" << db.lastError().type();
}
```


#### 3. **文件锁定或损坏**
- **检查文件是否被其他程序锁定**：尝试关闭所有可能访问该数据库的程序，然后重启Qt应用。
- **验证文件完整性**：使用SQLite命令行工具尝试打开数据库：
  ```bash
  sqlite3 /home/abner/abner2/zdev/qt/qtmis/qtmis.db
  ```
  如果无法打开，可能是数据库文件已损坏，尝试创建新数据库。


#### 4. **SELinux/AppArmor限制**
Ubuntu默认启用AppArmor，可能会限制Qt程序访问特定目录。临时禁用AppArmor进行测试：
```bash
sudo systemctl stop apparmor
sudo systemctl disable apparmor
```
如果禁用后问题解决，需配置AppArmor允许Qt程序访问数据库路径。


#### 5. **SQLite版本不兼容**
检查系统SQLite库版本是否与Qt编译时使用的版本兼容：
```bash
sqlite3 --version
```
如果版本过低，尝试更新SQLite：
```bash
sudo apt update
sudo apt install libsqlite3-dev
```


#### 6. **动态库加载问题**
确保SQLite动态库（`libsqlite3.so`）可被Qt程序找到。可通过以下命令检查：
```bash
ldd /path/to/your/qt/application | grep sqlite3
```
如果未找到，可创建软链接或设置`LD_LIBRARY_PATH`环境变量。


### **完整示例代码**
以下是一个包含详细错误处理的示例：

```cpp
#include <QCoreApplication>
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QDir>
#include <QFile>

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

    // 检查数据库文件是否存在且可访问
    QString dbPath = QDir::homePath() + "/abner2/zdev/qt/qtmis/qtmis.db";
    qDebug() << "数据库路径:" << dbPath;

    if (!QFile::exists(dbPath)) {
        qDebug() << "错误：数据库文件不存在！";
        return 1;
    }

    if (!QFile::permissions(dbPath).testFlag(QFile::ReadUser)) {
        qDebug() << "错误：无读取权限！";
        return 1;
    }

    if (!QFile::permissions(dbPath).testFlag(QFile::WriteUser)) {
        qDebug() << "错误：无写入权限！";
        return 1;
    }

    // 检查SQLite驱动
    qDebug() << "可用驱动:" << QSqlDatabase::drivers();
    if (!QSqlDatabase::isDriverAvailable("QSQLITE")) {
        qDebug() << "错误：SQLite驱动不可用！";
        return 1;
    }

    // 尝试打开数据库
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath);

    if (!db.open()) {
        qDebug() << "无法打开数据库:";
        qDebug() << "驱动错误:" << db.lastError().driverText();
        qDebug() << "数据库错误:" << db.lastError().databaseText();
        qDebug() << "错误代码:" << db.lastError().nativeErrorCode();
        qDebug() << "错误类型:" << db.lastError().type();
        return 1;
    }

    qDebug() << "数据库连接成功！";
    return a.exec();
}
```


### **调试建议**
1. 在Qt Creator中运行程序，查看完整的调试输出。
2. 使用`strace`跟踪系统调用，查看文件打开失败的具体原因：
   ```bash
   strace -f -e open,stat /path/to/your/qt/application
   ```
3. 尝试在临时目录创建新数据库文件，确认问题是否与特定路径有关。

通过以上步骤，应该能定位到无法打开数据库的具体原因。