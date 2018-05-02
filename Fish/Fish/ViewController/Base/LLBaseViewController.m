//
//  LLBaseViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLBaseViewController.h"
#import "UIView+AddBackView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface LLBaseViewController ()

@end

@implementation LLBaseViewController

#pragma mark - Lifecycle

- (instancetype)init {
	self = [super init];
	
	if (self) {
		
	}
	
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		
	}
	
	return self;
}

#pragma mark - View Lifecycle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    if (@available(iOS 11.0, *)) {
//        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
	self.navigationController.navigationBarHidden = YES;
    [self.view addbackButton:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
