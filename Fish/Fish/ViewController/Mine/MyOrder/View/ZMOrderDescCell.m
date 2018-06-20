//
//  ZMOrderDescCell.m
//  Fish
//
//  Created by zhaoming on 2018/6/15.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderDescCell.h"


@implementation ZMOrderDescCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.centerY.equalTo(self);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-14);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = UIColorFromRGB(0x4A576A);
        _leftLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = UIColorFromRGB(0x4A576A);
        _rightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _rightLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
