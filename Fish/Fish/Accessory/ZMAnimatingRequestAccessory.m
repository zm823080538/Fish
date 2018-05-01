//
//  ZMAnimatingRequestAccessory.m
//  Fish
//
//  Created by zhaoming on 25/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMAnimatingRequestAccessory.h"
#import <MBProgressHUD.h>

@interface ZMAnimatingRequestAccessory () {
    MBProgressHUD *_hud;
}

@end

@implementation ZMAnimatingRequestAccessory
- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: show loading
            _hud = [MBProgressHUD showHUDAddedTo:self.animatingView animated:YES];
            _hud.label.text = self.animatingText;
            [_hud showAnimated:YES];
            NSLog(@" loading start");
        });
    }
}

- (void)requestWillStop:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_hud hideAnimated:YES afterDelay:0.5f];
            // TODO: hide loading
            //[YTKAlertUtils hideLoadingAlertView:_animatingView];
            NSLog(@" loading finished");
        });
    }
}

@end
