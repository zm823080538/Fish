//
//  YTKBaseRequest+ZMAnimatingAccessory.h
//  Fish
//
//  Created by zhaoming on 25/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "YTKBaseRequest.h"
#import <UIKit/UIKit.h>

@interface YTKBaseRequest (ZMAnimatingAccessory) <YTKRequestAccessory>
@property (weak, nonatomic) UIView *animatingView;

@property (strong, nonatomic) NSString *animatingText;

@end
