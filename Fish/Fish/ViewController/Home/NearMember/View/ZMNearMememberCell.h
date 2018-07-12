//
//  ZMNearMememberCell.h
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMMemberModel.h"
#import "ZMCourseListModel.h"
@interface ZMNearMememberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) ZMMemberModel  *model;
@property (nonatomic, strong) ZMCourseListItem * item;

@end
