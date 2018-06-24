//
//  ZMBaseAlertView.m
//  Fish
//
//  Created by sunny on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseActionSheetView.h"

@interface ZMBaseActionSheetView ()
@property (nonatomic) ZMAlertViewType type;
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIButton * bgButton;

@end

@implementation ZMBaseActionSheetView

+ (ZMBaseActionSheetView *)alertWithContainerView:(UIView *)containerView type:(ZMAlertViewType)type {
    
    
    ZMBaseActionSheetView *alertView = [ZMBaseActionSheetView new];
    alertView.containerView = containerView;
    alertView.type = type;
    return alertView;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.bgButton.frame = window.bounds;
    [window addSubview:self.bgButton];
    if (self.type == ZMAlertViewTypeAlert) {
        [UIView animateWithDuration:0.3f delay:0.1f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
    }
}

- (void)hidden {
    
}


@end
