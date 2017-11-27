---
layout: post
title: "Transform Selfies into Anime Icons by Finding the Noise"
tags: []
---

<script type="text/x-mathjax-config">
 MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>

Inspired by my friend's attempt to transform selfies into anime icons by training a [CycleGAN](https://junyanz.github.io/CycleGAN/), I wonder if it is possible to achieve the same target using the model of, for example, [MakeGirlsMoe](make.girls.moe).

The basic idea is:

1. Find a noise that somehow encode the information from the selfie
2. Generate the anime icon using that noise

1. TOC
{:toc}

# Noise Update Recipe

For a typical GAN (aka [Generative Adversarial Networks](https://en.wikipedia.org/wiki/Generative_adversarial_network)) architecture, after training, the generator $G$ takes a noise $z$ (normally a normal random vector sampled from the latent space) as input and output an image $G(z)$, ideally drawn from the target data manifold (here the set of anime icons $A$).

The first idea that came to my mind was: pick a noise randomly and update the noise in a way that the corresponding icon look more and more similar to the target selfie. This idea is inspired by [Semantic Image Inpainting with Perceptual and Contextual Losses](https://arxiv.org/pdf/1607.07539).

## Math formulation

Suppose $S$ is the manifold of selfies (*condition images*), $A$ is the manifold of anime icons (*generated images*), then we need a *conceptual loss* $$L_c: S \times A \rightarrow \mathbb{R^+}$$ s.t. $\forall s \in S$ and $\forall a_1, a_2 \in A$, whenever $a_1$ is more likely a good candidate for an anime icon of $s$ than $a_2$, then $L_c(s, a_1) < L_c(s, a_2)$

However, if I update the noise against $L_c$, the result image might no longer preserve its identity as an anime icon. To avoid this problem, we define the *perceptual loss* $$L_p: I \rightarrow \mathbb{R^+}$$ s.t. $L_p$ is lower when $a \in I$ is more likely to be drawn from $A$. Here $I$ is the set of all images, i.e. $I = \mathbb{R}^{3 \times h \times w}$, where $h$, $w$ denote height and width of the image, respectively. $3$ is the number of channel.

unlike $L_c$, the choice of $L_p$ seems to be limited to the *discriminator loss* $D: I \rightarrow \mathbb{R^+}$. But as I will explain later in this post, using the $D$ that is trained together with the $G$ does not have the effect as intuitive as the choice itself. 

## Choice of $L_c$

There are four choice of $L_c$ that I tried.

1. l1 loss between $s \in S$ and $a \in A$
2. same with 1 but use l2 loss 
3. l1 (or l2) loss between feature map of $s$ and that of $a$
4. a linear combination of 1 and 3

where the feature map is extracted by [I2V](https://github.com/rezoo/illustration2vec). The specific feature map is extracted from one layer of the I2V



## Implementation

I 

# Encoder Recipe

Since I could not come up with an effective loss that measure the icon's "vicinity" of the selfie, I decided to take a try on *constructing a noise encoder*.

i.e. I want to find an Encoder that map 

## MakeGirlsMoe Generator

## Danbooru Generator


# Encoder Adversarial Networks

From encoder recipe it seems that using the original discriminator can greatly improve the 

