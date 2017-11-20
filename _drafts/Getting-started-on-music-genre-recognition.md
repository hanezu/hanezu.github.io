---
layout: post
title: "Getting started on music genre recognition"
categories: journal
tags: []
---

Per my friend's interest on deep learning based music recommendation, I decided to test some available idea on music classification (which is named Music Genre Recognition instead, and generally using CV liked models such as CNN).  

1. TOC
{:toc}

# Music recommendation system of Spotify
My friend shared a Chinese version of the blog [Spotify’s Discover Weekly: How machine learning finds your new music](https://hackernoon.com/spotifys-discover-weekly-how-machine-learning-finds-your-new-music-19a41ab76efe) with me. In particular, the deep learning stuff in this article points to [Recommending music on Spotify with deep learning](http://benanne.github.io/2014/08/05/spotify-cnns.html), a project in 2014 by Sander Dieleman, an intern at Spotify, who is now at DeepMind. The model is CNN and the analysis is conducted on pieces of music.

# Music Genre Recognition by DeepSound

Since Sander was unable to share his code, I go on to [Music Genre Recognition](http://deepsound.io/music_genre_recognition.html) by Piotr Kozakowski & Bartosz Michalak from DeepSound in 2016 implementing the paper [Deep Image Features in Music Information Retrieval](http://ijet.pl/index.php/ijet/article/view/10.2478-eletel-2014-0042/53) in 2014. The cool part of this project is that not only did they share their [codes](https://github.com/deepsound-project/genre-recognition) but they also have a great front end to showcase ([Demo](http://deepsound.io/genres/)). They also shared the front end so it is possible to download and try the music analysis on your own piece of music. The model is CRNN in Keras and capable of Live Music Genre Recognition.

## Run their code

I opened a new environment in my anaconda and installed the requirement. I found out that they were using Python 2.7 indeed and changed the python version of my environment.
 
When I ran, it told me that I did not install TensorFlow. I opened the `requirements.txt` and there was no TensorFlow in it.

So I `pip install tensorflow`, but this time it said 
```python
    x = tf.python.control_flow_ops.cond(tf.cast(_LEARNING_PHASE, 'bool'),
AttributeError: 'module' object has no attribute 'python'
```

Probably as [this issue](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/issues/3) explained, I had the wrong version of TensorFlow installed.

The version of Keras they used was 1.1.0 so the version of TensorFlow was probably very dated. The oldest one available for `pip install` was 0.12.0. I reinstalled but still not working.

The error changed to 
```python
    x = tf.python.control_flow_ops.cond(tf.cast(_LEARNING_PHASE, 'bool'),
AttributeError: 'module' object has no attribute 'control_flow_ops'
```

This time [StackOverflow](https://stackoverflow.com/questions/40046619/keras-tensorflow-gives-the-error-no-attribute-control-flow-ops) told me to install TensorFlow version 0.10, but it is not possible to pip install it directly.

So I went to [TensorFlow 0.10 on GitHub](https://github.com/tensorflow/tensorflow/tree/r0.10) and followed the [pip installation instruction](https://github.com/tensorflow/tensorflow/blob/r0.10/tensorflow/g3doc/get_started/os_setup.md):

```

# Mac OS X, CPU only, Python 2.7:
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-0.10.0-py2-none-any.whl

# Mac OS X, GPU enabled, Python 2.7:
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow-0.10.0-py2-none-any.whl

# Python 2
$ sudo pip install --upgrade $TF_BINARY_URL

```

I want to show it to my friend with my MacBook so the environment is set up on my laptop. I was blocked by GFW for the last step, so I went to the cafeteria and used IPv6 to download it instead (sigh).


# Music recommendation by Keunwoo Choi

On the other hand, [Keunwoo Choi](https://github.com/keunwoochoi) did many works on music recommendation.
 
## Transfer learning 
 [Transfer learning for music classification and regression tasks](https://arxiv.org/pdf/1703.09179.pdf) ([Code](https://github.com/keunwoochoi/transfer_learning_music)) used concatenated features from different layers so that the extracted feature can be later on used for different tasks.
 
### Remark
 If I correctly interpreted the paper, the definition of "Transfer learning" here has subtle difference from its original meaning.  
 
 - Original: pretrain a model for one task, and finetune it for other tasks.
 - Here: train a model for a task and use it as feature extractor for other tasks.
 
 The difference is, while the parameters of the model is generally modified when applied to other tasks, here the model's parameters are fixed. 
 
 Instead, the author suggested a inspiring idea that different tasks tend to emphasize on the features of different layers.

![transfer_learning_tasks]({{ site.github.url }}/images/Getting-started-on-music-genre-recognition/transfer_learning_tasks.png)
*The 6 tasks to tackle*

## Music Tagging

Another work is on [Music Tagging](https://github.com/keunwoochoi/music-auto_tagging-keras) in Jan '17, a little bit earlier than his work for Transfer Learning. It reminded me of [I2V](https://github.com/rezoo/illustration2vec).

![Models](https://raw.githubusercontent.com/keunwoochoi/music-auto_tagging-keras/master/imgs/diagrams.png)
*Left: compact_cnn, music_tager_cnn. Right: music_tagger_crnn*

The music_tagger_crnn model is similar to the work of DeepSound, but predicting tags instead.

The author suggests [compact_cnn](https://github.com/keunwoochoi/music-auto_tagging-keras/tree/master/compact_cnn) over music_tager_cnn and music_tagger_crn since the latter ones are his old works.

### Run compact_cnn

Keunwoo Choi wrote a packae for on-the-fly calculation of STFT/melspectrograms called [kapre (Keras Audio Preprocessors)](https://github.com/keunwoochoi/kapre). 











