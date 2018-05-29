//
//  ZMChangeMobileViewController.m
//  Fish
//
//  Created by zhaoming on 2018/5/27.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMChangeMobileViewController.h"
#import <ReactiveObjC.h>
#import "ZMChangeMobileRequest.h"
#import "ZMVerfiyCodeRequest.h"

@interface ZMChangeMobileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *verfiyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (nonatomic, assign) NSInteger remainSeconds;
@property (nonatomic, assign) NSInteger startCheckTimer;

@end

@implementation ZMChangeMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RAC(self.getCodeButton, enabled) = [RACSignal
                                        combineLatest:@[
                                                        RACObserve(self, remainSeconds),
                                                        RACObserve(self, startCheckTimer)
                                                        ]
                                        reduce:^id(NSNumber* remain, NSNumber* startCheck) {
                                            return@( remain.intValue == 0 && startCheck.integerValue == 0);
                                        }];
}
- (IBAction)getVerfiyCode:(UIButton *)sender {
    self.getCodeButton.enabled = FALSE;
    self.remainSeconds = 60;
    self.startCheckTimer = 1;
    [self setTime];
    ZMVerfiyCodeRequest *verfiyCodeRequest = [[ZMVerfiyCodeRequest alloc] init];
    verfiyCodeRequest.mobile = self.mobileTextField.text;
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

- (IBAction)commit:(UIButton *)sender {
    ZMChangeMobileRequest *commitRequest = [[ZMChangeMobileRequest alloc] init];
    commitRequest.id = [ZMAccountManager shareManager].loginUser.id;
    commitRequest.mobile = self.mobileTextField.text;
    commitRequest.code = self.verfiyCodeTextField.text;
    [commitRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.responseString);
        if ([request.responseObject[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccessMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
