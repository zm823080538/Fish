//
//  ZMMsgListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMsgListRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * pageNo;

@end
