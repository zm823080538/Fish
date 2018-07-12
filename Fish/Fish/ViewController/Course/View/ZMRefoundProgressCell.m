//
//  ZMRefoundProgressCell.m
//  Fish
//
//  Created by sunny on 2018/7/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRefoundProgressCell.h"

@interface ZMRefoundProgressCell ()
@property (weak, nonatomic) IBOutlet UILabel *NoLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ZMRefoundProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(ZMSettingItem *)item {
    if ([item.descTitle isEqualToString:@"1"]) {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.NoLabel);
            make.width.mas_equalTo(1);
            make.top.equalTo(self.NoLabel.mas_bottom);
        }];
        self.NoLabel.backgroundColor = ThemeColor;
    } else if ([item.descTitle isEqualToString:@"3"]) {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.NoLabel);
            make.width.mas_equalTo(1);
            make.bottom.equalTo(self.NoLabel.mas_top);
        }];
        self.NoLabel.backgroundColor = ThemeGrayColor;
    } else {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.NoLabel);
            make.width.mas_equalTo(1);
            make.top.bottom.equalTo(self);
        }];
        self.NoLabel.backgroundColor = ThemeColor;
    }
    self.NoLabel.text = item.descTitle;
    self.stepLabel.text = item.title;
    self.detailLabel.text = item.rightTitle;
}


@end
