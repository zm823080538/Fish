//
//  ZMGiveLessonController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGiveLessonController.h"

@interface ZMGiveLessonController ()

@end

@implementation ZMGiveLessonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
     ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"上课前" destinClassName:nil style:PersonalInfoCellStyleLabelArrow subTitle:@"1小时提醒"];
    self.dataSource = @[item01];
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
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *otherTitles = @[@"上课前提醒",@"1小时提醒",@"2小时前提醒",@"不提醒"];
    [UIAlertController alertWithTitle:nil message:nil cancelTitle:@"取消" otherTitles:otherTitles preferredStyle:UIAlertControllerStyleActionSheet completion:^(NSInteger index) {
        ZMPersonalModel *item01 = self.dataSource.firstObject;
        item01.subTitle = otherTitles[index];
        [self.tableView reloadData];
        
    }];
}

@end
