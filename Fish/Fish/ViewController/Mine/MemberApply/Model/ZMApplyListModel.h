//
//  ZMApplyListModel.h
//  Fish
//
//  Created by zhaoming on 2018/5/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMApplyListModelItem :NSObject
@property (nonatomic , copy) NSString              * tryflag;
@property (nonatomic , copy) NSString              * coursetypeids;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tid;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * coursetypenames;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * paytype;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * latitude;
@property (nonatomic , copy) NSString              * ctypename;
@property (nonatomic , copy) NSString              * cprice;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * payno;
@property (nonatomic , copy) NSString              * cuse;
@property (nonatomic , copy) NSString              * repeatstatus;
@property (nonatomic , copy) NSString              * csum;
@property (nonatomic , copy) NSString              * longitude;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * rebatedesc;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * crealprice;
@property (nonatomic , copy) NSString              * ctotalprice;
@property (nonatomic , copy) NSString              * ctype;
@property (nonatomic , copy) NSString              * rebate;

@end

@interface ZMApplyListModel :NSObject
@property (nonatomic , copy) NSString              * isApiPageFlag;
@property (nonatomic , copy) NSString              * pageNo;
@property (nonatomic , copy) NSString              * pageSize;
@property (nonatomic , copy) NSString              * count;
@property (nonatomic , copy) NSString              * firstResult;
@property (nonatomic , copy) NSString              * html;
@property (nonatomic , strong) NSArray<ZMApplyListModelItem *>              * list;
@property (nonatomic , copy) NSString              * maxResults;
@property (nonatomic , copy) NSString              * totalPage;

@end
