//
//  ZMBaseAlertView.h
//  Fish
//
//  Created by sunny on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ZMAlertViewType) {
    ZMAlertViewTypeAlert = 0,
    ZMAlertViewTypeActionSheet = 1
};

@interface ZMBaseActionSheetView : UIView
+ (ZMBaseActionSheetView *)alertWithContainerView:(UIView *)containerView type:(ZMAlertViewType)type;
- (void)show;
- (void)hidden;
@end
