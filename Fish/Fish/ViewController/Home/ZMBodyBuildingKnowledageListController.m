//
//  ZMBodyBuildingKnowledageListController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyBuildingKnowledageListController.h"
#import "ZMHomeBodyBuildingKnowledageCell.h"
@interface ZMBodyBuildingKnowledageListController ()

@end

@implementation ZMBodyBuildingKnowledageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 114;
//    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMHomeBodyBuildingKnowledageCell *knowledageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class])];
    if (!knowledageCell) {
        knowledageCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class]) owner:nil options:nil].firstObject;
    }
    return knowledageCell;
    
}

@end
