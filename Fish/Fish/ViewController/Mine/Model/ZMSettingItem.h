//
//  ZMMineModel.h
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ExcuteBlock)();

typedef NS_ENUM(NSUInteger, ZMSettingItemStyle) {
    ZMSettingItemStyleImage = 0,
    ZMSettingItemStyleLabel = 1,
    ZMSettingItemStyleTextField = 2,
    ZMSettingItemStyleArrow = 3,
    ZMSettingItemStyleLabelArrow = 4,
    ZMSettingItemStyleRightImage = 5,
    ZMSettingItemStyleCountNum = 6, //加减 + -
};

@interface ZMSettingItem : NSObject

/**
 左边的图片
 */
@property (nonatomic, copy) NSString * image;

/**
 标题
 */
@property (nonatomic, copy) NSString * title;

/**
 目标控制器
 */
@property (nonatomic, copy) NSString * destinClassName;

/**
 右边的标题
 */
@property (nonatomic, copy) NSString * rightTitle;
/**
 右边的图片
 */
@property (nonatomic, copy) NSString * rightImage;

@property (nonatomic, assign) ZMSettingItemStyle style;

@property (nonatomic, copy) ExcuteBlock block;

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className;


@end

