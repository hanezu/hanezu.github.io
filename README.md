# [Hanezu's blog](https://hanezu.net/)

I used Jekyll to build my blog.
I used a theme called [Lagrange](https://lenpaul.github.io/Lagrange/) developed by Paul Le, and did some adjustment.

## Some hacks for blogging

### LaTeX support

Insert the following snippet at the bottom of a markdown post, and we are ready to type Math equations.

```html
<script type="text/javascript" async
 src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>
<script type="text/x-mathjax-config">
 MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
```

### Custom excerpt

We can custimize the content of excerpt by adding
`excerpt_separator: "<!--more-->"` to [front matter](https://jekyllrb.com/docs/front-matter/),
and add `<!--more-->` to wherever we want to end the excerpt.
