//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLMineViewController.h"
#import <UIImageView+YYWebImage.h>
#import "UIAlertController+Set.h"
#import "ZMAccountManager.h"
#import "ZMMineModel.h"
#import "PersonalInfoCell.h"
#import <UIImage+YYAdd.h>
#import "ZMGetAuthRequest.h"
#import "ZMMessageViewController.h"
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"member_addUser"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClick)];
    
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting3"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
    [self loadData];
//    [self adapterUIForIOS11:self.tableView];
}

- (void)rightBarItem1Click {
    
}

- (void)leftBarItemClick {
    
}

- (void)rightBarItemClick {
    ZMMessageViewController *messageVC = [ZMMessageViewController new];
    messageVC.title = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)updateTableHeaderView {
    if ([ZMAccountManager shareManager].isLogin) {
        self.tableView.tableHeaderView = self.tableHeaderView2;
        [self.portrait setImageWithURL:[NSURL URLWithString:[ZMAccountManager shareManager].loginUser.img] placeholder:PlaceholderImage];
        self.userNameLabel.text = [ZMAccountManager shareManager].loginUser.nickname;
        [self getAuthStatus];
    } else {
        self.tableView.tableHeaderView = self.tableHeaderView1;
    }
}

- (void)getAuthStatus {
    ZMGetAuthRequest *authRequest = [[ZMGetAuthRequest alloc] init];
    authRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    [authRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([request.responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = request.responseObject[@"data"];
            if ([dict[@"status"] isEqualToString:@"0"]) {
                self.verfiyStatusLabel.text = @"未审核";
            } else if ([dict[@"status"] isEqualToString:@"1"]) {
                self.verfiyStatusLabel.text = @"审核通过";
            } else {
                self.verfiyStatusLabel.text = @"不通过";
            }
        }                
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)loadData {
    ZMMineModel  *item01 = [[ZMMineModel  alloc] initWithImage:@"result" title:@"教学资质" destinClassName:@"TeachQAViewController"];
    ZMMineModel  *item02 = [[ZMMineModel  alloc] initWithImage:@"member_addUser" title:@"会员申请" destinClassName:@"ZMCertificationViewController"];
    ZMMineModel  *item03 = [[ZMMineModel  alloc] initWithImage:@"order" title:@"我的日程" destinClassName:@""];
    ZMMineModel  *item04 = [[ZMMineModel  alloc] initWithImage:@"tongji" title:@"统计" destinClassName:@""];
    ZMMineModel  *item05 = [[ZMMineModel  alloc] initWithImage:@"tongji" title:@"押金" destinClassName:@""];
    ZMMineModel  *item06 = [[ZMMineModel  alloc] initWithImage:@"share2" title:@"推荐好友" destinClassName:@"ZMRecFriendViewController"];
    
    ZMMineModel  *item07 = [[ZMMineModel  alloc] initWithImage:@"about_us" title:@"关于我们" destinClassName:@""];
    ZMMineModel  *item08 = [[ZMMineModel  alloc] initWithImage:@"feedback" title:@"意思反馈" destinClassName:@"ZMFeedbackViewController"];
    
    self.dataSource = @[@[item01,item02,item03,item04,item05,item06],@[item07,item08]];
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
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
    if ([item.title isEqualToString:@"押金"]) {
        [UIAlertController alertWithTitle:@"提示" message:@"您暂未交押金！" cancelTitle:@"取消" otherTitles:@[@"交押金"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
            NSLog(@"---");
        }];
    } else {
        Class class = NSClassFromString(item.destinClassName);
        [self.navigationController pushViewController:[class new] animated:YES];
    }
}


@end
