//
//  ZMSubscribeLessonModel.m
//  Fish
//
//  Created by sunny on 2018/7/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSubscribeLessonModel.h"

@implementation Datelist
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"timelist" : [Timelist class],
             };
}
@end
@implementation Timelist

@end
@implementation ZMSubscribeLessonModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"timelist" : [Datelist class],
             };
}
@end
