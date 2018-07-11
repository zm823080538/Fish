//
//  ZMMineTableViewCell.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMSettingCell.h"
#import "ZMSettingItem.h"

@interface ZMSettingCell()

@end

@implementation ZMSettingCell

- (void)updateUI {
   self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_model.image) {
        
        [self.contentView addSubview:self.leftImageView];
        if (_model.style == ZMSettingItemStyleRightImage) {
            [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(34, 34));                make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
                make.centerY.equalTo(self.contentView);
            }];
        } else {
            [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(20, 20));
                make.left.mas_equalTo(21);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    if (_model.title) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_model.image && _model.style != ZMSettingItemStyleRightImage) {
                make.left.mas_equalTo(57);
            } else {
                make.left.mas_equalTo(21);
            }
            make.centerY.equalTo(self.contentView);
        }];
    }
   
    if (_model.style == ZMSettingItemStyleArrow || _model.style == ZMSettingItemStyleLabelArrow) {
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(9, 15));
            make.centerY.equalTo(self.contentView);            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
        }];
    }
    if (_model.rightTitle) {
        [self.contentView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);           make.right.equalTo(self.contentView.mas_right).mas_offset(-30);
            make.left.equalTo(self.titleLabel.mas_right).mas_offset(10);
        }];
    }
    if (_model.style == ZMSettingItemStyleCountNum) {
        [self.contentView addSubview:self.numberButton];
        self.numberButton.currentNumber = 1;
        self.numberButton.inputFieldFont = 13;
        self.numberButton.borderColor = ThemeColor;
    }
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
    }
    return _titleLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.textColor = UIColorFromRGB(0x333333);
    }
    return _rightLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"back24"];
    }
    return _arrowImageView;
}

- (PPNumberButton *)numberButton {
    if (!_numberButton) {
        _numberButton = [[PPNumberButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 135, 0, 120, 34)];
        _numberButton.increaseTitle = @"+";
        _numberButton.decreaseTitle = @"-";
        _numberButton.shakeAnimation = YES;
        _numberButton.centerY = self.contentView.centerY;
    }
    return _numberButton;
}

- (void)setModel:(ZMSettingItem *)model {
    _model = model;
    [self updateUI];
    self.titleLabel.text = model.title;
    self.rightLabel.text = model.rightTitle;
    if ([model.image hasPrefix:@"http"]) {
        [self.leftImageView setImageWithURL:[NSURL URLWithString:model.image] options:YYWebImageOptionProgressive];
    } else {
        self.leftImageView.image = [UIImage imageNamed:model.image];
    }
}
@end
