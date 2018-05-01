//
//  ZMRealNameRequest.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRealNameRequest.h"
#import "ZMUpLoadRequest.h"

@implementation ZMRealNameRequest {
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
    return @"api/user/saveauth";
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
