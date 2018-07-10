//
//  ZMGetTagsRequest.m
//  Fish
//
//  Created by sunny on 2018/7/10.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGetTagsRequest.h"

@implementation ZMGetTagsRequest
- (NSString *)requestUrl {
    return @"/api/course/gettags";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"uid": _uid             
             };
}
@end
