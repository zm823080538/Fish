//
//  ZMAccountManager.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMAccountManager.h"
#import <NSObject+YYModel.h>

@implementation ZMAccountManager
+ (instancetype)shareManager {
    static ZMAccountManager *accountManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManager = [[ZMAccountManager alloc] init];
    });
    return accountManager;
}

- (void)updateUserInfoWithAccount:(ZMAccount *)account {
    NSDictionary *dict = [account modelToJSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kZMUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (ZMAccount *)loginUser {
    if (!_loginUser) {
        NSDictionary *userInfoDict = [[NSUserDefaults standardUserDefaults] objectForKey:kZMUserInfo];
        _loginUser = [ZMAccount modelWithJSON:userInfoDict];
    }
    return _loginUser;
}

- (BOOL)isCoach {
    return [self.loginUser.role isEqualToString:@"0"];
}

- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kZMUserInfo] == nil ? NO : YES;
}

- (void)logOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kZMUserInfo];
    self.loginUser = nil;
}
@end
