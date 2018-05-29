//
//  ZMApplySaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/30.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMApplySaveRequest.h"


@implementation ZMApplySaveRequest
- (NSString *)requestUrl {
    return @"/api/order/save";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id":_id,
             @"tid":_tid,
             @"status":_status,
             };
}
@end
