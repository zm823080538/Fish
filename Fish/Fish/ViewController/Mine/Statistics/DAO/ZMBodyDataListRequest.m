//
//  ZMBodyDataListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyDataListRequest.h"

@implementation ZMBodyDataListRequest
- (NSString *)requestUrl {
    return @"/api/user/bodydataList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid":_userid
             };
}
@end
