//
//  ZMMemberListController.m
//  Fish
//
//  Created by zhaoming on 06/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMemberListController.h"
#import "ZMNearMememberCell.h"
#import "UIViewController+YPTabBarController.h"
#import <ReactiveObjC.h>
#import <MJRefresh.h>
#import "SSSearchBar.h"
#import <UIView+YYAdd.h>
#import <NSObject+YYModel.h>
#import "ZMMemberSearchViewController.h"
#import "ZMMemberDetailViewController.h"
#import "ZMMemberSearchRequest.h"
#import "ZMAccountManager.h"
#import "ZMMemberListRequest.h"
#import "ZMMemberModel.h"
@interface ZMMemberListController () {
    BOOL _firstLaunch;
}
@property (nonatomic, strong) SSSearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, assign) NSInteger currentPage;


@end

@implementation ZMMemberListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstLaunch = YES;
    UIButton *searchBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBgButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [searchBgButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBar = [[SSSearchBar alloc] initWithFrame:searchBgButton.bounds];
    [searchBgButton addSubview:self.searchBar];
    self.searchBar.userInteractionEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = searchBgButton;
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = @[].mutableCopy;
    self.currentPage = 1;
    if ([self.yp_tabItemTitle isEqualToString:@"附近会员"]) {
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(request)];
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self request];

}

- (void)searchClick {
    ZMMemberSearchViewController *memberSearchVC = [[ZMMemberSearchViewController alloc] init];
    [self.navigationController pushViewController:memberSearchVC animated:YES];
}



- (void)btnClick {
    ZMMemberSearchViewController *memberSearchVC = [[ZMMemberSearchViewController alloc] init];
    [self.navigationController pushViewController:memberSearchVC animated:YES];
}

- (void)request {
    if (_firstLaunch) {
        [MBProgressHUD showActivityMessageInView:nil];
    }
    if ([self.yp_tabItemTitle isEqualToString:@"附近会员"]) {
        ZMMemberSearchRequest *request = [[ZMMemberSearchRequest alloc] init];
        request.requestId = [ZMAccountManager shareManager].loginUser.id;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self.tableView.mj_header endRefreshing];
            if (_firstLaunch) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccessMessage:@"加载成功"];
            }
            _firstLaunch = NO;
            NSArray *list = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"][@"list"]];
            NSInteger totalPage = [request.responseObject[@"data"][@"totalPage"] intValue];
                [self.dataSource addObjectsFromArray:list];
                [self.tableView reloadData];
            self.currentPage ++;
            if (self.currentPage == totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self.tableView.mj_header endRefreshing];
        }];
    } else {
//        1关注2黑名单3已接单
        NSString *status = @"";
        if ([self.yp_tabItemTitle isEqualToString:@"我的会员"]) {
            status = @"3";
        } else if ([self.yp_tabItemTitle isEqualToString:@"我的关注"]) {
            status = @"1";
        } else if ([self.yp_tabItemTitle isEqualToString:@"黑名单"]) {
            status = @"2";
        }
        ZMMemberListRequest *request = [[ZMMemberListRequest alloc] init];
        request.requestId = [ZMAccountManager shareManager].loginUser.id;
        request.status = status;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccessMessage:@"加载成功"];
            if (request.responseObject[@"data"]) {
                self.dataSource = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"]].mutableCopy;
                [self.tableView reloadData];
            }
           
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self.tableView.mj_header endRefreshing];
        }];
    }
}



- (void)searchViewClick {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.searchBar resignFirstResponder];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberDetailViewController *memberDetailVC = [ZMMemberDetailViewController new];
    memberDetailVC.member = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:memberDetailVC animated:YES];
}

@end
