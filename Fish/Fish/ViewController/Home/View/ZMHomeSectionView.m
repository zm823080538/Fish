//
//  ZMHomeSectionView.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMHomeSectionView.h"
#import "UIColor+Hex.h"
#import <Masonry.h>

@interface ZMHomeSectionView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;

@end

@implementation ZMHomeSectionView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#4A576A"];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIButton *)arrowButton {
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc] init];
        [_arrowButton setImage:[UIImage imageNamed:@"bz"] forState:UIControlStateNormal];
        [_arrowButton addTarget:self action:@selector(arrowButtonClick) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _arrowButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)arrowButtonClick {
    if (self.arrowClick) {
        self.arrowClick();
    }
}

- (void)configUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self);
    }];
    
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
}
@end
