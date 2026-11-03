# 1.Celery 使用完整指南

<!--
https://github.com/celery/celery.git
-->

> **Celery 是 Python 分布式任务队列**，用来做异步任务、定时周期任务。
> ⚠️ Celery **本身不存消息**，必须搭配 Broker（消息中间件）：常用 Redis / RabbitMQ。
> - Broker：接收任务消息，给worker消费；
> - Worker：真正执行任务的进程；
> - Backend：可选，存储任务返回结果（Redis/MongoDB/SQLAlchemy）。

## 1. 安装
```bash
$ conda create -n celery  python=3.11
$ conda activate celery
# $ conda deactivate
$ pip install celery redis
```
Broker 选用 Redis（最简单上手）；也可以用 RabbitMQ。

### 1.1 celery 适合的 python 版本
- **Celery 5.6（当前新版）：Python3.9‑3.13**
- **Celery5.5：Python3.8‑3.13**
- Python3.7最高用5.2；3.6最高5.1；Python2.7用4.x。
> 生产推荐：**3.10 / 3.11**，兼容性最稳。Windows非官方支持。


## 2. 最小项目结构
```
demo/
├── celery_app.py   # celery实例配置
└── tasks.py        # 定义任务
```

### celery_app.py
```python
from celery import Celery

# 创建celery实例
app = Celery(
    "demo",
    broker="redis://127.0.0.1:6379/0",   # broker redis db0
    backend="redis://127.0.0.1:6379/0"   # 保存任务结果，可选
)

# 导入任务模块
app.autodiscover_tasks(["tasks"])
```

### tasks.py 编写任务
```python
from celery_app import app
import time

@app.task
def add(x, y):
    """普通异步任务"""
    time.sleep(2)
    return x + y

@app.task(bind=True)
def long_task(self, n):
    """bind=True：任务对象self，可以获取任务id、更新进度"""
    for i in range(n):
        time.sleep(1)
        self.update_state(state="PROGRESS", meta={"current": i})
    return {"result": n * 100}
```

## 3. 启动 Worker（消费任务）
> 先本地启动 redis-server。

```bash
# 进入demo目录启动worker
celery -A celery_app worker --loglevel=info
```
- `-A celery_app`：指定celery实例模块 `celery_app.py`
- worker：工作进程，监听broker，执行tasks

> Windows注意：celery4.x对windows支持差，建议加参数 `--pool=solo`
```bash
celery -A celery_app worker --pool=solo --loglevel=info
```

## 4. 调用异步任务（提交任务到队列）
新建 `run.py`
```python
from tasks import add, long_task

# 1. 提交异步任务，立刻返回任务id，不阻塞
res = add.delay(3,5)
print(f"task id: {res.id}")

# 获取结果（会阻塞等待完成）
print(res.get(timeout=10))

# 2. 带参数任务
res2 = long_task.delay(5)
print(res2.id)

# 查询任务状态
print(res2.state)
```
运行：`python run.py`

### 两种调用方式
1. `.delay(arg1, arg2)`：最简洁；
2. `.apply_async(args=(3,5), kwargs={}, countdown=5)`：更完整，可以设置延迟执行
```python
# 5秒之后才执行
add.apply_async(args=(10,20), countdown=5)
```

## 5. 获取任务状态、进度
```python
from celery.result import AsyncResult
from celery_app import app

task_id = "xxxx-xxxx"
res = AsyncResult(task_id, app=app)

print(res.state)
# PENDING STARTED PROGRESS SUCCESS FAILURE
if res.state == "PROGRESS":
    print(res.info) # meta进度字典
elif res.state == "SUCCESS":
    print(res.result)
elif res.state == "FAILURE":
    print(res.traceback)
```

## 6. 定时周期任务（Celery Beat）
修改 `celery_app.py`，增加定时配置
```python
from celery import Celery
from celery.schedules import crontab

app = Celery(
    "demo",
    broker="redis://127.0.0.1:6379/0",
    backend="redis://127.0.0.1:6379/0"
)
app.autodiscover_tasks(["tasks"])

# 周期任务配置
app.conf.beat_schedule = {
    "run-every-10-seconds": {
        "task": "tasks.add",
        "args": (1,2),
        "schedule": 10.0,  # 每10秒执行一次
    },
    "run-at-every-morning-8": {
        "task": "tasks.add",
        "args": (100,200),
        "schedule": crontab(hour=8, minute=0), # cron表达式
    }
}
app.conf.timezone = "Asia/Shanghai"
```

> Beat 是独立进程，负责生成定时任务放入broker；**必须同时启动 worker + beat**
```bash
# terminal1：worker
celery -A celery_app worker --loglevel=info

# terminal2：beat调度器
celery -A celery_app beat --loglevel=info
```
⚠️ beat多实例部署会重复跑任务；生产环境要用 `celery‑beat‑scheduler`（redis持久调度）保证单beat实例。

## 7. 任务队列路由（多队列）
业务场景：把重任务、轻任务分到不同队列，不同worker专门消费不同队列。

celery_app.py
```python
app.conf.task_routes = {
    "tasks.add": {"queue": "fast_queue"},
    "tasks.long_task": {"queue": "slow_queue"},
}
```

提交任务自动进对应队列；启动worker指定消费队列：
```bash
# 消费fast_queue
celery -A celery_app worker -Q fast_queue --loglevel=info

# 消费slow_queue
celery -A celery_app worker -Q slow_queue --loglevel=info
```

## 8. 生产常见坑
1. **Broker Redis 不要用内存做持久化，任务丢失风险**；生产优先RabbitMQ。
2. `backend` 只是存返回结果，**不要拿backend做业务数据库**，不要频繁查询大量任务状态。
3. 默认任务如果worker被杀掉，任务会丢失；开启 `task_reject_on_worker_lost` 可以重回队列。
4. **任务函数必须是可导入的模块函数**，不能是脚本内部临时函数，否则分布式worker找不到任务。
5. 任务内部不要依赖本地全局变量，worker进程是独立环境；需要的数据全部作为参数传入。
6. Beat不要启动多个，否则定时任务重复执行。
7. 超时：`soft_time_limit` 软超时抛异常；`time_limit` 硬超时直接kill进程。

```python
@app.task(time_limit=30, soft_time_limit=25)
def mytask():
    pass
```

## 9. 和你前面 Spark/Flink 简单对比
|组件|定位|语言|
|---|---|---|
|Celery|Python异步任务队列，适合业务后台异步、邮件、回调、轻量定时；**不适合大数据处理**|Python|
|Spark/Flink|分布式大数据流批引擎，海量数据计算，内核JVM|PySpark/PyFlink只是API外壳|

> Celery 适合Web后端：上传文件后后台解析、发消息、异步调用接口；**不适合TB级大数据运算**。

如果你需要，我可以给一个搭配FastAPI的最小完整示例：接口提交celery任务，接口查询任务进度。