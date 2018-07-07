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
#import "ZMAccountManager.h"
#import "ZMMemberDetailViewController.h"
#import <ReactiveObjC.h>
#import "SSSearchBar.h"
#import <NSObject+YYModel.h>
#import "ZMMemberModel.h"
#import <Masonry.h>
#import <UIView+YYAdd.h>
#import "ZMMemberSearchRequest.h"
@interface ZMMemberSearchViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,ZspMenuDataSource,ZspMenuDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZspMenu *menu;
@property (nonatomic, strong) SSSearchBar *searchBar;
@property (nonatomic, copy) NSString * skillids;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSArray * typeArray;
@property (nonatomic, strong) NSArray * distanceArray;
@property (nonatomic, strong) NSArray * sexArray;


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
    self.title = IS_COACH ? @"会员搜索" : @"教练搜索";
    if (IS_COACH) {
        self.typeArray = @[
                           @{
                               @"id": @"",
                               @"name": @"不限"
                               },@{
                               @"id": @"a01",
                               @"name": @"增肌"
                               }, @{
                               @"id": @"a02",
                               @"name": @"减脂"
                               }, @{
                               @"id": @"a03",
                               @"name": @"塑形"
                               }, @{
                               @"id": @"b01",
                               @"name": @"功能性"
                               }, @{
                               @"id": @"b02",
                               @"name": @"康复"
                               }, @{
                               @"id": @"b03",
                               @"name": @"体态修正"
                               }, @{
                               @"id": @"b04",
                               @"name": @"拉伸"
                               }, @{
                               @"id": @"b05",
                               @"name": @"搏击"
                               }, @{
                               @"id": @"c01",
                               @"name": @"竞技健美"
                               }];
        self.distanceArray = @[@{@"id": @"",
                                 @"name": @"不限"
                                 },
                               @{@"distance": @"1000",
                                 @"name": @"1km"
                                 },
                               @{@"distance": @"2000",
                                 @"name": @"2km"
                                 },
                               @{@"distance": @"3000",
                                 @"name": @"3km"
                                 },
                               @{@"distance": @"5000",
                                 @"name": @"5km"
                                 }
                               ,@{@"distance": @"10000",
                                  @"name": @"10km"
                                  }];
        self.sexArray = @[@{@"id": @"",
                            @"name": @"不限"
                            }
                          ,@{@"id": @"1",
                             @"name": @"男"
                             },
                          @{@"id": @"2",
                            @"name": @"女"
                            }];
    } else {
        self.typeArray = @[
                           @{
                               @"name":@"综合"
                               },@{
                               @"id": @"a01",
                               @"name": @"增肌"
                               }, @{
                               @"id": @"a02",
                               @"name": @"减脂"
                               }, @{
                               @"id": @"a03",
                               @"name": @"塑形"
                               }, @{
                               @"id": @"b01",
                               @"name": @"功能性"
                               }, @{
                               @"id": @"b02",
                               @"name": @"康复"
                               }, @{
                               @"id": @"b03",
                               @"name": @"体态修正"
                               }, @{
                               @"id": @"b04",
                               @"name": @"拉伸"
                               }, @{
                               @"id": @"b05",
                               @"name": @"搏击"
                               }, @{
                               @"id": @"c01",
                               @"name": @"竞技健美"
                               }];
        self.distanceArray = @[@{@"id": @"",
                                 @"name": @"不限"
                                 },
                               @{@"distance": @"1000",
                                 @"name": @"1km"
                                 },
                               @{@"distance": @"2000",
                                 @"name": @"2km"
                                 },
                               @{@"distance": @"3000",
                                 @"name": @"3km"
                                 },
                               @{@"distance": @"5000",
                                 @"name": @"5km"
                                 }
                               ,@{@"distance": @"10000",
                                  @"name": @"10km"
                                  }];
        self.sexArray = @[@{@"id": @"",
                            @"name": @"不限"
                            }
                          ,@{@"id": @"1",
                             @"name": @"男"
                             },
                          @{@"id": @"2",
                            @"name": @"女"
                            }];
    }
   
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)request {
    ZMMemberSearchRequest *request = [[ZMMemberSearchRequest alloc] init];
    request.requestId = [ZMAccountManager shareManager].loginUser.id;
    request.no = self.searchBar.text;
    request.skillids = self.skillids;
    request.sex = self.sex;
    request.distance = self.distance;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.dataSource = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"][@"list"]];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)setupUI
{
    self.searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.searchBar.placeholder = @"搜索会员名称及id";
    self.searchBar.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.searchBar];
    
    _menu = [[ZspMenu alloc] initWithOrigin:CGPointMake(0, 50) andHeight:44];
    _menu.selectedTextColor = UIColorFromRGB(0x4A576A);
    _menu.indicatorColor = UIColorFromRGB(0x4A576A);
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
    return self.dataSource.count;
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
        ZMMemberDetailViewController *detailVC = [[ZMMemberDetailViewController alloc] init];
        detailVC.member = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)numberOfColumnsInMenu:(ZspMenu *)menu {
    return 3;
}

//每个column有多少行
- (NSInteger)menu:(ZspMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.distanceArray.count;
    }else if(column == 1) {
        return self.sexArray.count;
    }else {
        return self.typeArray.count;
    }
}


//每个column中每行的title
- (NSString *)menu:(ZspMenu *)menu titleForRowAtIndexPath:(ZspIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.distanceArray[indexPath.row][@"name"];
    }else if(indexPath.column == 1) {
        return self.sexArray[indexPath.row][@"name"];
    }else {
        return self.typeArray[indexPath.row][@"name"];
    }
}

- (void)menu:(ZspMenu *)menu didSelectRowAtIndexPath:(ZspIndexPath *)indexPath {
//    if (indexPath.item >= 0) {
//
////        NSLog(@"点击了 %ld - %ld - %ld",indexPath.column,indexPath.row,indexPath.item);
//    }else {
//        NSLog(@"点击了 %ld - %ld",indexPath.column,indexPath.row);
//    }
    if (indexPath.column == 0) {
        self.distance = self.distanceArray[indexPath.row][@"distance"];
    } else if (indexPath.column == 1) {
        self.sex = self.sexArray[indexPath.row][@"id"];
    } else {
        self.skillids = self.typeArray[indexPath.row][@"id"];
    }
    [self request];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self request];
}


@end
