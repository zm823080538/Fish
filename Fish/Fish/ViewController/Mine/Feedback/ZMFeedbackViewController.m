//
//  ZMFeedbackViewController.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMFeedbackViewController.h"
#import "MGSearchFeedbackCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UITextView+MGPlaceholder.h"
#import "ZMPickPhotoCollectionView.h"
#import "UIColor+Hex.h"
#import <ReactiveObjC.h>
#import "HXPhotoManager.h"
#import "HXPhotoView.h"
#import "ZMUpLoadRequest.h"
#import <YTKBatchRequest.h>
#import "ZMFeedbackRequest.h"


@interface ZMFeedbackViewController () <UITableViewDelegate, UITableViewDataSource, PickPhotoCollectionViewDelegate,HXPhotoViewDelegate> {
    NSMutableArray *_detailImgs;
}
@property (nonatomic, strong) HXPhotoManager * manager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) NSMutableArray *selectFeedbackList;
@property (nonatomic, strong) RACSubject *selectSignal;
@property (weak, nonatomic) IBOutlet UIView *photoPickCollectionView;
@property (nonatomic, weak) HXPhotoView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ZMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈内容";
    [self configTableView];
    [self configFooterView];
    
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
//    photoView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 170);
    photoView.frame = self.photoPickCollectionView.bounds;
    photoView.lineCount = 5;
    photoView.spacing = 10;
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.photoPickCollectionView addSubview:photoView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    });
}

- (void)configTableView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
    self.dataSource = @[@"功能异常：功能故障或不可用",@"产品建议：用的不爽，我有建议",@"其他问题"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MGSearchFeedbackCell" bundle:nil] forCellReuseIdentifier:@"MGSearchFeedbackCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configFooterView {
    self.tableView.tableFooterView = self.footerView;
    self.commentTextView.placeholder = @"请输入不少于十个字的描述";
    self.commentTextView.placeholderColor = [UIColor colorWithHexString:@"#BABABA"];    
    self.commentTextView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 45);
    int  maxLength = 500;
    @weakify(self)
    RAC(self.commentNumLabel,text) = [self.commentTextView.rac_textSignal  map:^id(NSString *value) {
        @strongify(self)
        if (value.length > maxLength) {
            value = [value substringToIndex:maxLength];
            self.commentTextView.text = value;
        }
        self.commentNumLabel.textColor = (value.length == maxLength) ? [UIColor redColor] : [UIColor colorWithHexString:@"#999999"];
        return [NSString stringWithFormat:@"%ld/500",value.length];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSearchFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MGSearchFeedbackCell" forIndexPath:indexPath];
    cell.checkButton.userInteractionEnabled = NO;
    cell.titleLabel.text = self.dataSource[indexPath.row];
    BOOL containCurrentIndex = [self.selectFeedbackList containsObject:@(indexPath.row)];
    cell.checkButton.selected = containCurrentIndex ?: NO;
    [cell setLineViewHidden:((self.dataSource.count - 1) == indexPath.row) ? YES : NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MGSearchFeedbackCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkButton.selected = !cell.checkButton.selected;
    if (cell.checkButton.selected) {
        [self.selectFeedbackList addObject:@(indexPath.row)];
    } else {
        [self.selectFeedbackList removeObject:@(indexPath.row)];
    }
    [self.selectSignal sendNext:@(indexPath.row)];
}

- (void)commit {
    [self uploadImage];
}

- (void)uploadImage {
    NSMutableArray *uploadArray = @[].mutableCopy;
    for (UIImage *photoImage in _detailImgs) {
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
        [self save];
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"failed");
    }];
}

- (void)save {
    ZMFeedbackRequest *request = [[ZMFeedbackRequest alloc] init];
    request.userid = [ZMAccountManager shareManager].loginUser.id;
    NSString *pic1 = [_detailImgs componentsJoinedByString:@","];
    request.pic1 = pic1;
    request.type = @"2";
    request.content = self.commentTextView.text;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"反馈意见成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}



- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    [_detailImgs removeAllObjects];
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_detailImgs addObject:obj.thumbPhoto];
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
