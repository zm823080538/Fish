//
//  ZMMustReadTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMustReadTableViewController.h"
#import "ZMPersonalModel.h"
@interface ZMMustReadTableViewController ()

@end

@implementation ZMMustReadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"服务职责" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"服务流程" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"评论机制" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    self.dataSource = @[item01,item02,item03];
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



@end
