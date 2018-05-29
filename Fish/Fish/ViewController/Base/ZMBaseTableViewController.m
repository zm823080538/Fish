//
//  ZMBaseTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface ZMBaseTableViewController () <DZNEmptyDataSetSource>

@end

@implementation ZMBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.emptyDataSetSource = self;
    self.tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self adapterUIForIOS11:self.tableView];
}

- (void)adapterUIForIOS11:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
#ifdef  __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"zanwushuju"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无内容";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName:UIColorFromRGB(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (void)loadData {
    
}
@end
