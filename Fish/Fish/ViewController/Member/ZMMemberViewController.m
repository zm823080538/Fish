//
//  ZMMemberVierController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "ZMMemberViewController.h"
#import "ZMMessageViewController.h"
#import "ZMScanViewController.h"
#import "ZMMemberListController.h"
#import <SDCycleScrollView.h>
#import "ZMNewsListRequest.h"
#import "ZMNewList.h"
#import "ZMAccountManager.h"
#import <NSObject+YYModel.h>
#import "ZMWebViewController.h"
@interface ZMMemberViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) ZMNewList * bannerList;

@property (nonatomic, strong) SDCycleScrollView *bannerView;


@end

@implementation ZMMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"会员" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"saoyisao"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
    [self initViewControllers];
    [self configTabbar];
    [self request];
}

- (void)request {
    ZMNewsListRequest *newsListRequest1 = [[ZMNewsListRequest alloc] init];
    newsListRequest1.userid = [ZMAccountManager shareManager].loginUser.id;
    newsListRequest1.type = @"5";
    [newsListRequest1 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
         self.bannerList = [ZMNewList modelWithJSON:request.responseObject[@"data"]];
        NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:5];
        for (ZMNewListItem *item in self.bannerList.list) {
            [muArr addObject:item.image];
        }
        self.bannerView.imageURLStringsGroup = muArr;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)configTabbar {
    [self setHeaderView:self.bannerView
            needStretch:NO
           headerHeight:124
           tabBarHeight:44
      contentViewHeight:SCREEN_HEIGHT - StatusBarHeight - 64 - 44 - 49
  tabBarStopOnTopHeight:0];
    self.tabBar.itemTitleColor = UIColorFromRGB(0x3A3A3A);
    self.tabBar.itemTitleSelectedColor = UIColorFromRGB(0x4A576A);
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = UIColorFromRGB(0x4A576A);
    self.tabBar.indicatorCornerRadius = 2;
    [self.tabBar setIndicatorWidth:40 marginTop:35 marginBottom:6 tapSwitchAnimated:YES];
    [self setContentScrollEnabled:YES tapSwitchAnimated:NO];
}

- (void)initViewControllers {
    NSMutableArray *viewControllers = @[].mutableCopy;
    for (int i = 0; i < 4; i ++) {
        ZMMemberListController *listVC = [[ZMMemberListController alloc] init];
        if (i == 0) {
            listVC.yp_tabItemTitle =@"附近会员";
        } else if (i == 1){
            listVC.yp_tabItemTitle =@"我的会员";
        } else if (i == 2) {
            listVC.yp_tabItemTitle =@"我的关注";
        } else {
            listVC.yp_tabItemTitle =@"黑名单";
        }
        listVC.view.backgroundColor = [UIColor whiteColor];
        [viewControllers addObject:listVC];
    }
    self.viewControllers = viewControllers;
}

- (void)rightBarItem1Click {
    ZMScanViewController *scannerVC = [ZMScanViewController new];
    scannerVC.title = @"扫一扫";
    [self.navigationController pushViewController:scannerVC animated:YES];
}

- (void)leftBarItemClick {
    
}

- (void)rightBarItemClick {
    ZMMessageViewController *messageVC = [ZMMessageViewController new];
    messageVC.title = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124)];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZMNewListItem *item = self.bannerList.list[index];
    ZMWebViewController *webVc = [[ZMWebViewController alloc] init];
    webVc.item = item;
    [self.navigationController pushViewController:webVc animated:YES];
}

@end
