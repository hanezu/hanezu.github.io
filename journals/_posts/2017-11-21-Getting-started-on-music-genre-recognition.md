---
layout: post
title: "Getting started on music genre recognition"
tags: []
image:
  feature: 
  teaser: 
---

Per my friend's interest on deep learning based music recommendation, I decided to test some available idea on music classification (which is named Music Genre Recognition instead, and generally using CV liked models such as CNN).  

1. TOC
{:toc}

# Music recommendation system of Spotify
My friend shared a Chinese version of the blog [Spotify’s Discover Weekly: How machine learning finds your new music](https://hackernoon.com/spotifys-discover-weekly-how-machine-learning-finds-your-new-music-19a41ab76efe) with me. In particular, the deep learning stuff in this article points to [Recommending music on Spotify with deep learning](http://benanne.github.io/2014/08/05/spotify-cnns.html), a project in 2014 by Sander Dieleman, an intern at Spotify, who is now at DeepMind. The model is CNN and the analysis is conducted on pieces of music.

# Music Genre Recognition by DeepSound

Since Sander was unable to share his code, I go on to [Music Genre Recognition](http://deepsound.io/music_genre_recognition.html) by Piotr Kozakowski & Bartosz Michalak from DeepSound in 2016 implementing the paper [Deep Image Features in Music Information Retrieval](http://ijet.pl/index.php/ijet/article/view/10.2478-eletel-2014-0042/53) in 2014. The cool part of this project is that not only did they share their [codes](https://github.com/deepsound-project/genre-recognition) but they also have a great front end to showcase ([Demo](http://deepsound.io/genres/)). They also shared the front end so it is possible to download and try the music analysis on your own piece of music. The model is CRNN in Keras and capable of Live Music Genre Recognition.


One way to interpret how CNN works in music is to make an analogy of the 2D-conv in music classification to the 3D-conv in video classification, where the second axis of the convolutional kernel exploits the temporal structure of a music. 

And therefore, as an effective way to aggregate global temporal information, an RNN model built on top of the local CNN might help to classify the whole music.

## Run their code

I opened a new environment in my anaconda and installed the requirement. I found out that they were using Python 2.7 indeed and changed the python version of my environment.
 
When I ran, it told me that I did not install TensorFlow. I opened the `requirements.txt` and there was no TensorFlow in it.

So I `pip install tensorflow`, but this time it said 
```python
    x = tf.python.control_flow_ops.cond(tf.cast(_LEARNING_PHASE, 'bool'),
AttributeError: 'module' object has no attribute 'python'
```

Probably as [this issue](https://github.com/axelbrando/Mixture-Density-Networks-for-distribution-and-uncertainty-estimation/issues/3) explained, I had the wrong version of TensorFlow installed.

The version of Keras they used was 1.1.0 so the version of TensorFlow was probably very dated. The oldest one available for `pip install` was 0.12.0. I reinstalled to that version but still not working.

However, the error changed to 
```python
    x = tf.python.control_flow_ops.cond(tf.cast(_LEARNING_PHASE, 'bool'),
AttributeError: 'module' object has no attribute 'control_flow_ops'
```

This time I found out that [I need to install TensorFlow version 0.10](https://stackoverflow.com/questions/40046619/keras-tensorflow-gives-the-error-no-attribute-control-flow-ops), but it is not available through direct pip install.

So I went to [TensorFlow 0.10 on GitHub](https://github.com/tensorflow/tensorflow/tree/r0.10) and followed the [pip installation instruction](https://github.com/tensorflow/tensorflow/blob/r0.10/tensorflow/g3doc/get_started/os_setup.md):

```

# Mac OS X, CPU only, Python 2.7:
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-0.10.0-py2-none-any.whl

# Mac OS X, GPU enabled, Python 2.7:
# $ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/gpu/tensorflow-0.10.0-py2-none-any.whl

# Python 2
$ sudo pip install --upgrade $TF_BINARY_URL

```

I want to show it to my friend with my MacBook so I set up the environment on my laptop. 

I was blocked by GFW for the last step, so I went to the cafeteria and used IPv6 instead (sigh).

Then the last bug said

```
    assert type(outputs) in {list, tuple}, 'Output to a TensorFlow backend function should be a list or tuple.'
AssertionError: Output to a TensorFlow backend function should be a list or tuple.
```

I checked the code and in `common.py`, I modified one line of `get_layer_output_function` function to

`f = K.function([input, K.learning_phase()], (output, ))`

then it works. (probably it is because the TensorFlow version is still not correct? Maybe the easiest solution is to ask them for their version name)

## Run with GPU

Indeed CPU was unbearably slow so I later decided to run with GPU, but I failed to achieve that. The error message was:

```python
  File "/home/hanezu/anaconda/envs/deepsound-genre-recog/lib/python2.7/site-packages/tensorflow/python/pywrap_tensorflow.py", line 24, in swig_import_helper
    _mod = imp.load_module('_pywrap_tensorflow', fp, pathname, description)
ImportError: libcudart.so.7.5: cannot open shared object file: No such file or directory
```

It seems that Tensorflow 0.10 cannot run on my cuda 8.0. But mixing cuda 7.5 and 8.0 seems to be such a pain that I gave up. (Hoping there will be a CUDA environment manager like Anaconda!)


# Music recommendation by Keunwoo Choi

[Keunwoo Choi](https://github.com/keunwoochoi) worked from several other approaches, including

1. Combining shallow and deep features from CNN to assemble a general purposed feature 
1. Tagging using CNN or CRNN 
 
## Transfer learning 
 [Transfer learning for music classification and regression tasks](https://arxiv.org/pdf/1703.09179.pdf) ([Code](https://github.com/keunwoochoi/transfer_learning_music)) used concatenated features from different layers so that the extracted feature can be later on used for different tasks.
 
### Remark
 If I correctly interpreted the paper, the definition of "Transfer learning" here has subtle difference from its original meaning.  
 
 - Original: pretrain a model for one task, and finetune it for other tasks.
 - Here: train a model for a task and use it as feature extractor for other tasks.
 
i.e. while the parameters of the model is generally modified when applied to other tasks, here the model's parameters are fixed. 
 
 Instead, the author suggested a inspiring idea that different tasks tend to emphasize on the features of different layers.

![transfer_learning_tasks]({{ site.github.url }}/images/Getting-started-on-music-genre-recognition/transfer_learning_tasks.png)
*The 6 tasks to tackle*

## Music Tagging

Another work is on [Music Tagging](https://github.com/keunwoochoi/music-auto_tagging-keras) ([arXiv: CONVOLUTIONAL RECURRENT NEURAL NETWORKS FOR MUSIC CLASSIFICATION](https://arxiv.org/pdf/1609.04243.pdf)) in Jan '17, a little bit earlier than his work for Transfer Learning. It reminded me of [I2V](https://github.com/rezoo/illustration2vec).


![Models](https://raw.githubusercontent.com/keunwoochoi/music-auto_tagging-keras/master/imgs/diagrams.png)
*Left: compact_cnn, music_tager_cnn. Right: music_tagger_crnn*

The music_tagger_crnn model is similar to the work of DeepSound, but predicting tags instead.

The author suggests [compact_cnn](https://github.com/keunwoochoi/music-auto_tagging-keras/tree/master/compact_cnn) over music_tager_cnn and music_tagger_crn since the latter ones are his old works.

### Configure compact_cnn

Keunwoo Choi wrote a package for on-the-fly calculation of STFT/melspectrograms called [kapre (Keras Audio Preprocessors)](https://github.com/keunwoochoi/kapre). 

### Tensorflow Implementation

While K Choi used Theano, I also found a [Tensorflow Implementation](https://github.com/meetshah1995/crnn-music-genre-classification) of this work.

# Other public repos

## Deep Audio Classification

[A project by despoisj](https://github.com/despoisj/DeepAudioClassification) in TensorFlow (and his [blog](https://chatbotslife.com/finding-the-genre-of-a-song-with-deep-learning-da8f59a61194)).

![Pipeline](https://raw.githubusercontent.com/despoisj/DeepAudioClassification/master/img/pipeline.png)

This implementation plainly used CNN to classify slices of the spectrogram of a music and combine the results into the class of the music.

It is possible to train this model with your personal music library, just by placing the mp3 files at the data path and run the code.

It seems that I can also predict the class of a new piece of music (although unable to manipulate the genre information in the mp3 files though) without writing additional codes.

However, no pretrained model nor data is provided (Despoisj used his own iTunes library).

## MusicGenreClassification

[A project by mlachmish](https://github.com/mlachmish/MusicGenreClassification) in TensorFlow that almost implemented Sander Dieleman's blog.

# Current research

## Non-local Neural Networks

A new work on video classification, [Non-local Neural Networks](https://arxiv.org/pdf/1710.10121) by Xiaolong Wang suggested an approach to exploit the temporal structure of the data by adding non-local blocks after some convolutional layers in plain CNN so that the local model can now put attention on some related information even across large time-space gap.

Actually he demonstrated the effectiveness of CNN on music classification, which I doubted from the beginning of my research on music classification. 

This is in accordance with another point X Wang made that, recently there emerged a trend of using feedforward (i.e., non-recurrent) networks for modeling sequences in speech and language, e.g. WaveNet and Seq2Seq.

So feedforward approach might be an appropriate first step into the task of music classification, and adding non-local blocks might both enhance and simplify the feedforward model.



