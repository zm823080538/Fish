//
//  ZMFieldModel.h
//  Fish
//
//  Created by sunny on 2018/5/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMFieldModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, copy) NSString * status; //是否选中
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName status:(NSString *)status;

@end
