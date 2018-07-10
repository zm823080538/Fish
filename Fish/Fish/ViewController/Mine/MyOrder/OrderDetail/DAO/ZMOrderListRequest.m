//
//  ZMOrderListRequest.m
//  Fish
//
//  Created by sunny on 2018/7/10.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderListRequest.h"

@implementation ZMOrderListRequest
- (NSString *)requestUrl {
    return @"/api/order/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid,
             @"status": _status,
             @"pageNo": _pageNo
             };
}
@end
