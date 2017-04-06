---
layout: post
title: "Easy JS Unit Test with Jasmine and Karma "
categories: journal
tags: [Jasmine,Karma]
---

Jasmine is the testing framework. Karma is the test runner.
 Working with them when writing unit tests is... cool.

1. TOC
{:toc}

# [Karma](https://karma-runner.github.io/1.0/index.html)

## Single Run

Everytime I start Karma and fails, and edit the spec files, 
the Karma would shout at me "your files have done a complete reload!"

It's really annoying (perhaps there are other solutions), so I decided to run with

`karma start --single-run`

# Jasmine 

##[Focused Specs](https://jasmine.github.io/2.1/focused_specs.html)

Putting f in front of your `it`s or `describe`s, and start your Karma.
 Only the one you prefixed with `f` will run. 
 
# Play Karma in WebStorm 
 
 Install Karma Plugin in WebStorm, and you can now configure that 
 ^R will run the spec code in Karma.
 
 If you would like to prefix `f` to your suite, it will just function as handy 
 as any other Unit Test framework for Python or Ruby.
 
# JetBrains IDE Debugger and Chrome 

To run in debug mode, install JetBrains IDE Support Plugin in Chrome, and 
configure the IDE Connection Host and Port according to what your IDE says.


 