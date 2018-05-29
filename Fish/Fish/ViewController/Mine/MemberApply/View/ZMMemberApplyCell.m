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
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation ZMMemberApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}
- (IBAction)click:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithTitle:indexPath:)]) {
        [self.delegate clickWithTitle:sender.currentTitle indexPath:self.indexPath];
    }
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

- (void)setItem:(ZMApplyListModelItem *)item {
    self.nameLabel.text = item.nickname;
    self.titleLabel.text = item.coursetypenames;
    //a1已提交b2通过b3完成付款,b4不通过
    NSString *string = @"";
    if ([item.status isEqualToString:@"a1"]) {
        string = @"已提交";
    } else if ([item.status isEqualToString:@"b2"]) {
         string = @"通过";
    } else if ([item.status isEqualToString:@"b3"]) {
        string = @"完成付款";
    } else if ([item.status isEqualToString:@"b4"]) {
        string = @"不通过";
    }
    self.passStatusLabel.text = string;
    self.distanceLabel.text = item.distance;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:item.img] placeholder:PlaceholderImage];
}

@end
