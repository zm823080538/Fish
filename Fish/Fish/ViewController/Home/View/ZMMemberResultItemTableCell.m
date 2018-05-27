//
//  ZMMemberResultItemTableCell.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberResultItemTableCell.h"
#import <UIImageView+YYWebImage.h>
@interface ZMMemberResultItemTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation ZMMemberResultItemTableCell

- (void)setItem:(ZMNewListItem *)item {
    [self.bigImageView setImageWithURL:[NSURL URLWithString:item.image] placeholder:PlaceholderImage];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:item.userimg] placeholder:PlaceholderImage];
    self.titleLabel.text = item.title;
    self.dateLabel.text = item.updateDate;
    self.leftLabel.text = item.nickname;
}
@end
