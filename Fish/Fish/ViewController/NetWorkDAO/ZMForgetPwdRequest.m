//
//  ZMForgetPwdRequest.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMForgetPwdRequest.h"

@implementation ZMForgetPwdRequest {
    NSString *_password;
    NSString *_mobile;
    NSString *_code;
}
- (NSString *)requestUrl {
    return @"/api/user/changepsw";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{            
             @"password": _password,
             @"mobile": _mobile,
             @"code": _code,
             };
}
@end
