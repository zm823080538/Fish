//
//  ZMAnimatingRequestAccessory.h
//  Fish
//
//  Created by zhaoming on 25/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YTKBaseRequest.h>
@interface ZMAnimatingRequestAccessory : NSObject <YTKRequestAccessory>
@property(nonatomic, weak) UIView *animatingView;

@property(nonatomic, strong) NSString *animatingText;

- (id)initWithAnimatingView:(UIView *)animatingView;

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;

+ (id)accessoryWithAnimatingView:(UIView *)animatingView;

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;
@end
