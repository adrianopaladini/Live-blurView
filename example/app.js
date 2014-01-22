
// Load Module
var blur = require('com.widbook.blur');

// Create a Window
var window = Ti.UI.createWindow();

// Create video for testing real time blur
var video = Titanium.Media.createVideoPlayer({
    autoplay : true,
    mediaControlStyle : Titanium.Media.VIDEO_CONTROL_DEFAULT,
    scalingMode : Titanium.Media.VIDEO_SCALING_MODE_FILL,
    url: 'http://mirrorblender.top-ix.org/peach/bigbuckbunny_movies/big_buck_bunny_480p_h264.mov'
});


// create White view
var blurViewLight = blur.createView({
    top:40,
    height:120,
    width:220,
    borderRadius:20
});

// create black view
var blurViewDark = blur.createView({
    top:200,
    height:120,
    width:220,
    translucentStyleLight:false
});

// create label
var label = Ti.UI.createLabel({
    text:'My label'
});


// Add labels to views
blurViewLight.add(label);

// add video and view to window
window.add(video);
window.add(blurViewLight);
window.add(blurViewDark);

// open window
window.open();





// click on white blur view
blurViewLight.addEventListener('click', function(){
    
    // change to white
    blurViewDark.translucentStyleLight=true;
    
    // create a green color with alpha
    alpha = '55';
    color = '44DD44';
    colorWithAlpha = '#' + alpha + color; // == '#5544DD44'
    
    // change tint of dark view
    blurViewLight.translucentColor = colorWithAlpha;
    
});



