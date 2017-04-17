---
layout: post
title: "Statitical Learning Theory Note by Hisashi Kashima"
categories: journal
tags: [course_note]
---

<script type="text/javascript" async
 src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>
<script type="text/x-mathjax-config">
 MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>

The course was taught in Spring 2017.
The course material is [here.](http://www.geocities.jp/kashi_pong/course_statistical_learning_theory_2017.html)

1. TOC
{:toc}

# Apr. 17

## Represent discrete input by one-hot encoding

If an input has $N$ possible discrete value, we should encode 
the $i$-th value as

$$ (0, \dots, \stackrel{i}{1}, \dots, 0)  $$

In essence, we introduce an $N$-dimensional binary-valued subspace
for the input.

It is not possible to represent it as an variable in $\mathbb{Z}_N$ 
because it is embedded in $\mathbb{R}$ and will introduce magnitude. 

# Regularization in Ridge regression

[Ridge regression](https://en.wikipedia.org/wiki/Tikhonov_regularization)
share the idea of weight decay in machine learning.
But their starting points differ.

## Include penalty on the norm of weights $w$ to avoid instability

when we introduce the regularization term, it will lead to new solution.

$$ 
w = (X^T X + \lambda I)^{-1} X y
$$
 
I originally thought that a small enough $\lambda$
 should both ensure the stability of solution
and approximate the original solution.
But actually the $\lambda$ here can be plugged back to the original
loss function. The loss function will become

$$
L(w) = ||y-Xw||_2 + \lambda||w||_2
$$

The latter one is simply the weight decaying factor in machine learning.
