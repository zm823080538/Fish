//
//  ZMCoachDetailModel.h
//  Fish
//
//  Created by sunny on 2018/6/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberDetailIModel.h"

@interface Workdatelist :NSObject
@property (nonatomic , copy) NSArray<NSString *>              * timelist;
@property (nonatomic , copy) NSString              * weekindex;
@property (nonatomic , copy) NSString              * year;
@property (nonatomic , copy) NSString              * day;
@property (nonatomic , copy) NSString              * month;
@property (nonatomic , copy) NSString              * date;

@end


@interface ZMCoachDetailModel :ZMMemberDetailIModel
@property (nonatomic , copy) NSArray<Workdatelist *>              * workdatelist;
@end
