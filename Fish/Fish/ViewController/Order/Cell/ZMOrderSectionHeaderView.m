//
//  ZMOrderSectionHeaderView.m
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderSectionHeaderView.h"

@interface ZMOrderSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lessonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restCourseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UIButton *continueLessonBtn;

@end

@implementation ZMOrderSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.continueLessonBtn.layer.borderColor = ThemeColor.CGColor;
    self.continueLessonBtn.layer.borderWidth = 1;
}

- (IBAction)handle:(UIButton *)sender {
    [self.handleSubject sendNext:sender.currentTitle];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
