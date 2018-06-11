//
//  ZMRecFriendModel.m
//  Fish
//
//  Created by zhaoming on 2018/6/6.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRecFriendModel.h"

@implementation ZMRecFriendModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ZMAccount class]};
}
@end
