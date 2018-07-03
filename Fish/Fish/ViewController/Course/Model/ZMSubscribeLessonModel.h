//
//  ZMSubscribeLessonModel.h
//  Fish
//
//  Created by sunny on 2018/7/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface Timelist :NSObject
@property (nonatomic , copy) NSString              * zone;
@property (nonatomic , copy) NSString              * starttime;
@property (nonatomic , copy) NSString              * endtime;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * day;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * weekindex;
@property (nonatomic , copy) NSString              * brothertime;
@property (nonatomic , copy) NSString              * month;
@property (nonatomic , copy) NSString              * year;
@property (nonatomic , copy) NSString              * status;

@end

@interface Datelist :NSObject
@property (nonatomic , copy) NSArray<Timelist *>              * timelist;
@property (nonatomic , copy) NSString              * weekindex;
@property (nonatomic , copy) NSString              * year;
@property (nonatomic , copy) NSString              * day;
@property (nonatomic , copy) NSString              * month;
@property (nonatomic , copy) NSString              * date;

@end

@interface ZMSubscribeLessonModel :NSObject
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * gymname;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * coursetypeids;
@property (nonatomic , copy) NSString              * clickendtime;
@property (nonatomic , copy) NSString              * endtime;
@property (nonatomic , copy) NSString              * beginStarttime;
@property (nonatomic , copy) NSString              * longtitude;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * orderid;
@property (nonatomic , copy) NSString              * beginEndtime;
@property (nonatomic , copy) NSString              * no;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * endEndtime;
@property (nonatomic , copy) NSString              * ctypename;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * tryflag;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tid;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * ctype;
@property (nonatomic , copy) NSString              * starttime;
@property (nonatomic , copy) NSString              * cardid;
@property (nonatomic , copy) NSArray<Datelist *>              * timelist;
@property (nonatomic , copy) NSString              * endStarttime;
@property (nonatomic , copy) NSString              * coursetypenames;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * cancelreason;
@property (nonatomic , copy) NSString              * clickstarttime;
@property (nonatomic , copy) NSString              * latitude;

@end
