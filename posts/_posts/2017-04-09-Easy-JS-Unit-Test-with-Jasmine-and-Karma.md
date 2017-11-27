---
layout: post
title: "Easy JS Unit Test with Jasmine and Karma"
tags: [Jasmine,Karma]
---

Jasmine is the testing framework. Karma is the test runner.
 Working with them when writing unit tests is... cool.

1. TOC
{:toc}

# [Karma](https://karma-runner.github.io/1.0/index.html)

[Install Karma](http://karma-runner.github.io/1.0/intro/installation.html)
and [How to use Karma](https://karma-runner.github.io/latest/config/configuration-file.html)

In [Angular guide for unit-testing](https://docs.angularjs.org/guide/unit-testing), Karma is a JavaScript command line tool that can be used to spawn a web server which loads your application's source code and executes your tests. And Jasmine is a behavior driven development framework for JavaScript that has become the most popular choice for testing AngularJS applications. Here is [Introduction for Jasmine](https://jasmine.github.io/1.3/introduction.html)

The describe function is for grouping related specs. Specs are defined by calling the global Jasmine function it, which, like describe takes a string and a function. Suites and specs can be disabled with the xdescribe and xit functions, respectively. 


As the name implies the **beforeEach** function is called once before each spec in the describe is run and the afterEach function is called once after each spec. 


In chapter "Testing a Controller" of [Angular Unit Test Developer Guide](https://docs.angularjs.org/guide/unit-testing), it provides a great example.

It is possible to [Mock Services](http://www.bradoncode.com/blog/2015/06/11/unit-testing-code-that-uses-timeout-angularjs/) by mocking inject or using $injector.

## Single Run

Everytime I start Karma and fails, and edit the spec files, 
the Karma would shout at me "your files have done a complete reload!"

It's really annoying (perhaps there are other solutions), so I decided to run with

`karma start --single-run`

# Jasmine 

##[Focused Specs](https://jasmine.github.io/2.1/focused_specs.html)

Putting f in front of your `it`s or `describe`s, and start your Karma.
 Only the one you prefixed with `f` will run. 
 
## log in test

To log into console when using Jasmine, [use console.log directly.](http://stackoverflow.com/questions/35711329/how-to-log-values-in-jasmine)
 
# Play Karma in WebStorm 
 
 Install Karma Plugin in WebStorm, and you can now configure that 
 ^R will run the spec code in Karma.
 
 If you would like to prefix `f` to your suite, it will just function as handy 
 as any other Unit Test framework for Python or Ruby.
 
# JetBrains IDE Debugger and Chrome 

To run in debug mode, install JetBrains IDE Support Plugin in Chrome, and 
configure the IDE Connection Host and Port according to what your IDE says.

# Angular Controller testing 

Some points need attention:

- In karma.conf, put controller code's pass.

- To test a function from outside (Jasmine), the function should be defined in $scope. Normal function (can be thought as private?) is not available for testing.

- To make a validation function testable, the error message (exception object) should be return.

## Example 
```javascript
    function save() { ... }
```
can be change to 
```
    $scope.save = function () {
      var error = ErrorDialog.validate([
	  ...
	  if (error) {
        return error;
	  }
	}
```

after that
```javascript
      var controller = $controller('MyCtrller', {
		// inject services
      });

      var error = $scope.save();
      expect(error).toBeDefined();
      expect(error.code).toEqual('W11');
```

But some people insist that this is a pollution of namespace. The `self.` style should be used instead.

## Should I check if $scope.save is defined?

Not a bad idea but not necessary. After the controller is successfully initiated, $scope.save is defined naturally (unless you mistake the function's name!).

## Doing same job when testing similar controller?

It may be a good idea to extract duplicated codes into a js file just aside the controller testers. After you define functions there, it can be used to other controller testers.

for example, I would like to initialize $scope attributes before every testing, so I may put function

```javascript
function addAttr(obj, attributes) {
  for (var attr in attributes) {
    obj[attr] = attributes[attr];
  }
}
```

to a separate js file on the same directory of controller testers.

