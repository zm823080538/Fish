//
//  ZMMsgListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMsgListRequest.h"


@implementation ZMMsgListRequest
- (NSString *)requestUrl {
    return @"api/user/msgList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id":_id,
             @"pageNo":_pageNo
             };
}
@end
