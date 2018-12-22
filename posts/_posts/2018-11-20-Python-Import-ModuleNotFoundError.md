---
layout: post
title: "Python Import ModuleNotFoundError: No module named 'xxx'"
tags: [python]
---

`sys.path` by default does not need to includes current running position, which can be quite confusing and often leads to ModuleNotFoundError.

Let's assume the structure of our project looks like the following:

```bash
dir_a/
	x.py
	y.py
dir_b/
	z.py
```

Suppose you want to import both `y.py` and `z.py` into `x.py`. 
There are two practices depending on whether you want to use _explicit relative import_ or not.


1. TOC
{:toc}

# Import types


```python
# x.py

# absolute import
import dir_a.y

# EXPLICIT relative import of `y.py` from `x.py`
import .y

# IMPLICIT relative import of `y.py` from `x.py`
import y
```

Note that [implicit relative import is removed in python3](https://www.python.org/dev/peps/pep-0008/#imports).

# Absolute import only

My favorite practice is: refrain from relative import completely. 
It is also the default behavior of the auto-import function of Pycharm.

```python
# x.py

# We spent three lines adding project root directory to environment variable `$PATH`,
# so that running `python x.py` under `dir_a` directory will be fine. 
# If you are fine using `-m` switch all the time,
# then adding to path is not necessary.
import sys
from pathlib import Path
# Of course, you can use `os` instead of `pathlib`, but `pathlib` is good ;)
sys.path.append(str(Path(__file__).resolve().parent.parent))  # add project root to path

import dir_a.y  # absolute import
import dir_b.z  # absolute import 
```

In this way, `y.py` and `z.py` will always be found when running either `python dir_a/x.py` or `python -m dir_a.x` under the project root directory, or `python x.py` under `dir_a` directory.

In addition, if you attempt to use relative import by changing the last line to `import ..dir_b.z` and run from `dir_a`, a `ValueError: attempted relative import beyond top-level package` [will be thrown](https://stackoverflow.com/questions/30669474/beyond-top-level-package-error-in-relative-import).


# Relative import 

Besides, you don't have to add `dir_a` to your path, as long as you are willing to import `y.py` by

```python
import y  # absolute import
```
sys.path.append(str(Path(__file__).resolve().parent))  # add `dir_a` to path

import y  # absolute import

The downside does not work when executed directly



