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
#import "ZMHomeSectionView.h"
#import "ZMCancelOrderRequest.h"
#import "ZMRefoundLessonDetailVC.h"
#import "ZMRefoundLessonRequest.h"
#import "ZMLessonRecordVC.h"

@interface ZMOrderDetailViewController ()

@property (nonatomic, strong) ZMOrderDetailModel *detailModel;

@end

@implementation ZMOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self request];
    self.tableView.sectionFooterHeight = 10;
    
}

- (void)request {
    [MBProgressHUD showActivityMessageInView:@"加载中..."];
    ZMOrderDetailRequest *request = [[ZMOrderDetailRequest alloc] init];
    request.id = self.orderId;
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        self.detailModel = [ZMOrderDetailModel modelWithJSON:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)cancelOrder {
    ZMCancelOrderRequest *request = [[ZMCancelOrderRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.id = self.orderId;
    request.status = @"c70";
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"取消订单成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderListNotificatin" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    CGFloat realPrice = [self.detailModel.crealprice floatValue] / 100;
    CGFloat totalPrice = [self.detailModel.ctotalprice floatValue] / 100;
    ZMSettingItem *item01 = [[ZMSettingItem alloc] init];
    item01.title = @"优惠";
    item01.style = ZMSettingItemStyleLabel;
    item01.rightTitle = [NSString stringWithFormat:@"-%.2lf",totalPrice - realPrice];
    
    ZMSettingItem *item02 = [[ZMSettingItem alloc] init];
    item02.title = @"总价";
    item02.style = ZMSettingItemStyleLabel;
    item02.rightTitle = [NSString stringWithFormat:@"￥%.2lf",totalPrice];
    
    ZMSettingItem *item03 = [[ZMSettingItem alloc] init];
    item03.title = @"实付款";
    item03.style = ZMSettingItemStyleLabel;
    item03.rightTitle = [NSString stringWithFormat:@"￥%.2lf",realPrice];
    
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
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    self.tableView.tableFooterView = footerView;
    footerView.backgroundColor = [UIColor whiteColor];
    CGFloat btnW = 85;
    CGFloat btnH = 27;
    CGFloat btnSpacing = 17;
    NSMutableArray *titleArray;
    //a1提交b2通过b3已付款,b4不通过,b55退款中,b56已退款,c70取消订单
    if ([self.detailModel.status isEqualToString:@"a1"]) {
        titleArray = @[@"取消订单"].mutableCopy;
    } else if ([self.detailModel.status isEqualToString:@"b2"]) {
        titleArray = @[@"取消订单",@"立即支付"].mutableCopy;
    } else if ([self.detailModel.status isEqualToString:@"b3"]) {
        titleArray = @[@"退课"].mutableCopy;
    } else if ([self.detailModel.status isEqualToString:@"b55"]) {
        titleArray = @[@"取消退课",@"退课详情"].mutableCopy;
    } else if ([self.detailModel.status isEqualToString:@"b56"]) {
        titleArray = @[@"退课详情"].mutableCopy;
    }
    if (self.detailModel.cuse.integerValue > 0) {
        [titleArray addObject:@"上课记录"];
    }
    for (NSInteger i = titleArray.count; i > 0 ; i --) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 10 - (btnW + btnSpacing) * i, 0, btnW, btnH);
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        btn.centerY = footerView.height / 2;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:titleArray[i - 1] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 13;
        btn.layer.borderColor = ThemeGrayColor.CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
    }
    
    [self.tableView reloadData];
}

- (void)btnClick:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"评价"]) {
        ZMEvaluationVC *evaluationVC = [[ZMEvaluationVC alloc] init];
        evaluationVC.courseid = self.detailModel.cardid;
        evaluationVC.tid = self.detailModel.tid;
        [self.navigationController pushViewController:evaluationVC animated:YES];
    } else if ([button.currentTitle isEqualToString:@"取消订单"]){
        [self cancelOrder];
    } else if ([button.currentTitle isEqualToString:@"立即支付"]){
        NSLog(@"去支付");
    } else if ([button.currentTitle isEqualToString:@"退课"]){
//        NSLog(@"去支付");
        ZMRefoundLessonController *refoundLessonVC = [[ZMRefoundLessonController alloc] init];
        refoundLessonVC.detailModel = self.detailModel;
        [self.navigationController pushViewController:refoundLessonVC animated:YES];
    } else if ([button.currentTitle isEqualToString:@"取消退课"]){
        NSLog(@"去支付");
        [self cancelRefoundLesson];
    } else if ([button.currentTitle isEqualToString:@"退课详情"]) {
        ZMRefoundLessonDetailVC *refoundLessonDetailVC = [[ZMRefoundLessonDetailVC alloc] init];
        refoundLessonDetailVC.detailModel = self.detailModel;
        refoundLessonDetailVC.title = @"退课详情";
        [self.navigationController pushViewController:refoundLessonDetailVC animated:YES];
    } else if ([button.currentTitle isEqualToString:@"上课记录"]) {
        ZMLessonRecordVC *recordVC = [[ZMLessonRecordVC alloc] init];
        recordVC.title = @"上课记录";
        recordVC.orderid = self.detailModel.id;
        [self.navigationController pushViewController:recordVC animated:YES];
    }
}

- (void)cancelRefoundLesson {
    ZMRefoundLessonRequest *request = [[ZMRefoundLessonRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.id = self.orderId;
    request.status = @"b3";
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"取消退课申请成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        ZMHomeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"homeSectionView"];
        if (!sectionView) {
            sectionView = [[ZMHomeSectionView alloc] initWithReuseIdentifier:@"homeSectionView"];
        }
        sectionView.title = @"订单信息";
        sectionView.arrowButton.hidden = YES;
        return sectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 45;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 49;
    } else if (indexPath.section == 1) {
        return indexPath.row ? 50 : 141;
    } else {
        return 35;
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
//            cell.subject = [RACSubject subject];
//            @weakify(self)
//            [cell.subject subscribeNext:^(id  _Nullable x) {
//                @strongify(self)
//                ZMRefoundLessonController *refoundVC = [ZMRefoundLessonController new];                                                [self.navigationController pushViewController:refoundVC animated:YES];
//            }];
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
