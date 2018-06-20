//
//  ZMHistoryOrderListVC.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMHistoryOrderListVC.h"
#import "ZMOrderCell.h"
@interface ZMHistoryOrderListVC ()

@end

@implementation ZMHistoryOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 150;
    self.tableView.rowHeight = 52;
    self.tableView.tableFooterView = [UIView new];
}





#pragma mark - Table view data source


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderSectionHeaderView" owner:nil options:nil].firstObject;
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMOrderCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMOrderCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}




@end
