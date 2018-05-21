//
//  ZMBindAliPayViewController.m
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMBindAliPayViewController.h"

@interface ZMBindAliPayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *alipayInputTextFiedl;

@end

@implementation ZMBindAliPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加支付宝帐号";
}

- (IBAction)commit:(UIButton *)sender {
}


@end
