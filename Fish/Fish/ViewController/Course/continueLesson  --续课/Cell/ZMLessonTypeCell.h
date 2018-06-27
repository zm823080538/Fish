//
//  ZMLessonTypeCell.h
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
typedef NS_ENUM(NSUInteger, LessonType) {
    LessonTypeDaLei = 0,
    LessonTypeXiaoLei = 1
};

@interface ZMLessonTypeCell : UITableViewCell
@property (nonatomic, assign) LessonType lessonType;
@property (nonatomic, strong) SKTagView  * tagView;
@property (nonatomic, strong) NSArray * tagList;
@property (nonatomic, copy) NSString * title;


@end
