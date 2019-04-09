---
layout: post
title: "ssh: connect to host github.com port xxx: Connection timed out"
tags: [Programming]
---

# Symptom

```
Cloning into 'SOME-REPO'...
ssh: connect to host github.com port xxx: Connection timed out
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Where `xxx` can be some random port number other than `22`.

# Analysis

Probably you change the default ssh port at some point.

In my case, I cannot clone repos from my home server, 
so it might be a side effect caused by the non-standard port forwarding of ssh port from `22` to `xxx`.

# Solution

Add following to your `~/.ssh/config`

```
# ~/.ssh/config
Host github*
	Port 22
```

The above solution is originally from [this post](https://uzulla.hateblo.jp/entry/2014/05/13/082711),
I modified it so that it also works for GitHub enterprise.

