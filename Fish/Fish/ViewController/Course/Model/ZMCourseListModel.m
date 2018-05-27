//
//  ZMCourseListModel.m
//  Fish
//
//  Created by zhaoming on 2018/5/25.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseListModel.h"

@implementation ZMCourseListItem

@end
@implementation ZMCourseListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ZMCourseListItem class],
            };
}
@end
