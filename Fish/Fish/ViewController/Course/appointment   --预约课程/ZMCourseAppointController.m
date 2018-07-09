//
//  ZMCourseAppointController.m
//  Fish
//
//  Created by sunny on 2018/6/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseAppointController.h"
#import "ZMNearMememberCell.h"
#import "ZMSettingCell.h"
#import "ZMBaseActionSheetView.h"
#import "ZMSubscribeLessonRequest.h"
#import "ZMCourseAddressController.h"
#import "ZMSubscribeModel.h"
#import <UIImage+YYAdd.h>
#import "ELCVFlowLayout.h"
#import "ZMSubscribeSaveRequest.h"


@interface ZMCourseAppointController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    ZMBaseActionSheetView *_actionSheetView;
    NSInteger _btnIndex;
    NSInteger _brotherBtnIndex;
    NSInteger _currentSection;
}

@property (nonatomic, strong) ZMSubscribeModel * model;

@property (nonatomic, strong) NSArray * dataSource;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (nonatomic, strong) NSArray * dateArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSString *address;





@end

@implementation ZMCourseAppointController

- (void)viewDidLoad {
    [super viewDidLoad];
    _brotherBtnIndex = -1;
    _btnIndex = -1;
    _currentSection = -1;
    self.title = @"预约课程";
    self.view.backgroundColor = [UIColor whiteColor];
    [self request];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.tableView.tableFooterView = footerView;
     [self.tableView reloadData];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"提交申请" forState:UIControlStateNormal];
    button.backgroundColor = UIColorFromRGB(0x4A576A);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).mas_offset(13);
        make.right.equalTo(footerView).mas_offset(-13);
        make.bottom.equalTo(footerView.mas_bottom).mas_offset(-43);
        make.height.mas_equalTo(44);
    }];
    
   
}

- (void)request {
    ZMSubscribeLessonRequest *request = [[ZMSubscribeLessonRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.cardid = self.historyList.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.model = [ZMSubscribeModel modelWithJSON:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"result" title:@"课程类型" destinClassName:@"TeachQAViewController"];
        item01.rightTitle = [NSString stringWithFormat:@"%@(%@)",self.model.ctypename,self.model.coursetypenames];
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:@"member_addUser" title:@"预约时间" destinClassName:nil];
    item02.style = ZMSettingItemStyleLabelArrow;
    item02.rightTitle = @"请提前一个小时预约";
    ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:@"address_normal" title:@"地点" destinClassName:nil];
    item03.style = ZMSettingItemStyleLabelArrow;
    item03.rightTitle = self.model.address;
    self.dataSource = @[item01, item02, item03];
    [self.tableView reloadData];
    

}

- (void)commit {
    ZMSubscribeSaveRequest *request = [[ZMSubscribeSaveRequest alloc] init];
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.cardid = self.historyList.id;
    Datelist *dateList = self.model.timelist[_currentSection];
    request.startdate = dateList.date;
    Timelist *time1 = dateList.timelist[_btnIndex];
    Timelist *time2 = dateList.timelist[_brotherBtnIndex];
    request.starttime = [NSString stringWithFormat:@"%@,%@",time1.starttime,time2.starttime];
    request.address = _address;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 94;
    } else if (indexPath.row == 3) {
        return 53;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMNearMememberCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMNearMememberCell" owner:nil options:nil].firstObject;
        }
//        cell.model = self.model;
        return cell;
    } else if (indexPath.row == 3) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = @"建意提前12小时预约，超过12小时，教练有权拒绝。";
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = UIColorFromRGB(0xcccccc);
        return cell;
    } else  {
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineTableViewCell"];
        if (!cell) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMMineTableViewCell"];
        }
        if (indexPath.row == 4) {
            cell.model = self.dataSource.lastObject;
        } else {
            cell.model = self.dataSource[indexPath.row - 1];
        }        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        self.alertView = [[NSBundle mainBundle] loadNibNamed:@"ZMAppointTimeAlertView" owner:self options:nil].firstObject;
        ELCVFlowLayout *layout = [[ELCVFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 19;
        layout.minimumLineSpacing = 19;
        layout.itemSize = CGSizeMake((self.collectionView.width - 12) / 3, 26);

        [self.collectionView setCollectionViewLayout:layout];
//        layout.itemSize = CGSizeMake(77, 26);
//        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
       
        _actionSheetView = [ZMBaseActionSheetView alertWithContainerView:self.alertView type:ZMAlertViewTypeAlert];
        [self.collectionView reloadData];
        Datelist *dateModel = self.model.timelist[indexPath.section];
        self.currentDateLabel.text = [NSString stringWithFormat:@"周%@ %@",dateModel.weekindex,dateModel.date];
        [_actionSheetView show];
    } else if (indexPath.row == 4) {
        ZMCourseAddressController *addressVC = [ZMCourseAddressController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.model.timelist.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Datelist *list = self.model.timelist[section];
    return list.timelist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.layer.borderColor = ThemeColor.CGColor;
    cell.layer.borderWidth = 1;
    [cell.contentView removeAllSubviews];
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:ThemeColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
     Datelist *list = self.model.timelist[indexPath.section];
    Timelist *timeList = list.timelist[indexPath.item];
    [btn setTitle:timeList.time forState:UIControlStateNormal];
    
    if ((indexPath.section == _currentSection) && (_brotherBtnIndex == indexPath.item || _btnIndex == indexPath.item)) {
        btn.selected = YES;
    } else {
        btn.selected = NO;
    }
   
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [list.timelist enumerateObjectsUsingBlock:^(Timelist * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _currentSection = -1;
            _btnIndex = -1;
            _brotherBtnIndex = -1;
            _btnIndex = indexPath.item;
            if ([obj.time isEqualToString:timeList.brothertime]) {
                _brotherBtnIndex = idx;
                *stop = YES;
            }
            _currentSection = indexPath.section;
        }];
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }];
    }];
    [cell.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell);
    }];
    return cell;
}
- (IBAction)next:(id)sender {
    if (_currentIndex > self.model.timelist.count - 2) {
        return;
    }
    _currentIndex ++;
    Datelist *dateModel = self.model.timelist[self.currentIndex];
    self.currentDateLabel.text = [NSString stringWithFormat:@"周%@ %@",dateModel.weekindex,dateModel.date];
    CGFloat offSetX = self.collectionView.contentOffset.x + self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
}

- (IBAction)previous:(id)sender {
    if (_currentIndex == 0) {
        return;
    }
    
    self.currentIndex --;
    Datelist *dateModel = self.model.timelist[self.currentIndex];
    self.currentDateLabel.text = [NSString stringWithFormat:@"周%@ %@",dateModel.weekindex,dateModel.date];
    CGFloat offSetX = self.collectionView.contentOffset.x - self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}
- (IBAction)commit:(id)sender {
    [_actionSheetView hidden];
   
}

@end
