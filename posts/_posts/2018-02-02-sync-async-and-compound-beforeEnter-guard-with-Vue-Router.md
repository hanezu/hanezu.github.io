---
layout: post
title: "Synchronous, Asynchronous, and Compound beforeEnter Guard with Vue Router"
tags: [Front-end]
---

The `beforeEnter` hook of Vue Router serves as a guard from inappropriate user access. In this article, we explore its power by three examples: checking current state, waiting until the state satisfies certain condition, and put them together.

Note: we are using Vuex for state management, but the syntax should be intuitive enough even if you have no experience with it.

1. TOC
{:toc}

# State-Validate Guard

For almost any application, before routing to a new, user-specific page, there is the need to check whether the user has logged in.

For example, suppose we are able to check whether user is logged in or not by a getter property `isLoggedIn` of Vuex, we can code a guard like this:

```
const requireLogin = (to, from, next) => {
  if (store.getters.isLoggedIn) {  // true if user is logged in
    next()  // routing is approved and the guard is released 
  } else {
    console.log('you have to log in to access this page')
    next('/')  // push back to the index page
  }
}
```

and we can activate this guard whenever user wants to access, e.g., their dashboard, by initializing your Vue Router instance like this:

```
new Router({
  routes: [
	{
      mode: 'history',
      path: '/dashboard',
      beforeEnter: requireLogin,  // add it here
      component: Dashboard
    }
  ]
})
```

# Wait-Until Guard

Sometimes there is the need to wait until something arrives that we should start to enter the route and load everything on top of that. 
It can be anything as long as we can access and watch a flag that indicates whether it has arrived or not.

For example, suppose we want to wait until a [web3](https://github.com/ethereum/web3.js/) instance is injected into the browser (should be a common need for an Ethereum application), we can do the following.

```
const waitUntilWeb3Injected = (to, from, next) => {
  if (store.state.web3.isInjected) {  // already injected
    next()  // no need to wait
  } else {
    store.watch(  // watch by Vuex
      state => state.web3.isInjected,  // specifies the state to watch
      isInjected => {
        if (isInjected) {
          next()
        }
      }
    )
  }
}
```

If you are sending asynchronous request, then it's even simpler: just invoke `next()` when the request promise resolves, or in the callback function.

# Put them together

Now that we have two guards, there is the possibility that we will need two guards at the same time for a single route.

Unfortunately, Vue Router does not support multiple beforeEnter guard by the time of writing. However, we can use some trick to put them together gracefully. 

Let's suppose we need to wait the web3 instance to inject, **and** the user must also be logged in to access a certain page. We can create a compound guard:

```
const waitWeb3AndRequireLogin = (to, from, next) => {
  waitUntilWeb3Injected(to, from, 
  () => {  // a little cheating here! we substitute the original `next` with a new guard.
    requireLogin(to, from, next)  // pass in the real `next`
  })
}
```

This works because `next` is never called with an argument (recall that it can take a route as argument). When it is not the case, we can modify the above a little bit, like

```
  waitUntilWeb3Injected(to, from, (route) => {  
    if (route) next(route)  // redirect when the first guard failed to approve
    requireLogin(to, from, next)
  })
```

