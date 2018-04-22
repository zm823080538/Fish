//
//  RegisterViewController.m
//  Fish
//
//  Created by sunny on 2018/4/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChooseRoleViewController.h"
#import "UIColor+Hex.h"
#import "ZMRegistRequest.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verfiyTextField;
@property (weak, nonatomic) IBOutlet UIButton *showPassword;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerUser;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usernameTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [self.verfiyTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    self.usernameTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.verfiyTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.passwordTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.registerUser.layer.borderColor = [UIColor colorWithHexString:@"#FFCD00" alpha:0.4].CGColor;
    self.registerUser.layer.borderWidth = 1.0f;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:0.95];
    [self.registerUser setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
}

- (IBAction)registerClick:(UIButton *)sender {
    ZMRegistRequest *registRequest = [[ZMRegistRequest alloc] init];
    registRequest.mobile = self.usernameTextField.text;
    [registRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [appDelegate changeRootVC];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    ChooseRoleViewController *chooseRoleVC = [ChooseRoleViewController new];
    [self.navigationController pushViewController:chooseRoleVC animated:YES];
}

@end
