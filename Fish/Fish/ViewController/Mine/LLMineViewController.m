//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLMineViewController.h"
#import <UIImageView+YYWebImage.h>

#import "ZMAccountManager.h"
#import "ZMMineModel.h"
#import "PersonalInfoCell.h"
#import "PersonalInfoViewController.h"

@interface LLMineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView1;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView2;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *addUserBtn;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *verfiyStatusLabel;

@end

@implementation LLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self adapterUIForIOS11:self.tableView];
}

- (void)updateTableHeaderView {
    if ([ZMAccountManager shareManager].isLogin) {
        self.tableView.tableHeaderView = self.tableHeaderView2;
        [self.portrait setImageWithURL:[NSURL URLWithString:[ZMAccountManager shareManager].loginUser.nickname] placeholder:nil];
        
        [self.portrait setImageWithURL:[NSURL URLWithString:@"http://img2.imgtn.bdimg.com/it/u=1711569,1878578975&fm=27&gp=0.jpg"] placeholder:nil];
        self.userNameLabel.text = [ZMAccountManager shareManager].loginUser.nickname;
        self.userNameLabel.text = @"张三";
    } else {
        self.tableView.tableHeaderView = self.tableHeaderView1;
    }
}

- (void)loadData {
    ZMMineModel  *item01 = [[ZMMineModel  alloc] initWithImage:@"result" title:@"教学资质" destinClassName:@"PersonalInfoViewController"];
    ZMMineModel  *item02 = [[ZMMineModel  alloc] initWithImage:@"member_addUser" title:@"会员申请" destinClassName:@"ZMCertificationViewController"];
    ZMMineModel  *item03 = [[ZMMineModel  alloc] initWithImage:@"order" title:@"我的日程" destinClassName:@"TeachQAViewController"];
    ZMMineModel  *item04 = [[ZMMineModel  alloc] initWithImage:@"" title:@"统计" destinClassName:@""];
    ZMMineModel  *item05 = [[ZMMineModel  alloc] initWithImage:@"customService" title:@"我的客服" destinClassName:@""];
    
    ZMMineModel  *item06 = [[ZMMineModel  alloc] initWithImage:@"" title:@"关于我们" destinClassName:@""];
    ZMMineModel  *item07 = [[ZMMineModel  alloc] initWithImage:@"share2" title:@"分享给朋友" destinClassName:@""];
    
    self.dataSource = @[@[item01,item02,item03,item04,item05],@[item06,item07]];
    [self.tableView reloadData];
}
- (IBAction)setting:(UIButton *)sender {
    PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc] init];
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}
- (IBAction)messageBtnClick:(UIButton *)sender {
}
- (IBAction)addUserBtnClick:(UIButton *)sender {
}
- (IBAction)PushToPersonalInfo:(UITapGestureRecognizer *)sender {
    PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc] init];
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
    [self updateTableHeaderView];
    
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMineModel  *item = self.dataSource[indexPath.section][indexPath.row];
    Class class = NSClassFromString(item.destinClassName);
    [self.navigationController pushViewController:[class new] animated:YES];
}


@end
