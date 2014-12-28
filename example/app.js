
// Load Module
var blur = require('com.apaladini.blur');

// Create a Window
var window = Ti.UI.createWindow();

// Create video for testing real time blur
var video = Titanium.Media.createVideoPlayer({
    autoplay : true,
    mediaControlStyle : Titanium.Media.VIDEO_CONTROL_DEFAULT,
    scalingMode : Titanium.Media.VIDEO_SCALING_MODE_FILL,
    url: 'http://mirrorblender.top-ix.org/peach/bigbuckbunny_movies/BigBuckBunny_640x360.m4v'
});


// create White view
var blurViewLight = blur.createView({
    top:0,
    height:100,
    width:Ti.UI.FILL,
    style:1
});

// create black view
var blurViewDark = blur.createView({
    top:100,
    height:100,
    width:Ti.UI.FILL,
    style:0
});

// create extraLight view
var blurViewExtraLight = blur.createView({
    top:200,
    height:100,
    width:Ti.UI.FILL,
    style:2
});

// create labels
var label1 = Ti.UI.createLabel({
    text:'Light'
});
var label2 = Ti.UI.createLabel({
    text:'Dark',
    color:'#FFF'
});
var label3 = Ti.UI.createLabel({
    text:'Extra Light'
});


// Add labels to views
blurViewLight.add(label1);
blurViewDark.add(label2);
blurViewExtraLight.add(label3);

// add video and view to window
window.add(video);
window.add(blurViewLight);
window.add(blurViewDark);
window.add(blurViewExtraLight);

// open window
window.open();
