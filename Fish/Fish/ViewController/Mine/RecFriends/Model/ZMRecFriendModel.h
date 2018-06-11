//
//  ZMRecFriendModel.h
//  Fish
//
//  Created by zhaoming on 2018/6/6.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMRecFriendModel : NSObject
@property (nonatomic, copy) NSString *invitemoney;
@property (nonatomic, copy) NSString *invitecode;
@property (nonatomic, strong) NSArray <ZMAccount *> *list;


@end
