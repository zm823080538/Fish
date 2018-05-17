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
    self.location = @[@"综合", @"推荐商圈", @"越秀区", @"天河区", @"番禺区", @"海珠区", @"白云区", @"荔湾区", @"黄埔区"];
    self.sort = @[@"距离", @"离我最近", @"好评优先", @"人气最高"];
    self.sex = @[@"男", @"女"];
    self.choose = @[@"类型", @"折扣商品", @"进店领券", @"下单返券"];
    self.types = @[@"距离", @"折扣商品", @"进店领券", @"下单返券"];
    
    
    [self setupUI];
}

- (void)setupUI
{
    SSSearchBar *searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    searchBar.delegate = self;
    
    
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
    return 5;
}

//每个column有多少行
- (NSInteger)menu:(ZspMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.location.count;
    }else if(column == 1) {
        return self.sort.count;
    }else if(column == 2){
        return self.sex.count;
    } else if(column == 3){
        return self.choose.count;
    }else {
        return self.types.count;
    }
}


//每个column中每行的title
- (NSString *)menu:(ZspMenu *)menu titleForRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.location[indexPath.row];
    }else if(indexPath.column == 1) {
        return self.sort[indexPath.row];
    }else if(indexPath.column == 2) {
        return self.sex[indexPath.row];
    }else if(indexPath.column == 3) {
        return self.choose[indexPath.row];
    }else {
        return self.types[indexPath.row];
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
