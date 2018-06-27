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
#import "ZMCourseAddressController.h"
@interface ZMCourseAppointController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    ZMBaseActionSheetView *_actionSheetView;
}
@property (nonatomic, strong) NSArray * dataSource;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (nonatomic, strong) NSArray * dateArray;


@end

@implementation ZMCourseAppointController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约课程";
    self.view.backgroundColor = [UIColor whiteColor];
    ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"result" title:@"课程类型" destinClassName:@"TeachQAViewController"];
    item01.rightTitle = @"审核中";
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:@"member_addUser" title:@"预约时间" destinClassName:nil];
    item02.style = ZMSettingItemStyleLabelArrow;
    item02.rightTitle = @"请提前一个小时预约";
    ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:@"address_normal" title:@"地点" destinClassName:nil];
    self.dataSource = @[item01, item02, item03];
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

- (void)commit {
    
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
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMMineTableViewCell" owner:nil options:nil].firstObject;
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
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
       _actionSheetView = [ZMBaseActionSheetView alertWithContainerView:self.alertView type:ZMAlertViewTypeAlert];
        [_actionSheetView show];
    } else if (indexPath.row == 4) {
        ZMCourseAddressController *addressVC = [ZMCourseAddressController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.layer.borderColor = ThemeColor.CGColor;
    cell.layer.borderWidth = 1;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = ThemeColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    label.text = @"09:00-09:30";
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell);
    }];
    return cell;
}
- (IBAction)next:(id)sender {
}

- (IBAction)previous:(id)sender {
}
- (IBAction)commit:(id)sender {
    [_actionSheetView hidden];
}

@end
