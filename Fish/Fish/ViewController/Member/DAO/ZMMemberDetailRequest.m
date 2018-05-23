//
//  ZMMemberDetailRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberDetailRequest.h"

@implementation ZMMemberDetailRequest
- (NSString *)requestUrl {
    return @"/api/contact/studentDetail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid": _tid,
             @"uid" :_uid
             };
}
@end
