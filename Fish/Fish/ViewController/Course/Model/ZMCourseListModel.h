//
//  ZMCourseListModel.h
//  Fish
//
//  Created by zhaoming on 2018/5/25.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCourseListItem :NSObject
@property (nonatomic , copy) NSString              * cancelreason;
@property (nonatomic , copy) NSString              * longtitude;
@property (nonatomic , copy) NSString              * tryflag;
@property (nonatomic , copy) NSString              * beginStarttime;
@property (nonatomic , copy) NSString              * coursetypeids;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tid;
@property (nonatomic , copy) NSString              * coursetypenames;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * endEndtime;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * starttime;
@property (nonatomic , copy) NSString              * endtime;
@property (nonatomic , copy) NSString              * latitude;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * ctypename;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * beginEndtime;
@property (nonatomic , copy) NSString              * no;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * gymname;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * endStarttime;
@property (nonatomic , copy) NSString              * ctype;
@property (nonatomic , copy) NSString              * address;

@end

@interface ZMCourseListModel :NSObject
@property (nonatomic , copy) NSString              * isApiPageFlag;
@property (nonatomic , copy) NSString              * pageNo;
@property (nonatomic , copy) NSString              * pageSize;
@property (nonatomic , copy) NSString              * count;
@property (nonatomic , copy) NSString              * firstResult;
@property (nonatomic , copy) NSString              * html;
@property (nonatomic , strong) NSArray<ZMCourseListItem *>              * list;
@property (nonatomic , copy) NSString              * maxResults;
@property (nonatomic , copy) NSString              * totalPage;

@end
