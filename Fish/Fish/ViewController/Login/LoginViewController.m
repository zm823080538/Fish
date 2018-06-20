//
//  LoginViewController.m
//  Fish
//
//  Created by zhaoming on 07/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+AddBackView.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"
#import "YTKBaseRequest+ZMAnimatingAccessory.h"
#import "ChooseRoleViewController.h"
#import "ChooseRoleViewController.h"
#import "ForgetPasswordViewController.h"
#import "ZMAccount.h"
#import <NSObject+YYModel.h>
#import "ZMAccountManager.h"
#import <RongCloudIMKit/RongIMKit/RongIMKit.h>
#import "ZMLoginRequest.h"

@interface LoginViewController () <YTKRequestAccessory>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *showPassword;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerUser;
@property (weak, nonatomic) IBOutlet UILabel *otherChannelLoginLabel;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.usernameTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    self.usernameTextField.text = @"18280074372";
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.text = @"123456";
    self.usernameTextField.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.passwordTextField.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.otherChannelLoginLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.registerUser.layer.borderColor = [UIColor colorWithHexString:@"#FFCD00" alpha:0.4].CGColor;
    self.registerUser.layer.borderWidth = 1.0f;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:0.95];
    [self.registerUser setTitleColor:[UIColor colorWithHexString:@"#FFCD00" alpha:0.4] forState:UIControlStateNormal];
    self.otherChannelLoginLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
}


- (IBAction)showPwd:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTextField.secureTextEntry = sender.selected;
}

- (IBAction)forgetPwd {
    ForgetPasswordViewController *forgetPasswordVC = [ForgetPasswordViewController new];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

- (IBAction)loginClick {
    ZMLoginRequest *loginRequest = [[ZMLoginRequest alloc] initWithMobile:self.usernameTextField.text password:self.passwordTextField.text version:@"i1.0"];
    loginRequest.animatingText = @"正在登录";
    loginRequest.animatingView = self.view;
    [loginRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *requestInfo = (NSDictionary *)request.responseJSONObject;
            NSLog(@"---%@",requestInfo[@"msg"]);
            NSString *code = requestInfo[@"code"];
           if (code.integerValue == 0) {
                ZMAccount *account = [ZMAccount modelWithJSON:requestInfo[@"data"]];
               [ZMAccountManager shareManager].loginUser = account;
                NSDictionary *dict = [account modelToJSONObject];
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kZMUserInfo];
                [[NSUserDefaults standardUserDefaults] synchronize];
                // options是动画选项
                [[RCIM sharedRCIM] connectWithToken:account.token     success:^(NSString *userId) {
                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                            BOOL oldState = [UIView areAnimationsEnabled];
                            [UIView setAnimationsEnabled:NO];
                            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            [appDelegate changeRootVC];
                            [UIView setAnimationsEnabled:oldState];
                        } completion:^(BOOL finished) {
                            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                            
                            [userDefault setObject:self.usernameTextField.text forKey:@"userName"];                            
                            [userDefault setObject:self.passwordTextField.text forKey:@"password"];
                            
                            [userDefault synchronize];
                        }];
                        //
                    });
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"登陆的错误码为:%d", status);
                } tokenIncorrect:^{
                    //token过期或者不正确。
                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                    NSLog(@"token错误");
                }];
            } else {
                [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (IBAction)registerButtonClick {
    ChooseRoleViewController *chooseRoleVC = [ChooseRoleViewController new];
    [self.navigationController pushViewController:chooseRoleVC animated:YES];
}

@end
