//
//  ZMHistoryOrderListVC.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMHistoryOrderListVC.h"
#import <MJRefresh.h>
#import "ZMOrderCell.h"
#import "ZMContinueLessonVC.h"
#import "ZMOrderSectionHeaderView.h"
#import "ZMCourseAppointController.h"
#import "ZMOrderDetailViewController.h"
#import "ZMHistoryOrderListRequest.h"
#import "ZMHisOrderModel.h"
@interface ZMHistoryOrderListVC ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong)  ZMHisOrderModel *hisOrderModel;

@end

@implementation ZMHistoryOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 150;
    self.tableView.rowHeight = 52;
    self.tableView.tableFooterView = [UIView new];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self request];
}

- (void)request {
    ZMHistoryOrderListRequest *request = [[ZMHistoryOrderListRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.hisOrderModel = [ZMHisOrderModel modelWithJSON:request.responseObject[@"data"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}





#pragma mark - Table view data source


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMOrderSectionHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderSectionHeaderView" owner:nil options:nil].firstObject;
    headerView.historyList = self.hisOrderModel.list[section];
    headerView.handleSubject = [RACSubject subject];
    @weakify(self)
    [headerView.handleSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([x isEqualToString:@"预约"]) {
            ZMCourseAppointController *appointVC =  [ZMCourseAppointController new];
            appointVC.historyList = self.hisOrderModel.list[section];
            [self.navigationController pushViewController:appointVC animated:YES];
        } else {
            ZMContinueLessonVC *continueLessonVC = [ZMContinueLessonVC new];
            
            [self.navigationController pushViewController:continueLessonVC animated:YES];
        }
    }];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.hisOrderModel.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HistoryList *list = self.hisOrderModel.list[section];
    return list.orderlist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMOrderCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMOrderCell class]) owner:nil options:nil].firstObject;
    }
    HistoryList *list = self.hisOrderModel.list[indexPath.section];
    cell.orderList = list.orderlist[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderDetailViewController *detailVC = [ZMOrderDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
