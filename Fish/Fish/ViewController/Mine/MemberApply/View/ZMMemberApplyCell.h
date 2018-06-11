//
//  ZMMemberApplyCell.h
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMApplyListModel.h"
typedef NS_ENUM(NSUInteger, ApplyStyle) {
    ApplyStyleStyle1 = 0,
    ApplyStyleStyle2 = 1,
    ApplyStyleStyle3 = 2
};

@protocol ZMMemberApplyCellDelegate <NSObject>
@optional
- (void)clickWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;
@end

@interface ZMMemberApplyCell : UITableViewCell

@property (nonatomic, assign) ApplyStyle applyStyle;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) ZMApplyListModelItem * item;
@property (nonatomic, weak) id <ZMMemberApplyCellDelegate> delegate;


@end
