//
//  ZMPublishSaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/7/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPublishSaveRequest.h"


@implementation ZMPublishSaveRequest
- (NSString *)requestUrl {
    return @"/api/user/publishNeed";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid":_userid,
             @"coursetypeids":_coursetypeids,
             @"areacode":_areacode,
             @"csum":_csum,
             @"detail":_detail,
             @"detailimg":_detailimg
             };
}

@end
