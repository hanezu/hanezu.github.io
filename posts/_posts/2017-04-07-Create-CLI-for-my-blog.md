---
layout: post
title: "Create CLI for my blog"
tags: [Programming]
---

If you are kind enough to check my code for hosting this blog, you can see that I am using some Ruby scripts to create post templates, or rename post.

But as I get more engaged in writing posts and needs more functions, `ruby ***.rb` is getting clumsy.

So I decides to build a CLI for this blog in Ruby.

1. TOC
{:toc}

# Commandline template

## Option Parser? ×

I would like the commandline tool to not only have flag, but also action. 
What I means is, the template for usage should be

`program action --flag -p param`

As a result, the built-in ruby commandline tool Option Parser is not enough for me, since it only supports flags.
Besides, the grammar is a little clumsy.
 

## [Thor](http://whatisthor.com/)

Thor behaves similar as Rails, for example

```ruby
  desc "hello NAME", "say hello to NAME"
  def hello(name, from=nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end
```

### "Default over Configuration" principle

 the important string `"hello NAME"` following `desc` concisely describes the behavior of the action `hello`.
 
 If you look at *options and flags*([here for more detail](https://github.com/erikhuda/thor/wiki/Method-Options))
 , the `options` parameter that come out from nowhere demonstrate the power of *default*.
 

### method signature over desc 
 
It should also be mentioned that, the method signature actually determine how you will use it. 
For example, `hello "Yehuda Katz" "Carl Lerche"` is possible because of the optional argument of `hello` method.

# Commandline Tool setup

## `chmod u+x CommandlineTool.rb`

This line *change the mode* by *user add execution rights* to the script file. 

## `#!/usr/bin/env ruby`

Put this line to the first line of your script to tell the command line to execute the file by Ruby.

You are now nearly free from `ruby *.rb` and can enjoy `./*.rb`.





