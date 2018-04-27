//
//  MGSearchFeedbackCell.h
//  MGMobileMusic
//
//  Created by zhaoming on 2017/12/19.
//  Copyright © 2017年 migu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGSearchFeedbackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
- (void)setLineViewHidden:(BOOL)hidden;
@end
