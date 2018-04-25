//
//  ZMTestModel.m
//  FishUITests
//
//  Created by zhaoming on 24/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMTestModel.h"

@implementation ZMTestModel
- (instancetype)initWithName:(NSString *)name age:(NSNumber *)age flags:(NSUInteger)flags {
    if (self = [super init]) {
        self.name = name;
        self.age = age;
        self.flags = flags;
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.age = dict[@"age"];
        self.flags = dict[@"flags"];
    }
    return self;
}
@end
