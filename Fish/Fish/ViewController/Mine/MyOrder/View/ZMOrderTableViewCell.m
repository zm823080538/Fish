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
@property (weak, nonatomic) IBOutlet UIButton *operationBtn1;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn2;

@end

@implementation ZMOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
