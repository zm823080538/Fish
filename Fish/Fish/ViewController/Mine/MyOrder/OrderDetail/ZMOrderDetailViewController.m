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
#import "ZMRefoundLessonController.h"
#import "ZMEvaluationVC.h"
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
    for (NSInteger i = titleArr.count; i > 0 ; i --) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 10 - (btnW + btnSpacing) * i, 0, btnW, btnH);
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        btn.centerY = footerView.height / 2;
        [btn setTitle:titleArr[i - 1] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 13;
        btn.layer.borderColor = ThemeGrayColor.CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"评价"]) {
        ZMEvaluationVC *evaluationVC = [[ZMEvaluationVC alloc] init];
        [self.navigationController pushViewController:evaluationVC animated:YES];
    } else {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 49;
    } else if (indexPath.section == 1) {
        return indexPath.row ? 50 : 141;
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
            cell.subject = [RACSubject subject];
            @weakify(self)
            [cell.subject subscribeNext:^(id  _Nullable x) {
                @strongify(self)
                ZMRefoundLessonController *refoundVC = [ZMRefoundLessonController new];                                                [self.navigationController pushViewController:refoundVC animated:YES];
            }];
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
}



@end
