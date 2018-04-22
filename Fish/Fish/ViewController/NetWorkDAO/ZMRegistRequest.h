//
//  ZMRegistRequest.h
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMRegistRequest : YTKRequest
@property (nonatomic, copy) NSString * regtype;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * role;
@end
