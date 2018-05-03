//
//  ZMInputTextField.m
//  Fish
//
//  Created by sunny on 2018/4/26.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMInputTextField.h"
#import "UIColor+Hex.h"
#import <UIView+YYAdd.h>
@implementation ZMInputTextField

- (instancetype)init {
    if (self = [super init]) {
        [self setValue:[UIColor colorWithHexString:@"#BABABA" alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
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

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newFrame = CGRectInset(bounds, 20, 0);
    return newFrame;
}

- (void)setLeftLabelText:(NSString *)leftLabelText {
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor whiteColor];
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
