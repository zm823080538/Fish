//
//  ZMForgetPwdRequest.h
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface ZMForgetPwdRequest : YTKBaseRequest
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * code;
@end
