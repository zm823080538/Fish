//
//  UIView+AddBackView.m
//  Fish
//
//  Created by sunny on 2018/4/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "UIView+AddBackView.h"
#import <MBProgressHUD.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIView (AddBackView)
- (void)addbackButton:(void (^)(void))click {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 73)];
    topView.backgroundColor = [UIColor clearColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 31, 24, 24);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (click) {
            click();
        }
    }];
    [self addSubview:topView];
    [topView addSubview:backButton];
}

- (void)showToastString:(NSString *)string {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.label.text = string;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0f];
}

- (void)showError:(NSString *)errorDesc {
    
}
@end
