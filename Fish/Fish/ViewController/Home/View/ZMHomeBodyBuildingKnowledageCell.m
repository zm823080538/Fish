//
//  ZMHomeBodyBuildingKnowledageCell.m
//  Fish
//
//  Created by zhaoming on 04/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMHomeBodyBuildingKnowledageCell.h"
#import <UIImageView+YYWebImage.h>
@interface ZMHomeBodyBuildingKnowledageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ZMHomeBodyBuildingKnowledageCell



- (void)setItem:(ZMNewListItem *)item {
    [self.bgImageView setImageWithURL:[NSURL URLWithString:item.image] placeholder:PlaceholderImage];
}

@end
