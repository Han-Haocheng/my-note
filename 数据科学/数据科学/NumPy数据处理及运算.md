---
jupyter:
  jupytext:
    cell_metadata_filter: -all
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.18.1
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

# NumPy 数据处理及运算

## 创建N维数组

`numpy.narray()`：构造一个 `ndarray` 对象，据有固定大小项的多维同质数组

格式

```python
class numpy.ndarray(shape,dtype=float,buffer=None,offset=0,strides=Node,...)
```
```python
import numpy as np

np.ndarray(shape=(2,2),dtype=float,order='F')
```

```python

```
