//
//  ZMMemberVierController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "ZMMemberViewController.h"
#import "ZMMessageViewController.h"
#import "ZMMemberListController.h"
@interface ZMMemberViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *bannerView;


@end

@implementation ZMMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"会员" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    UIBarButtonItem *rightBarbuttonItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"saoyisao"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem1Click)];
    self.navigationItem.rightBarButtonItems = @[rightBarbuttonItem,rightBarbuttonItem1];
//    self.dataSource = @[@"附近教练",@"接单教练",@"我关注的",@"黑名单",@"如何选择好教练?"];
    [self initViewControllers];
    [self configTabbar];
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
        listVC.view.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            listVC.yp_tabItemTitle =@"附近会员";
        } else if (i == 1){
            listVC.yp_tabItemTitle =@"我的会员";
        } else if (i == 2) {
            listVC.yp_tabItemTitle =@"我的关注";
        } else {
            listVC.yp_tabItemTitle =@"黑名单";
        }
        [viewControllers addObject:listVC];
    }
    self.viewControllers = viewControllers;
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

- (UIView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124)];
        _bannerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Group 4"].CGImage);
        _bannerView.backgroundColor = [UIColor orangeColor];
    }
    return _bannerView;
}

@end
