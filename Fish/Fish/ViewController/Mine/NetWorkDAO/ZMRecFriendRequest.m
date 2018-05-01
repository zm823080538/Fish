//
//  ZMRecFriendRequest.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMRecFriendRequest.h"

@implementation ZMRecFriendRequest

- (NSString *)requestUrl {
    return @"api/user/promotionSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": _userid,
             @"friendsname": _friendsname,
             @"friendsmoblie": _friendsmoblie,
             };
}

@end
