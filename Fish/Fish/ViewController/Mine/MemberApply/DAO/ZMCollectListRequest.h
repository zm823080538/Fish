//
//  ZMCollectListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/26.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMCollectListRequest : YTKRequest
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * pageNo;
@end
