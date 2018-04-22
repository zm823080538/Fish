//
//  ZMLoginRequest.h
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMLoginRequest : YTKRequest
- (id)initWithMobile:(NSString *)mobile password:(NSString *)password version:(NSString *)version;
@end
