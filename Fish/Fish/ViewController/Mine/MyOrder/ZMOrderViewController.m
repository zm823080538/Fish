//
//  ZMOrderViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/14.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderViewController.h"
#import "ZMOrderListTableViewController.h"
@interface ZMOrderViewController ()

@end

@implementation ZMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSMutableArray *viewControllers = @[].mutableCopy;
    NSArray *titleArray = @[@"全部",@"待接单",@"待付款",@"已完成",@"退款中",@"已退款"];
    NSArray *statusArray = @[@"all",@"a1",@"b2",@"b3",@"b55",@"b56"];
    for (int i = 0; i < titleArray.count; i ++) {
            ZMOrderListTableViewController *listVC = [[ZMOrderListTableViewController alloc] init];
            listVC.yp_tabItemTitle = titleArray[i];
            listVC.status = statusArray[i];
            listVC.view.backgroundColor = [UIColor whiteColor];
            [viewControllers addObject:listVC];
        
    }
    self.viewControllers = viewControllers;
}
@end
