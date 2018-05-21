//
//  ZMCourseDetailViewController.m
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseDetailViewController.h"
#import <Masonry.h>
#import "UIButton+YPKit.h"
#import "UINavigationBar+Awesome.h"
@interface ZMCourseDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;



@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZMCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Group 2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    if (self.type) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bottomView.bounds;
        [button setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [button setTitle:@"发消息" forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];       
    } else {
        NSArray *titleArr = @[@{@"title":@"发消息",@"image":@"message"},@{@"title":@"取消预约"}];
        for (int i = 0; i < titleArr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * self.bottomView.width / 2, 0, self.bottomView.width / 2, self.bottomView.height);
            [button setImage:[UIImage imageNamed:[titleArr[i] valueForKey:@"image"]] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [button setTitle:titleArr[i][@"title"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
        }
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.bottomView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, self.bottomView.height - 20));
            make.center.equalTo(self.bottomView);
        }];
    }
}

- (void)rightBarItemClick {
    
}

- (void)bottomButtonClick:(UIButton *)button {
    
}

- (IBAction)callPhone {
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


@end
