//
//  ZMBodyDataSaveRequest.m
//  Fish
//
//  Created by zhaoming on 2018/7/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBodyDataSaveRequest.h"

@implementation ZMBodyDataSaveRequest
- (NSString *)requestUrl {
    return @"/api/user/bodydataSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid":_userid,
             @"id":_id,
             @"writedate":_writedate,
             @"height":_height ?: @"",
             @"weight":_weight ?: @"",
             @"fat":_fat ?: @"",
             @"bmr":_bmr ?: @"",
             @"bmi":_bmi ?: @"",
             @"visceralfat":_visceralfat ?: @"",
             @"muscle":_muscle ?: @"",
             @"bodywater":_bodywater ?: @"",
             @"wdxiong":_wdxiong ?: @"",
             @"wdyao":_wdyao ?: @"",
             @"wddatui":_wddatui ?: @"",
             @"wdxiaotui":_wdxiaotui ?: @"",
             @"wddabi":_wddabi ?: @"",
             @"wdxiaobi":_wdxiaobi ?: @"",
             @"wdtun":_wdtun ?: @"",
             @"wdjian":_wdjian ?: @""
             };
}
@end
