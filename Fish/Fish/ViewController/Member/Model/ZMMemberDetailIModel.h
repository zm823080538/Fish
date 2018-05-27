//
//  ZMMemberDetailIModel.h
//  Fish
//
//  Created by zhaoming on 2018/5/24.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Userinfo :NSObject
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * deviceid;
@property (nonatomic , copy) NSString              * birthdate;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * areacode;
@property (nonatomic , copy) NSString              * distancefmt;
@property (nonatomic , copy) NSString              * teachstatus;
@property (nonatomic , copy) NSString              * endBirthdate;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * provestatus;
@property (nonatomic , copy) NSString              * realname;
@property (nonatomic , copy) NSString              * score;
@property (nonatomic , copy) NSString              * no;
@property (nonatomic , copy) NSString              * role;
@property (nonatomic , copy) NSString              * reorder;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * depositstatus;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * longitude;
@property (nonatomic , copy) NSString              * areaname;
@property (nonatomic , copy) NSString              * courseprice;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * skillname;
@property (nonatomic , copy) NSString              * comfirmpsd;
@property (nonatomic , copy) NSString              * beginBirthdate;
@property (nonatomic , copy) NSString              * editnum;
@property (nonatomic , copy) NSString              * openid;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * degree;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , copy) NSString              * skillids;
@property (nonatomic , copy) NSString              * latitude;

@end

@interface Relation :NSObject
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tradestatus;

@end

@interface Need :NSObject
@property (nonatomic , copy) NSString              * detail;
@property (nonatomic , copy) NSString              * csum;
@property (nonatomic , copy) NSString              * areacode;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * ctype;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * userid;
@property (nonatomic , copy) NSString              * detailimg;
@property (nonatomic , copy) NSString              * ctypename;
@property (nonatomic , copy) NSString              * coursetypenames;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * areaname;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * coursetypeids;

@end

@interface Bodydata :NSObject
@property (nonatomic , copy) NSString              * userid;
@property (nonatomic , copy) NSString              * wddabi;
@property (nonatomic , copy) NSString              * wdxiaobi;
@property (nonatomic , copy) NSString              * weight;
@property (nonatomic , copy) NSString              * bodywater;
@property (nonatomic , copy) NSString              * wdxiong;
@property (nonatomic , copy) NSString              * writedate;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * wdtun;
@property (nonatomic , copy) NSString              * wddatui;
@property (nonatomic , copy) NSString              * fat;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * height;
@property (nonatomic , copy) NSString              * bmi;
@property (nonatomic , copy) NSString              * visceralfat;
@property (nonatomic , copy) NSString              * bmr;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * wdxiaotui;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * muscle;
@property (nonatomic , copy) NSString              * wdjian;
@property (nonatomic , copy) NSString              * wdyao;

@end

@interface ZMMemberDetailIModel :NSObject
@property (nonatomic , strong) Userinfo              * userinfo;
@property (nonatomic , strong) Bodydata              * bodydata;
@property (nonatomic , strong) Relation              * relation;
@property (nonatomic , copy) NSString              * isOrderd;
@property (nonatomic , strong) Need              * need;

@end
