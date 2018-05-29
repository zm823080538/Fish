//
//  ZMServicetimeSaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMServicetimeSaveRequest.h"

@implementation ZMServicetimeSaveRequest
- (NSString *)requestUrl {
    return @"/api/user/servicetimeSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid":_tid,
             @"starttime":_starttime,
             @"endtime":_endtime
             };
}
@end
