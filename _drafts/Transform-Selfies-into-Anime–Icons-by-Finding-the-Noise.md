---
layout: post
title: "Transform Selfies into Anime Icons by Finding the Noise"
categories: journal
tags: []
---

Inspired by my friend's attempt to transform selfies into anime icons by training a [CycleGAN](https://junyanz.github.io/CycleGAN/), I wonder if it is possible to achieve the same target using the model of, for example, [MakeGirlsMoe](make.girls.moe).

The basic idea is:

1. Find a noise that somehow encode the information from the selfie
2. Generate the anime icon using that noise

1. TOC
{:toc}

# Noise Update Recipe

For a typical GAN (aka [Generative Adversarial Networks](https://en.wikipedia.org/wiki/Generative_adversarial_network)) architecture, after training, the generator takes a noise (normally a normal random vector sampled from the latent space) as input and output an image, ideally drawn from the target data manifold (here the set of anime icons).

The first idea that came to my mind was: pick a noise randomly and modify the noise in a way that the corresponding icon look more and more similar to the target selfie.

# Encoder Recipe

Since I could not come up with an effective loss that measure the icon's "vicinity" of the selfie, I decided to take a try on *constructing a noise encoder*.

i.e. I want to find an `Encoder` that map 

## MakeGirlsMoe Generator

## Danbooru Generator


# Encoder Adversarial Networks

