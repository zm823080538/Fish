//
//  ZMCourseDetailViewController.h
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCourseListModel.h"


@interface ZMCourseDetailViewController : UIViewController
@property (nonatomic, assign) NSInteger type; //0:进行中  1:已结束
@property (nonatomic, strong) ZMCourseListItem * course;

@end
