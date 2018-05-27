//
//  ZMCourseCancelRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseCancelRequest.h"

@implementation ZMCourseCancelRequest
- (NSString *)requestUrl {
    return @"/api/course/cancel";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _id,
             @"tid" :_tid,
             @"cancelreason" :_cancelreason
             };
}
@end
