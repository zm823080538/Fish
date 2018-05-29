//
//  ZMUserEditRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMUserEditRequest.h"


@implementation ZMUserEditRequest
- (NSString *)requestUrl {
    return @"api/user/edit";
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
