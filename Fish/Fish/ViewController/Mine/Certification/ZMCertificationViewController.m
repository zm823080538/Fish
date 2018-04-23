//
//  ZMCertificationViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCertificationViewController.h"
#import "ZMRealNameRequest.h"
#import "ZMAccountManager.h"
#import "ZMUpLoadRequest.h"

@interface ZMCertificationViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UITextField *real_name_textField;
@property (weak, nonatomic) IBOutlet UITextField *ID_num_textField;
@property (weak, nonatomic) IBOutlet UIButton *IDCardForwardBtn;
@property (weak, nonatomic) IBOutlet UIButton *IDCardBackBtn;


@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *BizCertificateBtn;
@property (weak, nonatomic) IBOutlet UIButton *CertificateBtn;

@property (weak, nonatomic) IBOutlet UIView *thirdView;

@end

@implementation ZMCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    
    UIImage *image = [UIImage imageNamed:@"back24"];
    ZMUpLoadRequest *uploadRequest = [[ZMUpLoadRequest alloc] initWithImage:image];
    
    [uploadRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"_%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
   
}
- (IBAction)commit:(UIButton *)sender {
    ZMRealNameRequest *realNameRequest = [[ZMRealNameRequest alloc] init];
    realNameRequest.id = @"";
    realNameRequest.userid = [ZMAccountManager shareManager].account.id;
    realNameRequest.realname = self.real_name_textField.text;
    realNameRequest.idnumber = self.ID_num_textField.text;
    realNameRequest.idimgpath = @"0";
    realNameRequest.certpath = @"0";
    realNameRequest.photopath = @"0";
    realNameRequest.workdate = @"0";
    realNameRequest.areaid = @"0";
    [realNameRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"注册成功...");
        [self.navigationController popToRootViewControllerAnimated:YES];
        //        ChooseRoleViewController *chooseRoleVC = [ChooseRoleViewController new];
        //        [self.navigationController pushViewController:chooseRoleVC animated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
     self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.thirdView.frame) + 13);
}


@end
