//
//  PersonalInfoViewController.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoCell.h"
#import "ZMPersonalModel.h"
@interface PersonalInfoViewController ()  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;

@end

@implementation PersonalInfoViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadData {
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:@"result" title:@"头像" destinClassName:@"" style:PersonalInfoCellStyleImage subTitle:@""];
    
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:@"member_addUser" title:@"昵称" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"哈哈"];
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:@"order" title:@"性别" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"女"];
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"地址" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"四川-成都"];
    ZMPersonalModel   *item05 = [[ZMPersonalModel   alloc] initWithImage:@"customService" title:@"我的二维码" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"哈哈"];
    
    ZMPersonalModel   *item06 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"绑定微信号" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"哈哈"];
    ZMPersonalModel   *item07 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改手机号" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"哈哈"];
    
     ZMPersonalModel   *item08 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改登录密码" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"哈哈"];
    self.dataSource = @[@[item01,item02,item03,item04,item05],@[item06,item07,item08]];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMPersonalModel  *item = self.dataSource[indexPath.section][indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZMPersonalModel  *item = self.dataSource[indexPath.section][indexPath.row];
//    Class class = NSClassFromString(item.destinClassName);
//    [self.navigationController pushViewController:[class new] animated:YES];
}


@end
