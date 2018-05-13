//
//  ZMMemberApplyCell.h
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ApplyStyle) {
    ApplyStyleStyle1 = 0,
    ApplyStyleStyle2 = 1
};

@interface ZMMemberApplyCell : UITableViewCell

@property (nonatomic, assign) ApplyStyle applyStyle;
@end
