//
//  ZMTestModel.h
//  FishUITests
//
//  Created by zhaoming on 24/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMTestModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSNumber * age;
@property (nonatomic, assign) NSUInteger flags;
- (instancetype)initWithName: (NSString *)name age: (NSNumber *)age flags: (NSUInteger)flags;
- (instancetype)initWithDictionary: (NSDictionary *)dict;
- (NSDictionary *)modelToDictionary;
@end
