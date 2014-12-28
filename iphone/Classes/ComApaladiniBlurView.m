/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComApaladiniBlurView.h"
#import "TiUtils.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface ComApaladiniBlurView () {
    ComApaladiniBlurView *parentArea;
    UIBlurEffect *blurEffect;
    UIVisualEffectView *blurEffectView;
    /*
    UIVibrancyEffect *vibrancyEffect;
    UIVisualEffectView *vibrancyEffectView;
     */
    BOOL initComplete;
}
@end

@implementation ComApaladiniBlurView

#pragma mark - Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    parentArea = self;
    return parentArea;
}


- (void) createUI {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {

        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.bounds;

        /*
        vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        vibrancyEffectView.frame = self.bounds;
        [blurEffectView addSubview:vibrancyEffectView];
         */

        [self insertSubview:blurEffectView atIndex:0];

        initComplete=YES;
    }
}

#pragma mark - Configuring a View’s Visual Appearance
- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [blurEffectView setFrame:self.bounds];
}

- (void) setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [blurEffectView setFrame:self.bounds];
}

/*
#pragma mark - Managing the View Hierarchy
- (NSArray *) subviews {
    if (initComplete) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[super subviews]];
        [array removeObject:blurEffectView];
        return (NSArray *)array;
    }
    else {
        return [super subviews];
    }
}

- (void) sendSubviewToBack:(UIView *)view {
    if (initComplete) {
        [super insertSubview:view aboveSubview:blurEffectView];
        return;
    }
    else
        [super sendSubviewToBack:view];
}

- (void) insertSubview:(UIView *)view atIndex:(NSInteger)index {
    if (initComplete) {
        [super insertSubview:view atIndex:(index+1)];
    }
    else
        [super insertSubview:view atIndex:index];

}

- (void) exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
    if (initComplete)
        [super exchangeSubviewAtIndex:(index1+1) withSubviewAtIndex:(index2+1)];
    else
        [super exchangeSubviewAtIndex:(index1) withSubviewAtIndex:(index2)];
}
*/




// Add native view to titanium
-(void)dealloc {
    RELEASE_TO_NIL(square);
    [super dealloc];
}

-(UIView*)square {
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

- (void) setStyle_:(id)value {
    int style = [TiUtils intValue:value];
    UIBlurEffect *fx;
    if(style==0){
        fx = UIBlurEffectStyleDark;
    }else if(style==2){
        fx = UIBlurEffectStyleExtraLight;
    }else{
        fx = UIBlurEffectStyleLight;
    }

    blurEffect = [UIBlurEffect effectWithStyle:fx];

    blurEffectView.removeFromSuperview;
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = parentArea.bounds;
    [parentArea insertSubview:blurEffectView atIndex:0];
}

/*
- (void) setVibrancy_:(id)value {
    BOOL vib = [TiUtils boolValue:value];


    if(visualEffectView!=nil){
        visualEffectView.removeFromSuperview;
    }

    if(vib){
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        visualEffectView.frame = parentArea.bounds;
        [parentArea insertSubview:visualEffectView atIndex:-1];
    }
}
*/


@end
