//
//  ZMSubscribeSaveRequest.m
//  Fish
//
//  Created by sunny on 2018/7/7.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSubscribeSaveRequest.h"

@implementation ZMSubscribeSaveRequest
- (NSString *)requestUrl {
    return @"/api/course/subscribesave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid,
             @"cardid": _cardid,
             @"uid": _uid,
             @"startdate": _startdate,
             @"starttime": _starttime,
             @"address": _address,
             @"longtitude": _longtitude,
             @"latitude": _latitude
             };
}
@end
