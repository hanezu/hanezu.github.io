---
layout: post
title: "zsh not working properly under pyenv virtualenv in vscode"
tags: [Programming]
---

# TL;DR

Add `"python.terminal.activateEnvironment": false,` to your vscode settings, and
the integrated terminal will work as expected in vscode.

# Symptom

I just set up zsh for my mac, but it did not work well in the integrated terminal
of vscode. When I started a new terminal, it looks like this:

```
source /Users/hanezu/.pyenv/versions/my-virtualenv/bin/activate

# hanezu@Hanezu-mbp.local:~/my-project-dir on git:master
 source /Users/hanezu/.pyenv/versions/my-virtualenv/bin/activate
(my-virtualenv) \h:\W \u$
```

# Analysis

However, when I open a JavaScript project in vscode, everything worked out well.
Like this:

```
# hanezu@Hanezu-mbp.local:~/my-js-project-dir on git:master
 
```

So this must be caused by my `pyenv-virtualenv` settings.

If you look carefully at the wrong terminal output again,
you will find out that vscode actually activate the python environment for you twice:
before and after zsh is ready.

# Solution

Therefore, by adding `"python.terminal.activateEnvironment": false,` in vscode settings,
the terminal will work as expected in vscode.

By the way, this setting does not stop the terminal from activating your virtualenv, 
as long as you have set your virtualenv via `pyenv local my-virtualenv`.


