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
#import "ZMUpLoadRequest.h"
#import "HXPhotoManager.h"
#import "HXPhotoView.h"
#import <YTKBatchRequest.h>
@interface ZMComplainVC () <HXPhotoViewDelegate> {
    NSMutableArray *_detailImgs;
    NSMutableArray *_localImgs;
}
@property (nonatomic, strong) HXPhotoManager * manager;
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;
@property (weak, nonatomic) IBOutlet UIView *photoView;

@end

@implementation ZMComplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    _detailImgs = @[].mutableCopy;
    _localImgs = @[].mutableCopy;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = self.photoView.bounds;
    photoView.lineCount = 4;
    photoView.spacing = 10;
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.photoView addSubview:photoView];
    
}
- (IBAction)finish:(id)sender {
    [self uploadImage];
}

- (void)commit {
    ZMFeedbackRequest *feedbackRequest = [[ZMFeedbackRequest alloc] init];
    feedbackRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    feedbackRequest.content = self.resonTextView.text;
    feedbackRequest.pic1 = [_detailImgs componentsJoinedByString:@","];
    feedbackRequest.type = @"1";
    [feedbackRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"投诉成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)uploadImage {
    NSMutableArray *uploadArray = @[].mutableCopy;
    for (UIImage *photoImage in _localImgs) {
        ZMUpLoadRequest *a = [[ZMUpLoadRequest alloc] initWithImage:photoImage];
        [uploadArray addObject:a];
    }
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:uploadArray];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSLog(@"succeed");
        NSArray *requests = batchRequest.requestArray;
        for (ZMUpLoadRequest *request in requests) {
            [_detailImgs addObject:[request imageUrlString]];
        }
        [self commit];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"failed");
    }];
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    [_detailImgs removeAllObjects];
    [_localImgs removeAllObjects];
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.networkPhotoUrl) {
            [_detailImgs addObject:obj.networkPhotoUrl];
        } else if (obj.thumbPhoto) {
            [_localImgs addObject:obj.thumbPhoto];
        }
    }];
    
}

- (HXPhotoManager *)manager { // 懒加载管理类
    if (!_manager) { // 设置一些配置信息
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.showDeleteNetworkPhotoAlert = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 6;
        _manager.configuration.maxNum = 6;
        // 可以这个赋值也可以像下面那样
        
    }
    return _manager;
}


@end
