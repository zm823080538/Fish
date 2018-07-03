//
//  ZMWeiduTableViewController.h
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseTableViewController.h"
#import "ZMBodyDataModel.h"
@interface ZMWeiduTableViewController : ZMBaseTableViewController
@property (nonatomic, strong) BodyList *model;
@property (nonatomic, strong) RACSubject * subject;
@end
