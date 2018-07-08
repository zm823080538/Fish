//
//  ZMOrderDetailRequest.m
//  Fish
//
//  Created by sunny on 2018/7/8.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderDetailRequest.h"

@implementation ZMOrderDetailRequest
- (NSString *)requestUrl {
    return @"/api/order/detail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _id,
             @"uid": _uid
             };
}
@end
