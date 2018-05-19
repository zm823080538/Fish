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
@interface ZMMemberSearchViewController () <ZspMenuDataSource, ZspMenuDelegate, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZspMenu *menu;

@property (nonatomic, strong) NSArray *location;
@property (nonatomic, strong) NSArray *sort;
@property (nonatomic, strong) NSArray *choose;
@property (nonatomic, strong) NSArray *sex;
@property (nonatomic, strong) NSArray *types;

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
    [self setupUI];
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
