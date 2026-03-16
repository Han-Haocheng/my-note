---
jupyter:
  jupytext:
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

# numpy库

```python
import numpy as np
np.__version__
```

## 数组创建


### numpy.ndarray()

```python
np.ndarray(shape=(2,2), dtype=float, order='F') # 创建ndarray

```

#### 创建多维数组

```python
np.ndarray((2,), buffer = np.array([1,2,3]), offset=np.int_().itemsize, dtype = int) 
```

#### 创建多维数组


### numpy.array()

<!-- #region -->
### numpy.arange()

```python
numpy.arange(start=0, stop, step=1, dtype=int)
```
<!-- #endregion -->

```python
np.arange(0,20,4)
```

<!-- #region -->
### numpy.linspace()

numpy.linspace() 函数：用于创建等差数组。
- 通过 start 和 stop 指定数组元素的生成范围
- 与 numpy.arange() 函数区别：需要指定生成元素的个数

```python
numpy.linspace(start,stop,num=50,endpoint=True,retstep=False,dtype=None)
```
<!-- #endregion -->

```python

```

```python

```

<!-- #region -->
## 数组操作
###  改变数组形状

<!-- #endregion -->

