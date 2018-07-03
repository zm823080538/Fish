//
//  ZMBodyRecordDetailVC.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyRecordDetailVC.h"
#import "ZMRecordDetailCell.h"
#import "ZMSettingCell.h"
#import "ZMBodyDataSaveRequest.h"
#import "ZMWeiduTableViewController.h"
#import <PGDatePicker.h>
@interface ZMBodyRecordDetailVC () <PGDatePickerDelegate>
@property (nonatomic, strong) ZMSettingItem *item;
@end

@implementation ZMBodyRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.item = [[ZMSettingItem  alloc] initWithImage:nil title:@"时间选择" destinClassName:nil];
    self.item.rightTitle = self.model.writedate;
    self.item.style = ZMSettingItemStyleLabelArrow;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tableView.sectionFooterHeight = 20;
    footerBtn.backgroundColor = ThemeColor;
    [footerBtn setTitle:@"保存" forState:UIControlStateNormal];
    footerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [[footerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self commit];
    }];
    [footerView addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 49));
    }];
    self.tableView.tableFooterView = footerView;
    
    [self configData];
    
}

- (void)commit {
    ZMBodyDataSaveRequest *request = [[ZMBodyDataSaveRequest alloc] init];
    if (self.model) {
        request.id = self.model.id;
    }
    request.userid = [ZMAccountManager shareManager].loginUser.id;
    request.writedate = self.model.writedate;
    request.height = self.model.height;
    request.weight = self.model.weight;
    request.bmr = self.model.bmr;
    request.bodywater = self.model.bodywater;
    request.fat = self.model.fat;
    request.wdxiong = self.model.wdxiong;
    request.wdyao = self.model.wdyao;
    request.wddatui = self.model.wddatui;
    request.wdxiaotui = self.model.wdxiaotui;
    request.wddabi = self.model.wddabi;
    request.wdxiaobi = self.model.wdxiaobi;
    request.wdtun = self.model.wdtun;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZMRefreshBodyRecordListNotification" object:nil];
        [MBProgressHUD showSuccessMessage:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)configData {
    ZMSettingItem *item = [[ZMSettingItem alloc] init];
    item.title = @"您的最新体重";
    item.descTitle = @"单位:kg";
    item.rightTitle = self.model.weight;
    
    ZMSettingItem *item01 = [[ZMSettingItem alloc] init];
    item01.title = @"身高";
    item01.descTitle = @"单位:cm";
    item01.rightTitle = self.model.height;
    
    ZMSettingItem *item02 = [[ZMSettingItem alloc] init];
    item02.title = @"体脂";
    item02.rightTitle = self.model.fat;
    item02.descTitle = @"单位:%";
    
    ZMSettingItem *item03 = [[ZMSettingItem alloc] init];
    item03.title = @"基础代谢";
    item03.rightTitle = self.model.bmr;
    item03.descTitle = @"单位:%";
    
   
    
    ZMSettingItem *item04 = [[ZMSettingItem alloc] init];
    item04.title = @"身体水分";
    item04.descTitle = @"单位:%";
    item04.rightTitle = self.model.bodywater;
    
    ZMSettingItem *item05 = [[ZMSettingItem alloc] init];
    item05.title = @"维度";
    item05.rightTitle = self.model.weight;
    self.dataSource = @[item,item01,item02,item03,item04,item05];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 66;
    }
    return 97;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineTableViewCell"];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMMineTableViewCell"];
        }
        [cell setModel:self.item];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == self.dataSource.count -1){
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMWeiduTableViewCell"];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMWeiduTableViewCell"];
        }
        ZMSettingItem *item = [[ZMSettingItem alloc] initWithImage:nil title:@"维度" destinClassName:@"ZMWeiduTableViewController"];
        item.style = ZMSettingItemStyleArrow;
        [cell setModel:item];
        return cell;
    } else {
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
            if ([item.title isEqualToString:@"您的最新体重"]) {
                self.model.weight = x;
            } else if ([item.title isEqualToString:@"身高"]) {
                self.model.height = x;
            } else if ([item.title isEqualToString:@"体脂"]) {
                self.model.fat = x;
            } else if ([item.title isEqualToString:@"基础代谢"]) {
                self.model.bmr = x;
            } else if ([item.title isEqualToString:@"身体水分"]) {
                self.model.bodywater = x;
            }
        }];
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        PGDatePicker *datePicker = [[PGDatePicker alloc]init];
        datePicker.delegate = self;
        [datePicker show];
        datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
    }
    if (indexPath.section == 1 && indexPath.row == self.dataSource.count - 1) {
        ZMWeiduTableViewController *weiduTableVC = [ZMWeiduTableViewController new];
        weiduTableVC.title = @"维度";
        weiduTableVC.model = self.model;
        weiduTableVC.subject = [RACSubject subject];
        [weiduTableVC.subject subscribeNext:^(BodyList * _Nullable x) {
            self.model = x;
        }];
        [self.navigationController pushViewController:weiduTableVC animated:YES];
    }
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    ZMSettingCell *cell = (ZMSettingCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *month = dateComponents.month < 10 ? [NSString stringWithFormat:@"0%ld",dateComponents.month] : [NSString stringWithFormat:@"%ld",dateComponents.month];
    NSString *day = dateComponents.day < 10 ? [NSString stringWithFormat:@"0%ld",dateComponents.day] : [NSString stringWithFormat:@"%ld",dateComponents.day];
    NSString *hour = dateComponents.hour < 10 ? [NSString stringWithFormat:@"0%ld",dateComponents.hour] : [NSString stringWithFormat:@"%ld",dateComponents.hour];
    NSString *minute = dateComponents.minute < 10 ? [NSString stringWithFormat:@"0%ld",dateComponents.minute] : [NSString stringWithFormat:@"%ld",dateComponents.minute];
    cell.rightLabel.text = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@",dateComponents.year,month,day,hour,minute];
    self.model.writedate = cell.rightLabel.text;
}




@end
