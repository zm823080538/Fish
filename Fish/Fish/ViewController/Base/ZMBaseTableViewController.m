//
//  ZMBaseTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseTableViewController.h"

@interface ZMBaseTableViewController ()

@end

@implementation ZMBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
}

- (void)loadData {
    
}
@end
