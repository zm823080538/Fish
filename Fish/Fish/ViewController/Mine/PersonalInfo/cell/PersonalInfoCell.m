//
//  PersonalInfoCell.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "PersonalInfoCell.h"
#import "UIColor+Hex.h"
#import <Masonry.h>
#import "ZMPersonalModel.h"

@interface PersonalInfoCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UITextField *rightTextField;
@end

@implementation PersonalInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self updateFrame];
    }
    return self;
}

- (void)initUI {
    self.style = PersonalInfoCellStyleArrow;
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self addSubview:self.rightImageView];
    [self addSubview:self.rightArrow];
    [self addSubview:self.rightTextField];
    [self updateFrame];
}

- (void)updateFrame {
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.centerY.equalTo(self);
    }];
    
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(9, 15));
        make.centerY.equalTo(self);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrow.mas_left).mas_equalTo(-15);
        make.centerY.equalTo(self);
    }];
    
    [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrow.mas_left).mas_equalTo(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
            
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrow.mas_left).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.centerY.equalTo(self);
    }];
}

- (void)setPersonalModel:(ZMPersonalModel *)personalModel {
    _personalModel = personalModel;
    self.leftLabel.text = personalModel.title;
    if ([personalModel isMemberOfClass:[ZMPersonalModel class]]) {
        self.rightLabel.text = personalModel.subTitle;
        
    }
}

- (void)setStyle:(PersonalInfoCellStyle)style {
    _style = style;
    switch (style) {
        case PersonalInfoCellStyleLabel:
            self.rightImageView.hidden = YES;
            self.rightTextField.hidden = YES;
            self.rightLabel.hidden = NO;
            break;
        case PersonalInfoCellStyleImage:
            self.rightImageView.hidden = NO;
            self.rightTextField.hidden = YES;
            self.rightLabel.hidden = YES;
            break;
        case PersonalInfoCellStyleTextField:
            self.rightImageView.hidden = YES;
            self.rightTextField.hidden = NO;
            self.rightLabel.hidden = YES;
            break;
        case PersonalInfoCellStyleArrow:
            self.rightImageView.hidden = YES;
            self.rightTextField.hidden = YES;
            self.rightLabel.hidden = YES;
            break;
        default:
            break;
    }
}

#pragma mark -- lazy methods

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"leftLabel";
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.text = @"rightLabel";
        _leftLabel.textColor = [UIColor colorWithHexString:@"#8996AA"];        
    }
    return _rightLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"timg"];
        
    }
    return _rightImageView;
}

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = [UIImage imageNamed:@"back24"];
        
    }
    return _rightArrow;
}

- (UITextField *)rightTextField {
    if (!_rightTextField) {
        _rightTextField = [[UITextField alloc] init];
        
    }
    return _rightTextField;
}

@end
