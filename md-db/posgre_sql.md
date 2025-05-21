# 0.数据库的命令窗口
 
# 0.1使用 \l 用于查看已经存在的数据库：

postgres=# \l
                             List of databases
   Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
-----------+----------+----------+---------+-------+-----------------------
 postgres  | postgres | UTF8     | C       | C     | 
 runoobdb  | postgres | UTF8     | C       | C     | 
 template0 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 template1 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
(4 rows)

# 0.2接下来我们可以使用 \c + 数据库名 来进入数据库：

postgres=# \c runoobdb
You are now connected to database "runoobdb" as user "postgres".
runoobdb=# 
 
# 0.3CREATE DATABASE 创建数据库
CREATE DATABASE 命令需要在 PostgreSQL 命令窗口来执行，语法格式如下：
```sql
CREATE DATABASE dbname;
```

例如，我们创建一个 runoobdb 的数据库：
```sh
postgres=# CREATE DATABASE runoobdb;
```

# 0.4 DROP DATABASE 删除数据库
DROP DATABASE 会删除数据库的系统目录项并且删除包含数据的文件目录。
DROP DATABASE 只能由超级管理员或数据库拥有者执行。
DROP DATABASE 命令需要在 PostgreSQL 命令窗口来执行，语法格式如下：
```sql
DROP DATABASE [ IF EXISTS ] name
```

> 参数说明：
> IF EXISTS：如果数据库不存在则发出提示信息，而不是错误信息。
> name：要删除的数据库的名称。

例如，我们删除一个 runoobdb 的数据库：
```sh
postgres=# DROP DATABASE runoobdb;
```
<----------------------------------------------------------------->
<----------------------------------------------------------------->
-------------------------------------------------------------------

# 1.  postgresql 中，查询某个schema所有的数据库 和table

在 PostgreSQL 里，你可以通过 SQL 查询来获取某个模式（schema）下的所有数据库和表的信息。需要注意的是，模式是数据库内的逻辑结构，它本身并不包含多个数据库，不过可以包含多个表。下面分别介绍获取指定模式下所有表的方法。

## 1.1 方法一：使用系统视图 `pg_tables` 查询指定模式下的所有表
`pg_tables` 是 PostgreSQL 提供的一个系统视图，它包含了数据库中所有表的信息。你可以通过以下 SQL 语句查询指定模式下的所有表：
```sql
SELECT tablename
FROM pg_tables
WHERE schemaname = 'your_schema_name';
```
在上述代码中，将 `your_schema_name` 替换为你要查询的模式名，该查询会返回指定模式下的所有表名。

```sql
SELECT * FROM information_schema.tables;
```


## 1.2 方法二：使用 `psql` 元命令 `\dt` 查询指定模式下的所有表
如果你使用的是 `psql` 客户端，可以使用 `\dt` 元命令结合模式名来查询指定模式下的所有表：
```plaintext
\dt your_schema_name.*
```
这里的 `your_schema_name` 同样需要替换为你实际的模式名，执行该命令后，`psql` 会显示指定模式下的所有表的信息。

## 1.3 示例代码
下面是一个完整的示例，展示如何使用 SQL 查询指定模式（假设模式名为 `public`）下的所有表：

```query_tables.sql
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public';    
```
  
你可以在 `psql` 客户端或者其他 PostgreSQL 管理工具中执行上述 SQL 语句，就能得到 `public` 模式下的所有表名。 

<---------------------------------------------------------->
<---------------------------------------------------------->
------------------------------------------------------------

# 2. postgresql   \d

在 PostgreSQL 的 `psql` 交互式终端里，`\d` 是一个元命令，它的用途是列出数据库中的数据库对象信息。以下是关于它的详细介绍：

## 2.1 基本用法和输出
- **`\d`**：当你单独使用 `\d` 时，它会列出当前数据库里的所有表、视图、序列和外部表等对象。示例如下：

```plaintext
postgres=# \d
             List of relations
 Schema |       Name       |   Type   |  Owner   
--------+------------------+----------+----------
 public | your_table_name1 | table    | postgres
 public | your_table_name2 | table    | postgres
 public | your_view_name   | view     | postgres
 public | your_sequence    | sequence | postgres
(4 rows)
```
这里展示了不同类型的数据库对象及其所属的模式（通常是 `public`）和所有者。


- **`\d <对象名>`**：如果你在 `\d` 后面加上具体的对象名，就能查看该对象的详细定义。例如，若要查看表 `your_table_name1` 的详细信息，可以使用 `\d your_table_name1`：
```plaintext
postgres=# \d your_table_name1
                                   Table "public.your_table_name1"
  Column   |          Type          | Collation | Nullable |              Default              
-----------+------------------------+-----------+----------+-----------------------------------
 id        | integer                |           | not null | nextval('your_table_name1_id_seq'::regclass)
 name      | character varying(50)  |           |          | 
 age       | integer                |           |          | 
Indexes:
    "your_table_name1_pkey" PRIMARY KEY, btree (id)
```
此输出会显示表的列定义、数据类型、是否可为空、默认值以及索引等信息。


## 2.2 其他相关变体
- **`\dt`**：专门用于列出当前数据库中的表。
- **`\dv`**：用于列出当前数据库中的视图。
- **`\ds`**：用于列出当前数据库中的序列。
- **`\df`**：用于列出当前数据库中的函数。

这些变体可以让你更有针对性地查看不同类型的数据库对象信息。 
