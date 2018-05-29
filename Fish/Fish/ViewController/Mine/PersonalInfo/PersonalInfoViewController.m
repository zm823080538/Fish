//
//  PersonalInfoViewController.m
//  Fish
//
//  Created by sunny on 2018/4/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoCell.h"
#import <NSObject+YYModel.h>
#import "ZMPersonalModel.h"
#import "ZMAccountManager.h"
#import "UIAlertController+Set.h"
#import "LZCityPickerController.h"
#import "YPImagePicker.h"
#import <Masonry.h>
#import <RongCloudIMKit/RongIMKit/RongIMKit.h>
#import "AppDelegate.h"
#import <YTKChainRequest.h>
#import "ZMUserEditRequest.h"
#import "UIViewController+BackButtonHandler.h"
#import "ZMBindAliPayViewController.h"
#import "ZMUpLoadRequest.h"
#import "ZMChangeMobileViewController.h"

@interface PersonalInfoViewController ()  <UINavigationControllerDelegate, UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource,YTKChainRequestDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (nonatomic, strong) ZMAccount *originAccountInfo;
@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, copy) NSString *headerImageUrl;



@end

@implementation PersonalInfoViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    self.originAccountInfo = [ZMAccount modelWithJSON:[[ZMAccountManager shareManager].loginUser modelToJSONObject]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.backgroundColor = UIColorFromRGB(0x4A576A);
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(logoutBtn.mas_bottom);
    }];
    [self loadData];
}

- (void)save {
    if (self.headerImage) {
        ZMUpLoadRequest *image01 = [[ZMUpLoadRequest alloc] initWithImage:self.headerImage];
        
        [image01 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
            self.headerImageUrl = [image01 imageUrlString];
//            [self.imageUrlDict setValue:[image01 imageUrlString] forKey:@"idimgpath"];
//            dispatch_semaphore_signal(semaphore);
            [self updateUserInfo];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self.view showError:@"图片上传失败"];
        }];
    } else {
        [self updateUserInfo];
    }
}

- (void)updateUserInfo {
    ZMUserEditRequest *editRequest = [[ZMUserEditRequest alloc] init];
    editRequest.img = self.headerImageUrl;
    editRequest.nickname = self.originAccountInfo.nickname;
    editRequest.sex = self.originAccountInfo.sex;
    editRequest.id = [ZMAccountManager shareManager].loginUser.id;
    [editRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccessMessage:@"保存成功"];
            [MBProgressHUD hideHUD];
//            [ZMAccountManager shareManager].loginUser.nickname = self.originAccountInfo.nickname;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)logout {
    [[ZMAccountManager shareManager] logOut];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[RCIMClient sharedRCIMClient] disconnect:YES];
    [appdelegate changeRootVC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        });
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)[self.navigationController topViewController];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
//        if ([self.originAccountInfo modelHash] != [[ZMAccountManager shareManager].loginUser modelHash]) {
//            [self showAlert];
//            return NO;
//        }
//        return YES;
//    }
//    return YES;
//}

- (void)showAlert {
    [UIAlertController alertWithTitle:@"提示" message:@"是否保存修改" cancelTitle:@"取消" otherTitles:@[@"保存"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        [self commit];
        
    }];
}


- (void)commit {
    ZMUserEditRequest *request = [[ZMUserEditRequest alloc] init];
    request.nickname = self.originAccountInfo.nickname;
    request.sex = self.originAccountInfo.sex;
    request.img = self.originAccountInfo.img;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.view showToastString:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
//- (BOOL)navigationShouldPopOnBackButton {
//    if ([self.originAccountInfo modelHash] != [[ZMAccountManager shareManager].loginUser modelHash]) {
//        [self showAlert];
//        return NO;
//    }
//    return YES;
//}

- (void)loadData {
    ZMAccount *account = [ZMAccountManager shareManager].loginUser;
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:account.img title:@"头像" destinClassName:@"" style:PersonalInfoCellStyleImage subTitle:@""];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"昵称" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:account.nickname];
    NSString *sex;
    if ([account.sex isEqualToString:@"1"]) {
        sex = @"男";
    } else if ([account.sex isEqualToString:@"2"]) {
        sex = @"女";
    } else {
        sex = @"未知";
    }
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:@"order" title:@"性别" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:sex];
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"地址" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:account.address];
    ZMPersonalModel   *item05 = [[ZMPersonalModel   alloc] initWithImage:@"QR_Code" title:@"我的二维码" destinClassName:@"ZMMyQRCodeViewController" style:PersonalInfoCellStyleImage1 subTitle:nil];
    
    ZMPersonalModel   *item06 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"绑定微信号" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
     ZMPersonalModel   *item07 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"绑定支付宝帐号" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    ZMPersonalModel   *item08 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改手机号" destinClassName:@"ZMChangeMobileViewController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
     ZMPersonalModel   *item09 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改登录密码" destinClassName:@"ZMChangePwdViewController" style:PersonalInfoCellStyleArrow subTitle:nil];
    self.dataSource = @[@[item01,item02,item03,item04,item05],@[item06,item07,item08,item09]];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMPersonalModel  *item = self.dataSource[indexPath.section][indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfoCell *cell = (PersonalInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    ZMPersonalModel  *item = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [YPImagePicker pickSingleImageWithTitle:@"修改头像" allowEditing:YES inViewController:self completionBlock:^(UIImage *image) {
            cell.rightImageView.image = image;
            self.headerImage = image;
            
        }];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        ZMBindAliPayViewController *vc = [[ZMBindAliPayViewController alloc] init];
        vc.content = cell.rightLabel.text;
        @weakify(self)
        vc.block = ^(NSString *inputString) {
            @strongify(self)
            cell.rightLabel.text = inputString;
            self.originAccountInfo.nickname = inputString;        
        };
        vc.title = @"昵称";
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        [UIAlertController alertWithTitle:@"性别" message:nil cancelTitle:@"取消" otherTitles:@[@"男",@"女"] preferredStyle:UIAlertControllerStyleActionSheet completion:^(NSInteger index) {
            if (index == 0) {
                cell.rightLabel.text = @"男";
            } else if (index == 1) {
                cell.rightLabel.text = @"女";
            }
            item.subTitle = cell.rightLabel.text;
        }];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
            // 选择结果回调
            cell.rightLabel.text = address;
            
        }];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        ZMBindAliPayViewController *vc = [[ZMBindAliPayViewController alloc] init];
        vc.content = cell.rightLabel.text;
        vc.block = ^(NSString *inputString) {
            cell.rightLabel.text = inputString;
        };
        vc.title = @"绑定支付宝帐号";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (NSClassFromString(item.destinClassName)) {
        Class class = NSClassFromString(item.destinClassName);
        [self.navigationController pushViewController:[class new] animated:YES];
    }
}


@end
