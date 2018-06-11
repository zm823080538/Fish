//
//  ZMAccountManager.h
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMAccount.h"
@interface ZMAccountManager : NSObject

+ (instancetype)shareManager;
@property (nonatomic, readonly, getter=isLogin) BOOL login;
// 登陆后获取用户信息，如果未登录，则返回nil
@property (nonatomic, strong) ZMAccount *loginUser;
- (void)updateUserInfoWithAccount:(ZMAccount *)account;
- (void)logOut;


@end
