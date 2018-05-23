//
//  ZMMemberListController.m
//  Fish
//
//  Created by zhaoming on 06/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMemberListController.h"
#import "ZMNearMememberCell.h"
#import <ReactiveObjC.h>
#import "SSSearchBar.h"
#import <UIView+YYAdd.h>
#import "ZMMemberSearchViewController.h"
#import "ZMMemberDetailViewController.h"
#import "ZMMemberSearchRequest.h"
#import "ZMAccountManager.h"
@interface ZMMemberListController () <UISearchBarDelegate>
@property (nonatomic, strong) SSSearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray * dataSource;

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
    [self request];
}

- (void)request {
    ZMMemberSearchRequest *request = [[ZMMemberSearchRequest alloc] init];
    request.id = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}



- (void)searchViewClick {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)loadData:(NSArray *)data {
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberDetailViewController *memberDetailVC = [ZMMemberDetailViewController new];
    [self.navigationController pushViewController:memberDetailVC animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    ZMMemberSearchViewController *memberSearchVC = [[ZMMemberSearchViewController alloc] init];
    [self.navigationController pushViewController:memberSearchVC animated:YES];
    return NO;
}



@end
