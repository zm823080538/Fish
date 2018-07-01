//
//  ZMStudentSaveRequest.m
//  Fish
//
//  Created by sunny on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMStudentSaveRequest.h"

@implementation ZMStudentSaveRequest
- (NSString *)requestUrl {
    return @"/api/order/studentsave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"tid": _tid,
             @"uid": _uid,
             @"ctype": _ctype,
             @"coursetypeids": _coursetypeids,
             @"csum": _csum,
             @"address":_address,
             };
}
@end
