---
layout: post
title: "No 'Access-Control-Allow-Origin' header error triggered accidentally when using format_suffix_patterns in Django REST framework"
tags: [Django]
---

After I set up my Django backend with [django-cors-headers](https://github.com/ottoyiu/django-cors-headers),
I tried to access the api endpoint at `http://127.0.0.1:8000/api` 
from the front-end (which is served from http://localhost:8080)
by a `GET` request.

However, in the console of the browser, the typical CORS error was thrown like this:

```
Access to XMLHttpRequest at 'http://127.0.0.1:8000/api' from origin 'http://localhost:8080' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

However, I'm pretty sure that my setup of CORS on the backend side is correct, 
and I did not find any useful solution to my problem.

Finally, I figured out that, since I used `format_suffix_patterns` for my `urlpatterns`,
a call to `http://127.0.0.1:8000/api` will result in `GET`ting the rendered `html` page.

Therefore, by changing the query to `GET http://127.0.0.1:8000/api.json` 
the haunting CORS problem is gone.
