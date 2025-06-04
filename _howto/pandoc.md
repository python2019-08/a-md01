# 1.pandoc xx.docx -o xx.md生成的md文档里，多了很多不必要的\

当使用 Pandoc 将 DOCX 转换为 Markdown 时，多余的反斜杠（`\`）通常是由于 Pandoc 对特殊字符进行了转义。这些转义可能是为了确保 Markdown 的兼容性，但在某些情况下会显得冗余。以下是几种解决方法：
### **0.**
```bash
# mq: my best practice   08package.md
inputPrefix=12go-build
docxName=${inputPrefix}.docx
outMdName=${inputPrefix}.md

outMediaPath=./media12
pandoc ${docxName} -f docx -t gfm -o ${outMdName} --extract-media=${outMediaPath} --wrap=none
```


### **1. 使用 `markdown_strict` 格式**
指定更严格的 Markdown 格式，减少不必要的转义：
```bash
pandoc xx.docx -f docx -t markdown_strict -o xx.md
```


### **2. 禁用特定转义**
通过 `markdown` 格式的扩展选项禁用特定转义：
```bash
pandoc xx.docx -f docx -t markdown-smart --atx-headers -o xx.md
```
- `-smart`：使用智能标点（如弯引号）。
- `--atx-headers`：使用 `#` 标记标题，减少标题行尾的转义。


### **3. 使用自定义过滤器**
编写简单的 Python 脚本去除多余的反斜杠：
```python
#!/usr/bin/env python3
import sys
import re

def remove_extra_backslashes(content):
    # 移除行首列表标记前的反斜杠
    content = re.sub(r'^\\([*+-])', r'\1', content, flags=re.M)
    # 移除链接和图片中的反斜杠
    content = re.sub(r'\\([\[\]])', r'\1', content)
    # 移除代码块中的反斜杠
    content = re.sub(r'(```.*?```)', lambda m: m.group(1).replace('\\', ''), content, flags=re.DOTALL)
    return content

if __name__ == "__main__":
    content = sys.stdin.read()
    print(remove_extra_backslashes(content))
```
使用方法：
```bash
pandoc xx.docx -t markdown | python remove_backslashes.py > xx.md
```


### **4. 后处理替换**
使用工具（如 `sed`、`awk` 或文本编辑器）批量替换：
```bash
# 使用sed移除链接中的反斜杠
sed -i 's/\\\([\[\]])/\1/g' xx.md
```


### **5. 调整 Pandoc 输出选项**
尝试其他输出格式选项，如 GitHub Flavored Markdown：
```bash
## mq: good 
pandoc xx.docx -f docx -t gfm -o xx.md
# my cmd
pandoc 09concurrent.docx -f docx -t gfm -o 09concurrent.md --extract-media=./media09 --wrap=none
```


### **推荐组合方案**
```bash
pandoc xx.docx -f docx -t markdown-smart+hard_line_breaks --atx-headers | \
    python remove_backslashes.py > xx.md
```


### **注意事项**
- 反斜杠可能是必要的（如转义 Markdown 中的特殊字符），请确保处理后不会破坏文档结构。
- 复杂文档可能需要更精确的过滤规则，可根据具体情况调整正则表达式。

通过上述方法，你应该能够显著减少 Markdown 中的多余转义字符。

======================================== 
======================================== 
# 2.pandoc 转换docx文档时，图片丢失了


当使用 Pandoc 转换 DOCX 文档时图片丢失，通常是因为 Pandoc 默认不会自动提取并转换 DOCX 中的图片，需要手动指定参数或配置来处理图片。以下是详细的解决方法：


### **一、核心原因分析**
1. **DOCX 图片存储方式**  
   DOCX 中的图片以二进制形式存储在 `word/media/` 文件夹中，Pandoc 不会默认将其复制到输出目录。
2. **Markdown 对图片的支持**  
   Markdown 依赖外部图片文件，需明确指定图片路径或使用图片转换工具。


### **二、解决方案**


#### **方法 1：使用 `-o` 指定输出目录并提取图片**
通过 `-o` 参数指定输出为 **目录**（而非单个文件），Pandoc 会自动生成 Markdown 文件和图片资源：
```bash
# 将 docx 转换为 markdown 并生成图片资源目录
pandoc input.docx -o output_dir/
```
- 执行后会生成：  
  - `output_dir.md`：Markdown 文本  
  - `output_dir_files/`：包含提取的图片文件（格式可能为 PNG/JPEG）


#### **方法 2：强制提取图片并指定格式**
使用 `--extract-media` 参数手动提取图片，并通过 `-d` 指定输出目录：
```bash
pandoc input.docx -o output.md --extract-media=./images --wrap=none
```
- **参数说明**：  
  - `--extract-media=./images`：将图片提取到当前目录的 `images` 文件夹中。  
  - `-d`（或 `--output-dir`）：指定输出目录（需与 `--extract-media` 配合使用）。  


#### **方法 3：转换为 HTML 再提取图片（适用于复杂图片）**
先将 DOCX 转为 HTML，再从 HTML 中提取图片并重新生成 Markdown：
```bash
# 1. 转换为 HTML（自动提取图片到 html_files 目录）
pandoc input.docx -o temp.html

# 2. 将 HTML 转换为 Markdown（图片路径会保留）
pandoc temp.html -o output.md
```
- 图片会被保存在 `temp_files/` 目录中，需手动复制到目标位置。


#### **方法 4：指定图片格式（如转换为 PNG）**
DOCX 中的图片可能为 EMF/WMF 格式（矢量图），Markdown 不支持，需强制转换为 PNG/JPEG：
```bash
pandoc input.docx -o output.md --pdf-engine=weasyprint --epub-metadata=meta.xml
# 或使用 ImageMagick 转换（需先安装）
pandoc input.docx -o output.md --dpi=300 --extract-media=./images
```
- 需提前安装依赖：  
  - `weasyprint`：用于转换矢量图为位图。  
  - `ImageMagick`：用于调整图片分辨率（`--dpi` 参数）。


#### **方法 5：使用模板自定义图片路径**
创建自定义 Pandoc 模板（如 `img_template.html`），指定图片路径格式：
```html
![[image.png]]
```
使用模板转换：
```bash
pandoc input.docx -o output.md --template=img_template.html
```


### **三、常见问题与处理**
1. **图片格式不兼容**  
   - DOCX 中的 **矢量图（EMF/WMF）** 需先转为位图（PNG/JPEG），可通过 `inkscape` 或在线工具预处理。  
   - 安装 `libreoffice` 或 `unoconv` 辅助转换：  
     ```bash
     apt-get install libreoffice  # Ubuntu/Debian
     pandoc input.docx -o output.md --pdf-engine=libreoffice
     ```

2. **路径错误**  
   - 确保 Markdown 中图片路径与实际存储路径一致（如 `![image](./images/image.png)`）。  
   - 使用相对路径（如 `./images/`），避免绝对路径导致迁移后图片丢失。

3. **权限问题**  
   - 确保输出目录有写入权限，否则 Pandoc 无法保存图片文件。


### **四、推荐工作流**
```bash
# 完整流程：提取图片并转换为 PNG 格式
pandoc input.docx \
  -o output.md \
  --extract-media=./images \  # 提取图片到 images 目录
  --dpi=300 \                # 设置分辨率（可选）
  --wrap=none                # 禁用自动换行
```


### **总结**
Pandoc 处理 DOCX 图片的关键是**手动提取并指定图片存储路径**。根据文档复杂度，选择直接提取目录（方法 1）或强制转换格式（方法 4）通常能解决问题。若仍有问题，可尝试先用办公软件（如 LibreOffice）将 DOCX 另存为 HTML，再用 Pandoc 转换。
======================================== 
======================================== 
# 3.pandoc 把html转换 成md时，html内部的svg 图片的处理

pandoc 把html转换 成md时，html内部的svg 图片没有转成png或jpg而是保持原样，如何处理这个问题？

在使用 Pandoc 将 HTML 转换为 Markdown 时，SVG 图片默认会保留为原始格式（这是因为 Markdown 本身支持直接嵌入 SVG）。若需要将 SVG 转换为 PNG/JPG，可以通过以下方法解决：


### **方法1：使用 Pandoc 的过滤器（推荐）**
通过自定义过滤器在转换过程中自动将 SVG 转换为 PNG。以下是使用 Python 和 Inkscape（或 CairoSVG）实现的方案：

#### **步骤1：安装依赖工具**
```bash
# Ubuntu/Debian
sudo apt-get install inkscape python3 python3-pip
pip3 install panflute

# macOS (via Homebrew)
brew install inkscape python3
pip3 install panflute
```

#### **步骤2：创建 SVG 转换过滤器（`svg_to_png.py`）**
```python
#!/usr/bin/env python3
import os
import panflute as pf
from subprocess import run, PIPE

def svg_to_png(elem, doc):
    if isinstance(elem, pf.Image) and elem.url.endswith('.svg'):
        # 创建输出目录
        output_dir = 'converted_images'
        os.makedirs(output_dir, exist_ok=True)
        
        # 生成新文件名
        base_name = os.path.basename(elem.url).replace('.svg', '.png')
        output_path = os.path.join(output_dir, base_name)
        
        # 使用 Inkscape 转换 SVG 到 PNG
        cmd = [
            'inkscape', 
            '--export-type=png',
            '--export-filename=' + output_path,
            elem.url
        ]
        
        result = run(cmd, stdout=PIPE, stderr=PIPE)
        if result.returncode != 0:
            pf.debug(f"Error converting {elem.url}: {result.stderr.decode()}")
            return elem  # 转换失败，保持原样
        
        # 更新图片 URL
        elem.url = output_path
        return elem

if __name__ == '__main__':
    pf.run_filter(svg_to_png)
```

#### **步骤3：应用过滤器进行转换**
```bash
pandoc input.html -o output.md --filter ./svg_to_png.py
```


### **方法2：手动预处理 SVG**
先将 HTML 中的 SVG 全部转换为 PNG，再用 Pandoc 转换：

#### **步骤1：提取并转换 SVG**
```bash
# 使用工具如 svg-to-png 批量转换
npm install -g svg-to-png
svg-to-png input_dir/ output_dir/
```

#### **步骤2：替换 HTML 中的 SVG 引用**
使用脚本（如 Python/Perl）批量替换 HTML 中的 SVG 标签为 PNG：
```python
import re

with open('input.html', 'r') as f:
    content = f.read()

# 替换 <img src="*.svg"> 为 PNG
content = re.sub(r'<img[^>]*src="([^"]+\.svg)"[^>]*>', 
                r'<img src="\1.png">', 
                content)

with open('input_fixed.html', 'w') as f:
    f.write(content)
```

#### **步骤3：使用 Pandoc 转换处理后的 HTML**
```bash
pandoc input_fixed.html -o output.md
```


### **方法3：使用其他工具链**
#### **方案1：Chrome Headless 截图**
使用 Puppeteer 等工具将 SVG 渲染为 PNG：
```bash
npm install -g puppeteer-cli
puppeteer screenshot input.svg --out output.png
```

#### **方案2：CairoSVG（纯 Python 方案）**
```bash
pip3 install cairosvg
cairosvg input.svg -o output.png
```


### **优化建议**
1. **批量处理**：编写脚本自动遍历目录中的所有 HTML 文件，统一转换 SVG 后再用 Pandoc 处理。

2. **保留原始文件**：转换后的 PNG 保存到单独目录，避免覆盖原始文件。

3. **自动化集成**：将转换流程集成到 CI/CD 或构建脚本中，确保每次更新都自动处理 SVG。

4. **质量控制**：通过参数调整 PNG 的分辨率（如 Inkscape 的 `--export-dpi`）。


### **最终命令示例**
```bash
# 使用过滤器一次性完成转换
pandoc input.html -o output.md \
  --filter ./svg_to_png.py \
  --resource-path=./images  # 指定 SVG 资源路径
```

通过上述方法，SVG 将被转换为 PNG/JPG 格式，使 Markdown 在不支持 SVG 的平台（如 GitHub、某些文档系统）中也能正常显示图片。