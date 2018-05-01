//
//  YTKBaseRequest+ZMAnimatingAccessory.m
//  Fish
//
//  Created by zhaoming on 25/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "YTKBaseRequest+ZMAnimatingAccessory.h"
#import "ZMAnimatingRequestAccessory.h"
#import <MBProgressHUD/MBProgressHUD.h>


@implementation YTKBaseRequest (ZMAnimatingAccessory)

- (ZMAnimatingRequestAccessory *)animatingRequestAccessory {
    for (id accessory in self.requestAccessories) {
        if ([accessory isKindOfClass:[ZMAnimatingRequestAccessory class]]){
            return accessory;
        }
    }
    return nil;
}

- (UIView *)animatingView {
    return self.animatingRequestAccessory.animatingView;
}

- (void)setAnimatingView:(UIView *)animatingView {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[ZMAnimatingRequestAccessory accessoryWithAnimatingView:animatingView animatingText:nil]];
    } else {
        self.animatingRequestAccessory.animatingView = animatingView;
    }
}

- (void)setAnimatingText:(NSString *)animatingText {
    if (!self.animatingRequestAccessory) {
        [self addAccessory:[ZMAnimatingRequestAccessory accessoryWithAnimatingView:nil animatingText:animatingText]];
    } else {
        self.animatingRequestAccessory.animatingText = animatingText;
    }
}

- (NSString *)animatingText {
    return self.animatingRequestAccessory.animatingText;
}

@end
