//
//  ZMMemberApplyListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberApplyListRequest.h"

@implementation ZMMemberApplyListRequest
- (NSString *)requestUrl {
    return @"/api/order/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid":_tid,
             @"status":_status,
             @"pageNo":_pageNo
             };
}
@end
