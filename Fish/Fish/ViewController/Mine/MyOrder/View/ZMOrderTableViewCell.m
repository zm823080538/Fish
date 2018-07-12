//
//  ZMOrderTableViewCell.m
//  Fish
//
//  Created by zhaoming on 2018/6/14.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderTableViewCell.h"

@interface ZMOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *userAgeButton;
@property (weak, nonatomic) IBOutlet UILabel *lessonTotalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLessonLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *ID1Label;


@end

@implementation ZMOrderTableViewCell

- (IBAction)refoundBtnClick {
    [self.subject sendNext:nil];
    NSLog(@"refound");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.operationBtn1.layer.borderColor = ThemeGrayColor.CGColor;
    self.operationBtn1.layer.borderWidth = 1;
}

- (void)setDetailModel:(ZMOrderDetailModel *)detailModel {
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号:%@",detailModel.payno];
    [self.userIconImageView setImageWithURL:[NSURL URLWithString:detailModel.img] options:YYWebImageOptionProgressive];
    self.usernameLabel.text = detailModel.nickname;
    [self.userAgeButton setTitle:detailModel.age forState:UIControlStateNormal];
    if ([detailModel.sex isEqualToString:@"1"]) {
        [self.userAgeButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
        [self.userAgeButton setBackgroundColor:UIColorFromRGB(0x82C9F9)];
    } else {
        [self.userAgeButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
        [self.userAgeButton setBackgroundColor:UIColorFromRGB(0xF497B6)];
    }
    self.IDLabel.text = detailModel.no;
    self.orderPriceLabel.textColor = ThemeRedColor;
    self.orderPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[detailModel.ctotalprice floatValue] / 100];
    self.lessonCountLabel.text = [NSString stringWithFormat:@"共%@节课",detailModel.csum];
    self.resultLessonLabel.text = [NSString stringWithFormat:@"剩余课时(%@ / %@)",detailModel.cuse,detailModel.csum];
    
    //订单列表
    self.lessonTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[detailModel.ctotalprice floatValue] / 100];
    self.lessonCountLabel.text = [NSString stringWithFormat:@"共%@节课",detailModel.csum];
    self.orderDescLabel.text = [NSString stringWithFormat:@"%@(%@)",detailModel.ctypename,detailModel.coursetypenames];
    [self configStatus:detailModel.status];
}

- (void)configStatus:(NSString *)status {
    self.bottomConstraint.constant = 45;
    if ([status isEqualToString:@"a1"]) {
        self.orderStatusLabel.text = @"待接单";
        self.operationBtn2.hidden = YES;
        [self.operationBtn1 setTitle:@"取消订单" forState:UIControlStateNormal];
    } else if ([status isEqualToString:@"b2"]) {
        self.orderStatusLabel.text = @"待付款";
        [self.operationBtn1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.operationBtn2 setTitle:@"立即支付" forState:UIControlStateNormal];
    } else if ([status isEqualToString:@"b3"]) {
        self.orderStatusLabel.text = @"已完成";
        self.operationBtn2.hidden = YES;
        [self.operationBtn1 setTitle:@"退课" forState:UIControlStateNormal];
    } else if ([status isEqualToString:@"c70"] || [status isEqualToString:@"b4"] || [status isEqualToString:@"b56"]) {
        if ([status isEqualToString:@"b56"]) {
            self.orderStatusLabel.text = @"已退款";
        } else if ([status isEqualToString:@"b4"]) {
            self.orderStatusLabel.text = @"未通过";
        }
        self.bottomConstraint.constant = 10;
        self.operationBtn2.hidden = YES;
        self.operationBtn1.hidden = YES;
    } else if ([status isEqualToString:@"b55"]) {
        self.orderStatusLabel.text = @"退款中";
        self.operationBtn2.hidden = YES;
        [self.operationBtn1 setTitle:@"取消退课" forState:UIControlStateNormal];
    }
    
}

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [[RACSubject alloc] init];
        
    }
    return _subject;
}

- (IBAction)click:(UIButton *)sender {
    [self.subject sendNext:sender.currentTitle];
    
}

@end
