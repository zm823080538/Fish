//
//  ZMCancelOrderRequest.m
//  Fish
//
//  Created by sunny on 2018/7/11.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCancelOrderRequest.h"

@implementation ZMCancelOrderRequest
- (NSString *)requestUrl {
    return @"/api/order/studentsave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid,
             @"id": _id,
             @"pageNo": _status
             };
}
@end
