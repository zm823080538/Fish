//
//  ZMApplyListModel.m
//  Fish
//
//  Created by zhaoming on 2018/5/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMApplyListModel.h"

@implementation ZMApplyListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ZMApplyListModelItem class]
            };
}

@end

@implementation ZMApplyListModelItem

@end
