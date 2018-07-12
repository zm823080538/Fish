//
//  ZMCourseDetailViewController.m
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseDetailViewController.h"
#import <RongCloudIMKit/RongIMKit/RongIMKit.h>
#import "ZMCourseCancelRequest.h"
#import <Masonry.h>
#import <MAMapKit/MAMapKit.h>
#import "UIButton+YPKit.h"
#import "ZMCourseDetailRequest.h"
#import "ZMComplainVC.h"
#import "UINavigationBar+Awesome.h"
#import "ZMEvaluationVC.h"

@interface ZMCourseDetailViewController ()
@property (strong, nonatomic) IBOutlet UIView *cancelView;
@property (weak, nonatomic) IBOutlet UITextView *cancelTextView;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;



@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZMCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userIconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userIconImageView.layer.borderWidth = 3;
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
    self.mapView = [[MAMapView alloc] initWithFrame:self.contentView.bounds];
    self.mapView.zoomLevel = 11;
    self.mapView.showsUserLocation = YES;
    // 追踪用户位置
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.contentView addSubview:self.mapView];
    [AMapServices sharedServices].enableHTTPS = YES;
//    [self request];
    [self updateUI];
}

- (void)request {
    ZMCourseDetailRequest *request = [[ZMCourseDetailRequest alloc] init];
    request.id = [ZMAccountManager shareManager].loginUser.id;
    request.tid = self.course.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {

    [self.userIconImageView setImageWithURL:[NSURL URLWithString:self.course.img] options:YYWebImageOptionProgressive];
    self.nameLabel.text = self.course.nickname;
    self.lessonTypeLabel.text = [NSString stringWithFormat:@"%@(%@)",self.course.ctypename,self.course.coursetypenames];
    NSString *lessonStatus = @"";
    if ([self.course.status isEqualToString:@"10"]) {
        lessonStatus = @"已预约";
    } else if ([self.course.status isEqualToString:@"11"]) {
        lessonStatus = @"进行中";
    } else if ([self.course.status isEqualToString:@"2"]) {
        lessonStatus = @"已结束";
    } else if ([self.course.status isEqualToString:@"3"]) {
        lessonStatus = @"已取消";
    }
    self.dateLabel.text = self.course.starttime;
    self.lessonStatusLabel.text = lessonStatus;
    self.addressLabel.text = [NSString stringWithFormat:@"训练地址：%@",self.course.address];
    self.coordinate = CLLocationCoordinate2DMake(self.course.latitude.floatValue, self.course.longtitude.floatValue);
}
- (IBAction)poilt:(UITapGestureRecognizer *)sender {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            BOOL baiduMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
            BOOL aMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
            BOOL googleMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"系统地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                               MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            if (baiduMapCanOpen) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=巴黎&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    //                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude, self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    //                baiduMapDic[@"url"] = urlString;
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                    }
                }]];
            }
            if (googleMapCanOpen) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"谷歌地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
            }
            if (aMapCanOpen) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                    }
                }]];
            }
            [self presentViewController:alertController animated:YES completion:nil];

}

- (void)rightBarItemClick {
    if (IS_COACH) {
        [UIAlertController alertWithTitle:nil message:nil cancelTitle:@"取消" otherTitles:@[@"取消预约"] preferredStyle:0 completion:^(NSInteger index) {
            [self showCancel];
        }];
    } else {
        [UIAlertController alertWithTitle:nil message:nil cancelTitle:@"取消" otherTitles:@[@"投诉",@"取消预约"] preferredStyle:0 completion:^(NSInteger index) {
            if (index == 0) {
                ZMComplainVC *complainVC = [ZMComplainVC new];
                [self.navigationController pushViewController:complainVC animated:YES];
            } else {
                [self showCancel];
            }
        }];
    }
    
}
- (IBAction)cancelClick {
    ZMCourseCancelRequest *request = [[ZMCourseCancelRequest alloc] init];
    request.tid = self.course.tid;
    request.id = self.course.id;
    request.cancelreason = self.cancelTextView.text;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:request.responseObject[@"msg"]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
    }];
    
}
- (IBAction)cancelCloseClick:(UIButton *)sender {
    [self.cancelView removeFromSuperview];
    self.cancelView = nil;
}

- (void)bottomButtonClick:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"取消预约"]) {
        [self showCancel];
    } else {
        RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
        chatVC.conversationType = ConversationType_PRIVATE;
        //如果是单聊，不显示发送方昵称
        chatVC.targetId = self.course.uid;
        chatVC.title = self.course.nickname;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    
}

- (void)showCancel {
    self.cancelView = [[NSBundle mainBundle] loadNibNamed:@"ZMCourseCancelView" owner:self options:nil].firstObject;
    self.cancelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.cancelView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.cancelView];
    self.cancelTextView.layer.cornerRadius = 6;
    self.cancelTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancelTextView.layer.borderWidth = 1;
}

- (IBAction)callPhone {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self.course.mobile];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
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
