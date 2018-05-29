//
//  ZMLessonTimeSettingController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonTimeSettingController.h"
#import "ZMLessTimeSettingCell.h"
#import "ZMServiceTimeListRequest.h"
#import "ZMLessonDetailSetController.h"
#import "ZMServiceTimeModel.h"
@interface ZMLessonTimeSettingController ()
@end

@implementation ZMLessonTimeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务时间";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.tableView.rowHeight = 80;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"refreshServiceTimeListNotification" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        [self request];
    }];
    [self request];
}

- (void)add {
    ZMLessonDetailSetController *detailSetVC = [[ZMLessonDetailSetController alloc] init];
    [self.navigationController pushViewController:detailSetVC animated:YES];
}

- (void)request {
    [MBProgressHUD showActivityMessageInView:nil];
    ZMServiceTimeListRequest *request = [[ZMServiceTimeListRequest alloc] init];
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccessMessage:@"请求成功"];
        self.dataSource = [NSArray modelArrayWithClass:[ZMServiceTimeModel class] json:request.responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMLessTimeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMLessTimeSettingCell" owner:nil options:nil].firstObject;
    }
    cell.model = self.dataSource[indexPath.row];    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMLessonDetailSetController *lessonDetailSetVC = [[ZMLessonDetailSetController alloc] init];
    lessonDetailSetVC.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:lessonDetailSetVC animated:YES];
}


@end
