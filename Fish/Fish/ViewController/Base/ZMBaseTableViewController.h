//
//  ZMBaseTableViewController.h
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"
@interface ZMBaseTableViewController : UITableViewController
@property (nonatomic, strong) NSArray * dataSource;

- (void)loadData;
@end
