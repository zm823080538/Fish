//
//  ZMHistoryOrderListRequest.m
//  Fish
//
//  Created by sunny on 2018/6/30.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMHistoryOrderListRequest.h"

@implementation ZMHistoryOrderListRequest
- (NSString *)requestUrl {
    return @"/api/course/cardlist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid
             };
}
@end
