//
//  ForgetPasswordViewController.m
//  Fish
//
//  Created by sunny on 2018/4/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "UIColor+Hex.h"
#import "ZMVerfiyCodeRequest.h"
#import "ZMForgetPwdRequest.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *showPassword;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@property (weak, nonatomic) IBOutlet UITextField *verfiyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerUser;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usernameTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    self.usernameTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.passwordTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.registerUser.layer.borderColor = [UIColor colorWithHexString:@"#FFCD00" alpha:0.4].CGColor;
    self.registerUser.layer.borderWidth = 1.0f;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:0.95];
    [self.registerUser setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
}

- (IBAction)sendVerfiyCode:(UIButton *)sender {
    ZMVerfiyCodeRequest *verfiyCodeRequest = [[ZMVerfiyCodeRequest alloc] init];
    verfiyCodeRequest.mobile = self.usernameTextField.text;
    verfiyCodeRequest.type = @"2";
    [verfiyCodeRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

- (IBAction)commit:(UIButton *)sender {
    ZMForgetPwdRequest *commitRequest = [[ZMForgetPwdRequest alloc] init];
    commitRequest.mobile = self.usernameTextField.text;
    commitRequest.password = self.passwordTextField.text;
    commitRequest.code = self.verfiyCodeTextField.text;
    [commitRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.responseString);
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
