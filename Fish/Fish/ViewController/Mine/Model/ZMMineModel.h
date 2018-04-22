//
//  ZMMineModel.h
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMMineModel : NSObject
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * destinClassName;
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title destinClassName:(NSString *)className;
@end

