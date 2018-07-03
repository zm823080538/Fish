//
//  ZMSubscribeLessonRequest.m
//  Fish
//
//  Created by sunny on 2018/7/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSubscribeLessonRequest.h"

@implementation ZMSubscribeLessonRequest
- (NSString *)requestUrl {
    return @"/api/course/subscribepage";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid,
             @"cardid": _cardid
             };
}
@end
