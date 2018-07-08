//
//  ZMStudentSave1Request.m
//  Fish
//
//  Created by sunny on 2018/7/8.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMStudentSave1Request.h"

@implementation ZMStudentSave1Request
- (NSString *)requestUrl {
    return @"/api/order/studentsave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid": _tid,
             @"uid": _uid,
             @"tryflag": _tryflag
             };
}
@end
