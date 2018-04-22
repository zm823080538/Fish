//
//  LLBaseNavViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "LLBaseNavViewController.h"

@interface LLBaseNavViewController ()

@end

@implementation LLBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    if (self.viewControllers.count > 0) {
        //push后隐藏TabBarController
        
        viewController.hidesBottomBarWhenPushed = YES;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, 30, 30);
//        [button setImage:[UIImage imageNamed:@"Path_2"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        viewController.navigationItem.leftBarButtonItem = barButtonItem;

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Path_2"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"123" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
     [super pushViewController:viewController animated:animated];
    [viewController.navigationController setNavigationBarHidden:NO animated:YES];
}

//- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.childViewControllers.count < 2) {
//        //push后隐藏TabBarController
//        [viewController.navigationController setNavigationBarHidden:YES animated:YES];
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
//    return [super popToViewController:viewController animated:animated];
//}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        
    }
    [self.topViewController.view endEditing:YES];
    return [super popViewControllerAnimated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}


@end
