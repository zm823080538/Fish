//
//  ZMCertificationViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCertificationViewController.h"

@interface ZMCertificationViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@end

@implementation ZMCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
   
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
     self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.thirdView.frame) + 13);
}


@end
