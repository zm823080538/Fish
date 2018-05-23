//
//  ZMMemberSearchRequest.h
//  Fish
//
//  Created by sunny on 2018/5/22.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMemberSearchRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * no;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * skillids;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSString * latitude;

@end
