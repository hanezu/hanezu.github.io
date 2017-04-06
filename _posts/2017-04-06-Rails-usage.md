---
layout: post
title: "Rails usage"
categories: journal
tags: [rails]
---

1. TOC
{:toc}


## RubyMine cannot find ActiveRecord

I first found out that I should install bundle again, but still not works.

And in [this post at SO](http://stackoverflow.com/questions/11418408/rubymine-rails-gem-not-found),

> You need to add ruby sdks

> In RubyMine from file -> settings -> ruby Sdk and Gems -> add sdk

Which solved my problem. The error was because I installed both rbenv and rvm, annd I chose sdk as rbenv while install the bundle using rvm.

## Parsing a JSON string in Ruby
By [SO], `JSON.parse(string)` does the job.

It return a Hash, and its usage is [here](https://ruby-doc.org/core-2.4.0/Hash.html).

## Getting list of attribute from list of objects
Referred to [SO](http://stackoverflow.com/questions/16906922/iterate-over-array-of-objects-and-return-attributes),
```
 windows.map(&:device_serial)
```

## Remove a has\_many relation

Say we have a User who own a lot of windows, and a Window can only belong to a User at a time. Now user1 give the window to user2. We want to alter the ownership of the window.

I first tried to alter relation by `delete` and then `association=(new_owner)`. But it fails. The `RuntimeError` `Can't modify frozen hash` will pop out everytime.

The reason is that, by deleting, although I can still refer to `self`, if I call

```ruby

self.destroyed? # => true

```

and a destroyed object is frozen.

The correct way to do this is by setting a reverse association.

```ruby
# User
  has_many :windows,
    class_name: 'Window',
    dependent: :destroy,
    inverse_of: :user

# Window
  belongs_to :user,
    inverse_of: :windows

```

## Debug with rescue

I was trying to render a response of status 400 if JSON parse fails.

```ruby

	begin
      pref = JSON.parse(connection.pref_json)
    rescue ParserError
      render json: {error: "unable to parse #{connection.pref_json} to JSON"}, status: 400
      return
    end

```

But it does not work.

With the help of rails debugger (Thanks god it is so handy in RubyMine), I found out that I did not catch the Error at all, so the status response was 500 instead of 400.

In fact, the error that I should catch is `JSON::ParserError`. It is really a nightmare for Javaer using `import` to switch to Ruby. But anyway, module is a clever idea and I should get to be familiar with it.

## The class for `user.windows`

[ActiveRecord::Associations::CollectionProxy](http://edgeapi.rubyonrails.org/classes/ActiveRecord/Associations/CollectionProxy.html)

Useful method such as #find, #size, can be used in rspec.

## Reload in Association

There is a User who owns some windows, and the association has inverss. when I add a window by 

```ruby

        window.user = user
        window.save!

```

It turns out that

```
0> window.user
=> #<User id: 1, email: "bertrand@doyle.info", created_at: "2017-03-16 02:26:04", updated_at: "2017-03-16 02:26:04", access_key: nil, nickname: "Andy Beahan", stripe_customer_id: nil, payment_method: 0>

0> user1.windows
=> #<ActiveRecord::Associations::CollectionProxy []>

```

It seems that the association fails. But when I do

```

0> window.user.windows
=> #<ActiveRecord::Associations::CollectionProxy [#<Window id: 1, user_id: 1, device_serial: "AW101-0000000000", model: "AW101", name: nil, created_at: "2017-03-16 02:26:05", updated_at: "2017-03-16 02:26:05">]>

```

The association actually does the job! So I run

```

0> user1.reload
=> #<User id: 1, email: "bertrand@doyle.info", created_at: "2017-03-16 02:26:04", updated_at: "2017-03-16 02:26:04", access_key: nil, nickname: "Andy Beahan", stripe_customer_id: nil, payment_method: 0>

0> user1.windows
=> #<ActiveRecord::Associations::CollectionProxy [#<Window id: 1, user_id: 1, device_serial: "AW101-0000000000", model: "AW101", name: nil, created_at: "2017-03-16 02:26:05", updated_at: "2017-03-16 02:26:05">]>

```

and it's set.

## return render ?

I encountered this code snippet.

```ruby
return render json: ErrorCode::U09.to\_hash, status: 400
```

and what is it different from

```ruby 
render json: ErrorCode::U09.to_hash, status: 400
return 
```

The answer [by SO](http://stackoverflow.com/questions/37810599/return-render-vs-render-and-return-in-rails) is that we should avoid return render, because

> I don't believe anything is actually listening for the return value of the controller actions.


## Model A has\_one Model B: create together

I have two model that are one-on-one and onto with each other, say, a Window and a WindowConnection.

It is possible that I put 

```ruby

 after_create :create_window_connection

```

to Window, so that I can use `c = window.connection` without initialization.


## Extract Testing method

[This blog](https://testdrivenwebsites.com/2011/08/17/different-ways-of-code-reuse-in-rspec/) explained ways to extract Testing method.



