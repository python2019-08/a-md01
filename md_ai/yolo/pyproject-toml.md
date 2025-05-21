# 1. pyproject.toml

pyproject.toml 是 Python 项目中用于配置项目元数据和构建工具的文件，在 PEP 518 和 PEP 621 等规范的推动下，它逐渐成为 Python 项目配置的标准文件。以下是关于 pyproject.toml 的详细介绍：
## 1.1 用途和背景
在 pyproject.toml 出现之前，Python 项目的配置比较分散，如 setup.py 用于项目的安装和分发配置，requirements.txt 用于列出项目依赖等。pyproject.toml 的引入旨在提供一个统一的配置文件，让开发者可以更方便地管理项目的构建、依赖等信息。
## 1.2文件格式
pyproject.toml 采用 TOML（Tom's Obvious, Minimal Language）格式，这是一种易于阅读和编写的配置文件格式，语法简洁明了。

## 1.3常见配置内容
### 1.3.1. 构建系统配置（[build-system]）
该部分用于指定项目使用的构建后端（build backend）以及构建所需的依赖项。例如，使用 setuptools 作为构建后端的配置如下：
```toml
[
build-system
]
requires = ["setuptools>=42", "wheel"]
build-backend = "setuptools.build_meta"
```
> requires：列出构建项目所需的依赖包及其版本要求。
> build-backend：指定用于构建项目的后端模块和入口点。

### 1.3.2 build-backend = "setuptools.build_meta" 的具体含义

#### (1). setuptools
setuptools 是 Python 中一个非常流行且广泛使用的包管理和分发工具，它扩展了 Python 标准库中的 distutils 模块，提供了更多高级的功能，比如依赖管理、自动发现包、支持插件等。许多 Python 项目都使用 setuptools 来打包和分发代码，使其能够在不同的 Python 环境中方便地安装和使用。
#### (2). build_meta
build_meta 是 setuptools 提供的一个模块，它实现了 Python 构建后端 API（PEP 517 和 PEP 518 所定义）。这个 API 允许项目使用更灵活、更现代的方式进行构建，而不再依赖传统的 setup.py 脚本。build_meta 模块提供了一系列函数，用于处理项目的元数据、生成构建配置、执行实际的构建步骤等。

#### (3). 完整含义
build-backend = "setuptools.build_meta" 表示在构建项目时，使用 setuptools 库中的 build_meta 模块作为构建后端。当你使用支持 PEP 517 和 PEP 518 的构建工具（如 pip、build 等）来构建项目时，这些工具会调用 setuptools.build_meta 模块中的相应函数来完成构建任务，包括收集项目元数据、解析依赖关系、生成分发文件（如 .tar.gz 和 .whl 文件）等。

#### (4).工作流程示例
假设你有一个使用 setuptools 作为构建后端的 Python 项目，并且在 pyproject.toml 中配置了 build-backend = "setuptools.build_meta"，当你执行以下命令来构建项目时：
```bash
python -m build
```

build 工具会按照以下大致流程工作：
> (4.1)**读取 pyproject.toml**：build 工具首先会读取项目根目录下的 pyproject.toml 文件，找到 [build-system] 部分，并获取 build-backend 的值 setuptools.build_meta。
> (4.2)**加载构建后端**：根据 build-backend 的值，build 工具会尝试导入 setuptools.build_meta 模块。
> (4.3)**调用构建函数**：build 工具会调用 setuptools.build_meta 模块中定义的特定函数，例如 build_sdist 用于生成源代码分发文件（.tar.gz），build_wheel 用于生成二进制分发文件（.whl）。
> (4.4)**完成构建**：setuptools.build_meta 模块会根据项目的配置和代码，执行必要的操作，最终生成相应的分发文件，并将其放置在项目的 dist 目录下。

#### (5)总结
build-backend = "setuptools.build_meta" 使得项目能够利用 setuptools 的强大功能，以符合现代 Python 构建标准的方式进行打包和分发，为开发者提供了更简洁、灵活和高效的项目构建体验。


### 1.3.3. 项目元数据配置（[project]）
根据 PEP 621 规范，[project] 部分用于存储项目的基本元数据，如项目名称、版本、作者、描述等。示例如下：
```toml
[
project
]
name = "my_project"
version = "0.1.0"
description = "A simple Python project"
readme = "README.md"
requires-python = ">=3.7"
license = { text = "MIT" }
authors = [
    { name = "John Doe", email = "johndoe@example.com" }
]
dependencies = [
    "requests>=2.25.1",
    "numpy>=1.20.0"
]
```

> name：项目的名称。
> version：项目的版本号。
> description：项目的简短描述。
> readme：指定项目的 README 文件路径。
> requires-python：指定**项目所需的 Python** 版本范围。
> license：指定项目的许可证。
> authors：列出项目的作者信息。
> dependencies：列出项目运行时所需的**依赖包及其版本要求**。

### 1.3.4. 可选依赖配置（[project.optional-dependencies]）
该部分用于定义项目的可选依赖，例如用于测试、开发或特定功能的依赖。示例如下：
```toml
[
project.optional-dependencies
]
test = [
    "pytest>=6.2.5",
    "coverage>=5.5"
]
dev = [
    "black>=22.3.0",
    "flake8>=4.0.1"
]
```
这里定义了两个可选依赖组：test 用于测试，dev 用于开发。用户可以根据需要选择安装这些可选依赖。

### 1.3.5. 脚本配置（[project.scripts]）
用于**定义项目的可执行脚本**，用户可以通过 pip 安装项目后直接调用这些脚本。示例如下：
```toml
[
project.scripts
]
my_script = "my_project.module:main"
```
这表示定义了一个名为 my_script 的脚本，它对应于 my_project 包中 module 模块的 main 函数。

## 1.4与其他配置文件的关系
> * **替代 setup.py 和 setup.cfg**：pyproject.toml 可以替代传统的 setup.py 和 setup.cfg 文件，提供更简洁和统一的项目配置方式。
> * **与 requirements.txt 互补**：requirements.txt 通常用于指定项目在**生产环境**中的精确依赖版本，而 pyproject.toml 更侧重于项目的元数据和构建配置。

## 1.5工具支持
许多 Python 工具都支持 pyproject.toml，例如：
* **pip**：从 Python 3.11 开始，pip 可以直接读取 pyproject.toml 中的依赖信息进行安装。
* **poetry**：一个流行的 Python 项目管理工具，使用 pyproject.toml 作为主要的配置文件。
* **flit**：另一个轻量级的 Python 项目打包工具，也支持 pyproject.toml。

## 1.6 使用 pyproject.toml 进行项目操作

### 1.6.1安装依赖
使用 pip 安装项目依赖，pip 会读取 pyproject.toml 中的 dependencies 部分：
```bash
pip install .
```

如果要安装可选依赖，例如安装 test 组的依赖：
```bash
pip install .[test]
```

### 1.6.2构建项目
使用 setuptools 构建项目，生成源代码分发和二进制分发文件：
```bash
pip install build  # 先安装 build 工具
python -m build
```
这将在项目的 dist 目录下生成 .tar.gz（源代码分发）和 .whl（二进制分发）文件。

### 1.6.3发布项目到 PyPI
可以使用 twine 工具将构建好的项目发布到 PyPI：
```bash
pip install twine  # 先安装 twine 工具
twine upload dist/*
```

## 1.7. 配合其他工具使用
除了 pip、setuptools 等，还有一些工具也支持 pyproject.toml：

### 1.7.1 Poetry
Poetry 是一个功能强大的 Python 项目管理工具，它可以很好地处理 pyproject.toml。

* 初始化项目：
```bash
poetry init  # 按照提示填写项目信息，会自动生成 pyproject.toml
```

* 添加依赖：
```bash
poetry add requests  # 会自动更新 pyproject.toml 中的依赖信息
```

* 安装依赖：
```bash
poetry install
```

### 1.7.2 Flit
Flit 是另一个轻量级的 Python 项目打包工具，也支持 pyproject.toml。
* 安装依赖并打包项目：
```bash
flit install  # 安装依赖并将项目安装到当前 Python 环境
flit build    # 构建项目
```
