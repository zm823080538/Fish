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

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (void)config {
    [self setValue:[UIColor colorWithHexString:@"#BABABA" alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.lineView = [[UIView alloc] init];
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

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newFrame;
    newFrame = CGRectInset(bounds, 20, 0);
    return newFrame;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect newFrame = CGRectInset(bounds, 20, 0);
    return newFrame;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect newFrame = CGRectInset(bounds, 20, 0);
    return newFrame;
}

//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    CGRect newFrame = CGRectInset(bounds, 20, 0);
//    return newFrame;
//}

- (void)setLeftLabelText:(NSString *)leftLabelText {
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor redColor];
    leftLabel.left = 20;
    leftLabel.centerY = self.height / 2;
    leftLabel.size = CGSizeMake(84, self.height);
    leftLabel.text = leftLabelText;
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.leftView = leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

@end
