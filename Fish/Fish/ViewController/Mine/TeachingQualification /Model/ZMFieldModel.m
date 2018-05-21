//
//  ZMFieldModel.m
//  Fish
//
//  Created by sunny on 2018/5/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMFieldModel.h"

@implementation ZMFieldModel
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName status:(NSString *)status {
    if (self = [super init]) {
        _title = title;
        _imageName = imageName;
        _status = status;
    }
    return self;
}
@end
