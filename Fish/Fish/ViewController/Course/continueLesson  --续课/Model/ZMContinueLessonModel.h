//
//  ZMContinueLessonModel.h
//  Fish
//
//  Created by sunny on 2018/6/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Onsaledataforapp :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * total;

@end

@interface List :NSObject
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * duration;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * isNewRecord;

@end

@interface ZMContinueLessonModel :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * consalelabel;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * onsaledata;
@property (nonatomic , copy) NSArray<Onsaledataforapp *>              * onsaledataforapp;
@property (nonatomic , copy) NSString              * consaledata;
@property (nonatomic , copy) NSString              * onsaletype;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * isNewRecord;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSArray<List *>              * list;
@property (nonatomic , copy) NSString              * consaletype;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * onsalelabel;

@end
