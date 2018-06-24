//
//  ZMMemberDetailViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ZMAccountManager.h"
#import <NSObject+YYModel.h>
#import <RongIMKit/RongIMKit.h>
#import "ZMMemberDetailRequest.h"
#import "ZMMemberDetailIModel.h"
#import "ZMMemberHandleRequest.h"

@interface ZMMemberDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIView *descView;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *tallLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiziLabel;
@property (weak, nonatomic) IBOutlet UILabel *daixieLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentQualityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiduLabel;

@property (weak, nonatomic) IBOutlet UIView *detailDescView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) ZMMemberDetailIModel * detailModel;
@property (nonatomic, strong) NSArray * detailImgs;



@end

@implementation ZMMemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.member.id) {
        self.descView.hidden = self.detailDescView.hidden = self.bottomView.hidden = YES;
        UIButton *blackListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [blackListButton setTitle:@"从黑名单中删除" forState:UIControlStateNormal];
        blackListButton.backgroundColor = ThemeColor;
        [[blackListButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
        [self.view addSubview:blackListButton];
        [blackListButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_equalTo(49);
        }];
    }
    UIImage *image = [[UIImage imageNamed:@"Group 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 3;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.detailDescView.frame));
    [self configCollectionView];
    [self request];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 15, 0);
    flowLayout.itemSize = CGSizeMake(70, 70);
    flowLayout.minimumLineSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView reloadData];
}

- (void)request { 
    ZMMemberDetailRequest *request = [[ZMMemberDetailRequest alloc] init];
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    request.uid = self.member.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.detailModel = [ZMMemberDetailIModel modelWithJSON:request.responseObject[@"data"]];
        self.detailImgs = [self.detailModel.need.detailimg componentsSeparatedByString:@","];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    
    self.nameLabel.text = self.detailModel.userinfo.nickname;
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
    
    self.periodLabel.text = [NSString stringWithFormat:@"%@课时",self.detailModel.need.csum];
    self.purposeLabel.text = self.detailModel.need.coursetypenames;
    self.addressLabel.text = self.detailModel.need.areaname;
    self.detailDescriptionLabel.text = self.detailModel.need.detail;
    if ([self.detailModel.relation.status isEqualToString:@"0"]) {
        self.collectBtn.selected = NO;
    } else if ([self.detailModel.relation.status isEqualToString:@"1"]) {
        self.collectBtn.selected = YES;
    }
    
    [self.collectionView reloadData];
    [self updateBodyUI];
}

- (void)updateBodyUI {
    self.tallLabel.text = self.detailModel.bodydata.height;
    self.weightLabel.text = self.detailModel.bodydata.weight;
    self.daixieLabel.text = self.detailModel.bodydata.bmr;
    self.percentQualityLabel.text = self.detailModel.bodydata.bmi;
    self.tiziLabel.text = self.detailModel.bodydata.fat;
    self.weiduLabel.text = [NSString stringWithFormat:@"胸%@  臀%@  肩%@  小臂%@   大腿%@ ",self.detailModel.bodydata.wdxiong,self.detailModel.bodydata.wdtun,self.detailModel.bodydata.wdjian,self.detailModel.bodydata.wdxiaobi,self.detailModel.bodydata.wddatui];
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

#pragma mark -- 打招呼
- (IBAction)sayHello:(UIButton *)sender {
    RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
    chatVC.conversationType = ConversationType_PRIVATE;
    //如果是单聊，不显示发送方昵称
    chatVC.targetId = self.member.id;
    chatVC.title = self.member.nickname;
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark -- 关注
- (IBAction)concernClick:(UIButton *)sender {
    ZMMemberHandleRequest *request = [[ZMMemberHandleRequest alloc] init];
    request.id = [ZMAccountManager shareManager].loginUser.id;
    request.fid = self.detailModel.userinfo.id;
    if ([self.detailModel.relation.status isEqualToString:@"2"]) {
        [UIAlertController alertWithTitle:@"提示" message:@"此用户已被您加入黑名单，是否移除黑名单并关注" cancelTitle:@"取消" otherTitles:@[@"关注"] preferredStyle:UIAlertControllerStyleAlert completion:^(NSInteger index) {
            request.status = @"0";
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                self.collectBtn.selected = YES;
                self.detailModel.relation.status = @"1";
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
        }];
        return;
    }
   
    if ([self.detailModel.relation.status isEqualToString:@"0"]) {
        request.status = @"1";
    } else if ([self.detailModel.relation.status isEqualToString:@"1"]) {
        request.status = @"0";
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.detailModel.relation.status isEqualToString:@"0"]) {
                self.collectBtn.selected = YES;
                self.detailModel.relation.status = @"1";
            } else if ([self.detailModel.relation.status isEqualToString:@"1"]){
                self.collectBtn.selected = NO;
                self.detailModel.relation.status = @"0";
            }
        });
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar lt_setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailImgs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImageWithURL:[NSURL URLWithString:self.detailImgs[indexPath.row]] placeholder:PlaceholderImage];
    [cell addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell);
    }];
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

@end
