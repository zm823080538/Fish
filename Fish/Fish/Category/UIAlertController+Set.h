//
//  UIAlertController+Set.h
//  Fish
//
//  Created by sunny on 2018/4/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Set)
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)titles preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(void(^)(NSInteger index))completion;
@end
