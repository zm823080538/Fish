//
//  ZMContinueLessonVC.m
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMContinueLessonVC.h"
#import "ZMNearMememberCell.h"
#import "ZMLessonTypeCell.h"
#import "ZMSettingItem.h"
#import "ZMSettingCell.h"
#import "ZMAppointSuccVC.h"
#import "PPNumberButton.h"
#import "SKTagView.h"
@interface ZMContinueLessonVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * dataSource;


@end

@implementation ZMContinueLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买私教课";
    [self.view addSubview:self.tableView];
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
    commitButton.backgroundColor = ThemeColor;
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    @weakify(self)
    [[commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        ZMAppointSuccVC *vc = [ZMAppointSuccVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(commitButton.mas_top);
    }];
    
    ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"address_normal" title:@"地址" destinClassName:@"TeachQAViewController"];
    item01.style = ZMSettingItemStyleLabelArrow;
    item01.rightTitle = @"成都双流区";
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:nil title:@"常规课系统" destinClassName:@"ZMMemberApplyViewController"];
    item02.rightTitle = @"￥150";
    ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:nil title:@"购买节数" destinClassName:@"ZMCalendarViewController"];
    item03.style = ZMSettingItemStyleCountNum;
    ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:nil title:@"优惠" destinClassName:@"ZMCountTableViewController"];
    item04.rightTitle = @"￥150";
    ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:nil title:@"总价" destinClassName:@"ZMMyCollectListController"];
    item05.rightTitle = @"￥150";
    self.dataSource = @[item01,item02,item03,item04,item05];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 116;
        
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        return 100;
    }
    return 52;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMNearMememberCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMNearMememberCell" owner:nil options:nil].firstObject;
        }
        return cell;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        ZMLessonTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMLessonTypeCell"];
        if (!cell) {
            cell = [[ZMLessonTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMLessonTypeCell"];
        }
        if (indexPath.row == 1) {
            cell.tagList = @[@"常规课",@"特色课",@"专业课"];
            cell.title = @"课程类型";
            cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
                
                
            };
        } else {
            cell.tagList = @[@"常规课",@"特色课",@"专业课"];
            cell.title = @"课程小类";
            cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
                
            };
        }
       
        return cell;
    } else {
        static NSString *ID = @"ZMMineTableViewCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMMineTableViewCell" owner:nil options:nil].firstObject;
        }
        [cell setModel:self.dataSource[indexPath.row - 3]];
        cell.numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            
        };
        return  cell;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

@end
