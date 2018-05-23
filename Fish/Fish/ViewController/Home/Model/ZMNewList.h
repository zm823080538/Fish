//
//  ZMNewList.h
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMNewListItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * detail;
@property (nonatomic , copy) NSString              * linkurl;
@property (nonatomic , copy) NSString              * copyfrom;
@property (nonatomic , copy) NSString              * createDate;
@property (nonatomic , copy) NSString              * userid;
@property (nonatomic , copy) NSString              * userimg;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) BOOL              isNewRecord;
@property (nonatomic , copy) NSString              * summary;
@property (nonatomic , copy) NSString              * updateDate;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * sort;
@property (nonatomic , copy) NSString              * favorite;

@end

@interface ZMNewList :NSObject
@property (nonatomic , assign) BOOL              isApiPageFlag;
@property (nonatomic , assign) NSInteger              pageNo;
@property (nonatomic , assign) NSInteger              pageSize;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              firstResult;
@property (nonatomic , copy) NSString              * html;
@property (nonatomic , copy) NSArray<ZMNewListItem *>              * list;
@property (nonatomic , assign) NSInteger              maxResults;

@end
