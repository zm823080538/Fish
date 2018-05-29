//
//  ZMUserEditRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMUserEditRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString *nickname; // 昵称
@property (nonatomic, copy) NSString *openid; // 微信openid
@property (nonatomic, copy) NSString *img; // 头像
@property (nonatomic, copy) NSString *sex; // 值为1男性，值为2时是女性，值为0时是未知
@property (nonatomic, copy) NSString *areacode; // areacode地区id
@property (nonatomic, copy) NSString *deviceid; // 设备id
@property (nonatomic, copy) NSString *longitude; // 经度
@property (nonatomic, copy) NSString *latitude; // 纬度
@end
