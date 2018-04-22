//
//  ZMMineModel.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMineModel.h"

@implementation ZMMineModel
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className {
    if (self = [super init]) {
        self.image = image;
        self.title = title;
        self.destinClassName = className;
    }
    return self;
}
@end
