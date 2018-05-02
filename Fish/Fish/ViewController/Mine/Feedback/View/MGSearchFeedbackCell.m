//
//  MGSearchFeedbackCell.m
//  MGMobileMusic
//
//  Created by zhaoming on 2017/12/19.
//  Copyright © 2017年 migu. All rights reserved.
//

#import "MGSearchFeedbackCell.h"
@interface MGSearchFeedbackCell()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation MGSearchFeedbackCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setLineViewHidden:(BOOL)hidden {
    self.lineView.hidden = hidden;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
