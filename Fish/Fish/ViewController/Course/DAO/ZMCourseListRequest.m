//
//  ZMCourseListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseListRequest.h"

@implementation ZMCourseListRequest
- (NSString *)requestUrl {
    return @"/api/course/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    if (IS_COACH) {
        return @{@"tid": _tid,
                 @"status" :_status,
                  @"starttime" :_starttime ?:@""
                 };
    } else {
    return @{@"uid": _uid,
             @"status" :_status,
             @"orderid" :_orderid ?: @"",
              @"starttime" :_starttime ?:@""
             };
    }
}
@end
