//
//  ZMMemberHandleRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberHandleRequest.h"

@implementation ZMMemberHandleRequest
- (NSString *)requestUrl {
    return @"/api/contact/handle";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _id,
             @"fid" :_fid,
             @"status" :_status,
             };
}
@end
