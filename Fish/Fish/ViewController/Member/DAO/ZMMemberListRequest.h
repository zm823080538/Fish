//
//  ZMMemberListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMemberListRequest : YTKRequest
@property (nonatomic, copy) NSString * requestId;
/**
 状态1关注2黑名单3已接单
 */
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * condition;

@end
