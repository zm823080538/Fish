//
//  ZMGetPromotionRequest.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMGetPromotionRequest.h"

@implementation ZMGetPromotionRequest
- (NSString *)requestUrl {
    return @"api/user/getPromotion";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": _userid
             };
}
@end
