//
//  ZMMyCollectListController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMyCollectListController.h"
#import "ZMCollectionCell.h"
#import <NSObject+YYModel.h>
#import "ZMAccountManager.h"
#import "ZMCollectRequest.h"
#import "ZMNewList.h"
#import "ZMCollectListRequest.h"
@interface ZMMyCollectListController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ZMMyCollectListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.tableView.rowHeight = 110;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = @[].mutableCopy;
    [self request];
}

- (void)request {
    ZMCollectListRequest *collectListRequest = [[ZMCollectListRequest alloc] init];
    collectListRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    collectListRequest.pageNo = @"0";
    [collectListRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZMNewList *list = [ZMNewList modelWithJSON:request.responseObject[@"data"]];
        [self.dataSource addObjectsFromArray:list.list];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMCollectionCell" owner:nil options:nil].firstObject;
    }
    cell.item = self.dataSource[indexPath.row];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMNewListItem *item = self.dataSource[indexPath.row];
    ZMCollectRequest *collectRequest = [[ZMCollectRequest alloc] init];
    collectRequest.id = item.id;
    collectRequest.userid = item.userid;
    collectRequest.action = @"0";
    [collectRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        // 从数据源中删除
        [_dataSource removeObjectAtIndex:indexPath.row];
        // 从列表中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

@end
