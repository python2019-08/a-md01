# 1.SQLite数据库 

SQLite是一个轻量级的嵌入式数据库引擎。它不需要单独的服务器进程，数据存储在一个单一的文件中，非常适合小型项目和原型开发。

## sqlite教程地址
 https://www.runoob.com/sqlite/sqlite-commands.html

## 下载地址：
 https://www.sqlite.org/download.html

## 创建数据库：
sqlite3 mydatabase.db

## 常用命令
.tables:列出所有表。
.schema<table_name>:查看表结构。
.databases:列出所有数据库。
.exit:退出SQLite命令行。

```sh
sqlite3 mydatabase.db
sqlite>.tables
sqlite>.schemausers
sqlite> SELECT * FROM users;
sqlite> .exit
```
==============================================================
# 2.sqlite3 命令执行一个sql文件 

是的，`sqlite3` 命令可以执行一个 SQL 文件。你可以使用以下语法：

```bash
sqlite3 数据库文件 < SQL脚本文件
```

### 示例
假设你有一个名为 `schema.sql` 的 SQL 文件，内容如下：

```sql
-- 创建一个表
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER
);

-- 插入一些数据
INSERT INTO users (name, age) VALUES ('Alice', 30);
INSERT INTO users (name, age) VALUES ('Bob', 25);
```

你可以通过以下命令执行这个 SQL 文件：

```bash
sqlite3 mydatabase.db < schema.sql
```

这会创建一个名为 `mydatabase.db` 的 SQLite 数据库，并执行 `schema.sql` 中的所有 SQL 语句。

### 另一种方式
你也可以在 `sqlite3` 交互式 shell 中使用 `.read` 命令：

```bash
sqlite3 mydatabase.db
sqlite> .read schema.sql
```

这种方式允许你在执行 SQL 文件前后执行其他 SQLite 命令。

====================================================================
