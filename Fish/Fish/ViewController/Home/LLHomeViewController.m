//
//  LLHomeViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLHomeViewController.h"
#import <SDCycleScrollView.h>
#import <YTKBatchRequest.h>
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
#import <NSObject+YYModel.h>

#import "ZMExerciseResultListController.h"
#import "ZMMemberResultListController.h"
#import "ZMBodyBuildingKnowledageListController.h"
#import "ZMWebViewController.h"

#import "ZMNewsListRequest.h"

#import "ZMNewList.h"

@interface LLHomeViewController () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic, strong) ZMNewList *activityNewList;
@property (nonatomic, strong) ZMNewList *bannberNewList;
@property (nonatomic, strong) ZMNewList *knowledgeNewList;
@property (nonatomic, strong) ZMNewList *resultNewList;
@property (nonatomic, strong) ZMNewList *teachNewList;


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
    self.bannerView.delegate = self;
    self.tableView.tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    

    
    [self request];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZMNewListItem *item = self.activityNewList.list[index];
    ZMWebViewController *webVc = [[ZMWebViewController alloc] init];
    webVc.item = item;
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)request {
    ZMNewsListRequest *newsListRequest = [[ZMNewsListRequest alloc] init];
    newsListRequest.type = @"1";
    
    ZMNewsListRequest *newsListRequest1 = [[ZMNewsListRequest alloc] init];
    newsListRequest.type = @"2";
    
    ZMNewsListRequest *newsListRequest2 = [[ZMNewsListRequest alloc] init];
    newsListRequest.type = @"3";
    
    ZMNewsListRequest *newsListRequest3 = [[ZMNewsListRequest alloc] init];
    newsListRequest.type = @"4";
    
    ZMNewsListRequest *newsListRequest4 = [[ZMNewsListRequest alloc] init];
    newsListRequest.type = @"5";
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[newsListRequest,newsListRequest1,newsListRequest2,newsListRequest3,newsListRequest4]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        ZMNewsListRequest *request = requests[0];
        self.activityNewList = [ZMNewList modelWithJSON:request.responseObject[@"data"]];
//        1:活动2:健身知识，4训练成果，5 训练技巧
//        ZMNewsListRequest *request1 = requests[1];
//        self.bannberNewList = [ZMNewList modelWithJSON:request1.responseObject[@"data"]];
        ZMNewsListRequest *request2 = requests[1];
        self.knowledgeNewList = [ZMNewList modelWithJSON:request2.responseObject[@"data"]];
        ZMNewsListRequest *request3 = requests[2];
        self.teachNewList = [ZMNewList modelWithJSON:request3.responseObject[@"data"]];
        ZMNewsListRequest *request4 = requests[3];
        self.resultNewList = [ZMNewList modelWithJSON:request4.responseObject[@"data"]];
        [self.tableView reloadData];
        NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:5];
        for (ZMNewListItem *item in self.activityNewList.list) {
            [muArr addObject:item.image];
        }
        self.bannerView.imageURLStringsGroup = muArr;
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSLog(@"failed");
    }];
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
    perferentialActivityVC.list = self.activityNewList.list;
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
            bodyBuildingKnowledageListVC.arrayList = self.knowledgeNewList;
            bodyBuildingKnowledageListVC.title = @"健身知识";
            [self.navigationController pushViewController:bodyBuildingKnowledageListVC animated:YES];
        };
    } else if (section == 1) {
        sectionView.title = @"会员成果";
        @weakify(self)
        sectionView.arrowClick = ^{
            @strongify(self)
            ZMMemberResultListController *memberResultListVC = [[ZMMemberResultListController alloc] init];
            memberResultListVC.arrayList = self.resultNewList;
            memberResultListVC.title = @"会员成果";
            [self.navigationController pushViewController:memberResultListVC animated:YES];
        };        
    } else {
        sectionView.title = @"训练技巧";
        @weakify(self)
        sectionView.arrowClick = ^{
            @strongify(self)
            ZMExerciseResultListController *exciseResultListVC = [[ZMExerciseResultListController alloc] init];
            exciseResultListVC.arrayList = self.teachNewList;
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
        knowledageCell.item = self.knowledgeNewList.list[indexPath.row];
        return knowledageCell;
    } else if (indexPath.section == 1) {
        ZMMemberResultCell *memberResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberResultCell class])];;
        if (!memberResultCell) {
            memberResultCell = [[ZMMemberResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZMMemberResultCell class])];
        }
        memberResultCell.arrayList = self.resultNewList.list;
        return memberResultCell;
    } else {
        ZMExerciseResultCell *exerciseResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMExerciseResultCell class])];;
        if (!exerciseResultCell) {
            exerciseResultCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMExerciseResultCell class]) owner:nil options:nil].firstObject;
        }
        exerciseResultCell.item = self.teachNewList.list[indexPath.row];
        return exerciseResultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
