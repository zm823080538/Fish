//
//  PersonalInfoCell.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "PersonalInfoCell.h"
#import "UIColor+Hex.h"
#import <UIImageView+YYWebImage.h>
#import <Masonry.h>
#import "ZMPersonalModel.h"

@interface PersonalInfoCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *rightImageView1;

@property (nonatomic, strong) UIImageView *rightArrow;
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
    [self addSubview:self.rightImageView1];
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
    
    [self.rightImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrow.mas_left).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self);
    }];

}

- (void)setPersonalModel:(ZMPersonalModel *)personalModel {
    _personalModel = personalModel;
    self.leftLabel.text = personalModel.title;
    if ([personalModel.image hasPrefix:@"http://"]) {
        [self.rightImageView setImageWithURL:[NSURL URLWithString:personalModel.image] placeholder:PlaceholderImage];
        [self.rightImageView1 setImageWithURL:[NSURL URLWithString:personalModel.image] placeholder:PlaceholderImage];
    } else {
        self.rightImageView1.image = [UIImage imageNamed:personalModel.image];
        self.rightImageView.image = [UIImage imageNamed:personalModel.image];
//        if ([personalModel.title isEqualToString:@"我的二维码"]) {
//            _rightImageView.layer.cornerRadius = 0;
////            _rightImageView.size = CGSizeMake(25, 25);
//            [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.rightArrow.mas_left).mas_offset(-15);
//                make.size.mas_equalTo(CGSizeMake(34, 34));
//                make.centerY.equalTo(self);
//            }];
//        } else {
//            _rightImageView.layer.cornerRadius = 17;
//            _rightImageView.layer.masksToBounds = YES;
//        }
    }
    if ([personalModel isMemberOfClass:[ZMPersonalModel class]]) {
        self.rightLabel.text = personalModel.subTitle;
    }
    
}

- (void)setStyle:(PersonalInfoCellStyle)style {
    _style = style;
    if (style == PersonalInfoCellStyleLabel) {
        self.rightImageView.hidden = YES;
        self.rightImageView1.hidden = YES;
        self.rightTextField.hidden = YES;
        self.rightLabel.hidden = NO;
        self.rightArrow.hidden = YES;
        [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).mas_equalTo(-15);
            make.centerY.equalTo(self);
            
        }];
    } else if (style == PersonalInfoCellStyleImage) {
        self.rightImageView.hidden = NO;
        self.rightTextField.hidden = YES;
        self.rightLabel.hidden = YES;
        self.rightImageView1.hidden = YES;
    } else if (style == PersonalInfoCellStyleTextField) {
        self.rightImageView.hidden = YES;
        self.rightTextField.hidden = NO;
        self.rightLabel.hidden = YES;
        self.rightImageView1.hidden = YES;
    } else if (style == PersonalInfoCellStyleArrow) {
        self.rightImageView.hidden = YES;
        self.rightTextField.hidden = YES;
        self.rightLabel.hidden = YES;
        self.rightImageView1.hidden = YES;
    } else if (style == PersonalInfoCellStyleLabelArrow) {
        self.rightImageView.hidden = YES;
        self.rightTextField.hidden = YES;
        self.rightLabel.hidden = NO;
        self.rightArrow.hidden = NO;
        self.rightImageView1.hidden = YES;
    } else if (style == PersonalInfoCellStyleImage1) {
        self.rightImageView.hidden = YES;
        self.rightTextField.hidden = YES;
        self.rightLabel.hidden = YES;
        self.rightImageView1.hidden = NO;
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
        _leftLabel.font = [UIFont systemFontOfSize:13];
        _leftLabel.text = @"rightLabel";
        _leftLabel.textColor = [UIColor colorWithHexString:@"#8996AA"];        
    }
    return _rightLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.cornerRadius = 17;
        _rightImageView.layer.masksToBounds = YES;
    }
    return _rightImageView;
}

- (UIImageView *)rightImageView1 {
    if (!_rightImageView1) {
        _rightImageView1 = [[UIImageView alloc] init];
    }
    return _rightImageView1;
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
