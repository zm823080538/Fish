//
//  ZMPersonalModel.h
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMineModel.h"
#import "ZMMineDefine.h"

typedef void(^ClickBlock)(void);

@interface ZMPersonalModel : ZMMineModel
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) PersonalInfoCellStyle style;
@property (nonatomic, copy) ClickBlock clickBlock;

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className style:(PersonalInfoCellStyle)style subTitle:(NSString *)subTitle;

@end
