//
//  ZMOrderDetailViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/15.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderDetailViewController.h"
#import <ReactiveObjC.h>
#import "ZMOrderAddressCell.h"
#import "ZMOrderTableViewCell.h"
#import "ZMOrderDescCell.h"
@interface ZMOrderDetailViewController ()

@end

@implementation ZMOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    self.tableView.tableFooterView = footerView;
    CGFloat btnW = 85;
    CGFloat btnH = 27;
    CGFloat btnSpacing = 17;
    NSArray *titleArr = @[@"删除订单",@"评价"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 10 - (btnW + btnSpacing) * i, 0, btnW, btnH);
        [btn setTitleColor:UIColorFromRGB(0x8996AA) forState:UIControlStateNormal];
        btn.centerY = footerView.centerY;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 13;
        btn.layer.borderColor = UIColorFromRGB(0x8996AA).CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)button {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 49;
    } else if (indexPath.section == 1) {
        return indexPath.row ? 50 : 140;
    } else {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 4;
    if (section == 2) return 5;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *ID = @"ZMOrderAddressCell";
        ZMOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderAddressCell" owner:nil options:nil].firstObject;
        }
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *ID = @"ZMOrderTableViewCell";
            ZMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderTableViewCell" owner:nil options:nil].lastObject;
            }
            return cell;
        } else {
            static NSString *ID = @"ZMOrderDescCell";
            ZMOrderDescCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[ZMOrderDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
            }
            cell.leftLabel.text = @"优惠";
            cell.rightLabel.text = @"100";
            return cell;
        }
    } else {
        static NSString *ID = @"ZMOrderDescCell2";
        ZMOrderDescCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ZMOrderDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
        }
        cell.leftLabel.text = @"订单号：123123123";
        cell.rightLabel.hidden = YES;
        return cell;
    }
    return nil;
    
}



@end
