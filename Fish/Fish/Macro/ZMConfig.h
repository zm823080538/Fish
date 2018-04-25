//
//  ZMConfig.h
//  Fish
//
//  Created by zhaoming on 25/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#ifndef ZMConfig_h
#define ZMConfig_h
#define kZMUserInfo   @"kZMUserInfo"


//当前系统版本
#define IOS11 ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0 ? YES : NO)
#define IOS10 ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0 ? YES : NO)
#define IOS9 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0 ? YES : NO)
#endif /* ZMConfig_h */
