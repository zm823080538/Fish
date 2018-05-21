//
//  ZMExciseLanguageController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMExciseLanguageController.h"
#import "UITextView+MGPlaceholder.h"
#import <Masonry.h>
#import "UIColor+Hex.h"
#import <ReactiveObjC.h>
@interface ZMExciseLanguageController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel * commentNumLabel;

@end

@implementation ZMExciseLanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.commentNumLabel];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(80);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(244);
    }];
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.textView).mas_offset(-15);
    }];
    
    if ([self.title isEqualToString:@"健身格言"]) {
        _textView.placeholder = @"生命在于运动(此人太懒没有留下任何文字)";
    } else {
        _textView.placeholder = @"简历描述";
    }
    NSInteger  maxLength = [self.title isEqualToString:@"健身格言"] ? 50 : 500;
    if ([self.title isEqualToString:@"健身格言"]) {
        self.commentNumLabel.text = @"0/50";
    } else {
        self.commentNumLabel.text = @"0/500";
    }
    
    @weakify(self)
    RAC(self.commentNumLabel,text) = [self.textView.rac_textSignal  map:^id(NSString *value) {
        @strongify(self)
        if (value.length > maxLength) {
            value = [value substringToIndex:maxLength];
            self.textView.text = value;
        }
        self.textView.textColor = (value.length == maxLength) ? [UIColor redColor] : [UIColor colorWithHexString:@"#999999"];
        return [NSString stringWithFormat:@"%ld/%ld",value.length,maxLength];
    }];
    
   
}

- (void)viewDidLayoutSubviews {
   
}


- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
       
        _textView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _textView.placeholderColor = UIColorFromRGB(0x999999);
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}

- (UILabel *)commentNumLabel {
    if (!_commentNumLabel) {
        _commentNumLabel = [[UILabel alloc] init];
        _commentNumLabel.font = [UIFont systemFontOfSize:14];
        _commentNumLabel.textColor = UIColorFromRGB(0x999999);
    }
    return _commentNumLabel;
}

@end
