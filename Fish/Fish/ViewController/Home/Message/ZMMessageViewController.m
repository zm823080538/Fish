//
//  ZMMessageViewController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMMessageViewController.h"
#import "ZMMessageListController.h"



@interface ZMMessageViewController ()

@end

@implementation ZMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (iPhoneX) {
        [self setTabBarFrame:CGRectMake(0,0, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 88+44, screenSize.width, screenSize.height - 88 - bottom - 34)];
    } else {
        [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 64 - 44)];
    }
    self.tabBar.itemTitleColor = UIColorFromRGB(0x3A3A3A);
    self.tabBar.itemTitleSelectedColor = UIColorFromRGB(0x4A576A);
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = UIColorFromRGB(0x4A576A);
    self.tabBar.indicatorCornerRadius = 2;
    [self.tabBar setIndicatorWidth:40 marginTop:35 marginBottom:6 tapSwitchAnimated:YES];
    [self setContentScrollEnabled:YES tapSwitchAnimated:NO];
}

- (void)initViewControllers {
    NSMutableArray *viewControllers = @[].mutableCopy;
    for (int i = 0; i < 2; i ++) {
        ZMMessageListController *listVC = [[ZMMessageListController alloc] init];
        listVC.view.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            listVC.yp_tabItemTitle =@"私信";
        } else {
            listVC.yp_tabItemTitle =@"系统";
        }
        [viewControllers addObject:listVC];
    }
    self.viewControllers = viewControllers;
}

@end
