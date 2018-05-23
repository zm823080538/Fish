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
#import "SSSearchBar.h"
#import <UIView+YYAdd.h>
#import <NSObject+YYModel.h>
#import "ZMMemberSearchViewController.h"
#import "ZMMemberDetailViewController.h"
#import "ZMMemberSearchRequest.h"
#import "ZMAccountManager.h"
#import "ZMMemberListRequest.h"
#import "ZMMemberModel.h"
@interface ZMMemberListController () <UISearchBarDelegate>
@property (nonatomic, strong) SSSearchBar *searchBar;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation ZMMemberListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchBar.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)request {
    if ([self.yp_tabItemTitle isEqualToString:@"附近会员"]) {
        ZMMemberSearchRequest *request = [[ZMMemberSearchRequest alloc] init];
        request.requestId = [ZMAccountManager shareManager].loginUser.id;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            self.dataSource = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
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
            self.dataSource = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}



- (void)searchViewClick {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)loadData:(NSArray *)data {
    
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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    ZMMemberSearchViewController *memberSearchVC = [[ZMMemberSearchViewController alloc] init];
    [self.navigationController pushViewController:memberSearchVC animated:YES];
    return NO;
}



@end
