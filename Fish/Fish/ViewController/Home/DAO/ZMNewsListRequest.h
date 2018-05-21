//
//  ZMNewsListRequest.h
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <YTKRequest.h>

@interface ZMNewsListRequest : YTKRequest
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userimg;

/**
 1:活动,2:广告,3:健身知识，4训练成果，5 训练技巧
 */
@property (nonatomic, copy) NSString *type;
@end
