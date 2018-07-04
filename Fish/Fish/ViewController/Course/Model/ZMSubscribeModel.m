//
//  ZMSubscribeModel.m
//  Fish
//
//  Created by zhaoming on 2018/7/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSubscribeModel.h"

@implementation Datelist
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"timelist" : [Timelist class],
             };
}
@end

@implementation Timelist

@end

@implementation ZMSubscribeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"timelist" : [Datelist class],
             };
}
@end
