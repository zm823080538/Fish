//
//  ZMMemberDetailViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import <PNChart.h>

@interface ZMMemberDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet PNLineChart *chartView;

@property (weak, nonatomic) IBOutlet UILabel *tallLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiziLabel;
@property (weak, nonatomic) IBOutlet UILabel *daixieLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentQualityLabel;



@end

@implementation ZMMemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Group 2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    
    // 设置x轴上坐标内容
    [self.chartView setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
    // 设置好像没什么用
    self.chartView.xLabelColor = [UIColor orangeColor];
    
    self.chartView.showLabel = YES;
    // 是否显示Y轴的数值
    self.chartView.showGenYLabels = YES;
    // 是否显示横向虚线
    self.chartView.showYGridLines = YES;
    // 是否平滑的曲线
    self.chartView.showSmoothLines = NO;
    // 是否显示xy 坐标轴
    self.chartView.showCoordinateAxis = YES;
    // 轴的颜色
    self.chartView.axisColor = [UIColor orangeColor];
    // 轴的宽度
    self.chartView.axisWidth = 2.0f;
    
    
    //    lineChart.thousandsSeparator = YES;
    // 设置y轴坐标的颜色
    self.chartView.yLabelColor = [UIColor redColor];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.dataTitle = @"Hello World";
    // 设置点的格式
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.inflexionPointColor = [UIColor purpleColor];
    // 是否点label
    data01.showPointLabel = YES;
    data01.pointLabelColor = [UIColor redColor];
    data01.pointLabelFont = [UIFont systemFontOfSize:12];
    data01.pointLabelFormat = @"%1.1f";
    // 设置折线有几个值
    data01.itemCount = self.chartView.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        
        // 设置x轴坐标对应的y轴的值
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = self.chartView.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // 设置line的数据数组
    self.chartView.chartData = @[data01, data02];
    // 绘制出来
    [self.chartView strokeChart];

}

- (void)rightBarItemClick {
    
}

#pragma mark -- 打招呼
- (IBAction)sayHello:(UIButton *)sender {
}

#pragma mark -- 关注
- (IBAction)concernClick:(UIButton *)sender {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
