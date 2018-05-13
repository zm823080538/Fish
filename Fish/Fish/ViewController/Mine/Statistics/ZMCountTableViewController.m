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

@interface ZMCountTableViewController ()  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  NSArray *dataSource;
@end

@implementation ZMCountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计";
    self.tableView.rowHeight = 50;
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计收入" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"￥240"];
    
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计会员" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"24个"];
    
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"累计课时" destinClassName:@"" style:PersonalInfoCellStyleLabel subTitle:@"60课时"];
    self.dataSource = @[item01,item02,item03];
    self.tableView.tableFooterView = [UIView new];
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
