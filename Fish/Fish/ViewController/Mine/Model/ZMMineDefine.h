//
//  ZMMineDefine.h
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#ifndef ZMMineDefine_h
#define ZMMineDefine_h
typedef NS_ENUM(NSUInteger, PersonalInfoCellStyle) {
    PersonalInfoCellStyleImage = 0,    
    PersonalInfoCellStyleLabel = 1,
    PersonalInfoCellStyleTextField = 2,
    PersonalInfoCellStyleArrow = 3,
    PersonalInfoCellStyleLabelArrow = 4,
    PersonalInfoCellStyleImage1 = 5
};

#define PlaceholderImage [UIImage imageNamed:@"timg"]
#import "UIView+AddBackView.h"
#import <UIImageView+YYWebImage.h>
#import <NSObject+YYModel.h>
#import "ZMAccountManager.h"
#import <Masonry.h>
#import <MBProgressHUD+JDragon.h>



#endif /* ZMMineDefine_h */
