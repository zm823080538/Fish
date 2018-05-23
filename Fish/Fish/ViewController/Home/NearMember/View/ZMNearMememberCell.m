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
@end

@implementation ZMNearMememberCell

- (void)setModel:(ZMMemberModel *)model {
    [self.userIconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholder:PlaceholderImage];
    self.distanceLabel.text = model.distancefmt;
    self.nameLabel.text = model.nickname;
    self.statusLabel.text = model.skillname;
    [self.ageButton setTitle:model.age forState:UIControlStateNormal];
    if ([model.sex isEqualToString:@"1"]) {
        [self.ageButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
    } else {
         [self.ageButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    }
}

@end
