//
//  ZMCourseDetailRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseDetailRequest.h"

@implementation ZMCourseDetailRequest
- (NSString *)requestUrl {
    return @"/api/course/get";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid": _tid,
             @"id" :_id
             };
}
@end
