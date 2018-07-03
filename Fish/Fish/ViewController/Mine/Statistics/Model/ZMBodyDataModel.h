//
//  ZMBodyDataModel.h
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BodyList :NSObject
@property (nonatomic , copy) NSString              * userid;
@property (nonatomic , copy) NSString              * wddabi;
@property (nonatomic , copy) NSString              * wdxiaobi;
@property (nonatomic , copy) NSString              * wddetail;
@property (nonatomic , copy) NSString              * bodywater;
@property (nonatomic , copy) NSString              * wdxiong;
@property (nonatomic , copy) NSString              * weight;
@property (nonatomic , copy) NSString              * writedate;
@property (nonatomic , copy) NSString              * wdtun;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * wddatui;
@property (nonatomic , copy) NSString              * fat;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * height;
@property (nonatomic , copy) NSString              * bmi;
@property (nonatomic , copy) NSString              * visceralfat;
@property (nonatomic , copy) NSString              * bmr;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * muscle;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * wdxiaotui;
@property (nonatomic , copy) NSString              * wdjian;
@property (nonatomic , copy) NSString              * wdyao;

@end

@interface ZMBodyDataModel :NSObject
@property (nonatomic , copy) NSString              * isApiPageFlag;
@property (nonatomic , copy) NSString              * pageNo;
@property (nonatomic , copy) NSString              * pageSize;
@property (nonatomic , copy) NSString              * count;
@property (nonatomic , copy) NSString              * firstResult;
@property (nonatomic , copy) NSString              * html;
@property (nonatomic , strong) NSArray<BodyList *>              * list;
@property (nonatomic , copy) NSString              * maxResults;
@property (nonatomic , copy) NSString              * totalPage;

@end
