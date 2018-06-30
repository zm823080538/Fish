//
//  ZMHistoryOrderListVC.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMHistoryOrderListVC.h"
#import "ZMOrderCell.h"
#import "ZMContinueLessonVC.h"
#import "ZMOrderSectionHeaderView.h"
#import "ZMCourseAppointController.h"
#import "ZMOrderDetailViewController.h"
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
    ZMOrderSectionHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderSectionHeaderView" owner:nil options:nil].firstObject;
    headerView.handleSubject = [RACSubject subject];
    @weakify(self)
    [headerView.handleSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([x isEqualToString:@"预约"]) {
            ZMCourseAppointController *appointVC =  [ZMCourseAppointController new];
            [self.navigationController pushViewController:appointVC animated:YES];
        } else {
            ZMContinueLessonVC *continueLessonVC = [ZMContinueLessonVC new];            
            [self.navigationController pushViewController:continueLessonVC animated:YES];
        }
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderDetailViewController *detailVC = [ZMOrderDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
