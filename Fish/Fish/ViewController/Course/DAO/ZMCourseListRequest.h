//
//  ZMCourseListRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMCourseListRequest : YTKRequest
@property (nonatomic, copy) NSString * tid;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * pageNo;
@property (nonatomic, copy) NSString * starttime;
@property (nonatomic, copy) NSString * orderid;


@end
