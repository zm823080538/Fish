//
//  ZMBodyDataListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMBodyDataListRequest : YTKRequest
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *pageNo;


@end
