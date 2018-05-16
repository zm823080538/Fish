//
//  ZMMyCollectListController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMyCollectListController.h"
#import "ZMCollectionCell.h"
@interface ZMMyCollectListController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation ZMMyCollectListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.tableView.rowHeight = 110;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)loadData {
    
    
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"zanwushuju"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无收藏内容";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName:UIColorFromRGB(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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
