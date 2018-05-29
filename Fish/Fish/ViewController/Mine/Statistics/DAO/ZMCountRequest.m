//
//  ZMCountRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCountRequest.h"

@implementation ZMCountRequest
- (NSString *)requestUrl {
    return @"/api/user/count";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid":_tid
             };
}
@end
