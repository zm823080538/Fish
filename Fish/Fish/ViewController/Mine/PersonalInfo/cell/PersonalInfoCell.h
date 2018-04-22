//
//  PersonalInfoCell.h
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMMineDefine.h"
@class ZMPersonalModel;

@interface PersonalInfoCell : UITableViewCell
@property (nonatomic, assign) PersonalInfoCellStyle style;
@property (nonatomic, strong) ZMPersonalModel *personalModel;
@end
