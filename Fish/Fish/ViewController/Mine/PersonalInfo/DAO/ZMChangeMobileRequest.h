//
//  ZMChangeMobileRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMChangeMobileRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * code;
@end
