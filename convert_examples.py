#!/usr/bin/env python3

import re

# 读取文件内容
with open('/mnt/d/Documents/HanNote/数学/分析/积分/不定积分.md', 'r', encoding='utf-8') as f:
    content = f.readlines()

# 处理内容
result = []
in_example = False
current_example = []

for line in content:
    # 检查是否是新的例题开始
    if not in_example:
        # 匹配以"例"开头的例题
        if re.match(r'^例\d+', line.strip()):
            in_example = True
            current_example = [line.strip()]
        # 匹配以"(数字)"开头的例题
        elif re.match(r'^\(\d+\)', line.strip()):
            in_example = True
            current_example = [line.strip()]
        # 匹配以"(例数字)"开头的例题
        elif re.match(r'^\(例\d+\)', line.strip()):
            in_example = True
            current_example = [line.strip()]
        # 匹配直接以数学表达式开头的例题
        elif line.strip().startswith('$\int'):
            in_example = True
            current_example = [line.strip()]
        else:
            result.append(line)
    else:
        # 检查是否是例题结束（空行）
        if line.strip() == '':
            # 转换当前例题为指定格式
            if current_example:
                result.append('> [!faq]- ' + current_example[0] + '\n')
                for i, example_line in enumerate(current_example[1:]):
                    result.append('> ' + example_line + '\n')
            result.append(line)
            in_example = False
            current_example = []
        else:
            # 添加到当前例题
            current_example.append(line.strip())

# 处理最后一个例题
if in_example and current_example:
    result.append('> [!faq]- ' + current_example[0] + '\n')
    for i, example_line in enumerate(current_example[1:]):
        result.append('> ' + example_line + '\n')

# 写入处理后的内容
with open('/mnt/d/Documents/HanNote/数学/分析/积分/不定积分.md', 'w', encoding='utf-8') as f:
    f.writelines(result)

print("转换完成！")
