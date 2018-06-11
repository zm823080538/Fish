//
//  ZMApplyListTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMApplyListTableViewController.h"
#import "ZMMemberApplyCell.h"
#import "ZMApplySaveRequest.h"
#import "ZMApplyListModel.h"
#import "ZMMemberApplyListRequest.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIViewController+YPTabBarController.h"
@interface ZMApplyListTableViewController () <ZMMemberApplyCellDelegate>
@property (nonatomic, strong) ZMApplyListModel *applyModel;
@end

@implementation ZMApplyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 82;
//    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self request];
}

- (void)request {
    ZMMemberApplyListRequest *request = [[ZMMemberApplyListRequest alloc] init];
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    request.pageNo = @"1";
    if ([self.yp_tabItemTitle isEqualToString:@"申请记录"]) {
        request.status = @"b";
    } else {
        if ([self.yp_tabItemTitle isEqualToString:@"体验课"]) {
            request.tryflag = @"1";
        } else {
            request.tryflag = @"0";
        }
        request.status = @"1";
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.applyModel = [ZMApplyListModel modelWithJSON:request.responseObject[@"data"]];
        [self.tableView reloadData];
//        self.dataSource = [ request.responseObject[@"data"]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.applyModel.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberApplyCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMMemberApplyCell class]) owner:nil options:nil].firstObject;
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    if ([self.yp_tabItemTitle isEqualToString:@"申请记录"]) {
        cell.applyStyle = ApplyStyleStyle2;
    } else {
        cell.applyStyle = ApplyStyleStyle1;
    }
    cell.item = self.applyModel.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)clickWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath {
     ZMApplyListModelItem *item = self.applyModel.list[indexPath.row];
    ZMApplySaveRequest *request = [[ZMApplySaveRequest alloc] init];
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    request.id = item.id;
    if ([title isEqualToString:@"通过"]) {
        request.status = @"b2";
    } else {
        request.status = @"b4";
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] integerValue] == 0)  {
            [self request];
            [MBProgressHUD showSuccessMessage:@"操作成功"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
