//
//  AppDelegate.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "AppDelegate.h"
#import "LLTabBar.h"
#import "LoginViewController.h"
#import "LLHomeViewController.h"
#import "ZMMemberViewController.h"
#import "ZMCourseViewController.h"
#import "LLMineViewController.h"
#import "LLBaseNavViewController.h"
#import <YTKNetworkConfig.h>
#import <RongCloudIMKit/RongIMKit/RongIMKit.h>
//#import <IQKeyboardManager.h>

@interface AppDelegate () <LLTabBarDelegate, UIActionSheetDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"https://www.bjwork.xyz";
     [[RCIM sharedRCIM] initWithAppKey:@"kj7swf8ok1mu2"];
//    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
//    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LLBaseNavViewController  *nav = [[LLBaseNavViewController  alloc] initWithRootViewController:[LoginViewController new]];
    self.window.rootViewController = nav;
//    [self changeRootVC];
    
    
//
//    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
   
//    [RCIM sharedRCIM].enableTypingStatus = YES;
//    //开启输入状态监听
//    [RCIM sharedRCIM].enableTypingStatus = YES;
//    //群成员数据源
    
   
//    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
//    [RCIM sharedRCIM].enableMessageMentioned = YES;
//
//    //开启消息撤回功能
//    [RCIM sharedRCIM].enableMessageRecall = YES;
//
//    //群成员数据源
//    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
//    [RCIM sharedRCIM].enableMessageMentioned = YES;
//
//    //开启消息撤回功能
//    [RCIM sharedRCIM].enableMessageRecall = YES;
    [self.window makeKeyAndVisible];
//    return YES;
    
 
   
    //    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"home_normal", kLLTabBarItemAttributeSelectedImageName : @"home_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
    //                                    @{kLLTabBarItemAttributeTitle : @"发布", kLLTabBarItemAttributeNormalImageName : @"post_normal", kLLTabBarItemAttributeSelectedImageName : @"post_normal", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
    //                                    @{kLLTabBarItemAttributeTitle : @"消息", kLLTabBarItemAttributeNormalImageName : @"message_normal", kLLTabBarItemAttributeSelectedImageName : @"message_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
    //    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"home_normal", kLLTabBarItemAttributeSelectedImageName : @"home_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
    //                                    @{kLLTabBarItemAttributeTitle : @"同城", kLLTabBarItemAttributeNormalImageName : @"mycity_normal", kLLTabBarItemAttributeSelectedImageName : @"mycity_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
   
//    [[IQKeyboardManager sharedManager] setEnable:YES];
    return YES;
}

- (void)changeRootVC {
    LLHomeViewController *homeViewController = [[LLHomeViewController alloc] init];
    ZMMemberViewController *sameCityViewController = [[ZMMemberViewController alloc] init];
    ZMCourseViewController *messageViewController = [[ZMCourseViewController alloc] init];
    LLMineViewController *mineViewController = [[LLMineViewController alloc] init];
    LLBaseNavViewController *nav1 = [[LLBaseNavViewController  alloc] initWithRootViewController:homeViewController];
    LLBaseNavViewController  *nav2 = [[LLBaseNavViewController  alloc] initWithRootViewController:sameCityViewController];
    LLBaseNavViewController  *nav3 = [[LLBaseNavViewController  alloc] initWithRootViewController:messageViewController];
    LLBaseNavViewController  *nav4 = [[LLBaseNavViewController  alloc] initWithRootViewController:mineViewController];
   
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav1, nav2, nav3, nav4];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"room", kLLTabBarItemAttributeSelectedImageName : @"Shape", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"会员", kLLTabBarItemAttributeNormalImageName : @"member2", kLLTabBarItemAttributeSelectedImageName : @"member", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
//                                    @{kLLTabBarItemAttributeTitle : @"", kLLTabBarItemAttributeNormalImageName : @"Group 9", kLLTabBarItemAttributeSelectedImageName : @"Group 9", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
                                    @{kLLTabBarItemAttributeTitle : @"课程", kLLTabBarItemAttributeNormalImageName : @"lesson2", kLLTabBarItemAttributeSelectedImageName : @"lesson", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"member22", kLLTabBarItemAttributeSelectedImageName : @"memeber_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    tabBar.delegate = self;
    [tabBarController.tabBar addSubview:tabBar];
    self.window.rootViewController = tabBarController;
    
}

#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

