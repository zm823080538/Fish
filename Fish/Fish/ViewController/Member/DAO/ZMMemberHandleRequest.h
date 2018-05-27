//
//  ZMMemberHandleRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMemberHandleRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * fid;
@property (nonatomic, copy) NSString * status;

@end
