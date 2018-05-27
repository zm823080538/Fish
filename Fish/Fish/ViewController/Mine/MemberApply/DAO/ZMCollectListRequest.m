//
//  ZMCollectListRequest.m
//  Fish
//
//  Created by zhaoming on 2018/5/26.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCollectListRequest.h"

@implementation ZMCollectListRequest
- (NSString *)requestUrl {
    return @"api/media/favoritepage";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid":_userid,
             @"pageNo":_pageNo
             };
}
@end
