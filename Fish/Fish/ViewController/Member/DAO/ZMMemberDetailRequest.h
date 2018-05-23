//
//  ZMMemberDetailRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMemberDetailRequest : YTKRequest
@property (nonatomic, copy) NSString * tid;
@property (nonatomic, copy) NSString * uid;

@end
