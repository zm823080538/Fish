//
//  ZMMyCollectListController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMyCollectListController.h"
#import "ZMCollectionCell.h"
@interface ZMMyCollectListController ()

@end

@implementation ZMMyCollectListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.tableView.rowHeight = 110;
    self.tableView.tableFooterView = [UIView new];
}

- (void)loadData {
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMCollectionCell" owner:nil options:nil].firstObject;
    }
    return cell;
    
}

@end
