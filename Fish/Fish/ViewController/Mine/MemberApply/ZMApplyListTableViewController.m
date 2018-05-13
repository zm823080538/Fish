//
//  ZMApplyListTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMApplyListTableViewController.h"
#import "ZMMemberApplyCell.h"
#import "UIViewController+YPTabBarController.h"
@interface ZMApplyListTableViewController ()

@end

@implementation ZMApplyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberApplyCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMMemberApplyCell class]) owner:nil options:nil].firstObject;
    }
    if ([self.yp_tabItemTitle isEqualToString:@"申请记录"]) {
        cell.applyStyle = ApplyStyleStyle2;
    } else {
        cell.applyStyle = ApplyStyleStyle1;
    }
    return cell;
}

@end
