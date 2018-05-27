//
//  ZMBodyBuildingKnowledageListController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyBuildingKnowledageListController.h"
#import "ZMHomeBodyBuildingKnowledageCell.h"
#import "ZMWebViewController.h"

@interface ZMBodyBuildingKnowledageListController ()

@end

@implementation ZMBodyBuildingKnowledageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 114;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMHomeBodyBuildingKnowledageCell *knowledageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class])];
    if (!knowledageCell) {
        knowledageCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class]) owner:nil options:nil].firstObject;
    }
    knowledageCell.item = self.arrayList.list[indexPath.row];
    return knowledageCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMWebViewController *webVC = [[ZMWebViewController alloc] init];
    ZMNewListItem *item = self.arrayList.list[indexPath.row];
    webVC.item = item;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
