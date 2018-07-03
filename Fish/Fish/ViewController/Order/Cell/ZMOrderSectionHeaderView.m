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

- (void)setHistoryList:(HistoryList *)historyList {
    self.nameLabel.text = historyList.nickname;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:historyList.img] placeholder:PlaceholderImage];
    self.IDNumLabel.text = [NSString stringWithFormat:@"ID：%@",historyList.no];
    [self.ageButton setTitle:historyList.age forState:UIControlStateNormal];
    [self.ageButton setTitle:historyList.age forState:UIControlStateNormal];
    if ([historyList.sex isEqualToString:@"1"]) {
        [self.ageButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0x82C9F9)];
    } else {
        [self.ageButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0xF497B6)];
    }
    self.restCourseLabel.text = [NSString stringWithFormat:@"剩余课时(%@/%@)",historyList.cuse,historyList.csum];
    self.lessonTypeLabel.text = historyList.ctypename;
    
    
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
