//
//  ZMChangeMobileRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMChangeMobileRequest.h"


@implementation ZMChangeMobileRequest
- (NSString *)requestUrl {
    return @"/api/user/changemobile";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"id": _id,
             @"mobile": _mobile,
             @"code": _code
             };
}
@end
