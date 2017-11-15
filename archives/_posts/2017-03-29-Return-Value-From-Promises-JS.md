---
layout: post
title: "Return Value From Promises (JS)"
categories: journal
tags: [JS, promise]
image:
  feature: .jpg
  teaser: .jpg
  credit:
  creditlink:
---

{:toc}


var video = {id: 1};

var p = Promise.resolve(['good','bad','worst']);
p.then(function(v) {
  console.log(video); // name == null
  video.name = v[0];  
  console.log(video);// name == 'good'
});
setTimeout(function(){
console.log(video);  // name == 'good'
}, 0)
console.log(video);  // name == null
