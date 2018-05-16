//
//  ZMSettingTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSettingTableViewController.h"
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"

@interface ZMSettingTableViewController ()  <UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic)  NSArray *dataSource;
@end

@implementation ZMSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self loadData];
}

- (void)loadData {
//    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"个人资料" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
//
//    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"语言设置" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"课程时间设置" destinClassName:@"ZMGiveLessonController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"课程提醒设置" destinClassName:@"ZMLessonTimeSettingController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    self.dataSource = @[item03,item04];
    [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    Class class = NSClassFromString(item.destinClassName);
    UIViewController *vc = [class new];
    vc.title = item.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
