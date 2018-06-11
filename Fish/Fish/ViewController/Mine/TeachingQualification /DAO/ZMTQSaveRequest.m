//
//  ZMTQSaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/30.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMTQSaveRequest.h"

@implementation ZMTQSaveRequest
- (NSString *)requestUrl {
    return @"/api/user/teachingQualificationSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid": _userid,
             @"workdate" :_workdate,
             @"skillname" :_skillname,
             @"photopath" :_photopath,
             };
}
@end
