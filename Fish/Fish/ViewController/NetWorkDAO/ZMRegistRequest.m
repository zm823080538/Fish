//
//  ZMRegistRequest.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRegistRequest.h"

@implementation ZMRegistRequest {
    NSString *_regtype;
    NSString *_password;
    NSString *_mobile;
    NSString *_code;
    NSString *_role;
}
- (NSString *)requestUrl {
    return @"/api/user/reg";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"regtype": _regtype,
             @"password": _password,
             @"mobile": _mobile,
             @"code": _code,
             @"role": _role,
             };
}
//regtype;
//@property (nonatomic, copy) NSString * password;
//@property (nonatomic, copy) NSString * mobile;
//@property (nonatomic, copy) NSString * code;
//@property (nonatomic, copy) NSString * role;
@end
