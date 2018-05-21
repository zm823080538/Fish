//
//  ZMFieldCollectionViewCell.m
//  Fish
//
//  Created by sunny on 2018/5/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMFieldCollectionViewCell.h"
#import "ZMFieldModel.h"

@interface ZMFieldCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@end

@implementation ZMFieldCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = NO;
    // Initialization code
}

- (void)setFieldModel:(ZMFieldModel *)fieldModel {
    _fieldModel = fieldModel;
    self.imageView.image = [UIImage imageNamed:fieldModel.imageName];
    self.titleLabel.text = fieldModel.title;
    if ([_fieldModel.status isEqualToString:@"1"]) {
        self.checkImageView.hidden = NO;
    } else {
          self.checkImageView.hidden = YES;
    }
    
}

@end
