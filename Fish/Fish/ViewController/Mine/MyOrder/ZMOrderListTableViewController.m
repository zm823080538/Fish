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
#import "ZMOrderListRequest.h"
#import "ZMOrderListModel.h"
#import <MJRefresh.h>
#import "ZMRefoundLessonController.h"

@interface ZMOrderListTableViewController () {
    NSInteger _pageNo;
    BOOL _isLoadMore;
}
@property (nonatomic, strong) ZMOrderListModel * model;


@end

@implementation ZMOrderListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    self.tableView.rowHeight = 233;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 10;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self request];
}

- (void)loadMore {
    _pageNo ++;
    _isLoadMore = YES;
    [self request];
}

- (void)request {
    ZMOrderListRequest *request = [[ZMOrderListRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.status = self.status;
    request.pageNo = [NSString stringWithFormat:@"%ld",_pageNo];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {\
        
        if (_pageNo == self.model.totalPage.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (_isLoadMore) {
            NSArray *array = [NSArray modelArrayWithClass:[ZMOrderDetailModel class] json:request.responseObject[@"data"][@"list"]];
            NSMutableArray *muArray = self.model.list.mutableCopy;
            [muArray addObjectsFromArray:array];
            self.model.list = muArray;
            [self.tableView.mj_footer endRefreshing];
            _isLoadMore = NO;
        } else {
            [self.tableView.mj_header endRefreshing];
            self.model = [ZMOrderListModel modelWithJSON:request.responseObject[@"data"]];
        }
        [self.tableView reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderTableViewCell" owner:nil options:nil].firstObject;
    }
    if ([self.status isEqualToString:@"a1"]) {
        cell.operationBtn2.hidden = YES;
    }
    cell.detailModel = self.model.list[indexPath.row];
    [cell.subject subscribeNext:^(NSString  *_Nullable currentTitle) {
        if ([currentTitle isEqualToString:@"退课"]) {
            ZMRefoundLessonController *refoundLessonVC = [ZMRefoundLessonController new];
            refoundLessonVC.detailModel = self.model.list[indexPath.row];
            [self.navigationController pushViewController:refoundLessonVC animated:YES];
        } else if ([currentTitle isEqualToString:@"取消退课"]) {
            
        } else if ([currentTitle isEqualToString:@"取消订单"]) {
            
        }
    }];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

@end
