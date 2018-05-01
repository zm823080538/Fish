//
//  ZMSaveAuthRequest.h
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface ZMSaveAuthRequest : YTKBaseRequest
@property (nonatomic, copy) NSString * id;        //id 不为空表示修改,否则为新建
@property (nonatomic, copy) NSString * userid;        // 会员id
@property (nonatomic, copy) NSString * realname;        // 真实姓名
@property (nonatomic, copy) NSString * idnumber;        // 身份证号码
@property (nonatomic, copy) NSString * idimgpath;        // 身份证图片
@property (nonatomic, copy) NSString * idimgbackpath;        // 身份证图片背面
@property (nonatomic, copy) NSString * certpath;        // 证书地址  注：前期选填，后期必填
@property (nonatomic, copy) NSString * photopath;        // 从业证明（工牌、形象照） 注：必填
@property (nonatomic, copy) NSString * workdate;        // 工作时间 请传时间字符串例如'2018-02-01'
@property (nonatomic, copy) NSString * areaid;        // 地区id
@end
