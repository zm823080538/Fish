//
//  ZMStudentSaveRequest.h
//  Fish
//
//  Created by sunny on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMStudentSaveRequest : YTKRequest
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *ctype;
@property (nonatomic, copy) NSString *coursetypeids;
@property (nonatomic, copy) NSString *csum;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *clongtitude;
@property (nonatomic, copy) NSString *clatitude;

@end
