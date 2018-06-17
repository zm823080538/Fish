//
//  ZMGiveLessonController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGiveLessonController.h"
#import "ZMUserEditRequest.h"
@interface ZMGiveLessonController ()

@end

@implementation ZMGiveLessonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    NSString *string;
    if ([[ZMAccountManager shareManager].loginUser.remindme isEqualToString:@"0"]) {
        string = @"上课前提醒";
    } else if ([[ZMAccountManager shareManager].loginUser.remindme isEqualToString:@"1"]) {
         string = @"一小时提醒";
    } else if ([[ZMAccountManager shareManager].loginUser.remindme isEqualToString:@"2"]) {
         string = @"两小时提醒";
    } else if ([[ZMAccountManager shareManager].loginUser.remindme isEqualToString:@"9"]) {
         string = @"不提醒";
    }
     ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"上课前" destinClassName:nil style:PersonalInfoCellStyleLabelArrow subTitle:string];
    self.dataSource = @[item01];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
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
        [ZMAccountManager shareManager].loginUser.remindme = item01.subTitle;
    }];
}

@end
