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
#import "YPImagePicker.h"
#import "UIViewController+BackButtonHandler.h"

@interface PersonalInfoViewController ()  <UINavigationControllerDelegate, UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (nonatomic, strong) ZMAccount *originAccountInfo;
@property (nonatomic, strong) UIImage *headerImage;



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
    self.originAccountInfo = [ZMAccountManager shareManager].loginUser;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        });
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)[self.navigationController topViewController];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        if ([self.originAccountInfo modelHash] != [[ZMAccountManager shareManager].loginUser modelHash]) {
            [self showAlert];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)showAlert {
    [UIAlertController alertWithTitle:@"提示" message:@"是否保存修改" cancelTitle:@"取消" otherTitles:@[@"保存"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (BOOL)navigationShouldPopOnBackButton {
    if ([self.originAccountInfo modelHash] != [[ZMAccountManager shareManager].loginUser modelHash]) {
        [self showAlert];
        return NO;
    }
    return YES;
}

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
    ZMPersonalModel   *item05 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"我的二维码" destinClassName:@"" style:PersonalInfoCellStyleImage subTitle:nil];
    
    ZMPersonalModel   *item06 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"绑定微信号" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
    ZMPersonalModel   *item07 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改手机号" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
    
     ZMPersonalModel   *item08 = [[ZMPersonalModel   alloc] initWithImage:@"share2" title:@"修改登录密码" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
    self.dataSource = @[@[item01,item02,item03,item04,item05],@[item06,item07,item08]];
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
    if (indexPath.row == 0) {
        [YPImagePicker pickSingleImageWithTitle:@"修改头像" allowEditing:YES inViewController:self completionBlock:^(UIImage *image) {
            cell.rightImageView.image = image;
            self.headerImage = image;
        }];
    }
    if (NSClassFromString(item.destinClassName)) {
        Class class = NSClassFromString(item.destinClassName);
        [self.navigationController pushViewController:[class new] animated:YES];
    }
}


@end
