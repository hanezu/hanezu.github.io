---
layout: post
title: "Using both Python 2 and 3"
categories: journal
tags: [anaconda, python]
---

{:toc}

I recently switch to Anaconda for convenient environment for studying machine learning, as suggested by CS231n.

Then I encounter the problem of switching back and forth between Python 2 and 3, again.

Fortunately, Anaconda provide a handy solution for this problem.

Then I go to this [SO post](http://stackoverflow.com/questions/24405561/how-to-install-2-anacondas-python-2-7-and-3-4-on-mac-os-10-9) and it works magically.

# Conda

Both of the posts suggest using Conda.

> Conda, the package manager for Anaconda, fully supports separated environments.

## Create Environment

I first installed Anaconda for python3, so now I would like to create a new environment for python2. So

`conda create -n python2 python=2.7 anaconda`

will create such an environment named `python2` for you. 

## Activate Environment

By

`source activate python2`

and now you can run any of your codes now in python, without the nuisance of using `python2` or `python3` to run your codes now (which I used, and is pretty error-prone).

```python
import sys
print(sys.version)
```

gets

```
2.7.13 |Anaconda 4.3.1 (x86_64)| (default, Dec 20 2016, 23:05:08) 
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.57)]
```

## Deactivate Environment

Simply 

`source activate python2`

and the (python2) in front of your command line should disappear and you are back to python3!

