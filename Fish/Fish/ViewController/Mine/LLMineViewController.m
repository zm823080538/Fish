//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLMineViewController.h"
#import <UIImageView+YYWebImage.h>
#import "ZMCertificationViewController.h"
#import "TeachQAViewController.h"
#import "UIAlertController+Set.h"
#import "ZMAccountManager.h"
#import "ZMGetUserRequest.h"
#import "ZMSettingItem.h"
#import "ZMMineDefine.h"
#import "ZMSettingCell.h"
#import <UIImage+YYAdd.h>
#import "ZMGetAuthRequest.h"
#import "ZMPrivacyListViewController.h"
#import "UINavigationBar+Awesome.h"
#import <RongIMKit/RongIMKit.h>
#import "ZMSettingTableViewController.h"
#import "ZMCalendarViewController.h"
#import "PersonalInfoViewController.h"
#import "ZMOrderViewController.h"

@interface LLMineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView1;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView2;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *addUserBtn;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *verfiyStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ID_number_label;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;

@end

@implementation LLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 10;
    UIImage *xiaoxi = [[UIImage imageNamed:@"xiaoxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:xiaoxi style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    rightBarbuttonItem.tintColor = [UIColor whiteColor];
    
    UIImage *setting3 = [UIImage imageNamed:@"setting3"];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:setting3 style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    rightBarbuttonItem1.tintColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
    [self updateTableHeaderView];
    [self loadData];
    [self updateUI];
    [self adapterUIForIOS11:self.tableView];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:ZMUpdateUserInfoNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        [self updateTableHeaderView];
    }];
}

- (void)rightBarItem1Click {
    ZMSettingTableViewController *settingVC = [[ZMSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}



- (void)rightBarItemClick {
    ZMPrivacyListViewController *messageVC = [ZMPrivacyListViewController new];
    messageVC.title = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)updateTableHeaderView {
    if ([ZMAccountManager shareManager].isLogin) {
        self.tableView.tableHeaderView = self.tableHeaderView2;
        [self.portrait setImageWithURL:[NSURL URLWithString:[ZMAccountManager shareManager].loginUser.img] placeholder:PlaceholderImage];
        self.userNameLabel.text = [ZMAccountManager shareManager].loginUser.nickname;
        self.ID_number_label.text = [NSString stringWithFormat:@"ID:%@",[ZMAccountManager shareManager].loginUser.no];
        [self.ageButton setTitle:[ZMAccountManager shareManager].loginUser.age forState:UIControlStateNormal];
        [self getAuthStatus];
        self.verfiyStatusLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToCer)];
        [self.verfiyStatusLabel addGestureRecognizer:tapGesture];
        
    } else {
        self.tableView.tableHeaderView = self.tableHeaderView1;
    }
    self.tableView.tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

}

- (void)pushToCer {
    ZMCertificationViewController *cerficationVc = [[ZMCertificationViewController alloc] init];
    [self.navigationController pushViewController:cerficationVc animated:YES];
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
    ZMGetUserRequest *request = [[ZMGetUserRequest alloc] init];
    request.id = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        if ([request.responseObject[@"code"] integerValue] == 0) {
            ZMAccount *account = [ZMAccount modelWithJSON:request.responseObject[@"data"]];
            [ZMAccountManager shareManager].loginUser = account;
            [self updateTableHeaderView];
        } else {
            [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];


}

- (void)updateUI {
    if ([[ZMAccountManager shareManager] isCoach]) { //教练
        //Section0
        ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"result" title:@"教学资质" destinClassName:@"TeachQAViewController"];
        item01.style = ZMSettingItemStyleLabelArrow;
        item01.rightTitle = @"审核中";
        ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:@"member_addUser" title:@"会员申请" destinClassName:@"ZMMemberApplyViewController"];
        item02.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:@"order" title:@"我的日程" destinClassName:@"ZMCalendarViewController"];
        item03.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:@"tongji" title:@"统计" destinClassName:@"ZMCountTableViewController"];
        item04.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:@"shoucang" title:@"我的收藏" destinClassName:@"ZMMyCollectListController"];
        item05.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item06 = [[ZMSettingItem  alloc] initWithImage:@"Recommend" title:@"推荐好友" destinClassName:@"ZMRecFriendViewController"];
        item06.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item07 = [[ZMSettingItem  alloc] initWithImage:@"servicetime" title:@"工作时间设置" destinClassName:@"ZMLessonTimeSettingController"];
        item07.style = ZMSettingItemStyleArrow;
        //Section1
        ZMSettingItem  *item08 = [[ZMSettingItem  alloc] initWithImage:@"yajin" title:@"押金" destinClassName:@""];
        item08.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item09 = [[ZMSettingItem  alloc] initWithImage:@"Mustread" title:@"教练必读" destinClassName:@"ZMMustReadTableViewController"];
        item09.style = ZMSettingItemStyleArrow;
        //Section2
        ZMSettingItem  *item10 = [[ZMSettingItem  alloc] initWithImage:@"share2" title:@"分享给朋友" destinClassName:@""];
        item10.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item11 = [[ZMSettingItem  alloc] initWithImage:@"feedback" title:@"意见反馈" destinClassName:@"ZMFeedbackViewController"];
        item11.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item12 = [[ZMSettingItem  alloc] initWithImage:@"about_us" title:@"关于我们" destinClassName:@""];
        item12.style = ZMSettingItemStyleArrow;
         self.dataSource = @[@[item01,item02,item03,item04,item05,item06,item07],@[item08,item09],@[item10,item11,item12]];
    } else { // 会员
        
        ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"result" title:@"我的订单" destinClassName:@"ZMOrderViewController"];
        item01.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:@"member_addUser" title:@"身体数据" destinClassName:@"ZMWebViewController"];
//        ZMBodyBuildingKnowledageListController
        item02.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:@"order" title:@"健身需求" destinClassName:@"ZMCalendarViewController"];
        item03.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:@"shoucang" title:@"我的收藏" destinClassName:@"ZMMyCollectListController"];
        item04.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:@"share2" title:@"分享给朋友" destinClassName:@""];
        item05.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item06 = [[ZMSettingItem  alloc] initWithImage:@"feedback" title:@"意见反馈" destinClassName:@"ZMFeedbackViewController"];
        item06.style = ZMSettingItemStyleArrow;
        ZMSettingItem  *item07 = [[ZMSettingItem  alloc] initWithImage:@"about_us" title:@"关于我们" destinClassName:@""];
        item07.style = ZMSettingItemStyleArrow;
        self.dataSource = @[@[item01,item02],@[item03,item04,item05,item06],@[item07]];
    }
    [self.tableView reloadData];
}


- (IBAction)PushToPersonalInfo:(UITapGestureRecognizer *)sender {
    PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc] init];
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //设置导航栏背景图片为一个空的image，这样就透明了
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMSettingItem  *item = self.dataSource[indexPath.section][indexPath.row];
    [cell setModel:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMSettingItem  *item = self.dataSource[indexPath.section][indexPath.row];
    if ([item.title isEqualToString:@"押金"]) {
        [UIAlertController alertWithTitle:@"提示" message:@"您暂未交押金！" cancelTitle:@"取消" otherTitles:@[@"交押金"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
            NSLog(@"---");
        }];
    } else {
        if ([item.title isEqualToString:@"教学资质"]) {
            TeachQAViewController *teachQA = [TeachQAViewController new];
            teachQA.status = @"审核中";
            [self.navigationController pushViewController:teachQA animated:YES];
        } else {
            Class class = NSClassFromString(item.destinClassName);
            UIViewController *vc = [class new];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
