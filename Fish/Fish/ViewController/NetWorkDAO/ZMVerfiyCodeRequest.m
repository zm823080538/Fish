//
//  ZMVerfiyCodeRequest.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMVerfiyCodeRequest.h"

@implementation ZMVerfiyCodeRequest {
    NSString *_type;    
    NSString *_mobile;
}

- (NSString *)requestUrl {
    return @"api/sms/get";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"type": _type,
             @"mobile": _mobile,
             };
}
@end
