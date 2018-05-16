//
//  ZMLessonDaySettingController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonDaySettingController.h"

@interface ZMLessonDaySettingController ()
@property (nonatomic, strong) NSMutableArray *selectList;
@end

@implementation ZMLessonDaySettingController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上课时间设置";
    self.tableView.rowHeight = 48;
    self.selectList = @[].mutableCopy;
    self.dataSource = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *dayString = self.dataSource[indexPath.row];
    if (![self.selectList containsObject:dayString]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.selectList addObject:dayString];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [self.selectList removeObject:dayString];
    }
}

@end
