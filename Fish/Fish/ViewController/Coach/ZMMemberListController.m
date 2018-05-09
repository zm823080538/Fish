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
@interface ZMMemberListController () <UISearchBarDelegate>

@end

@implementation ZMMemberListController

- (void)viewDidLoad {
    [super viewDidLoad];
    SSSearchBar *searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    searchBar.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = searchBar;
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
}



- (void)searchViewClick {
    
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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"+++++");
    return NO;
}

@end
