//
//  ZMServicetimeSaveRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMServicetimeSaveRequest : YTKRequest
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *starttime;
@property (nonatomic, copy) NSString *endtime;
@property (nonatomic, copy) NSString *day1;
@property (nonatomic, copy) NSString *day2;
@property (nonatomic, copy) NSString *day3;
@property (nonatomic, copy) NSString *day4;
@property (nonatomic, copy) NSString *day5;
@property (nonatomic, copy) NSString *day6;
@property (nonatomic, copy) NSString *day7;

@end
