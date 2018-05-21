//
//  ZMMemberSearchViewController.m
//  Fish
//
//  Created by sunny on 2018/5/17.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberSearchViewController.h"
#import "ZspMenu.h"
#import "ZMNearMememberCell.h"
#import "ZMMemberDetailViewController.h"
#import <ReactiveObjC.h>
#import "SSSearchBar.h"
#import <Masonry.h>
#import <UIView+YYAdd.h>
@interface ZMMemberSearchViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SSSearchBar *searchBar;


@end

@implementation ZMMemberSearchViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.rowHeight = 82;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchBar.placeholder = @"搜索会员名称及id";
    self.searchBar.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)menu:(ZspMenu *)menu didSelectRowAtIndexPath:(ZspIndexPath *)indexPath {
    ZMMemberDetailViewController *detailVC = [[ZMMemberDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
