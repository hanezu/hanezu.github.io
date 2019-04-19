---
layout: post
title: "AWS Cognito Authentication with email and password using amplify cli"
tags: [Programming]
---

It's wierd that Amplify does not yet support out-of-the-box email + password sign up, but it's possible to implement with some configuration.

The original solution can be found in this [GitHub issue](https://github.com/aws-amplify/amplify-cli/issues/102). 
The following code will be in Vue.js, but it is supposed to work similarly for other frameworks.

1. TOC
{:toc}

# Set up email sign in

For the latest version of aws-amplify, you can set up email sign in when you first run `amplify add auth`

![Set up email sign in during amplify add auth](https://user-images.githubusercontent.com/7247658/55456698-98e64e00-559c-11e9-9842-e85dfd240810.png)
*Select Email to set up email sign in when `amplify add auth`*

# Configure Authenticator 

In your sign up page, put an Authenticator component somewhere in the template:

```vue
<amplify-authenticator :authConfig="authConfig"></amplify-authenticator>
```

You need to [set up aws-amplify for your Vue project](https://aws-amplify.github.io/docs/js/vue) to use the `Amplify-Authenticator` component.

# Configure signUpConfig

```js
data () {
  return {
	authConfig: {
	  signUpConfig: {
		signUpFields  : [
		  {
			label       : 'Email',
			key         : 'username', // !!!Important
			required    : true,
			displayOrder: 1,
			type        : 'string',
			custom      : false
		  },
		  {
			label       : 'Password',
			key         : 'password',
			required    : true,
			displayOrder: 2,
			type        : 'password',
			custom      : false
		  },
		],
		// defaultCountryCode: '81',
		hiddenDefaults: [
		  'username',
		  'phone_number',
		  'email'
		]
	  }
	}
  }
}
```


