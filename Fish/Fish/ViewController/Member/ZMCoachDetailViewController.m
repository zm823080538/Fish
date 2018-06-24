//
//  ZMCoachDetailViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCoachDetailViewController.h"
#import <FSCalendar.h>
#import "ZMLessonTimeCell.h"
#import <RongIMKit/RongIMKit.h>
#import "UINavigationBar+Awesome.h"
#import "ZMContinueLessonVC.h"
@interface ZMCoachDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *privacyTalkBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *weekdaysLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dateButtons;

@end

@implementation ZMCoachDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.privacyTalkBtn.layer.borderWidth = 1;
    self.privacyTalkBtn.layer.borderColor = ThemeColor.CGColor;
    self.tableViewHeightConstraint.constant = 3 * 44;
}
- (IBAction)buy:(UIButton *)sender {
    ZMContinueLessonVC *vc = [ZMContinueLessonVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)appoint {
    [UIAlertController alertWithTitle:nil message:@"是否要预约体验课？" cancelTitle:@"取消" otherTitles:@[@"确实"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        NSLog(@"sure");
    }];
    
}
- (IBAction)fouse:(UIButton *)sender {
}
- (IBAction)praviteChat:(UIButton *)sender {
        RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
        chatVC.conversationType = ConversationType_PRIVATE;
        //如果是单聊，不显示发送方昵称
//        chatVC.targetId = self.member.id;
//        chatVC.title = self.member.nickname;
        [self.navigationController pushViewController:chatVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar lt_setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMLessonTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMLessonTimeCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

@end
