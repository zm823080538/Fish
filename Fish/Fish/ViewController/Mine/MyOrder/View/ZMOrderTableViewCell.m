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


@end

@implementation ZMOrderTableViewCell

- (IBAction)refoundBtnClick {
    [self.subject sendNext:nil];
    NSLog(@"refound");
}

- (void)setDetailModel:(ZMOrderDetailModel *)detailModel {
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
    self.orderPriceLabel.text = [NSString stringWithFormat:@"￥%@",detailModel.cprice];
    self.resultLessonLabel.text = [NSString stringWithFormat:@"剩余课时(%@ / %@)",detailModel.cuse,detailModel.csum];
    self.orderStatusLabel.text = [NSString stringWithFormat:@"%@(%@)",detailModel.ctypename,detailModel.coursetypenames];
//    self.orderCountLabel.text = [NSString stringWithFormat:@"x%@",detailModel.]
}

- (IBAction)click:(id)sender {
}

@end
