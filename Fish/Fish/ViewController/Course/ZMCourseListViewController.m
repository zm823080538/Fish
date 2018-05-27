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
#import <NSObject+YYModel.h>
#import "ZMAccountManager.h"
#import <MJRefreshFooter.h>
#import "ZMCourseListModel.h"
#import "ZMCourseDetailViewController.h"
#import "UIViewController+YPTabBarController.h"
@interface ZMCourseListViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger currentPage;

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
    self.dataSource = @[].mutableCopy;
    self.currentPage = 1;
    if ([self.yp_tabItemTitle isEqualToString:@"已结束"]) {
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(request)];
    }
    [self request];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)request {
    ZMCourseListRequest *request = [[ZMCourseListRequest alloc] init];
        //        1关注2黑名单3已接单
        NSString *status = @"";
        if ([self.yp_tabItemTitle isEqualToString:@"进行中"]) {
            status = @"1";
        } else if ([self.yp_tabItemTitle isEqualToString:@"已结束"]) {
            status = @"2";
            request.pageNo = [NSString stringWithFormat:@"%ld",self.currentPage];
        }
        request.tid = [ZMAccountManager shareManager].loginUser.id;
        request.status = status;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSArray *list = [NSArray modelArrayWithClass:[ZMCourseListItem class] json:request.responseObject[@"data"][@"list"]];

            if ([self.yp_tabItemTitle isEqualToString:@"已结束"]) {
                NSInteger totalPage = [request.responseObject[@"data"][@"totalPage"] intValue];
                [self.dataSource addObjectsFromArray:list];
                self.currentPage ++;
                if (self.currentPage == totalPage) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            } else {
                self.dataSource = list.mutableCopy;
            }
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
}




- (void)searchViewClick {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    cell.item = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMCourseDetailViewController *courseDetailVC = [[ZMCourseDetailViewController alloc] init];
    courseDetailVC.type =  [self.yp_tabItemTitle isEqualToString:@"进行中"] ? 0 : 1;
    courseDetailVC.course = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}

@end
