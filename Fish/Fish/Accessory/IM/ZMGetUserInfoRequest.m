//
//  ZMGetUserInfoRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetUserInfoRequest.h"

@implementation ZMGetUserInfoRequest
- (NSString *)requestUrl {
    return @"api/user/get";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id":_id};
}
@end
