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
#import "ZMOrderDetailRequest.h"
#import "ZMOrderDetailModel.h"
#import "ZMSettingCell.h"

@interface ZMOrderDetailViewController ()

@property (nonatomic, strong) ZMOrderDetailModel *detailModel;

@end

@implementation ZMOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self request];
    self.tableView.sectionFooterHeight = 10;
}

- (void)request {
    ZMOrderDetailRequest *request = [[ZMOrderDetailRequest alloc] init];
    request.id = self.orderId;
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.detailModel = [ZMOrderDetailModel modelWithJSON:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    
    ZMSettingItem *item01 = [[ZMSettingItem alloc] init];
    item01.title = @"优惠";
    item01.style = ZMSettingItemStyleLabel;
    item01.rightTitle = [NSString stringWithFormat:@"-%@",self.detailModel.cprice];
    
    ZMSettingItem *item02 = [[ZMSettingItem alloc] init];
    item02.title = @"总价";
    item02.style = ZMSettingItemStyleLabel;
    item02.rightTitle = [NSString stringWithFormat:@"￥%@",self.detailModel.ctotalprice];
    
    ZMSettingItem *item03 = [[ZMSettingItem alloc] init];
    item03.title = @"实付款";
    item03.style = ZMSettingItemStyleLabel;
    item03.rightTitle = [NSString stringWithFormat:@"￥%@",self.detailModel.crealprice];
    
    ZMSettingItem *item04 = [[ZMSettingItem alloc] init];
    item04.title = [NSString stringWithFormat:@"订单号:%@",self.detailModel.payno];
    
    ZMSettingItem *item05 = [[ZMSettingItem alloc] init];
    NSString *payType = [self.detailModel.paytype isEqualToString:@"0"] ? @"支付宝" : @"微信";
    
    item05.title = [NSString stringWithFormat:@"付款方式:%@",payType];
    
    ZMSettingItem *item06 = [[ZMSettingItem alloc] init];
    item06.title = [NSString stringWithFormat:@"创建时间:%@",self.detailModel.createDate];
    
    ZMSettingItem *item07 = [[ZMSettingItem alloc] init];
    item07.title = [NSString stringWithFormat:@"成交时间:%@",self.detailModel.paydate];
    
    ZMSettingItem *item08 = [[ZMSettingItem alloc] init];
    NSString *payStatus;
    if ([self.detailModel.status isEqualToString:@"a1"]) {
        payStatus = @"提交";
    } else if ([self.detailModel.status isEqualToString:@"b2"]) {
        payStatus = @"通过";
    } else if ([self.detailModel.status isEqualToString:@"b3"]) {
        payStatus = @"已付款";
    } else if ([self.detailModel.status isEqualToString:@"b4"]) {
        payStatus = @"不通过";
    } else if ([self.detailModel.status isEqualToString:@"b55"]) {
        payStatus = @"退款中";
    } else if ([self.detailModel.status isEqualToString:@"b56"]) {
        payStatus = @"已退款";
    } else if ([self.detailModel.status isEqualToString:@"c70"]) {
        payStatus = @"取消订单";
    }
    item08.title = [NSString stringWithFormat:@"订单状态:%@",payStatus];
    
    self.dataSource = @[@[item01,item02,item03],@[item04,item05,item06,item07,item08]];
    
    
    [self.tableView reloadData];
}

- (void)btnClick:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"评价"]) {
        ZMEvaluationVC *evaluationVC = [[ZMEvaluationVC alloc] init];
        evaluationVC.courseid = self.detailModel.cardid;
        evaluationVC.tid = self.detailModel.tid;
        [self.navigationController pushViewController:evaluationVC animated:YES];
    } else {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
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
            static NSString *ID = @"ZMOrderTableViewCell";
            ZMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderTableViewCell" owner:nil options:nil].lastObject;
            }
            cell.refoundClick.hidden = YES;
            cell.subject = [RACSubject subject];
            @weakify(self)
            [cell.subject subscribeNext:^(id  _Nullable x) {
                @strongify(self)
                ZMRefoundLessonController *refoundVC = [ZMRefoundLessonController new];                                                [self.navigationController pushViewController:refoundVC animated:YES];
            }];
            cell.detailModel = self.detailModel;
            return cell;
        } else {
            static NSString *ID = @"ZMSettingCell";
            ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
            }
            cell.model = self.dataSource[indexPath.section - 1][indexPath.row - 1];
            if ([cell.model.title isEqualToString:@"实付款"]) {
                cell.rightLabel.textColor = ThemeRedColor;
            } else {
                cell.rightLabel.textColor = ThemeColor;
            }
            return cell;
        }
    } else {
        static NSString *ID = @"ZMSettingCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];;
        }
        cell.model = self.dataSource[indexPath.section - 1][indexPath.row];
        cell.titleLabel.textColor = ThemeGrayColor;
        return cell;
    }    
}



@end
