//
//  ZMMemberResultListController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberResultListController.h"
#import "ZMMemberResultItemTableCell.h"

@interface ZMMemberResultListController ()

@end

@implementation ZMMemberResultListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 287;
    //    [self loadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberResultItemTableCell *knowledageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberResultItemTableCell class])];
    if (!knowledageCell) {
        knowledageCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMMemberResultItemTableCell class]) owner:nil options:nil].firstObject;
    }
    return knowledageCell;
    
}
@end
