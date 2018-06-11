//
//  LZPickerModel.h
//  LZCityPicker
//
//  Created by Artron_LQQ on 2017/1/20.
//  Copyright © 2017年 Artup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZPickerModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* pid;
@property (nonatomic, copy) NSString* level;
@property (nonatomic, strong) NSArray *childs;
@end

@interface LZProvince : LZPickerModel
//- (void)configWithDic:(NSDictionary *)dic;
@end

@interface LZCity : LZPickerModel
//@property (nonatomic, copy) NSString *province;
//- (void)configWithArr:(NSArray *)arr;
@end

@interface LZArea : LZPickerModel

//@property (nonatomic, copy) NSString *address;
//@property (nonatomic, copy) NSString *province;
//@property (nonatomic, copy) NSString *city;
@end
