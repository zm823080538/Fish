//
//  ZMWeiduTableViewController.m
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMWeiduTableViewController.h"
#import "ZMSettingCell.h"
#import "ZMRecordDetailCell.h"
@interface ZMWeiduTableViewController ()

@end

@implementation ZMWeiduTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self configData];
    
}

- (void)finish {
    [self.subject sendNext:self.model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configData {
    ZMSettingItem *item = [[ZMSettingItem alloc] init];
    item.title = @"胸";
    item.descTitle = @"单位:cm";
    item.rightTitle = self.model.wdxiong;
    
    ZMSettingItem *item01 = [[ZMSettingItem alloc] init];
    item01.title = @"腰";
    item01.descTitle = @"单位:cm";
    item01.rightTitle = self.model.wdyao;
    
    ZMSettingItem *item02 = [[ZMSettingItem alloc] init];
    item02.title = @"小腿";
    item02.rightTitle = self.model.wdxiaotui;
    item02.descTitle = @"单位:cm";
    
    ZMSettingItem *item03 = [[ZMSettingItem alloc] init];
    item03.title = @"大腿";
    item03.rightTitle = self.model.wddatui;
    item03.descTitle = @"单位:cm";
    
    ZMSettingItem *item04 = [[ZMSettingItem alloc] init];
    item04.title = @"大臂";
    item04.descTitle = @"单位:cm";
    item04.rightTitle = self.model.wddabi;
    
    ZMSettingItem *item05 = [[ZMSettingItem alloc] init];
    item05.title = @"小臂";
    item05.descTitle = @"单位:cm";
    item05.rightTitle = self.model.wdxiaobi;
    
    ZMSettingItem *item06 = [[ZMSettingItem alloc] init];
    item06.title = @"臀";
    item06.descTitle = @"单位:cm";
    item06.rightTitle = self.model.wdtun;
    self.dataSource = @[item,item01,item02,item03,item04,item05,item06];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        ZMRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMRecordDetailCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMRecordDetailCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZMSettingItem *item = self.dataSource[indexPath.row];
        cell.leftLabel.text = item.title;
        cell.rightTextField.text = item.rightTitle;
        cell.unitLabel.text = item.descTitle;
    [cell.rightTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if ([item.title isEqualToString:@"胸"]) {
            self.model.wdxiong = x;
        } else if ([item.title isEqualToString:@"腰"]) {
            self.model.wdyao = x;
        } else if ([item.title isEqualToString:@"小腿"]) {
            self.model.wdxiaotui = x;
        } else if ([item.title isEqualToString:@"大腿"]) {
            self.model.wddatui = x;
        } else if ([item.title isEqualToString:@"大臂"]) {
            self.model.wddabi = x;
        } else if ([item.title isEqualToString:@"小臂"]) {
            self.model.wdxiaobi = x;
        } else if ([item.title isEqualToString:@"臀"]) {
            self.model.wdtun = x;
        }
    }];
        return cell;
}


@end
