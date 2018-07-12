//
//  ZMRefoundLessonDetailVC.m
//  Fish
//
//  Created by sunny on 2018/7/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRefoundLessonDetailVC.h"
#import "ZMSettingCell.h"
#import "ZMNearMememberCell.h"
#import "ZMRefoundProgressCell.h"
#import "ZMHomeSectionView.h"

@interface ZMRefoundLessonDetailVC ()

@end

@implementation ZMRefoundLessonDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self updateUI];
}

- (void)updateUI {
    self.tableView.sectionFooterHeight = 10;
    ZMSettingItem *item01 = [[ZMSettingItem alloc] init];
    item01.title = @"退款金额";
    item01.style = ZMSettingItemStyleLabel;
    item01.rightTitle = self.detailModel.refundmoney;
    
    ZMSettingItem *item02 = [[ZMSettingItem alloc] init];
    item02.title = [NSString stringWithFormat:@"退课原因:%@",self.detailModel.cancelreason];
    item02.style = ZMSettingItemStyleLabel;
    
    ZMSettingItem *item03 = [[ZMSettingItem alloc] init];
    item03.title = [NSString stringWithFormat:@"申请时间:%@",self.detailModel.updateDate];
    item03.style = ZMSettingItemStyleLabel;
    
    ZMSettingItem *item04 = [[ZMSettingItem alloc] init];
    item04.title = [NSString stringWithFormat:@"退款编号:%@",self.detailModel.payno];
    item01.style = ZMSettingItemStyleLabel;
    
    ZMSettingItem *item05 = [[ZMSettingItem alloc] init];
    item05.descTitle = @"1";
    item05.title = @"申请已提交";
    item05.rightTitle = @"您的退课申请已提交，请耐心等待工作人员的审核";
    
    ZMSettingItem *item06 = [[ZMSettingItem alloc] init];
    item06.title = @"退款中";
    item06.descTitle = @"2";
    item06.style = ZMSettingItemStyleLabel;
    item06.rightTitle = @"您的退课申请正在等待教练通过，如果3天之后教练未处理我们将 自动把钱退给您！";
    
    ZMSettingItem *item07 = [[ZMSettingItem alloc] init];
    item07.title = @"退款成功";
    item07.descTitle = @"3";
    item07.rightTitle = @"您的退课由已转入到您的银行账户，请耐心等待。";
    self.dataSource =  @[@[item01],@[item02,item03,item04],@[item05,item06,item07]];
    [self.tableView reloadData];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        ZMHomeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"homeSectionView"];
        if (!sectionView) {
            sectionView = [[ZMHomeSectionView alloc] initWithReuseIdentifier:@"homeSectionView"];
        }
        sectionView.title = @"退款流程";
        sectionView.arrowButton.hidden = YES;
        return sectionView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 45;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 57;
    } else if (indexPath.section == 1) {
        return indexPath.row ? 40 : 98;
    } else {
        return 70;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 4;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *ID = @"ZMSettingCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        ZMSettingItem  *item = [[ZMSettingItem alloc] init];
        item.title = @"地址";
        item.rightTitle = self.detailModel.address;
        item.style = ZMSettingItemStyleLabel;
        [cell setModel:item];
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
            if (!cell ) {
                cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
            }
            ZMCourseListItem *item = [ZMCourseListItem modelWithJSON:[self.detailModel modelToJSONObject]];
            cell.item = item;
            cell.distanceLabel.text = [NSString stringWithFormat:@"ID:%@",self.detailModel.no];
            return cell;
        } else {
            static NSString *ID = @"ZMSettingCell";
            ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
            }
            cell.model = self.dataSource[indexPath.section][indexPath.row - 1];
            cell.titleLabel.textColor = ThemeGrayColor;
            return cell;
        }
    } else {
        static NSString *ID = @"ZMRefoundProgressCell";
        ZMRefoundProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMRefoundProgressCell" owner:nil options:nil].firstObject;
        }
        cell.item = self.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
}


@end
