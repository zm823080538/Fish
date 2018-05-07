//
//  ZMMarketTableViewController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMarketTableViewController.h"
#import "ZMHomeSectionView.h"
#import "ZMMemberResultCell.h"

@interface ZMMarketTableViewController ()
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ZMMarketTableViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; self.tableView.tableFooterView = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    self.tableView.rowHeight = 195;
}

- (void)rightBarItemClick {
    
}




#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMHomeSectionView *sectionView = [[ZMHomeSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    if (section == 0) {
        sectionView.title = @"人气单品";
    } else {
        sectionView.title = @"热销单品";
    }
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberResultCell *memberResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberResultCell class])];;
    if (!memberResultCell) {
        memberResultCell = [[ZMMemberResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZMMemberResultCell class])];
    }
    return memberResultCell;
}
@end
