//
//  ZMBodyRecordListVC.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyRecordListVC.h"
#import "ZMBodyRecordDetailVC.h"
#import "ZMAddBodyRecordVC.h"
#import "ZMBodyDataListRequest.h"
#import "ZMBodyDataModel.h"
@interface ZMBodyRecordListVC ()
@property (nonatomic, strong) ZMBodyDataModel *dataModel;
@end

@implementation ZMBodyRecordListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身体数据记录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addRecord)];
    self.tableView.rowHeight = 65;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"ZMRefreshBodyRecordListNotification" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        [self request];
    }];
    [self request];
}

- (void)request {
    [MBProgressHUD showActivityMessageInView:@"加载中..."];
    ZMBodyDataListRequest *request = [[ZMBodyDataListRequest alloc] init];
    request.userid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        self.dataModel = [ZMBodyDataModel modelWithJSON:request.responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)addRecord {
    ZMBodyRecordDetailVC *detailVC = [ZMBodyRecordDetailVC new];
    detailVC.title = @"添加数据";
    [self.navigationController pushViewController:detailVC animated:YES];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    BodyList *model = self.dataModel.list[indexPath.row];
    cell.textLabel.text = model.writedate;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = ThemeColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BodyList *model = self.dataModel.list[indexPath.row];
    ZMBodyRecordDetailVC *detailVC = [ZMBodyRecordDetailVC new];
    detailVC.title = model.writedate;
    detailVC.model = self.dataModel.list[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
