//
//  LZPickerModel.m
//  LZCityPicker
//
//  Created by Artron_LQQ on 2017/1/20.
//  Copyright © 2017年 Artup. All rights reserved.
//

#import "LZPickerModel.h"

@implementation LZPickerModel
- (void)configWithDic:(NSDictionary *)dic {
    
}
@end

@implementation LZProvince
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"childs" : [LZCity class]};
}
//- (void)configWithDic:(NSDictionary *)dic {
//
//    NSArray *citys = [dic allKeys];
//
//    NSMutableArray *tmpCitys = [NSMutableArray arrayWithCapacity:citys.count];
//    for (NSString *tmp in citys) {
//
//        LZCity *city = [[LZCity alloc]init];
//        city.name = tmp;
//        city.province = self.name;
//        NSArray *area = [dic objectForKey:tmp];
//
//        [city configWithArr:area];
//        [tmpCitys addObject:city];
//
//    }
//
//    self.childs = [tmpCitys copy];
//}
@end

@implementation LZCity
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"childs" : [LZArea class]};
}
//- (void)configWithArr:(NSArray *)arr {
//    
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arr.count];
//    for (NSString *tmp in arr) {
//        
//        LZArea *area = [[LZArea alloc]init];
//        area.name = tmp;
//        area.province = self.province;
//        area.city = self.name;
//        [array addObject:area];
//    }
//    
//    self.childs = [array copy];    
//}
@end

@implementation LZArea


@end
