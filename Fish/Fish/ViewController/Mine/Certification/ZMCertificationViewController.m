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
#import <YTKBatchRequest.h>
#import <YTKChainRequest.h>
#import "YPImagePicker.h"
#import "ZMInputTextField.h"

@interface ZMCertificationViewController () <YTKChainRequestDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet ZMInputTextField *real_name_textField;
@property (weak, nonatomic) IBOutlet ZMInputTextField *ID_num_textField;
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
//    self.ID_num_textField.leftLabelText = @"123123";
    UIImage *image = [UIImage imageNamed:@"back24"];
    ZMUpLoadRequest *uploadRequest = [[ZMUpLoadRequest alloc] initWithImage:image];
    
    [uploadRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"_%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
   
}
- (IBAction)commit:(UIButton *)sender {
     ZMUpLoadRequest *image01 = [[ZMUpLoadRequest alloc] initWithImage:nil];
    YTKChainRequest *chainRequest = [[YTKChainRequest alloc] init];
    [chainRequest addRequest:image01 callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
//        RegisterApi *result = (RegisterApi *)baseRequest;
//        NSString *userId = [result userId];
//        GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId];
//        [chainRequest addRequest:api callback:nil];
    }];
    chainRequest.delegate = self;
    
    
//    ZMUpLoadRequest *image01 = [[ZMUpLoadRequest alloc] initWithImage:nil];
//    ZMUpLoadRequest *image02 = [[ZMUpLoadRequest alloc] initWithImage:nil];
//    ZMUpLoadRequest *image03 = [[ZMUpLoadRequest alloc] initWithImage:nil];
//    ZMUpLoadRequest *image04 = [[ZMUpLoadRequest alloc] initWithImage:nil];
//    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[image01,image02,image03,image04]];
//    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
//        NSArray *requests = batchRequest.requestArray;
//        ZMUpLoadRequest *a = (ZMUpLoadRequest *)requests[0];
//        ZMUpLoadRequest *b = (ZMUpLoadRequest *)requests[1];
//        ZMUpLoadRequest *c = (ZMUpLoadRequest *)requests[2];
//    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
//
//    }];
//    ZMRealNameRequest *realNameRequest = [[ZMRealNameRequest alloc] init];
//    realNameRequest.id = @"";
//    realNameRequest.userid = [ZMAccountManager shareManager].account.id;
//    realNameRequest.realname = self.real_name_textField.text;
//    realNameRequest.idnumber = self.ID_num_textField.text;
//    realNameRequest.idimgpath = @"0";
//    realNameRequest.certpath = @"0";
//    realNameRequest.photopath = @"0";
//    realNameRequest.workdate = @"0";
//    realNameRequest.areaid = @"0";
//    [realNameRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
////        NSLog(@"注册成功...");
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        //        ChooseRoleViewController *chooseRoleVC = [ChooseRoleViewController new];
//        //        [self.navigationController pushViewController:chooseRoleVC animated:YES];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//    }];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request {
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
     self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.thirdView.frame) + 13);
}

- (IBAction)takePhotoWithBtn:(UIButton *)sender {
    [YPImagePicker pickSingleImageWithTitle:@"设置封面" allowEditing:NO inViewController:self completionBlock:^(UIImage *image) {
        [sender setImage:image forState:UIControlStateNormal];
    }];
    if (sender == self.IDCardBackBtn) {
        
    } else if (sender == self.IDCardForwardBtn) {
        
    } else if (sender == self.BizCertificateBtn) {
        
    } else if (sender == self.CertificateBtn) {
        
    }
}

@end
