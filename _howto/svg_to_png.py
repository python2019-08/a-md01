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