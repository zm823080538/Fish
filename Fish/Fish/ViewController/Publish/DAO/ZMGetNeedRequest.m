//
//  ZMGetNeedRequest.m
//  Fish
//
//  Created by zhaoming on 2018/7/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetNeedRequest.h"

@implementation ZMGetNeedRequest
- (NSString *)requestUrl {
    return @"/api/user/getNeed";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid":_userid
             };
}


@end
