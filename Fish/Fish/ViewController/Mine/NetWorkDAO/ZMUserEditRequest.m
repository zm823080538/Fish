//
//  ZMUserEditRequest.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMUserEditRequest.h"

@implementation ZMUserEditRequest 

- (NSString *)requestUrl {
    return @"api/user/edit";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"id": _id
             };
}
@end
