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

## numpy.ndarray()

```python
np.ndarray(shape=(2,2), dtype=float, order='F') # 创建ndarray

```

### 创建多维数组

```python
np.ndarray((2,), buffer = np.array([1,2,3]), offset=np.int_().itemsize, dtype = int) 
```

### 创建多维数组


## numpy.array()


## numpy.arange()

```
numpy.arange(start=0, stop, step=1, dtype=int)
```

```python
np.arange(0,20,4)
```

### numpy.linspace()
