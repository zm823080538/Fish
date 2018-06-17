//
//  ZMLessonPriceTableViewController.m
//  Fish
//
//  Created by sunny on 2018/6/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonPriceTableViewController.h"
#import "ZMLessonPriceDetailViewController.h"
@interface ZMLessonPriceTableViewController ()

@end

@implementation ZMLessonPriceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"普通课" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:@"200"];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"专业课" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:@"200"];
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"特色课" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:@"200"];

    self.dataSource = @[item01,item02,item03];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMLessonPriceDetailViewController *vc = [ZMLessonPriceDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
