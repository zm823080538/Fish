//
//  ZMComplainVC.m
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMComplainVC.h"
#import "ZMPickPhotoCollectionView.h"
#import "ZMFeedbackRequest.h"
@interface ZMComplainVC ()
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;
@property (weak, nonatomic) IBOutlet ZMPickPhotoCollectionView *pickView;

@end

@implementation ZMComplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    
}
- (IBAction)finish:(id)sender {
    ZMFeedbackRequest *feedbackRequest = [[ZMFeedbackRequest alloc] init];
    feedbackRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    feedbackRequest.content = self.resonTextView.text;
    feedbackRequest.pic1 = @"";
    feedbackRequest.type = @"1";
    [feedbackRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"投诉成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
   
}


@end
