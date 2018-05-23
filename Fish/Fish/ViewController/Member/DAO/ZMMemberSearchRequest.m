//
//  ZMMemberSearchRequest.m
//  Fish
//
//  Created by sunny on 2018/5/22.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberSearchRequest.h"

@implementation ZMMemberSearchRequest
- (NSString *)requestUrl {
    return @"/api/contact/search";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
