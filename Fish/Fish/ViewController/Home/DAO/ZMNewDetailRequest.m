//
//  ZMNewDetailRequest.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMNewDetailRequest.h"

@implementation ZMNewDetailRequest
- (NSString *)requestUrl {
    return @"/h5/news/detail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
