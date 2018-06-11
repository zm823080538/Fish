//
//  ZMUserEditRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMUserEditRequest.h"


@implementation ZMUserEditRequest
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type":@"application/x-www-form-urlencoded"};
}

- (NSString *)requestUrl {
    return @"api/user/edit";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"id": _id,
             @"nickname": _nickname,
             @"areacode": _areacode,
             @"img": _img,
             @"alipay":_alipay,
             @"sex":_sex
             };
}

@end
