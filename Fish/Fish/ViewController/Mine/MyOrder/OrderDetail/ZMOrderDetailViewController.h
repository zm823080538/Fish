//
//  ZMOrderDetailViewController.h
//  Fish
//
//  Created by zhaoming on 2018/6/15.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseTableViewController.h"

//typedef NS_ENUM(NSUInteger, OrderStatust) {
//    OrderStatust
//};

@interface ZMOrderDetailViewController : ZMBaseTableViewController
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString * orderStatus;

@end
