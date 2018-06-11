//
//  ZMRecFriendRequest.m
//  Fish
//
//  Created by zhaoming on 2018/6/6.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRecFriendRequest.h"

@implementation ZMRecFriendRequest
- (NSString *)requestUrl {
    return @"/api/user/invitelist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id":_id
             };
}
@end
