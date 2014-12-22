# LiveBlur Module
Require iOS 8.1 and Titanium SDK 3.4.1.

## Description

#### This module is a view with the real time blur effect. Compatible only with iOS 8.1.

![Blur View preview on movie](blur-preview.png)
##### View with blur effect on top of video to see in real time.


Apple on iOS 7 put some screens on the system with the blur effect like Control or Notification Center. It's a nice effect and many people want to do the same in their applications, and has asked to Appcelerator, which put this feature in titanium.

Many modules are to capture the screen, apply the effect on the image and display it, but it is very expensive for the hardware and does not give the effect in real time.

Now in iOS 8.1 Apple release a API to use this effect.

This module use a native and public API from Apple to create a blur view.

This module can be published in Apple Store.

This module is ready for 64-bit support.


### Get the module

**You can download the version already compiled on dist folder**


## Accessing the LiveBlur Module

To access this module from JavaScript, you would do the following:

```javascript
var blur = require("com.apaladini.blur");
```

The blur variable is a reference to the Module object.

## Functions

### createView

Simple, create a view with (almost) all the properties of the native view of Titanium. Just do not have the 'backgroundColor' properties and 'backgroundImage'.

```javascript
var myView = blur.createView();
```

## Properties

This view has its own properties


### style

*Integer*, **0** (default) for Light, **1** for Dark and **2** for ExtraLight

```javascript
var myView = blur.createView({
	style:1
});
```

or

```javascript
myView.style = 1;
```



## This is a module that I'm still working to improve it


## Author

Adriano Paladini
