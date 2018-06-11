//
//  ZMMineTableViewCell.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMineTableViewCell.h"
#import "ZMMineModel.h"
@interface ZMMineTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end

@implementation ZMMineTableViewCell


- (void)setModel:(ZMMineModel *)model {
    self.titleLabel.text = model.title;
    self.leftImageView.image = [UIImage imageNamed:model.image];
    if (model.rightTitle) {
        self.rightLabel.hidden = NO;
        self.rightLabel.text = model.rightTitle;
    } else {
        self.rightLabel.hidden = YES;
    }
}

//- (void)setPersonModel:(ZMMineModel *)model{
//    if ([model isKindOfClass:[ZMPersonalModel class]]) {
//        ZMPersonalModel  *personalModel = (ZMPersonalModel *)model;
//        self.leftLabel.text = personalModel.title;
//        [self.rightImageView setImageWithURL:[NSURL URLWithString:personalModel.image] placeholder:PlaceholderImage];
//        self.rightLabel.text = personalModel.subTitle;
//    } else if ([model isKindOfClass:[ZMMineModel class]]) {
//        self.leftLabel.text = model.title;
//        self.leftImageView.image = [UIImage imageNamed:model.image];
//    }
//}

@end
