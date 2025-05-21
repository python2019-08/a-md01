# 1.[vscode 单步调试 docker中python代码]

**豆包AI** 下面为你详细介绍在 VS Code 里单步调试 Docker 中 Python 代码的步骤：

### 1.1. 准备工作
确保你已经安装了以下工具：
- Docker
- VS Code
- VS Code 中的 Python 扩展和 Docker 扩展

### 1.2. 创建 Dockerfile 和 Python 代码示例
假设你的项目中有一个简单的 Python 脚本 `app.py`，内容如下：
```python
def add_numbers(a, b):
    result = a + b
    return result


if __name__ == "__main__":
    num1 = 5
    num2 = 3
    result = add_numbers(num1, num2)
    print(f"The result of {num1} + {num2} is {result}")

```
同时，创建一个 `Dockerfile` 用于构建 Docker 镜像：
```Dockerfile
# 使用 Python 3.9 基础镜像
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 复制当前目录下的所有文件到工作目录
COPY . /app

# 运行 Python 脚本
CMD ["python", "app.py"]
```

### 1.3. 构建并运行 Docker 容器
在 VS Code 的终端中，执行以下命令来构建 Docker 镜像：
```bash
docker build -t my-python-app .
```
然后运行 Docker 容器，并将项目目录挂载到容器中，方便调试时实时更新代码：
```bash
docker run -it --name my-running-app -v $(pwd):/app my-python-app
```
这里的 `-v $(pwd):/app` 是将当前目录挂载到容器的 `/app` 目录。

### 1.4. 配置 VS Code 调试
在 VS Code 中打开项目文件夹，创建或编辑 `.vscode/launch.json` 文件，添加如下配置：
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Remote Attach",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 5678
            },
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "/app"
                }
            ]
        }
    ]
}
```
这个配置的作用是让 VS Code 连接到 Docker 容器内运行的 Python 调试服务器。

### 1.5. 安装调试依赖并启动调试
在容器内安装 `ptvsd` 调试器：
```bash
docker exec -it my-running-app pip install ptvsd
```
修改 `app.py` 脚本，添加以下代码以启动调试服务器：
```python
import ptvsd

# 允许任何 IP 地址连接调试器
ptvsd.enable_attach(address=('0.0.0.0', 5678))
# 等待调试器连接
ptvsd.wait_for_attach()

def add_numbers(a, b):
    result = a + b
    return result


if __name__ == "__main__":
    num1 = 5
    num2 = 3
    result = add_numbers(num1, num2)
    print(f"The result of {num1} + {num2} is {result}")
```
重新启动 Docker 容器，确保调试服务器已启动。

### 1.6. 启动调试会话
在 VS Code 中，切换到调试面板，选择 `Python: Remote Attach` 配置，点击启动调试按钮。这时，VS Code 会连接到 Docker 容器内的调试服务器，你就可以在代码中设置断点并进行单步调试了。

下面是整合后的代码示例，方便你查看和使用：
```
doubaocanvas identifier="debug-python-in-docker" type="general_code" title="VS Code 调试 Docker 中 Python 代码示例">

import ptvsd

# 允许任何 IP 地址连接调试器
ptvsd.enable_attach(address=('0.0.0.0', 5678))
# 等待调试器连接
ptvsd.wait_for_attach()

def add_numbers(a, b):
    result = a + b
    return result


if __name__ == "__main__":
    num1 = 5
    num2 = 3
    result = add_numbers(num1, num2)
    print(f"The result of {num1} + {num2} is {result}")    
    # 使用 Python 3.9 基础镜像

    
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 复制当前目录下的所有文件到工作目录
COPY . /app

# 运行 Python 脚本
CMD ["python", "app.py"]    
    {
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Remote Attach",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 5678
            },
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "/app"
                }
            ]
        }
    ]
}    
```

按照上述步骤操作，你就能在 VS Code 中对 Docker 里的 Python 代码进行单步调试了。 

<============================================================================>
<============================================================================>
# 2.[vscode 单步调试 docker中python代码]
Baidu-AI答：
在 Docker 容器中单步调试 Python 代码通常需要使用一些特定的工具和设置。这里我将介绍几种常用的方法来帮助你在 Docker 容器中单步调试 Python 代码。

## 2.1 方法一：使用 py-spy 和 pdb

### 安装 py-spy

py-spy 是一个性能分析工具，可以用来帮助你定位代码的运行情况，但它也可以用来辅助调试。首先，你需要安装 py-spy：
```sh
docker exec -it your_container_name bash
pip install py-spy
```

### 使用 pdb 进行调试

在 Python 代码中设置断点，例如：
```python
import pdb; pdb.set_trace()
```
### 运行 py-spy

在 Docker 容器中运行你的 Python 程序，并使用 py-spy 来监控并附加到正在运行的 Python 进程：
```sh
py-spy top --pid $(pgrep -f your_python_script.py)
```
这将显示当前 Python 进程的调用栈。你可以看到断点附近的代码执行情况。

## 2.2方法二：使用 Visual Studio Code (VS Code) 和 Docker 插件

### 安装 VS Code 和 Docker 插件

确保你的机器上安装了 Visual Studio Code，并且安装了 Docker 插件。

### 配置 Docker 容器

在 VS Code 中，你可以配置一个 Docker 容器来运行你的 Python 应用。在 .devcontainer 文件夹中创建或修改 devcontainer.json 文件：

{
    "name": "Python in Docker",
    "dockerFile": "Dockerfile",
    "settings": {},
    "extensions": [
        "ms-python.python"
    ],
    "runArgs": ["--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"],
    "mounts": [ "source=dind-var-lib-docker,target=/var/lib/docker,type=volume" ]
}

### 配置调试

在 VS Code 中，创建一个新的 launch.json 文件（在 .vscode 文件夹中），配置 Python 的调试设置：

{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": false, // 允许调试第三方库代码（例如 pdb）
        }
    ]
}

### 开始调试

在 VS Code 中打开你的 Python 文件，设置断点，然后使用 VS Code 的调试功能开始调试。你可以像在本地环境中一样设置断点、单步执行等。

### 2.3方法三：使用远程调试模式 (Remote Debugging)

### 在 Dockerfile 中设置远程调试

修改你的 Dockerfile，确保安装了 debugpy 并设置了正确的环境变量：
```Dockerfile
FROM python:3.8-slim
WORKDIR /app
COPY . /app
RUN pip install debugpy -t /app/debugpy/lib/python3.8/site-packages && \
    python -m compileall /app/debugpy/lib/python3.8 && \
    python -O -m py_compile /app/debugpy/lib/python3.8/site-packages/debugpy/__main__.py && \
    python -O -m py_compile /app/debugpy/lib/python3.8/site-packages/debugpy/adapter/__main__.py && \ 
    mkdir /app/.vscode && \ 
    echo "{\"version\":\"0.2.0\",\"configurations\":[{\"name\":\"Python: Remote Attach\",\"type\":\"python\",\"request\":\"attach\",\"connect\":{\"host\":\"0.0.0.0\",\"port\":5678}}]}" > /app/.vscode/launch.json && \ 
    echo "export PYTHONPATH=/app/debugpy/lib/python3.8:/app" >> /app/.profile && \ 
    echo "export PYDEVD_USE_CYTHON=NO" >> /app/.profile && \
```    