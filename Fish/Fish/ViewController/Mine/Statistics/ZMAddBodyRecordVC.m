//
//  ZMAddBodyRecordVC.m
//  Fish
//
//  Created by zhaoming on 2018/6/28.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMAddBodyRecordVC.h"
#import "ZMRecordDetailCell.h"
#import "ZMSettingCell.h"
@interface ZMAddBodyRecordVC ()
@property (nonatomic, strong) ZMSettingItem *item;
@end

@implementation ZMAddBodyRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加数据";
    self.tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.item = [[ZMSettingItem  alloc] initWithImage:nil title:@"时间选择" destinClassName:nil];
    self.item.rightTitle = @"2016";
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
        NSLog(@"commit");
    }];
    [footerView addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 49));
    }];
    self.tableView.tableFooterView = footerView;
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineTableViewCell"];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMMineTableViewCell"];
        }
        [cell setModel:self.item];
        return cell;
    } else {
        ZMRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMRecordDetailCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMRecordDetailCell" owner:nil options:nil].firstObject;
        }
        return cell;
    }
}
@end
