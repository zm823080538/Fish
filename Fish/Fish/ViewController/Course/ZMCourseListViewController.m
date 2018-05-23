//
//  ZMCourseListViewController.m
//  Fish
//
//  Created by zhaoming on 06/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMCourseListViewController.h"
#import "ZMNearMememberCell.h"
#import "ZMCourseListRequest.h"
#import "ZMAccountManager.h"
#import "ZMCourseDetailViewController.h"
#import "UIViewController+YPTabBarController.h"
@interface ZMCourseListViewController ()

@end

@implementation ZMCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headerView.backgroundColor = UIColorFromRGB(0xF3F3F3);
    self.tableView.tableHeaderView = headerView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self request];
}

- (void)request {
        //        1关注2黑名单3已接单
        NSString *status = @"";
        if ([self.yp_tabItemTitle isEqualToString:@"进行中"]) {
            status = @"1";
        } else if ([self.yp_tabItemTitle isEqualToString:@"已结束"]) {
            status = @"2";
        }
        ZMCourseListRequest *request = [[ZMCourseListRequest alloc] init];
        request.tid = [ZMAccountManager shareManager].loginUser.id;
        request.status = status;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//            self.dataSource = [NSArray modelArrayWithClass:[ZMMemberModel class] json:request.responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
}




- (void)searchViewClick {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMCourseDetailViewController *courseDetailVC = [[ZMCourseDetailViewController alloc] init];
    courseDetailVC.type =  [self.yp_tabItemTitle isEqualToString:@"进行中"] ? 0 : 1;
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}

@end
