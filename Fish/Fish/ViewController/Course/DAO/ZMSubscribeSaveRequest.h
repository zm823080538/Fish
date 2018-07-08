//
//  ZMSubscribeSaveRequest.h
//  Fish
//
//  Created by sunny on 2018/7/7.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMSubscribeSaveRequest : YTKRequest
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *cardid;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *starttime;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longtitude;

@end
