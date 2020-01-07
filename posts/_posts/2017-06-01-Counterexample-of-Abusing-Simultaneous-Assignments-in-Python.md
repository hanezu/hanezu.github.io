---
layout: post
title: "Counterexample of Abusing Simultaneous Assignments in Python"
tags: [Programming]
---

When learning python,
I was amazed by `a, b = b, a`
and thought, 
"I don't need to keep track of or caching any
variables now when I want to do simultaneous assignment
thanks to python!"

However, things are not so simple, and I was stuck 
when I try to simultaneously assign value to linked list.


1. TOC
{:toc}


# Reverse Nodes in k-Group

## reverse the pointing of adjacent nodes

The critical step to solve [this problem](https://leetcode.com/problems/reverse-nodes-in-k-group/#/description)
is to reverse the pointing of adjacent nodes.
Which is: 

change 

$$
\overset{l}{1}\rightarrow2\rightarrow\overset{r}{3}
$$

to 

$$
\overset{l}{2}\rightarrow1 \rightarrow \overset{r}{3}
$$

here the numbers denote nodes
and the alphabets on top of the node denote pointers that keep track
of these nodes (`l` for left and `r` for right. In particular,
I need the `r` because the problem is actually not of size 3,
but size `k`)

## Counterexample of simultaneous assignment
I attempted to achieve it with the following code:

`l, l.next, l.next.next = l.next, r, l`

Here is my idea.

1. `l`: a pointer that is pointing at `1` should now 
points to `2`, which is `l.next`
2. `l.next`: the `next` of `l` (`1`) should be set to `3`
3. `l.next.next`: the `next` of `l.next` (`2`) should be set to `1`

But it does not work. 
Actually the program is stuck in a dead loop.

## Limitation of simultaneous assignment

It is not valid to perform the line
because python only do the cache for you
when you are doing simultaneous assignment
(the things on the right-hand side of the `=`)
but it will never remember your variable settings
(the things on the left-hand side of the `=`).


## The dead loop

To be specific, what python really did was:

1. `l`: a pointer that is pointing at `1` is now 
pointing to `2`. No problem.
2. `l.next`: the `next` of `l` (which is now **`3`**!)
is set to `3`(nothing happened in effect)
3. `l.next.next`: the `next` of `l.next` (which is still **`3`**!!)
is set to `l`, which is `1`
(notice that python helped me here. 
It cached the original `l = 1` for me)

The result turns out to be a dead circle in the linked list!

$$
\rightarrow1\rightarrow2\rightarrow3\rightarrow1\rightarrow\dots
$$

## The correct solution

Just don't believe python can do anything for you.
Cache the nodes if necessary, and all set.

```python

m = l.next
l.next = r
m.next = l
    
```

However, actually there is a tidier solution.

# 'Order' of 'Simultaneous' Assignment
 
If you thought "it is actually not simultaneous!"
then you are on the right track. 
The order does matter.

## An example from the above Counterexample

Actually I just used another simultaneous assignment in
the same piece of code, as following.

    l.next, l = self.kth_later, r

Why is this one correct?
The code tells `l` to point to a node called $k^{th} later$
and change the pointer that points to `l` now to `r`.

Therefore, it seems that it is possible to assign value to the property of 
the object before assigns value to the *pointer* to the object itself.

## A simpler analogous example

Let assume we have the class `Anime` with property `name`,
and we do the following.

```python

a = Anime()
b = Anime()
saekano.name = "saekano"
```

Now

    a.name, a = "eromanga-sensei", saekano
    
will define `a`'s name to "eromanga-sensei", and let `a`
points to `saekano`. So `a.name` will be "saekano"

While

    a, a.name = saekano, "eromanga-sensei"
    
change both `a.name` and `b.name` to "eromanga-sensei" in effect.

## back to the original problem 

Noticing the order help us to come up with a tidier solution
for the original Reverse Nodes problem.

If we try

`l.next.next, l.next, l = l, r, l.next`

the result will be `2->1->3`

What happens is, Python first cache the `l, r, l.next`, 
which are `1, 3, 2`.
Then we let `2` points to `1`, `1` points to `3`, and set
`l` to point to `2`.


## the Takeaway

- Be careful in simultaneous assignment when the left-hand side
(the variables) is under possible changes during the assignment.
  
- Changing the order of simultaneous assignment might help,
but more importantly, think of the assignment process as "
caching the right, and assign to left, one by one". If the logic
is clear, then go fo the simpler code.



<script type="text/javascript" async
 src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>
<script type="text/x-mathjax-config">
 MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
