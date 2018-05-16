//
//  ZMLessTimeSettingCell.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessTimeSettingCell.h"

@interface ZMLessTimeSettingCell ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ZMLessTimeSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.openSwitch.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
