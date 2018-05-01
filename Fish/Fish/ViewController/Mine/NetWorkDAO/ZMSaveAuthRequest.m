//
//  ZMSaveAuthRequest.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMSaveAuthRequest.h"

@implementation ZMSaveAuthRequest
- (NSString *)requestUrl {
    return @"api/user/saveauth";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
