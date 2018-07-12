//
//  ZMLessonRecordVC.m
//  Fish
//
//  Created by sunny on 2018/7/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonRecordVC.h"
#import "ZMCourseListRequest.h"
#import "ZMCourseListModel.h"
#import "ZMCourseDetailViewController.h"
@interface ZMLessonRecordVC ()

@end

@implementation ZMLessonRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
   
}

- (void)request {
    [MBProgressHUD showActivityMessageInView:@"加载中..."];
    ZMCourseListRequest *request = [[ZMCourseListRequest alloc] init];
    //        1关注2黑名单3已接单
    if (IS_COACH) {
        request.tid = [ZMAccountManager shareManager].loginUser.id;
    } else {
        request.uid = [ZMAccountManager shareManager].loginUser.id;
    }
    request.orderid = self.orderid;
    request.status = @"2";;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccessMessage:@"加载成功"];
        self.dataSource = [NSArray modelArrayWithClass:[ZMCourseListItem class] json:request.responseObject[@"data"][@"list"]];
        
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:@"加载失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMCourseListItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.updateDate;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = ThemeColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMCourseDetailViewController *detailVC = [ZMCourseDetailViewController new];
    detailVC.course = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
