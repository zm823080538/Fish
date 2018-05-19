//
//  LLHomeViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLHomeViewController.h"
#import <SDCycleScrollView.h>
#import "ZMHomeBodyBuildingKnowledageCell.h"
#import "ZMMemberResultCell.h"
#import "ZMExerciseResultCell.h"
#import "LLTabBarItem.h"
#import "LLTabBar.h"
#import "UIButton+YPKit.h"
#import <UIView+YYAdd.h>
#import "ZMHomeSectionView.h"
#import "ZMPreferentialActivityController.h"
#import "ZMMarketTableViewController.h"
#import "ZMNearMemberViewController.h"
#import "ZMMessageViewController.h"

#import "ZMExerciseResultListController.h"
#import "ZMMemberResultListController.h"
#import "ZMBodyBuildingKnowledageListController.h"

@interface LLHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation LLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIButton *button in self.buttons) {
        [button setContentHorizontalCenterWithVerticalOffset:5];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"健身" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    self.bannerView.imageURLStringsGroup = @[@"http://img05.tooopen.com/images/20140328/sy_57865838889.jpg",@"http://img05.tooopen.com/images/20140328/sy_57865838889.jpg",@"http://img05.tooopen.com/images/20140328/sy_57865838889.jpg"];
}

- (void)leftBarItemClick {
    
}

- (void)rightBarItemClick {
    ZMMessageViewController *messageVC = [ZMMessageViewController new];
    messageVC.title = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}
- (IBAction)preferentialActivity:(UIButton *)sender {
    ZMPreferentialActivityController *perferentialActivityVC = [ZMPreferentialActivityController new];
    perferentialActivityVC.title = @"优惠活动";
    [self.navigationController pushViewController:perferentialActivityVC animated:YES];
}
- (IBAction)pushToMarket:(id)sender {
    ZMMarketTableViewController *marketVC = [ZMMarketTableViewController new];
    marketVC.title = @"商城";
    [self.navigationController pushViewController:marketVC animated:YES];
    
}
- (IBAction)pushToNearmember:(id)sender {
    ZMNearMemberViewController *nearMemberVC = [ZMNearMemberViewController new];
    nearMemberVC.title = @"附近会员";
    [self.navigationController pushViewController:nearMemberVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 114;
    } else if (indexPath.section == 1) {
        return 271;
    } else {
        return 140;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMHomeSectionView *sectionView = [[ZMHomeSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    if (section == 0) {
        sectionView.title = @"健身知识";
        @weakify(self)
        sectionView.arrowClick = ^{
            @strongify(self)
            ZMBodyBuildingKnowledageListController *bodyBuildingKnowledageListVC = [[ZMBodyBuildingKnowledageListController alloc] init];
            bodyBuildingKnowledageListVC.title = @"健身知识";
            [self.navigationController pushViewController:bodyBuildingKnowledageListVC animated:YES];
        };
    } else if (section == 1) {
        sectionView.title = @"会员成果";
        @weakify(self)
        sectionView.arrowClick = ^{
            @strongify(self)
            ZMMemberResultListController *memberResultListVC = [[ZMMemberResultListController alloc] init];
            memberResultListVC.title = @"会员成果";
            [self.navigationController pushViewController:memberResultListVC animated:YES];
        };        
    } else {
        sectionView.title = @"训练技巧";
        @weakify(self)
        sectionView.arrowClick = ^{
            @strongify(self)
            ZMExerciseResultListController *exciseResultListVC = [[ZMExerciseResultListController alloc] init];
             exciseResultListVC.title = @"训练技巧";
            [self.navigationController pushViewController:exciseResultListVC animated:YES];
        };
      
    }
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZMHomeBodyBuildingKnowledageCell *knowledageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class])];
        if (!knowledageCell) {
            knowledageCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMHomeBodyBuildingKnowledageCell class]) owner:nil options:nil].firstObject;
        }
        return knowledageCell;
    } else if (indexPath.section == 1) {
        ZMMemberResultCell *memberResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberResultCell class])];;
        if (!memberResultCell) {
            memberResultCell = [[ZMMemberResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZMMemberResultCell class])];
        }
        return memberResultCell;
    } else {
        ZMExerciseResultCell *exerciseResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMExerciseResultCell class])];;
        if (!exerciseResultCell) {
            exerciseResultCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMExerciseResultCell class]) owner:nil options:nil].firstObject;
        }
        return exerciseResultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
