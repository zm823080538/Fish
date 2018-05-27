//
//  ZMCollectionCell.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCollectionCell.h"
#import <UIImageView+YYWebImage.h>
@interface ZMCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@end

@implementation ZMCollectionCell

- (void)setItem:(ZMNewListItem *)item {
    [self.leftImageView setImageWithURL:[NSURL URLWithString:item.image] placeholder:PlaceholderImage];
    self.nameLabel.text = item.nickname;
    self.titleLabel.text = item.title;
}

@end
