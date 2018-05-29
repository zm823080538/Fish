//
//  LLMessageViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "ZMCourseViewController.h"
#import "ZMCourseListViewController.h"
#import "ZMCalendarViewController.h"
#import "ZMMessageViewController.h"
#import "ZMScanViewController.h"
@interface ZMCourseViewController () 
@end

@implementation ZMCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"课程" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"kechengbiao"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
    [self initViewControllers];
    [self configTabbar];
}

- (void)configTabbar {
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (iPhoneX) {
        [self setTabBarFrame:CGRectMake(0,64, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 88+44, screenSize.width, screenSize.height - 88 - bottom - 34)];
    } else {
        [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 64 - 49)];
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
        ZMCourseListViewController *listVC = [[ZMCourseListViewController alloc] init];
        if (i == 0) {
            listVC.yp_tabItemTitle =@"进行中";
        }  else {
            listVC.yp_tabItemTitle =@"已结束";
        }
        listVC.view.backgroundColor = [UIColor whiteColor];
        [viewControllers addObject:listVC];
    }
    self.viewControllers = viewControllers;
}

- (void)rightBarItem1Click {
    
    ZMCalendarViewController *calendarVC = [ZMCalendarViewController new];
//    calendarVC.title = @"";
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (void)leftBarItemClick {
    
}

- (void)rightBarItemClick {
    ZMMessageViewController *messageVC = [ZMMessageViewController new];
    messageVC.title = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}

@end
