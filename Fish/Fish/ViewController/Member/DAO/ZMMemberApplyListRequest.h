//
//  ZMMemberApplyListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMMemberApplyListRequest : YTKRequest
@property (nonatomic, copy) NSString * tid;
@property (nonatomic, copy) NSString * pageNo;
@property (nonatomic, copy) NSString * tryflag;
@property (nonatomic, copy) NSString * status;

@end
