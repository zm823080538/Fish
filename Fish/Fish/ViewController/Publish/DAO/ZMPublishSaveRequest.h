//
//  ZMPublishSaveRequest.h
//  Fish
//
//  Created by zhaoming on 2018/7/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMPublishSaveRequest : YTKRequest
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * coursetypeids;
@property (nonatomic, copy) NSString * areacode;
@property (nonatomic, copy) NSString * csum;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, copy) NSString * detailimg;
@end
