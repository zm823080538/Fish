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
#import "UIAlertController+Set.h"
#import "ZMAccountManager.h"
#import "ZMMineModel.h"
#import "ZMMineDefine.h"
#import "ZMMineTableViewCell.h"
#import <UIImage+YYAdd.h>
#import "ZMGetAuthRequest.h"
#import "ZMMessageViewController.h"
#import "UINavigationBar+Awesome.h"
#import <RongIMKit/RongIMKit.h>
#import "ZMCalendarViewController.h"
#import "PersonalInfoViewController.h"

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
    
    UIImage *xiaoxi = [[UIImage imageNamed:@"xiaoxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:xiaoxi style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    rightBarbuttonItem.tintColor = [UIColor whiteColor];
    
    UIImage *setting3 = [UIImage imageNamed:@"setting3"];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:setting3 style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    rightBarbuttonItem1.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
    [self loadData];
    [self adapterUIForIOS11:self.tableView];
}

- (void)rightBarItem1Click {
    ZMCalendarViewController *scheduleVC = [[ZMCalendarViewController alloc] init];
    [self.navigationController pushViewController:scheduleVC animated:YES];
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
    ZMMineModel  *item01 = [[ZMMineModel  alloc] initWithImage:@"result" title:@"教学资质" destinClassName:@"TeachQAViewController"];
    ZMMineModel  *item02 = [[ZMMineModel  alloc] initWithImage:@"member_addUser" title:@"会员申请" destinClassName:@"ZMMemberApplyViewController"];
    ZMMineModel  *item03 = [[ZMMineModel  alloc] initWithImage:@"order" title:@"我的日程" destinClassName:@""];
    ZMMineModel  *item04 = [[ZMMineModel  alloc] initWithImage:@"tongji" title:@"统计" destinClassName:@"ZMCountTableViewController"];
    ZMMineModel  *item05 = [[ZMMineModel  alloc] initWithImage:@"shoucang" title:@"我的收藏" destinClassName:@"ZMMyCollectListController"];
    ZMMineModel  *item06 = [[ZMMineModel  alloc] initWithImage:@"share2" title:@"推荐好友" destinClassName:@"ZMRecFriendViewController"];
    ZMMineModel  *item07 = [[ZMMineModel  alloc] initWithImage:@"yajin" title:@"押金" destinClassName:@""];

  
    ZMMineModel  *item08 = [[ZMMineModel  alloc] initWithImage:@"Mustread" title:@"教练必读" destinClassName:@"ZMMustReadTableViewController"];
    ZMMineModel  *item09 = [[ZMMineModel  alloc] initWithImage:@"share2" title:@"分享给朋友" destinClassName:@"ZMRecFriendViewController"];


//
     ZMMineModel  *item10 = [[ZMMineModel  alloc] initWithImage:@"feedback" title:@"意见反馈" destinClassName:@"ZMFeedbackViewController"];
    ZMMineModel  *item11 = [[ZMMineModel  alloc] initWithImage:@"about_us" title:@"关于我们" destinClassName:@""];
    self.dataSource = @[@[item01,item02,item03,item04,item05,item06],@[item07,item08,item09],@[item10,item11]];
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
    ZMMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMMineTableViewCell" owner:nil options:nil].firstObject;
    }
    ZMMineModel  *item = self.dataSource[indexPath.section][indexPath.row];
    [cell setModel:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMineModel  *item = self.dataSource[indexPath.section][indexPath.row];
    if ([item.title isEqualToString:@"押金"]) {
        [UIAlertController alertWithTitle:@"提示" message:@"您暂未交押金！" cancelTitle:@"取消" otherTitles:@[@"交押金"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
            NSLog(@"---");
        }];
    } else {
        if ([item.title isEqualToString:@"我的客服"]) {
            RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
            chatVC.conversationType = ConversationType_CUSTOMERSERVICE;
            //如果是单聊，不显示发送方昵称
            chatVC.targetId = @"001";
            chatVC.title = @"我的客服";
            [self.navigationController pushViewController:chatVC animated:YES];
        } else {
            Class class = NSClassFromString(item.destinClassName);
            [self.navigationController pushViewController:[class new] animated:YES];
        }
    }
}


@end
