//
//  ZMServicetimeSaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMServicetimeSaveRequest.h"

@implementation ZMServicetimeSaveRequest
- (NSString *)requestUrl {
    return @"/api/user/servicetimeSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid":_tid,
             @"starttime":_starttime,
             @"endtime":_endtime,
             @"day1":_day1,
             @"day2":_day2,
             @"day3":_day3,
             @"day4":_day4,
             @"day5":_day5,
             @"day6":_day6,
             @"day7":_day7,
             };
}
@end
