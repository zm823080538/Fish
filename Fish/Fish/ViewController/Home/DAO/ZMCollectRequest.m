//
//  ZMCollectRequest.m
//  Fish
//
//  Created by sunny on 2018/5/22.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCollectRequest.h"

@implementation ZMCollectRequest
- (NSString *)requestUrl {
    return @"api/media/useraction";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
   return @{@"id":_id,
      @"userid":_userid,
      @"action":_action
      };
}
@end
