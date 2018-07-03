//
//  ZMGetAllLessonRequest.m
//  Fish
//
//  Created by zhaoming on 2018/7/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetAllLessonRequest.h"

@implementation ZMGetAllLessonRequest
- (NSString *)requestUrl {
    return @"/api/course/getcoursetypestags";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
