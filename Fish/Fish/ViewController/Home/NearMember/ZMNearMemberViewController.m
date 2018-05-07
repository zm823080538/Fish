//
//  ZMNearMemberViewController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMNearMemberViewController.h"
#import "XCDropdownSegment.h"
#import "ZMNearMememberCell.h"
#import <Masonry.h>

@interface ZMNearMemberViewController () <XCDropdownSegmentDataSource, XCDropdownSegmentDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
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
    [self setupUI];
}

- (void)setupUI
{
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.mas_bottom).mas_offset(10);
    }];
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XCDropdownSegment *segment = [[XCDropdownSegment alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height - 64)];
    segment.dataSource = self;
    segment.delegate   = self;
    return segment;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

#pragma mark - 📕 👀 XCDropdownSegmentDataSource 👀

- (NSArray<NSString *> *)titlesOfHeaderInDropdownSegment:(XCDropdownSegment *)dropdownSegment
{
    return @[@"综合", @"距离", @"筛选"];
}

- (NSArray<NSString *> *)dropdownSegment:(XCDropdownSegment *)dropdownSegment titlesInSection:(NSInteger)section
{
    if (0 == section)   return @[@"一：001", @"一：002", @"一：003"];
    
    if (1 == section)   return @[
                                 @"二：001",
                                 @"二：002",
                                 @"二：003",
                                 @"二：004",
                                 @"二：005",
                                 @"二：006",
                                 @"二：007"
                                 ];
    return @[
             @"三：001",
             @"三：002",
             @"三：003",
             @"三：004",
             @"三：005"
             ];
}

#pragma mark - 💉 👀 XCDropdownSegmentDelegate 👀

- (void)dropdownSegment:(XCDropdownSegment *)dropdownSegment didSelectHeaderInSection:(NSInteger)section
{
    NSLog(@"点击了第 %zi 段", section);
}

- (void)dropdownSegment:(XCDropdownSegment *)dropdownSegment didSelectRow:(NSInteger)row inSection:(NSInteger)section
{
    NSLog(@"点击了第 %zi 段的第 %zi 行", section, row);
}


@end
