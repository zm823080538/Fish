//
//  ZMPersonalModel.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPersonalModel.h"

@implementation ZMPersonalModel
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className style:(PersonalInfoCellStyle)style subTitle:(NSString *)subTitle {
    if (self = [super initWithImage:image title:title destinClassName:className]) {
        self.style = style;
        self.subTitle = subTitle;
    }
    return self;
}
@end
