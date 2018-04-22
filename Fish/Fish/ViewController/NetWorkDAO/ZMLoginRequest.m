//
//  ZMLoginRequest.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLoginRequest.h"

@implementation ZMLoginRequest {
    NSString *_mobile;
    NSString *_password;
    NSString *_version;
}

- (id)initWithMobile:(NSString *)mobile password:(NSString *)password version:(NSString *)version {
    self = [super init];
    if (self) {
        _mobile = mobile;
        _password = password;
        _version = version;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/user/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"mobile": _mobile,
             @"password": _password,
              @"version": _version,
             };
}


@end
