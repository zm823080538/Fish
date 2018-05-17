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
@interface ZMMemberListController () <UISearchBarDelegate>
@property (nonatomic, strong) SSSearchBar *searchBar;

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



- (void)searchViewClick {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBar resignFirstResponder];
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


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    ZMMemberSearchViewController *memberSearchVC = [[ZMMemberSearchViewController alloc] init];
    [self.navigationController pushViewController:memberSearchVC animated:YES];
}


@end
