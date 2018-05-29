//
//  ZMApplySaveRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/30.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMApplySaveRequest : YTKRequest
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *status;

@end
