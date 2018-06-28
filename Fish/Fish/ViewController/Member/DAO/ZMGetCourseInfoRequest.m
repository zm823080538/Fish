//
//  ZMGetCourseInfoRequest.m
//  Fish
//
//  Created by sunny on 2018/6/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetCourseInfoRequest.h"

@implementation ZMGetCourseInfoRequest
- (NSString *)requestUrl {
    return @"/api/order/getcourseinfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid": _tid};
}
@end
