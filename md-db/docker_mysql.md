# 1.启动MySQL和Redis
参见《bili-bigevent-1springboot3-action.docx》之“P14实战篇-02_开发模式和环境搭建”

About "docker install mysql", please see [docker-install-mysql](https://www.runoob.com/docker/docker-install-mysql.html) .

 
## 1.1 启动MySQL

abel@Ubuntu2204:~$ docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
abel@Ubuntu2204:~$ docker ps
abel@Ubuntu2204:~$ mysql -h 127.0.0.1 -P 3306 -u root -p

## 1.2 启动Redis

E:\programs\Redis-7.4.1-Windows-x64-msys2-with-Service\start.bat

=====================================================================
# 2. mysql tutorial
https://www.runoob.com/mysql/mysql-tutorial.html



