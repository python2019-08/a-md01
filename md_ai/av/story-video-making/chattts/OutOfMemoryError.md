# 1.OutOfMemoryError

## 1.1 question

```
Exception has occurred: OutOfMemoryError
CUDA out of memory. Tried to allocate 20.00 MiB. GPU 0 has a total capacity of 7.64 GiB of which 59.44 MiB is free. Including non-PyTorch memory, this process has 6.41 GiB memory in use. Of the allocated memory 6.12 GiB is allocated by PyTorch, and 120.15 MiB is reserved by PyTorch but unallocated. If reserved but unallocated memory is large try setting PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True to avoid fragmentation.  See documentation for Memory Management  (https://pytorch.org/docs/stable/notes/cuda.html#environment-variables)
  File "/home/abner/abner2/zdev/ai/av/ChatTTS/ChatTTS/model/gpt.py", line 419, in generate
```

这个错误提示表明在使用 PyTorch 进行 CUDA 计算时，GPU 内存不足，无法分配 20.00 MiB 的内存。下面为你分析可能的原因以及对应的解决办法：

## 1.2 可能的原因
1. **模型过大**：你所使用的模型参数量巨大，加载到 GPU 时会占用大量内存。
2. **批量大小过大**：在训练或推理过程中，批量大小设置得过大，使得每次处理的数据量过多，进而占用大量 GPU 内存。
3. **内存碎片化**：频繁地分配和释放内存会导致 GPU 内存碎片化，即使有足够的总内存，也可能无法分配连续的大块内存。
4. **其他程序占用 GPU 内存**：除了你正在运行的程序，可能还有其他程序在使用 GPU 内存，导致可用内存减少。

## 1.3解决办法

#### (1). 减小批量大小
在训练或推理时，适当减小批量大小可以减少每次处理的数据量，从而降低 GPU 内存的使用。例如，在训练代码中修改批量大小参数：
```python
# 原批量大小
batch_size = 32
# 减小批量大小
batch_size = 16
```

#### (2). 释放不必要的变量和缓存
在代码中及时释放不再使用的变量和缓存，避免内存泄漏。可以使用 `del` 关键字删除变量，并调用 `torch.cuda.empty_cache()` 来清空 GPU 缓存：
```python
import torch

# 假设 x 是不再使用的变量
del x
torch.cuda.empty_cache()
```

#### (3). 启用内存碎片化优化
按照错误提示，可以设置 `PYTORCH_CUDA_ALLOC_CONF` 环境变量来避免内存碎片化：
```bash
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
```
或者在 Python 代码中设置：
```python
import os
os.environ["PYTORCH_CUDA_ALLOC_CONF"] = "expandable_segments:True"
```

#### (4). 使用混合精度训练
混合精度训练可以减少模型和数据在 GPU 内存中的占用。在 PyTorch 中，可以使用 `torch.cuda.amp` 模块来实现混合精度训练：
```python
import torch
from torch.cuda.amp import GradScaler, autocast

scaler = GradScaler()

for inputs, labels in dataloader:
    inputs, labels = inputs.cuda(), labels.cuda()
    with autocast():
        outputs = model(inputs)
        loss = criterion(outputs, labels)
    scaler.scale(loss).backward()
    scaler.step(optimizer)
    scaler.update()
    optimizer.zero_grad()
```

#### (5). 检查并关闭其他占用 GPU 内存的程序
使用 `nvidia-smi` 命令查看当前 GPU 的使用情况，关闭其他不必要的占用 GPU 内存的程序：
```bash
nvidia-smi
```

#### (6). 分布式训练或多 GPU 并行
如果有多个 GPU 可用，可以使用分布式训练或多 GPU 并行来分摊内存压力。在 PyTorch 中，可以使用 `torch.nn.DataParallel` 或 `torch.nn.DistributedDataParallel` 来实现：
```python
import torch
import torch.nn as nn

model = YourModel().cuda()
# 使用 DataParallel 进行多 GPU 并行
model = nn.DataParallel(model)
```

通过以上方法，你应该能够解决 GPU 内存不足的问题。如果问题仍然存在，建议检查模型结构和数据处理流程，进一步优化内存使用。 