//
//  ZMGetUserRequest.m
//  Fish
//
//  Created by zhaoming on 2018/6/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetUserRequest.h"

@implementation ZMGetUserRequest
- (NSString *)requestUrl {
    return @"api/user/get";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"id": _id,
             };
}
@end
