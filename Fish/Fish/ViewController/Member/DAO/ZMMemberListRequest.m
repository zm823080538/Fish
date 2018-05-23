//
//  ZMMemberListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberListRequest.h"

@implementation ZMMemberListRequest
- (NSString *)requestUrl {
    return @"/api/contact/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _requestId,
             @"status" :_status
             };
}

@end
