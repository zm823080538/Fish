//
//  ForgetPasswordViewController.m
//  Fish
//
//  Created by sunny on 2018/4/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import <ReactiveObjC.h>
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
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@property (nonatomic, assign) NSInteger remainSeconds;
@property (nonatomic, assign) NSInteger startCheckTimer;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usernameTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [self.verfiyCodeTextField setValue:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    self.usernameTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.passwordTextField.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
    self.registerUser.layer.borderColor = [UIColor colorWithHexString:@"#FFCD00" alpha:0.4].CGColor;
    self.registerUser.layer.borderWidth = 1.0f;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:0.95];

    [self.registerUser setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];


    RAC(self.getCodeButton, enabled) = [RACSignal
                                        combineLatest:@[
                                                        RACObserve(self, remainSeconds),
                                                        RACObserve(self, startCheckTimer)
                                                        ]
                                        reduce:^id(NSNumber* remain, NSNumber* startCheck) {
                                            return@( remain.intValue == 0 && startCheck.integerValue == 0);
                                        }];
    
}
- (IBAction)showPwdClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTextField.secureTextEntry = !sender.selected;
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
        if ([request.responseObject[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccessMessage:@"修改成功"];
        } else {
            [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
        }
        NSLog(@"%@",request.responseString);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (IBAction)getCodeClick:(UIButton *)sender {
    self.getCodeButton.enabled = FALSE;
    self.remainSeconds = 60;
    self.startCheckTimer = 1;
    [self setTime];
    ZMVerfiyCodeRequest *verfiyCodeRequest = [[ZMVerfiyCodeRequest alloc] init];
    verfiyCodeRequest.mobile = self.usernameTextField.text;
    verfiyCodeRequest.type = @"2";
    [verfiyCodeRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

- (void)setTime{
    @weakify(self);
    RACSignal* signal = [[[RACSignal interval:1
                                  onScheduler:[RACScheduler mainThreadScheduler]] startWith:[NSDate date]] map:^id(NSDate* value) {
        @strongify(self);
        if(self.remainSeconds > 0 && self.startCheckTimer){
            self.remainSeconds = self.remainSeconds - 1;
            if(self.remainSeconds == 0){
                self.startCheckTimer = 0;
            }
        }
        NSString *text = [NSString stringWithFormat:@"%ld",self.remainSeconds];
        return text; }];
    [signal subscribeNext:^(NSString* x) {
        @strongify(self);
        if (x.integerValue == 0) {
            [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        } else {
            [self.getCodeButton setTitle:[NSString stringWithFormat:@"%@秒",x] forState:UIControlStateNormal];
        }
    }];
}

@end
