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
    return @{@"tid": _tid,
             @"status" :_status
             };
}
@end