//
//  ZMOrderListTableViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/14.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderListTableViewController.h"
#import "ZMOrderTableViewCell.h"
#import "ZMOrderDetailViewController.h"
@interface ZMOrderListTableViewController ()

@end

@implementation ZMOrderListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 233;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderTableViewCell" owner:nil options:nil].firstObject;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

@end
