---
layout: post
title: "Configure ESLint and Prettier and Vetur in VSCode"
tags: [Front-end]
---

ESLint and Prettier and Vetur conflict with one another, 
so it is a nightmare to make all of them working together in vscode.

Here are some caveats and suggestions for setting up a customizable code styling 
in VSCode for a better Vue.js development experience.

1. TOC
{:toc}

# ESLint == Prettier?

First, ESLint is a linter, so it analyze your code and find out errors in your code, 
both syntactical ones and stylistic ones.
On the other hand, Prettier is a code formatter, 
which only format your code so that it is more beautiful.

[This document](https://prettier.io/docs/en/comparison.html) explains the difference between formatter and linter.

So the tricky part is, ESLint, as a linter, also does some of the formatting, 
by fixing your stylistic problems. 

For example, you can get rid of semicolons using either of them.

## Get rid of semicolon using ESLint

Putting the below line under `rules` in your `.eslintrc.js`.

```
    semi: ["error", "never"]
```

## Get rid of semicolon using Prettier

Putting the below line in your `settings.json`.

```
    "prettier.semi": false,
```

By the way, there is another popular code prettifier called `Beautify`,
but the [corresponding extension](https://marketplace.visualstudio.com/items?itemName=peakchen90.vue-beautify)
seems to be not in maintenance. 

# Execution of ESLint and Prettier

Since we are using VSCode, we normally don't want to lint or format our code from terminal.
To lint and format our code directly from VSCode, 
we can 

1. call directly
2. trigger on save.

## Lint or format directly

### ESLint

Open your command palette (by default, `Ctrl+Shift+P` or `Cmd+Shift+P`)
and search for `Eslint: Fix all auto-fixable Problems`
You can of course assign a keyboard shortcut to it.

### Prettier

Open your command palette
and search for `Format Document` (by default, `Shift-Alt-F`) or `Format Selection` (by default, `Cmd-K Cmd-F`).

The former one format the whole file, while the latter one format what you selected. 
(Notice that the latter one actually does not work with Vetur, which we will introduce later on)

## Lint or format on save 

In `settings.json`,

* ESLint: `"eslint.autoFixOnSave": true,`
* Prettier: `"editor.formatOnSave": true,`

Two caveats:
1. It will not trigger when auto-saved. You need to press `Ctrl-S`.
2. The order of execution is undetermined. This means that if you have conflicted formatting setups for ESLint and Prettier, you may have different result every time you save.

Therefore, you should not set both of them to `true`.

# Vetur

The above discussions are actually framework-free, and now we are going to set up for Vue.js project.

(To begin with, if you do not want to configure your custom ESLint rules (which is often not the case), 
then you do not need to do the following steps)

Before starting, you should read [the documentation of Vetur](https://vuejs.github.io/vetur/) 
first for the basic setup.

## Linting

Then follow the steps in [the section of linting](https://vuejs.github.io/vetur/linting-error.html#linting)
which basically tells you to

1. Install [ESLint plugin](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint).
2. Turn off Vetur's template validation.
3. npm install `eslint` and `eslint-plugin-vue`.

Now you can add your custom ESLint rules in `.eslintrc`!

(Note that the last step is dependent to project, so you need to do it everytime with all of your Vue.js projects.)

## Formatting

While it is recommended that you use `ESLint plugin` instead of a bundled one in Vetur, 
it's easier to use the bundled Vetur Formatters.

So, instead of installing [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
as a VSCode extension and adding some `"prettier.xxx"` in your settings.json,

we can simply use the formatters that come for free in Vetur.
It will prefer a local `.prettierrc` file so it is possible to configure the bundled prettier in Vetur.

# Some comments

If you just want good code inspection and basic formatting for Vue.js project, 
the easy solution might be installing Vetur and ESLint extensions and configure them.
If you really need a formatter along with a linter, 
then the best bet is to use the bundled formatter to reduce the pain.
