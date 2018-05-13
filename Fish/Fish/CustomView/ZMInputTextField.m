//
//  ZMInputTextField.m
//  Fish
//
//  Created by sunny on 2018/4/26.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMInputTextField.h"
#import "UIColor+Hex.h"
#import <Masonry.h>
#import <UIView+YYAdd.h>

@interface ZMInputTextField ()
@property (nonatomic, strong) UIView *lineView;


@end

@implementation ZMInputTextField

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        
    }
    return _lineView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (void)config {
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 20, 0, 0));
    }];
    [self.textField setValue:[UIColor colorWithHexString:@"#BABABA" alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}


- (void)setLeftLabelText:(NSString *)leftLabelText {
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.left = 20;
    leftLabel.centerY = self.height / 2;
    leftLabel.size = CGSizeMake(100, self.height);
    leftLabel.text = leftLabelText;
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.textField.leftView = leftLabel;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
}

@end
