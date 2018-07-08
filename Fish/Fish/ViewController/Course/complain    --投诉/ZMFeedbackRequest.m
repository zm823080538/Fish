//
//  ZMFeedbackRequest.m
//  Fish
//
//  Created by sunny on 2018/7/8.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMFeedbackRequest.h"

@implementation ZMFeedbackRequest
- (NSString *)requestUrl {
    return @"/api/user/feedback";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid": _userid,
             @"content": _content,
             @"pic1": _pic1,
             @"type": _type
             };
}
@end
