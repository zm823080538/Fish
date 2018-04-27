//
//  ZMGetAuthRequest.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMGetAuthRequest.h"

@implementation ZMGetAuthRequest
- (NSString *)requestUrl {
    return @"api/user/getauth";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": _userid
             };
}

@end
