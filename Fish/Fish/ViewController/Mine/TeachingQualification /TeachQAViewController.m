//
//  TeachQAViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "TeachQAViewController.h"
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"

@interface TeachQAViewController ()   <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;

@end

@implementation TeachQAViewController

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
    self.title = @"教学资质";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData {
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"从业时间" destinClassName:@"PersonalInfoViewController"];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"擅长领域" destinClassName:@"ZMCertificationViewController"];
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"成功案例" destinClassName:@""];
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"证书" destinClassName:@""];
    ZMPersonalModel   *item05 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"健身格言" destinClassName:@""];
    
    ZMPersonalModel   *item06 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"形象照" destinClassName:@""];
    ZMPersonalModel   *item07 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"申请晋升" destinClassName:@""];
    ZMPersonalModel   *item08 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"简历口述" destinClassName:@""];
    
    self.dataSource = @[item01,item02,item03,item04,item05,item06,item07,item08];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.style = PersonalInfoCellStyleArrow;
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    ZMPersonalModel  *item = self.dataSource[indexPath.section][indexPath.row];
    //    Class class = NSClassFromString(item.destinClassName);
    //    [self.navigationController pushViewController:[class new] animated:YES];
}

@end
