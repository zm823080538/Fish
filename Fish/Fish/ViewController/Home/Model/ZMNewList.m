//
//  ZMNewList.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMNewList.h"

@implementation ZMNewList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ZMNewListItem class] };
}
@end

@implementation ZMNewListItem

@end