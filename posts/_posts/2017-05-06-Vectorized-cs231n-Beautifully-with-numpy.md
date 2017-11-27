---
layout: post
title: "Vectorized cs231n Beautifully with numpy"
tags: [machine learning,numby]
---

I started to work on cs231n assigments recently. 

Probably just as everyone who first take a crack at these assigments, the vectorization parts of them are crazily frustrating but engaging.

So here I make a memo on manipulating ND-arrays. But it is better to also look up document for details on how to play with these methods.

1. TOC
{:toc}


# np.\*

Roughly speaking, np.\* is the functions part of numpy. Accordingly, np.ndarray.* is the methods part, which is the simpler paraphrases of their counterpart functions.

## choose

Used to pick out the score of the label class of a not-yet-classified sample.

for label(N) and scores(N, C) 

`np.choose(label, scores.T)`

will choose the scores of labels(N). Transpose is needed as the label are treated as row vector here.

a slightly confusing paraphrase is 

`label.choose(scores.T)`

It should sounds like "use label to choose on scores".

# np.random.\*

## choice

Used to generate samples.

Generate `num` random numbers from 0 ~ N-1 by

`np.random.choice(N, num)`

and generate samples from array using

`np.random.choice(arr, num)`

Also check out for non-uniform and no-replacement sampling.

# Clever usage of methods

## np.arange(N\*M).reshape((N, M))

More generally, when you want to create a (N, M) 2D-array, probably for playing in ipython, you can create an (N * M,) 1D-array and reshape it immediately.

As an aside, `arange` is quite simple to play with, as entrices are not only distinct, but when you play with it, you can easily calculate the result by heart.

if the case requires a matrix without order, `np.random.choice(choice_list, N\*M).reshape((N, M))` may do the job.

# Index tricks

I referred to clever manipulation of matrix of the form `matrix[...]` as index tricks.

## change value of the labeled elements

I want to do

`np.choose(label, scores.T) -= scores.max(1)`

for scores(N, C). It is made possible by

`scores[np.arange(N), label] -= scores.max(1)`

because the above line picks every labeled element from the scores, the left will be degenerated to a 1D-array, whose shape coincides with that of the right.

# Broadcasting

[Great guide here.](http://cs231n.github.io/python-numpy-tutorial/#numpy-broadcasting)

Scenarios for broadcasting comes out everywhere.

## add an (N,) vector to every column/row of an (N,M)/(M,N) matrix.

for (N, M) matrix

`vec.reshape((N, 1)) + mat`

## calculate difference between every element of two same size vectors

`vec1.reshape((N, 1)) - vec2.reshape((1, N))`
