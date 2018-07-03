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
#import "ZMMemberDetailRequest.h"
#import "ZMCoachDetailModel.h"
#import "ZMMemberHandleRequest.h"
#import "ZMContinueLessonVC.h"
@interface ZMCoachDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *privacyTalkBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *weekdaysLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, strong) ZMCoachDetailModel * detailModel;
@property (nonatomic, strong) NSArray * currentTimeList;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dateButtons;
@property (nonatomic, strong) UIButton *currentDateButton;


@end

@implementation ZMCoachDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [[UIImage imageNamed:@"Group 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    barButtonItem.tintColor = [UIColor whiteColor];
    
    self.currentDateButton = self.dateButtons.firstObject;
    self.currentDateButton.backgroundColor = ThemeColor;
    self.currentDateButton.layer.cornerRadius = 22;
    self.currentDateButton.layer.masksToBounds = YES;
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 3;
    self.privacyTalkBtn.layer.borderWidth = 1;
    self.privacyTalkBtn.layer.borderColor = ThemeColor.CGColor;
    [self request];
}

- (void)rightBarItemClick {
    NSString *string = [self.detailModel.relation.status isEqualToString:@"2"] ? @"取消拉黑" : @"拉黑";
    NSString *messageString = [self.detailModel.relation.status isEqualToString:@"2"] ? @"将该会员移除黑名单" : @"将该会员拉入黑名单";
    [UIAlertController alertWithTitle:@"提示" message:messageString cancelTitle:@"取消" otherTitles:@[string] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        ZMMemberHandleRequest *request = [[ZMMemberHandleRequest alloc] init];
        request.id = [ZMAccountManager shareManager].loginUser.id;
        request.fid = self.detailModel.userinfo.id;
        request.status = [self.detailModel.relation.status isEqualToString:@"2"] ? @"0" : @"2";
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.detailModel.relation.status = [self.detailModel.relation.status isEqualToString:@"2"] ? @"0" : @"2";
            });
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }];
}

- (void)request {
    ZMMemberDetailRequest *request = [[ZMMemberDetailRequest alloc] init];
    if (IS_COACH) {
        request.tid = [ZMAccountManager shareManager].loginUser.id;
        request.uid = self.member.id;
    } else {
        request.uid = [ZMAccountManager shareManager].loginUser.id;
        request.tid = self.member.id;
    }
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.detailModel = [ZMCoachDetailModel modelWithJSON:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    self.currentTimeList = self.detailModel.workdatelist.firstObject.timelist;
    self.tableViewHeightConstraint.constant = self.currentTimeList.count * 44;
    
    [self.tableView reloadData];
    self.nameLabel.text = self.detailModel.userinfo.nickname;
    self.IDNumberLabel.text = [NSString stringWithFormat:@"ID:%@",self.detailModel.userinfo.no];
    self.infoLabel.text = self.detailModel.userinfo.intro;
    [self.ageLabel setTitle:self.detailModel.userinfo.age forState:UIControlStateNormal];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.detailModel.userinfo.img] placeholder:PlaceholderImage];
    NSString *imageName = @"";
    if ([self.detailModel.userinfo.sex isEqualToString:@"1"]) {
        imageName = @"nan";
        [self.ageLabel setBackgroundColor:UIColorFromRGB(0x82C9F9)];
    } else {
        imageName = @"nv";
        [self.ageLabel setBackgroundColor:UIColorFromRGB(0xF497B6)];
        
    }
    [self.ageLabel setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    self.periodLabel.text = self.detailModel.userinfo.skillname;
    self.addressLabel.text = self.detailModel.userinfo.address;
    
    
    NSString *month = self.detailModel.workdatelist.firstObject.month;
    NSString *year = self.detailModel.workdatelist.firstObject.year;
    self.dateLabel.text = [NSString stringWithFormat:@"%@月 %@",month,year];
    [self.detailModel.workdatelist enumerateObjectsUsingBlock:^(Workdatelist * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((UILabel *)self.weekdaysLabel[idx]).text = obj.weekindex;
        [((UIButton *)self.dateButtons[idx]) setTitle:obj.day forState:UIControlStateNormal];
    }];
}

- (IBAction)buy:(UIButton *)sender {
    ZMContinueLessonVC *vc = [ZMContinueLessonVC new];
    vc.coachDetailModel = self.detailModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)appoint {
    [UIAlertController alertWithTitle:nil message:@"是否要预约体验课？" cancelTitle:@"取消" otherTitles:@[@"确定"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        NSLog(@"sure");
    }];
    
}


- (IBAction)dateButtonClick:(UIButton *)sender {
    self.currentDateButton.backgroundColor = [UIColor whiteColor];
    sender.backgroundColor = ThemeColor;
    sender.layer.cornerRadius = 22;
    sender.layer.masksToBounds = YES;
    self.currentDateButton = sender;
    NSInteger index = sender.tag - 100;
    self.currentTimeList = self.detailModel.workdatelist[index].timelist;
    [self.tableView reloadData];
    self.tableViewHeightConstraint.constant = self.currentTimeList.count * 44;
    [self.view layoutIfNeeded];
    
}

- (IBAction)fouse:(UIButton *)sender {
}
- (IBAction)praviteChat:(UIButton *)sender {
        RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
        chatVC.conversationType = ConversationType_PRIVATE;
        //如果是单聊，不显示发送方昵称
        chatVC.targetId = self.detailModel.userinfo.id;
        chatVC.title = self.detailModel.userinfo.nickname;
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
    return self.currentTimeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMLessonTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMLessonTimeCell" owner:nil options:nil].firstObject;
    }
    cell.timeLabel.text = self.currentTimeList[indexPath.row];
    return cell;
}

@end
