//
//  ZMOrderListRequest.h
//  Fish
//
//  Created by sunny on 2018/7/10.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMOrderListRequest : YTKRequest
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * pageNo;

@end
