---
layout: post
title: "Angular usage"
categories: journal
tags: [angular]
---

1. TOC
{:toc}

# Solve garbled character problem

actually it is an HTML problem.
Just put the
`<meta charset="utf-8" >`
tag into your head tag.

# broadcast and emit

Good article explaining [$scope.broadcast/emit and $rootScope.broadcast/emit](https://toddmotto.com/all-about-angulars-emit-broadcast-on-publish-subscribing/)
To correctly broadcast to as less irrelevant receivers as possible,
  think about the relationship between the two controllers you have,
  and use rootScope when it is the only choice.

