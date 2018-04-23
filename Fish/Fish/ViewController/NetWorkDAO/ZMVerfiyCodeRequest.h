//
//  ZMVerfiyCodeRequest.h
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMVerfiyCodeRequest : YTKRequest
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * type;
@end
