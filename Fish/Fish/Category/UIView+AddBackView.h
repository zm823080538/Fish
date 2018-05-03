//
//  UIView+AddBackView.h
//  Fish
//
//  Created by sunny on 2018/4/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AddBackView)
- (void)addbackButton:(void(^)(void))click;
- (void)showToastString:(NSString *)string;
- (void)showError:(NSString *)errorDesc;
@end
