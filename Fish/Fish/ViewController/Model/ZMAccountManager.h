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
@property (nonatomic, strong) ZMAccount * account;

@end
