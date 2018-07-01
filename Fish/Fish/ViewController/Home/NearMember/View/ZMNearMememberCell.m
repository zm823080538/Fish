//
//  ZMNearMememberCell.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMNearMememberCell.h"
#import <UIImageView+YYWebImage.h>
#import <UIButton+YYWebImage.h>
@interface ZMNearMememberCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *versionBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation ZMNearMememberCell

- (void)setModel:(ZMMemberModel *)model {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.userIconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholder:PlaceholderImage];
    self.distanceLabel.text = model.distancefmt;
    self.nameLabel.text = model.nickname;
    self.statusLabel.text = model.skillname;
    [self.ageButton setTitle:model.age forState:UIControlStateNormal];
    if ([model.sex isEqualToString:@"1"]) {
        [self.ageButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0x82C9F9)];
    } else {
         [self.ageButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0xF497B6)];
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.courseprice];
    
    self.starLabel.text = [NSString stringWithFormat:@"评分%@",model.score];
    [self.versionBtn setTitle:model.degree forState:UIControlStateNormal];
    if (!IS_COACH) {
        self.courseNumLabel.textColor = UIColorFromRGB(0xFD506D);
        self.courseNumLabel.text = [NSString stringWithFormat:@"￥%@",model.courseprice];
    }
}

- (void)setItem:(ZMCourseListItem *)item {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.userIconImageView setImageWithURL:[NSURL URLWithString:item.img] placeholder:PlaceholderImage];
    self.distanceLabel.text = [NSString stringWithFormat:@"下次预约:%@",item.updateDate];
    self.nameLabel.text = item.nickname;
    self.statusLabel.text = item.coursetypenames;
//    self.dateLabel.text = ;
    [self.ageButton setTitle:item.ctype forState:UIControlStateNormal];
    if ([item.sex isEqualToString:@"1"]) {
        [self.ageButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0x82C9F9)];
    } else {
        [self.ageButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
        [self.ageButton setBackgroundColor:UIColorFromRGB(0xF497B6)];
    }
}

@end
