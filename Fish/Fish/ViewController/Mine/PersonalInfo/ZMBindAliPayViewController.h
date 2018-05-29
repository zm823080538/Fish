//
//  ZMBindAliPayViewController.h
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBindAliPayViewController : UIViewController
@property(nonatomic,copy) void(^block)(NSString *inputString);
@property (nonatomic, copy) NSString * content;

@end
