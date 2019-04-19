---
layout: post
title: "Cascading priority of global styles in Vue"
tags: [Programming]
---

Since a `style` tag without a `scoped` attribute is global in Vue.js, we can write a selector in the child component to style the parent component. Like below ([Interactive Demo](https://codesandbox.io/embed/102x483y9q?fontsize=14))

```vue
<!-- App.vue -->
<template>
  <div id="app">
    <HelloWorld/>
  </div>
</template>

<!-- HelloWorld.vue -->
<style>
#app {
  background-color: green;
}
</style>
```

So, whenever there is a `HelloWorld` component appears in `App.vue`, the `background-color` will be `green`.

On the other hand, we can use `scoped style` to style current component without affecting its parents or children, and it should make sense that `scoped style` has a higher priority than global one.
So if we add the following lines to `App.vue`, the `background-color` will be red.

```vue
<!-- App.vue -->
<style scoped>
#app {
  background-color: red;
}
</style>
```

However, what if we use `global style` instead of `scoped style`?

```vue
<!-- App.vue -->
<style>
#app {
  background-color: red;
}
</style>
```

The answer is,  the `background-color` will be green. Styles from children have higher priority than those from parents.

This is both helpful and tricky. You can use this property to override styles of parents based on a child's appearance.

<iframe src="https://codesandbox.io/embed/102x483y9q?fontsize=14" title="Vue Template" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>


