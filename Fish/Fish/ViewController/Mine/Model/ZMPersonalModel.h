//
//  ZMPersonalModel.h
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMineModel.h"
#import "ZMMineDefine.h"

@interface ZMPersonalModel : ZMMineModel
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) PersonalInfoCellStyle style;
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className style:(PersonalInfoCellStyle)style subTitle:(NSString *)subTitle;
@end
