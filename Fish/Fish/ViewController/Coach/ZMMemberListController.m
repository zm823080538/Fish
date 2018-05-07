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
#import <UIView+YYAdd.h>
@interface ZMMemberListController ()

@end

@implementation ZMMemberListController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
//    searchButton.backgroundColor
    UIView *searchView = [[NSBundle mainBundle] loadNibNamed:@"ZMSearchButton" owner:nil options:nil].firstObject;
    searchView.height = 50;
    searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewClick)];
    [searchView addGestureRecognizer:tapGesture];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = searchView;
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

@end
