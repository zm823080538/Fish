//
//  ZMMemberApplyViewController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberApplyViewController.h"
#import "ZMApplyListTableViewController.h"

@interface ZMMemberApplyViewController ()

@end

@implementation ZMMemberApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员申请";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (iPhoneX) {
        [self setTabBarFrame:CGRectMake(0,88, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 88+44, screenSize.width, screenSize.height - 88 - bottom - 34)];
    } else {
        [self setTabBarFrame:CGRectMake(0, 64, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 64+24, screenSize.width, screenSize.height - 64 - 24)];
    }
    [self initViewControllers];
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
    NSArray *titleArray = @[@"体验课",@"私教课",@"退课",@"申请记录"];
    NSMutableArray *viewControllers = @[].mutableCopy;
    for (int i = 0; i < titleArray.count; i ++) {
        ZMApplyListTableViewController *listVC = [[ZMApplyListTableViewController alloc] init];
        listVC.index = i;
        listVC.yp_tabItemTitle = titleArray[i];
        listVC.view.backgroundColor = [UIColor whiteColor];
        [viewControllers addObject:listVC];
    }
    self.viewControllers = viewControllers;
}

@end
