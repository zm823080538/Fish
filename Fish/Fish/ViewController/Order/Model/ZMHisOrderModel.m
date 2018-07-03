//
//  ZMHisOrderModel.m
//  Fish
//
//  Created by sunny on 2018/7/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMHisOrderModel.h"

@implementation Orderlist

@end
@implementation HistoryList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderlist" : [Orderlist class]
             };
}
@end
@implementation ZMHisOrderModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HistoryList class]};
}
@end
