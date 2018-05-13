//
//  ZMMemberApplyCell.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberApplyCell.h"

@interface ZMMemberApplyCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UIButton *passButton;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;

@end

@implementation ZMMemberApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (void)setApplyStyle:(ApplyStyle)applyStyle {
    _applyStyle = applyStyle;
    if (applyStyle == ApplyStyleStyle1) {
        self.passStatusLabel.hidden = YES;
        self.passButton.hidden = self.refuseButton.hidden = NO;
        self.refuseButton.layer.borderColor = self.passButton.layer.borderColor = UIColorFromRGB(0x4A576A).CGColor;
        self.refuseButton.layer.borderWidth = self.passButton.layer.borderWidth = 1;
    } else {
        self.passStatusLabel.hidden = NO;
        self.passButton.hidden = self.refuseButton.hidden = YES;
    }
}

@end
