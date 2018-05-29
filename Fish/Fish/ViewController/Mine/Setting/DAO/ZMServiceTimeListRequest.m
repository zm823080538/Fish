//
//  ZMServiceTimeListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMServiceTimeListRequest.h"

@implementation ZMServiceTimeListRequest
- (NSString *)requestUrl {
    return @"/api/user/servicetimeList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid":_tid};
}
@end
