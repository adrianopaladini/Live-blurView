/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

/*
 // Thanks:
 //  https://github.com/ivoleko/ILTranslucentView
 //  Created by Ivo Leko on 10/11/13.
 //  Copyright (c) 2013 Ivo Leko. All rights reserved.
*/

#import "ComWidbookBlurView.h"
#import "TiUtils.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface ComWidbookBlurView () {
    UIView *nonexistentSubview; //this is first child view of ILTranslucentView. It is not available trough "Managing the View Hierarchy" methods.
    UIView *toolbarContainerClipView; //view which contain UIToolbar as child subview
    UIToolbar *toolBarBG; //this is empty toolbar which we use to produce blur (translucent) effect
    UIView *overlayBackgroundView; //view over toolbar that is responsive to backgroundColor property
    BOOL initComplete;
}


@end


@implementation ComWidbookBlurView

#pragma mark - Initalization
- (id)initWithFrame:(CGRect)frame //code
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder { //XIB
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void) createUI {
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        // creating nonexistentSubview
        nonexistentSubview = [[UIView alloc] initWithFrame:self.bounds];
        nonexistentSubview.backgroundColor=[UIColor clearColor];
        nonexistentSubview.clipsToBounds=YES;
        nonexistentSubview.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self insertSubview:nonexistentSubview atIndex:0];
        
        //creating toolbarContainerClipView
        toolbarContainerClipView = [[UIView alloc] initWithFrame:self.bounds];
        toolbarContainerClipView.backgroundColor=[UIColor clearColor];
        toolbarContainerClipView.clipsToBounds=YES;
        toolbarContainerClipView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [nonexistentSubview addSubview:toolbarContainerClipView];
        
        //creating toolBarBG
        //we must clip 1px line on the top of toolbar
        CGRect rect= self.bounds;
        rect.origin.y-=1;
        rect.size.height+=1;
        toolBarBG =[[UIToolbar alloc] initWithFrame:rect];
        toolBarBG.frame=rect;
        toolBarBG.autoresizingMask= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toolBarBG.translucent=YES;
        [toolbarContainerClipView addSubview:toolBarBG];
        
        
        
        
        //view above toolbar, great for changing blur color effect
        overlayBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        overlayBackgroundView.backgroundColor = [UIColor clearColor];
        overlayBackgroundView.autoresizingMask= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [toolbarContainerClipView addSubview:overlayBackgroundView];
        
        
        [self setBackgroundColor:[UIColor clearColor]]; //view must be transparent :)
        initComplete=YES;
    }
    
}

#pragma mark - Configuring a View’s Visual Appearance



- (void) setFrame:(CGRect)frame {
    
    
    //     - Setting frame of view -
    // UIToolbar's frame is not great at animating. It produces lot of glitches.
    // Because of that, we never actually reduce size of toolbar"
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        CGRect rect = frame;
        rect.origin.x=0;
        rect.origin.y=0;
        
        if (toolbarContainerClipView.frame.size.width>rect.size.width) {
            rect.size.width=toolbarContainerClipView.frame.size.width;
        }
        if (toolbarContainerClipView.frame.size.height>rect.size.height) {
            rect.size.height=toolbarContainerClipView.frame.size.height;
        }
        
        toolbarContainerClipView.frame=rect;
        
        [super setFrame:frame];
        [nonexistentSubview setFrame:self.bounds];
    }
    else
        [super setFrame:frame];
}

- (void) setBounds:(CGRect)bounds {
    
    //     - Setting bounds of view -
    // UIToolbar's bounds is not great at animating. It produces lot of glitches.
    // Because of that, we never actually reduce size of toolbar"
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        CGRect rect = bounds;
        rect.origin.x=0;
        rect.origin.y=0;
        
        if (toolbarContainerClipView.bounds.size.width>rect.size.width) {
            rect.size.width=toolbarContainerClipView.bounds.size.width;
        }
        if (toolbarContainerClipView.bounds.size.height>rect.size.height) {
            rect.size.height=toolbarContainerClipView.bounds.size.height;
        }
        
        toolbarContainerClipView.bounds=rect;
        [super setBounds:bounds];
        [nonexistentSubview setFrame:self.bounds];
    }
    else
        [super setBounds:bounds];
    
}



#pragma mark - Managing the View Hierarchy

- (NSArray *) subviews {
    
    // must exclude nonexistentSubview
    
    if (initComplete) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[super subviews]];
        [array removeObject:nonexistentSubview];
        return (NSArray *)array;
    }
    else {
        return [super subviews];
    }
    
}

- (void) sendSubviewToBack:(UIView *)view {
    
    // must exclude nonexistentSubview
    
    if (initComplete) {
        [self insertSubview:view aboveSubview:toolbarContainerClipView];
        return;
    }
    else
        [super sendSubviewToBack:view];
}

- (void) insertSubview:(UIView *)view atIndex:(NSInteger)index {
    
    // must exclude nonexistentSubview
    
    if (initComplete) {
        [super insertSubview:view atIndex:(index+1)];
    }
    else
        [super insertSubview:view atIndex:index];
    
}

- (void) exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
    
    // must exclude nonexistentSubview
    
    if (initComplete)
        [super exchangeSubviewAtIndex:(index1+1) withSubviewAtIndex:(index2+1)];
    else
        [super exchangeSubviewAtIndex:(index1) withSubviewAtIndex:(index2)];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
    // Drawing code
 }
 */





// Add native view to titanium
-(void)dealloc {
    RELEASE_TO_NIL(square);
    [super dealloc];
}

-(UIView*)square {
    NSLog(@"[INFO] square");
    if (square==nil){
        square = [[UIView alloc] initWithFrame:[self frame]];
        [self addSubview:square];
    }
    return square;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds {
    if (square!=nil) {
        [TiUtils setView:square positionRect:bounds];
    }
}








// Titanium functions


- (void) setTranslucentStyleLight_:(id)value {
    BOOL *translucentStyleLight = [TiUtils boolValue:value];
    if(translucentStyleLight){
        toolBarBG.barStyle = UIBarStyleDefault;
    } else {
        toolBarBG.barStyle = UIBarStyleBlack;
    }
}

- (void) setTranslucentTintColor_:(id)value {
    UIColor *translucentTintColor = [UIColor clearColor];
    if(value!=NULL){
        translucentTintColor = [[TiUtils colorValue:value] _color];
    }
    [toolBarBG setBarTintColor:translucentTintColor];
}

- (void) setTranslucentColor_:(id)value {
    UIColor *color = [[TiUtils colorValue:value] _color];
    overlayBackgroundView.backgroundColor = color;
}



@end

