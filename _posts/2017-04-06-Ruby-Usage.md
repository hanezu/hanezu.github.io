---
layout: post
title: "Ruby Usage"
categories: journal
tags: [ruby]
---

1. TOC
{:toc}


# Ruby scripting

It is really convenient to use Ruby to script (compare to Python), especially when it come to command line interaction.

## Put function as well as execution of function together

It might be better to write function and execution of it separately in script, but why not make life better by condensing them into one file?

This can be achieved by 
```ruby
def my_fn
	...
end

my_fn if __FILE__==$0
```

# new and initialize

Very basic points but I made mistake here.

In [this blog](http://www.verygoodindicators.com/blog/2015/03/15/ruby-contructors/), read the 
