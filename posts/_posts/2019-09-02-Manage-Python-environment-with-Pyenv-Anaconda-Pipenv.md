---
layout: post
title: "Manage Python environment with Pyenv + Anaconda + Pipenv"
tags: []
---

Pipenv is great. But it is not a perfect solution. Besides, sometimes it is convenient if we can use anaconda to manage some libraries that does not work well with `pip`.

Luckily, it is possible to take the best of two worlds.

1. TOC
{:toc}

## Step 1: install Pyenv

The easiest way to do it is via [pyenv installer](https://github.com/pyenv/pyenv-installer).

## Step 2: install anaconda

We can now use pyenv to manage python and anaconda versions. For example,

```
pyenv install anaconda3-5.3.1
pyenv global anaconda3-5.3.1
```

## Step 3: install anaconda packages

Now you can install packages that are managed by anaconda.

As an example, if you want to install Tkinter, you can run

```
conda install tk
```

## Step 4: install pipenv

Now we can install pipenv using the pip of conda:

```
pip install pipenv
```

## Step 5: Setup virtual environment of the repository

Before using pipenv to install packages, you need to set up pipenv to use the Python distribution of your anaconda environment. [[ref]](https://pipenv.readthedocs.io/en/latest/advanced/#pipenv-and-other-python-distributions)

```
$ cd your-repo
$ conda_python=$(python -c 'import sys; print(sys.executable);')
$ pipenv --python=$conda_python --site-packages
```

## Step 6: install packages via Pipenv

Finally, if you have a `Pipfile` in your repo directory, you can install packages by `pipenv install`.
You can also install new packages.

## Final notes

Let me list some pitfalls that I falled into using this approach.

### Library not found error

If you installed some libraries but the program still return you error messages like

```
usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `CXXABI_1.3.11' not found
```

you might need to manually add libraries installed by anaconda to your PATH:

```
export LD_LIBRARY_PATH=/home/USERNAME/.pyenv/versions/anaconda3-5.2.0/lib:$LD_LIBRARY_PATH
```

You can check conda installation directory by `conda info`

### Jupyter Lab

Currently, the default JupyterLab shipped with anaconda installation does not recognize packages installed by `pipenv`.

Therefore, you need to install JupyterLab via pipenv: `pipenv install --dev jupyterlab jupytext`

(I did not check for Jupyter Notebook)