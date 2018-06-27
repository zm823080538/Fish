//
//  ZMMineTableViewCell.h
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
@class ZMSettingItem;
@interface ZMSettingCell : UITableViewCell
@property (nonatomic, strong) ZMSettingItem * model;
@property (strong, nonatomic)  UIImageView *leftImageView;
@property (strong, nonatomic)  UIImageView *rightImageView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *arrowImageView;
@property (strong, nonatomic)  UILabel *rightLabel;
@property (strong, nonatomic)  PPNumberButton *numberButton;
@end
