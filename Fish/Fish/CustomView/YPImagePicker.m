//
//  YPImagePicker.m
//  PiFuKeYiSheng
//
//  Created by 喻平 on 14-7-4.
//  Copyright (c) 2014年 com.pifukeyisheng. All rights reserved.
//

#import "YPImagePicker.h"
#import <objc/runtime.h>
#import "UIAlertController+YPKit.h"
#import "AppDelegate.h"
#import "ZMConfig.h"
//#import "YPKit.h"
//#import "MGUIToolKits.h"
//#import "QBImagePicker.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface YPImagePicker () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, copy) void (^singleBlock)(UIImage *image);
@property (nonatomic, copy) void (^multiBlock)(NSArray *images);

@end

@implementation YPImagePicker

+ (instancetype)shared {
    static YPImagePicker *imagePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [[YPImagePicker alloc] init];
    });
    return imagePicker;
}

+ (void)pickImageWithMaxNumber:(NSInteger)maxNumber
              inViewController:(UIViewController *)viewController
               completionBlock:(void (^)(NSArray *images))completionBlock {
    [[YPImagePicker shared] pickImageWithMaxNumber:maxNumber
                                  inViewController:viewController
                                   completionBlock:completionBlock];
}

+ (void)pickSingleImageWithTitle:(NSString *)title
                    allowEditing:(BOOL)allowEditing
             inViewController:(UIViewController *)viewController
                 completionBlock:(void (^)(UIImage *image))completionBlock {
    [[YPImagePicker shared] pickSingleImageWithTitle:title
                                        allowEditing:allowEditing
                                 inViewController:viewController
                                     completionBlock:completionBlock];
}

+ (void)pickSingleImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
                         allowEditing:(BOOL)allowEditing
                     inViewController:(UIViewController *)viewController
                      completionBlock:(void (^)(UIImage *image))completionBlock {
    [[YPImagePicker shared] pickSingleImageWithSourceType:sourceType
                                             allowEditing:allowEditing
                                         inViewController:viewController
                                          completionBlock:completionBlock];
}

- (void)pickImageWithMaxNumber:(NSInteger)maxNumber
              inViewController:(UIViewController *)viewController
               completionBlock:(void (^)(NSArray *images))completionBlock {
    self.multiBlock = completionBlock;
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
//    [actionSheet showInView:viewController.view
//      withCompletionBlock:^(NSInteger buttonIndex) {
//          if (buttonIndex == 0) {
//              [self requestCameraPermissionWithGrantedBlock:^{
//                  [self presentImagePickerControllerInViewController:viewController
//                                                          sourceType:UIImagePickerControllerSourceTypeCamera
//                                                        allowEditing:NO];
//              }];
//          } else if (buttonIndex == 1) {
//              [self requestPhotoLibraryPermissionWithGrantedBlock:^{
//                  QBImagePickerController *picker = [[QBImagePickerController alloc] init];
//                  picker.delegate = self;
//                  picker.allowsMultipleSelection = YES;
//                  picker.maximumNumberOfSelection = maxNumber;
//                  [viewController presentViewController:picker animated:YES completion:^{
//                      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//                  }];
//              }];
//          }
//      }];
}

- (void)pickSingleImageWithTitle:(NSString *)title
                    allowEditing:(BOOL)allowEditing
             inViewController:(UIViewController *)viewController
                 completionBlock:(void (^)(UIImage *image))completionBlock {
    self.singleBlock = completionBlock;

   __block UIImagePickerControllerSourceType sourceType;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        [self requestCameraPermissionWithGrantedBlock:^{
            [self presentImagePickerControllerInViewController:viewController sourceType:sourceType allowEditing:allowEditing];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self requestPhotoLibraryPermissionWithGrantedBlock:^{
            [self presentImagePickerControllerInViewController:viewController sourceType:sourceType allowEditing:allowEditing];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)pickSingleImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
                           allowEditing:(BOOL)allowEditing
                     inViewController:(UIViewController *)viewController
                        completionBlock:(void (^)(UIImage *image))completionBlock {
    self.singleBlock = completionBlock;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self requestCameraPermissionWithGrantedBlock:^{
            [self presentImagePickerControllerInViewController:viewController
                                                    sourceType:sourceType
                                                  allowEditing:allowEditing];
        }];
    } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [self requestPhotoLibraryPermissionWithGrantedBlock:^{
            [self presentImagePickerControllerInViewController:viewController
                                                    sourceType:sourceType
                                                  allowEditing:allowEditing];
        }];
    }
}

- (void)presentImagePickerControllerInViewController:(UIViewController *)controller
                                          sourceType:(UIImagePickerControllerSourceType)sourceType
                                        allowEditing:(BOOL)allowEditing {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = allowEditing;
    [controller presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        UIImage *image;
        if (picker.allowsEditing) {
            image = info[UIImagePickerControllerEditedImage];
        } else {
            image = info[UIImagePickerControllerOriginalImage];
        }
        NSLog(@"image size-->%@", NSStringFromCGSize(image.size));
        if (self.singleBlock) {
            self.singleBlock(image);
        }
        if (self.multiBlock) {
            self.multiBlock(@[image]);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
//        [[MGSkinManager instance] updateStatusBarStyle];
        self.singleBlock = nil;
        self.multiBlock = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [[MGSkinManager instance] updateStatusBarStyle];
}

- (void)requestCameraPermissionWithGrantedBlock:(void(^)(void))grantedBlock {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    // 有权限
                    if (grantedBlock) {
                        grantedBlock();
                    }
                } else {
                    // 用户拒绝
                    [UIAlertController showAlertWithTitle:@"相机权限已关闭，请到“隐私”-“相机”下打开权限"
                                      okButtonTitle:@"设置"
                                    okButtonClicked:^{
//                                        [UIApplication openURLString:UIApplicationOpenSettingsURLString];
                                    }];
                }
            });
        }];
    } else {
//        [UIView showErrorToast:@"您的设备不支持相机"];
        return;
    }
}

- (void)requestPhotoLibraryPermissionWithGrantedBlock:(void(^)(void))grantedBlock {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    if (grantedBlock) {
                        grantedBlock();
                    }
                } else if (status == PHAuthorizationStatusDenied) {
                    [UIAlertController showAlertWithTitle:@"照片权限已关闭，请到“隐私”-“照片”下打开权限"
                                      okButtonTitle:@"设置"
                                    okButtonClicked:^{
                                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
//                                        [UIApplication openURLString:UIApplicationOpenSettingsURLString];
                                    }];
                } else if (status == PHAuthorizationStatusRestricted) {
//                    [UIView showErrorToast:@"您的设备不支持相册"];
                }
            });
        }];
    } else {
//        [UIView showErrorToast:@"您的设备不支持相册"];
    }
}

@end
