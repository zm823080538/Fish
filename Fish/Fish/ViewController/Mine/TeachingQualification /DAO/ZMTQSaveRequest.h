//
//  ZMTQSaveRequest.h
//  Fish
//
//  Created by zhaoming on 2018/5/30.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMTQSaveRequest : YTKRequest
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * workdate;
@property (nonatomic, copy) NSString * skillname;
@property (nonatomic, copy) NSString * succase;
@property (nonatomic, copy) NSString * certpath;
@property (nonatomic, copy) NSString * photopath;
@property (nonatomic, copy) NSString * motto;
@property (nonatomic, copy) NSString * intro;

@end
