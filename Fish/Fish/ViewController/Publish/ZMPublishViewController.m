//
//  ZMPublishViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPublishViewController.h"
#import "ZMHomeSectionView.h"
#import "ZMSettingCell.h"
#import "UITextView+MGPlaceholder.h"
#import "SKTagView.h"
#import "ZMPersonalModel.h"
#import "ZMGetNeedRequest.h"
#import "ZMGetAllLessonRequest.h"
#import "ZMPickPhotoCollectionView.h"
#import "ZMBaseActionSheetView.h"
#import "ZMCTypeModel.h"
#import "ZMPublishModel.h"
#import "LZCityPickerController.h"
#import "ZMPublishSaveRequest.h"
#import "HXPhotoManager.h"
#import "HXPhotoView.h"

@interface ZMPublishViewController () <UITableViewDelegate, UITableViewDataSource,HXPhotoViewDelegate> {
    NSInteger _number;
    NSString *_detail;
    NSString *_areaCode;
    NSString *_detailImgs;
    CGFloat _sectionHeight;
}
@property (nonatomic, strong) HXPhotoManager *manager;
@property (nonatomic, weak) HXPhotoView *photoView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) NSArray * cTypes;
@property (nonatomic, strong) NSArray * details;
@property (nonatomic, strong) NSMutableArray * selectCTypes;
@property (nonatomic, strong) ZMPublishModel * publishModel;




@end

@implementation ZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionHeight = 50;
    self.title = @"发布需求";
    self.selectCTypes = @[].mutableCopy;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.view addSubview:self.tableView];
    [self request];
   
    self.sectionTitles = @[@"类型", @"详细描述", @"意向购买节数"];
 
}

- (void)save {
    ZMPublishSaveRequest *request = [[ZMPublishSaveRequest alloc] init];
    request.userid = [ZMAccountManager shareManager].loginUser.id;
    NSString *coursetypeids = [self.selectCTypes componentsJoinedByString:@","];
    request.coursetypeids = coursetypeids;
    request.csum = [NSString stringWithFormat:@"%ld",_number];
    request.areacode = _areaCode;
    request.detail = _detail;
    request.detailimg = _detailImgs;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"发布需求成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)request {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        ZMGetAllLessonRequest *request = [[ZMGetAllLessonRequest alloc] init];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            self.cTypes = [NSArray modelArrayWithClass:[ZMCTypeModel class] json:request.responseObject[@"data"]];
            dispatch_semaphore_signal(semaphore);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            ZMGetNeedRequest *request = [[ZMGetNeedRequest alloc] init];
            request.userid = [ZMAccountManager shareManager].loginUser.id;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                self.publishModel = [ZMPublishModel modelWithJSON:request.responseObject[@"data"]];
                self.selectCTypes = [self.publishModel.coursetypeids componentsSeparatedByString:@","].mutableCopy;
                _detail = self.publishModel.detail;
                _detailImgs = self.publishModel.detailimg;
                _areaCode = self.publishModel.areacode;
//                NSMutableArray *array = [NSMutableArray arrayWithObjects:@"http://oss-cn-hangzhou.aliyuncs.com/tsnrhapp/shop/photos/857980fd0acd3caf9e258e42788e38f5_0.gif",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
                NSArray *array = [_detailImgs componentsSeparatedByString:@","];
                [self.manager addNetworkingImageToAlbum:array selected:YES];
                [self.photoView refreshView];
                ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:nil title:@"购买节数" destinClassName:nil];
                item01.style = ZMSettingItemStyleCountNum;
                ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:nil title:@"地址" destinClassName:nil];
                item02.style = ZMSettingItemStyleLabelArrow;
                item02.rightTitle = self.publishModel.areaname;                
                self.details = @[item01,item02];
                [self.tableView reloadData];
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMHomeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZMHomeSectionView"];
    if (!sectionView) {
        sectionView = [[ZMHomeSectionView alloc] initWithReuseIdentifier:@"ZMHomeSectionView"];
    }
    sectionView.arrowButton.hidden = YES;
    sectionView.title = self.sectionTitles[section];
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
        photoView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 100);
        photoView.lineCount = 5;
        photoView.delegate = self;
        photoView.backgroundColor = [UIColor whiteColor];
        self.photoView = photoView;
        return photoView;
    } else {
        return nil;
    }
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return _sectionHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 150;
    if (indexPath.section == 1) return 100;
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) return 1;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        SKTagView *tagView = [[SKTagView alloc] init];
        tagView.padding = UIEdgeInsetsMake(10, 20, 10, 20);
        tagView.lineSpacing = 20;
        tagView.interitemSpacing = 42;
        NSMutableArray *muArry = @[].mutableCopy;
        for (ZMCTypeModel *model in self.cTypes) {
            SKTag *tag = [[SKTag alloc] initWithText:model.name];
            if ([self.selectCTypes containsObject:model.id]) {
                [muArry addObject:tag];
            }
            tag.padding = UIEdgeInsetsMake(8, 17, 8, 17);
            tag.textColor = ThemeColor;
            tag.borderColor = ThemeColor;
            tag.borderWidth = 1;
            tag.cornerRadius = 3;
            [tagView addTag:tag];
        }
        tagView.selectIndexs = muArry;
        [cell addSubview:tagView];
        [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
        }
        UITextView *textView = [[UITextView alloc] init];
        [cell addSubview:textView];
        textView.placeholder = @"请输入描述文字";
        textView.text = self.publishModel.detail;
        [textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            _detail = x;
        }];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).insets(UIEdgeInsetsMake(14, 14, 14, 14));
        }];
        return cell;
    } else {
        static NSString *ID = @"ZMSettingCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        ZMSettingItem  *item = self.details[indexPath.row];
        [cell setModel:item];
        if (cell.numberButton) {
            cell.numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
                _number = number;
            };
        }
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMSettingCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    if (indexPath.section == 2 && indexPath.row == 1) { //地址
        [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area,NSString *areaCode) {
            // 选择结果回调
            cell.rightLabel.text = address;
            _areaCode = areaCode;
        }];
    }
   
}

- (HXPhotoManager *)manager { // 懒加载管理类
    if (!_manager) { // 设置一些配置信息
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        //        _manager.openCamera = NO;
        _manager.configuration.showDeleteNetworkPhotoAlert = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 6;
        _manager.configuration.maxNum = 6;
        // 可以这个赋值也可以像下面那样

    }
    return _manager;
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    NSSLog(@"%@",NSStringFromCGRect(frame));
    _sectionHeight = CGRectGetMaxY(frame) + 10;
    [self.tableView reloadData];
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + 10);
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 50;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
