//
//  ZMOrderListModel.m
//  Fish
//
//  Created by sunny on 2018/7/10.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderListModel.h"

@implementation ZMOrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ZMOrderDetailModel class]
            };
}
@end




