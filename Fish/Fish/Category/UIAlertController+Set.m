//
//  UIAlertController+Set.m
//  Fish
//
//  Created by sunny on 2018/4/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "UIAlertController+Set.h"
#import "UIViewController+CurrentViewController.h"

@implementation UIAlertController (Set)
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)titles preferredStyle:(UIAlertControllerStyle)preferredStyle completion:(void (^)(NSInteger))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(idx);
            }
        }]];
    }];
    [[UIViewController getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}
@end
