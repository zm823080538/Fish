//
//  ZMNewsListRequest.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMNewsListRequest.h"

@implementation ZMNewsListRequest

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type":@"application/x-www-form-urlencoded"};
}

- (NSString *)requestUrl {
    return @"/api/news/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"type": _type,
             @"userid":_userid
             };
}

@end
