//
//  ZMMessageListController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMessageListController.h"
#import "ZMNearMememberCell.h"
#import "ZMMsgListRequest.h"
@interface ZMMessageListController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataSource;


@end

@implementation ZMMessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 82;
    self.tableView.tableFooterView = [UIView new];
    [self request];
}

- (void)request {
    ZMMsgListRequest *requst = [[ZMMsgListRequest alloc] init];
    requst.id = [ZMAccountManager shareManager].loginUser.id;
    requst.pageNo = @"1";
    [requst startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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






@end
