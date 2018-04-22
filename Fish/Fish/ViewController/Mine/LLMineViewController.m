//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLMineViewController.h"
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

@end

@implementation LLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.tableHeaderView1;
    [self loadData];
    [self adapterUIForIOS11:self.tableView];
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
