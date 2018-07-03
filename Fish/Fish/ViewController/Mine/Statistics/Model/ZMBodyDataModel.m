//
//  ZMBodyDataModel.m
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyDataModel.h"

@implementation ZMBodyDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [BodyList class]
             };
}
@end

@implementation BodyList

@end

