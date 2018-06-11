//
//  ZMRecFriendCell.m
//  Fish
//
//  Created by zhaoming on 2018/6/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRecFriendCell.h"

@interface ZMRecFriendCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ZMRecFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFriendModel:(ZMAccount *)friendModel {
    self.nameLabel.text = friendModel.nickname;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:friendModel.img] placeholder:PlaceholderImage];
    self.IDNumberLabel.text = friendModel.no;
    self.dateLabel.text = friendModel.updateDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
