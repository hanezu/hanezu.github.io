# [Hanezu's blog](https://hanezu.net/)

[Jekyll](https://jekyllrb.com/) + [Lagrange](https://lenpaul.github.io/Lagrange/)

## LaTeX support

Inserted the following snippet at the bottom of a markdown post to support LaTeX equations.

```html
<script type="text/javascript" async
 src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>
<script type="text/x-mathjax-config">
 MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
```

## Custom excerpt

custimize the excerpt of a post by adding `excerpt_separator: "<!--more-->"`
to the [front matter](https://jekyllrb.com/docs/front-matter/), and add
`<!--more-->` to wherever we want to end the excerpt.
