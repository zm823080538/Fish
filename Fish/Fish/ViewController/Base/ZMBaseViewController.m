//
//  ZMBaseViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBaseViewController.h"

@interface ZMBaseViewController ()

@end

@implementation ZMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)adapterUIForIOS11:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UIScrollView class]]) {
        return;
    }
#ifdef  __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
}

@end
