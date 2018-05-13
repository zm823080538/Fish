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
#import "ZMSaveAuthRequest.h"
#import "UIView+AddBackView.h"

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
@property (nonatomic, strong) NSMutableDictionary *imageDict;
@property (nonatomic, strong) NSMutableDictionary *imageUrlDict;


@end

@implementation ZMCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
//    self.ID_num_textField.leftLabelText = @"123123";
    
//    ZMUpLoadRequest *uploadRequest = [[ZMUpLoadRequest alloc] initWithImage:image];
//    UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
    self.imageDict = [NSMutableDictionary dictionary];
    self.imageUrlDict = [NSMutableDictionary dictionary];
}
- (IBAction)commit:(UIButton *)sender {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        ZMUpLoadRequest *image01 = [[ZMUpLoadRequest alloc] initWithImage:self.imageDict[@"idimgpath"]];

        
        [image01 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
//            NSDictionary *dict = request.responseObject;
            [self.imageUrlDict setValue:[image01 imageUrlString] forKey:@"idimgpath"];
            dispatch_semaphore_signal(semaphore);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    });
    dispatch_group_async(group, queue, ^{
        ZMUpLoadRequest *image02 = [[ZMUpLoadRequest alloc] initWithImage:self.imageDict[@"idimgpath"]];

        [image02 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
            NSDictionary *dict = request.responseObject;
        [self.imageUrlDict setValue:[image02 imageUrlString] forKey:@"idimgbackpath"];            dispatch_semaphore_signal(semaphore);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    });
    dispatch_group_async(group, queue, ^{
//        ZMUpLoadRequest *image03 = [[ZMUpLoadRequest alloc] initWithImage:image];
        ZMUpLoadRequest *image03 = [[ZMUpLoadRequest alloc] initWithImage:self.imageDict[@"photopath"]];

        [image03 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
            NSDictionary *dict = request.responseObject;
            [self.imageUrlDict setObject:[image03 imageUrlString] forKey:@"photopath"];
            dispatch_semaphore_signal(semaphore);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    });
    dispatch_group_async(group, queue, ^{
//        ZMUpLoadRequest *image04 = [[ZMUpLoadRequest alloc] initWithImage:image];
        ZMUpLoadRequest *image04 = [[ZMUpLoadRequest alloc] initWithImage:self.imageDict[@"certpath"]];

        [image04 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
            NSDictionary *dict = request.responseObject;
             [self.imageUrlDict setValue:[image04 imageUrlString] forKey:@"certpath"];
            dispatch_semaphore_signal(semaphore);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            ZMSaveAuthRequest *saveAuthRequest = [[ZMSaveAuthRequest alloc] init];
            saveAuthRequest.userid = [ZMAccountManager shareManager].loginUser.id;
            saveAuthRequest.realname = self.real_name_textField.textField.text;
            saveAuthRequest.idnumber = self.ID_num_textField.textField.text;
            saveAuthRequest.idimgpath = self.imageUrlDict[@"idimgpath"];
            saveAuthRequest.idimgbackpath = self.imageUrlDict[@"idimgbackpath"];
            saveAuthRequest.certpath = self.imageUrlDict[@"photopath"];
            saveAuthRequest.photopath = self.imageUrlDict[@"certpath"];
            saveAuthRequest.areaid =  [ZMAccountManager shareManager].loginUser.areacode;
            [saveAuthRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([request.responseObject[@"code"] isEqualToString:@"0"]) {
                        [self.view showToastString:@"认证成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [self.view showToastString:@"认证失败"];
                    }
                });
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        });
    });
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
     self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.thirdView.frame) + 13);
}

- (IBAction)takePhotoWithBtn:(UIButton *)sender {
    [YPImagePicker pickSingleImageWithTitle:@"设置封面" allowEditing:NO inViewController:self completionBlock:^(UIImage *image) {
        [sender setImage:image forState:UIControlStateNormal];
        if (sender == self.IDCardBackBtn) {
            [self.imageDict setObject:image forKey:@"idimgpath"];
        } else if (sender == self.IDCardForwardBtn) {
            [self.imageDict setObject:image forKey:@"idimgbackpath"];
        } else if (sender == self.BizCertificateBtn) {
            [self.imageDict setObject:image forKey:@"photopath"];
        } else if (sender == self.CertificateBtn) {
            [self.imageDict setObject:image forKey:@"certpath"];
        }
        
        
    }];
    
}

@end
