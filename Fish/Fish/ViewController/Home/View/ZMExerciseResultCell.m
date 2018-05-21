//
//  ZMExerciseResultCell.m
//  Fish
//
//  Created by zhaoming on 04/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMExerciseResultCell.h"
#import <UIImageView+YYWebImage.h>
@interface ZMExerciseResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@end

@implementation ZMExerciseResultCell

- (void)setItem:(ZMNewListItem *)item {
    [self.contentImageView setImageWithURL:[NSURL URLWithString:item.image] placeholder:PlaceholderImage];
    self.titleLabel.text = item.title;
    self.subTitleLabel.text = item.summary;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@阅读",item.remarks];
    
}

@end
