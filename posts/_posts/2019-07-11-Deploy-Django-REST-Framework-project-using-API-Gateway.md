---
layout: post
title: "Deploy Django REST Framework project using API Gateway"
tags: [Django]
---

1. TOC
{:toc}

# Set up API Gateway

It is easy to wrap an existing API with API Gateway to hide the host and support HTTPS.
I followed the [official tutorial](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-http.html)
and set up my API.

To be specific, assume my DRF (Django REST Framework) project is served at `my.server.host:12345`. 
I created an `ANY` method with `Integration type` of `HTTP Proxy` and 
`Endpoint URL` of `http://aoba.chara.moe:39429/{proxy}`. 
Then I save the setup and deploy the API 
(it is very important to deploy API everytime you do any edition!).

# CORS error?

Having API Gateway set up, I attempted to call the API from my front-end website,
with the following `403` response.

```
Failed to load resource: the server responded with a status of 403 ()

Access to XMLHttpRequest at 'https://[API_ID].execute-api.ap-northeast-1.amazonaws.com/[API_ROUTE]' (redirected from 'https://[API_ID].execute-api.ap-northeast-1.amazonaws.com/[API_STAGE]/[API_ROUTE]') from origin 'https://my.front-end.com' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

The error message seemed to be a CORS error. 
However, I already set up CORS in my DRF project using [django-cors-headers](https://github.com/ottoyiu/django-cors-headers),
and direct access to the API did not cause any CORS error.

# Solution

It turned out that API Gateway will ignore the trailing slash of all incoming request (see [this thread](https://forums.aws.amazon.com/thread.jspa?messageID=749625)),



