//
//  ZMAccountManager.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMAccountManager.h"

@implementation ZMAccountManager
+ (instancetype)shareManager {
    static ZMAccountManager *accountManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManager = [[ZMAccountManager alloc] init];
    });
    return accountManager;
}
@end
