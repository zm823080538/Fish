//
//  ZMCancelOrderRequest.h
//  Fish
//
//  Created by sunny on 2018/7/11.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMCancelOrderRequest : YTKRequest
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * status;

@end
