//
//  ZMNearMemberViewController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMNearMemberViewController.h"
#import "ZspMenu.h"
#import "ZMNearMememberCell.h"
#import <Masonry.h>

@interface ZMNearMemberViewController () <ZspMenuDataSource, ZspMenuDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZspMenu *menu;

@property (nonatomic, strong) NSArray *location;
@property (nonatomic, strong) NSArray *sort;
@property (nonatomic, strong) NSArray *choose;

@end

@implementation ZMNearMemberViewController

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
    self.location = @[@"综合", @"推荐商圈", @"越秀区", @"天河区", @"番禺区", @"海珠区", @"白云区", @"荔湾区", @"黄埔区"];
    self.sort = @[@"距离", @"离我最近", @"好评优先", @"人气最高"];
    self.choose = @[@"筛选", @"折扣商品", @"进店领券", @"下单返券"];

    
    [self setupUI];
}

- (void)setupUI
{
    
    _menu = [[ZspMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_menu.mas_bottom);
        
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

- (NSInteger)numberOfColumnsInMenu:(ZspMenu *)menu {
    return 3;
}

//每个column有多少行
- (NSInteger)menu:(ZspMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.location.count;
    }else if(column == 1) {
        return self.sort.count;
    }else {
        return self.choose.count;
    }
}


//每个column中每行的title
- (NSString *)menu:(ZspMenu *)menu titleForRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.location[indexPath.row];
    }else if(indexPath.column == 1) {
        return self.sort[indexPath.row];
    }else {
        return self.choose[indexPath.row];
    }
}

- (void)menu:(ZspMenu *)menu didSelectRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld",indexPath.column,indexPath.row);
    }
}

@end
