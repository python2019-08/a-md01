# 1.urls

(1) Download OpenStreetMap data for China:
    https://download.geofabrik.de/asia/china.html

(2)行政区边界：  
    https://geojson.hxkj.vip/

(3)GIS数据下载的官方渠道合集： 
    https://www.bilibili.com/opus/757641392410329106

(4) 地理空间数据云
    https://www.gscloud.cn/sources/index?pid=eafee2c80c844412b9d5bee58a3fc9ab&type=3
(5) 四十多个市级地铁的 SHP 数据文件
本仓库提供了一份包含四十多个市级地铁的 SHP 数据文件，这些数据不仅包含了地铁线路的详细信息，还特别标注了地铁线路的有色值。这些数据对于城市规划、交通分析、地理信息系统（GIS）应用等领域具有重要的参考价值
 项目地址:   https://gitcode.com/open-source-toolkit/f12f5 

原文链接：https://blog.csdn.net/gitblog_09701/article/details/142951618

(6) 建筑数据

【[数据分享】全球含建筑高度的建筑物数据（shp格式\约15亿栋建筑物）](https://www.bilibili.com/opus/969420323971661829)
  2024年08月25日 09:54

另外，作为训练数据集的全球已知建筑高度数据来自于ONEGEO Map (https://onegeo.co/data/)、微软建筑物足迹 (Microsoft，2018)、百度地图(https://map.baidu.com/)和 EMU Analytics (https://www.emu-analytics.com/)。



数据来源：Zenodo数据库
https://zenodo.org/records/11397015（亚洲）
https://zenodo.org/records/11391077（欧洲）
https://zenodo.org/records/11319913（美洲、非洲和大洋洲）

=====================================================

# 2.Ubuntu 下载大文件“快 + 断点续传”的做法。
<!-- tx-yuanbao-AI -->
Geofabrik 的 `china-latest.osm.pbf` 现在约 **3.6 GB**（PBF 二进制压缩格式），单线程 wget 在跨境链路上经常跑不满带宽，而且 Geofabrik 近期对 `latest` 文件改成了 **302 重定向到带日期的具体文件**，直接用 `wget` 不加参数容易中断后从头再来。下面给你一套 Ubuntu 下“快 + 能断点 + 不踩坑”的做法。

## 一、先选工具：单线程稳 vs 多线程快

### 方案 A：wget（零安装，最稳，支持断点）
```bash
cd ~/a2/zdev/nv/map_data
wget -c --tries=0 --timeout=60 \
  https://download.geofabrik.de/asia/china-latest.osm.pbf
```
- `-c` 断点续传（中断后重跑同一条命令接着下）
- Geofabrik 的 302 重定向 wget 默认会跟随，没问题
- 缺点：单连接，跨境时速度可能只有几 MB/s

### 方案 B：aria2c（推荐，多线程 + 自动续传）
```bash
sudo apt update && sudo apt install -y aria2

cd ~/a2/zdev/nv/map_data
aria2c -c -x 10 -s 10 -k 10M  https://download.geofabrik.de/asia/china-latest.osm.pbf

aria2c -c -x 10 -s 10 -k 10M  https://download.geofabrik.de/asia/china-shortbread-1.0.mbtiles
```
- `-c` 断点续传
- `-x 10` 每服务器 10 连接，`-s 10` 总分块 10
- `-k 10M` 分块大小，大文件更友好
- 速度通常比 wget 快 3–8 倍，且同样能续

### 方案 C：axel（轻量多线程）
```bash
sudo apt install -y axel
axel -n 10 -a https://download.geofabrik.de/asia/china-latest.osm.pbf
```
- 默认自动续传，中断重跑同命令即可
- 比 aria2 简单，但没有 aria2 的 RPC/金属链接那些高级功能

> 实务建议：**首选 aria2c**，其次 axel，纯不想装东西再用 wget -c。

---

## 二、Geofabrik 的“latest”重定向小坑

Geofabrik 现在请求 `china-latest.osm.pbf` 会 **302 跳到** `china-260805.osm.pbf` 这种带日期的文件。  
所有上面工具都会自动跟随重定向，没问题；但如果你用 `curl` 忘了 `-L` 就会拿到一个空跳转页：
```bash
curl -L -C - -O https://download.geofabrik.de/asia/china-latest.osm.pbf
```
（`-L` 跟随跳转，`-C -` 断点）

---

## 三、国内/跨境慢：换镜像源（立竿见影）

如果 Geofabrik 主站慢，可以换 **OpenStreetMap.fr 镜像**（内容同源，更新略晚几小时）：
```bash
aria2c -c -x 10 -s 10 \
  https://download.openstreetmap.fr/extracts/asia/china-latest.osm.pbf
```
这个镜像对国内网络通常比 geofabrik.de 友好很多。

> 注意：Geofabrik 页面本身国内可直接开，但大文件跨境带宽不一定给满，镜像经常反而更快。

---

## 四、下载完必做：校验完整性

PBF 下一半坏了，osmium 后面会报“invalid blob”之类错。Geofabrik 同目录会提供 `china-latest.osm.pbf.md5`：
```bash
# 下 md5 校验文件
wget -c https://download.geofabrik.de/asia/china-latest.osm.pbf.md5
md5sum -c china-latest.osm.pbf.md5
```
或简单用 osmium 自检：
```bash
osmium fileinfo china-latest.osm.pbf
```
能正常输出版本和对象计数，就说明没坏。

---

## 五、如果你其实“不需要全中国”

`china-latest.osm.pbf` 3.6G，后面 osmium → tilemaker/planetiler 吃内存非常狠（20G+ RAM 才舒服）。  
如果只是做某个省的底图：
- 去 https://download.geofabrik.de/asia/china.html 下 `guangdong-latest.osm.pbf` 这种分省文件，几百 MB 搞定
- 或用 `osmium extract -b minlon,minlat,maxlon,maxlat` 先切bbox再处理

---

## 一句话路线
> 不想装东西 → `wget -c`  
> 要快 → `aria2c -c -x 10 -s 10`  
> 主站慢 → 换 `download.openstreetmap.fr` 镜像  
> 下完 → `md5sum -c` 或 `osmium fileinfo` 验伤

要不要我顺手给你一个 `download-china-pbf.sh`（aria2c + md5 校验 + 失败自动重试），你 `bash` 一下就去睡，醒了就下好？