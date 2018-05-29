//
//  ZMCountTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCountTableViewController.h"
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"
#import "ZMCountRequest.h"

@interface ZMCountTableViewController ()  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  NSArray *dataSource;
@end

@implementation ZMCountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计";
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self request];
}

- (void)request {
    ZMCountRequest *request = [[ZMCountRequest alloc] init];
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *requestInfo = request.responseObject[@"data"];
        ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计收入" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:requestInfo[@"money"]];
        
        ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计会员" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:requestInfo[@"member"]];
        
        ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计课时" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:requestInfo[@"course"]];
        self.dataSource = @[item01,item02,item03];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

@end
