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
#import "ZMGetCourseInfoRequest.h"
#import "ZMContinueLessonModel.h"
@interface ZMContinueLessonVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSArray * infoArray;



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
    item01.rightTitle = self.coachDetailModel.userinfo.address;
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:nil title:@"常规课系统" destinClassName:@"ZMMemberApplyViewController"];
    item02.rightTitle = self.coachDetailModel.userinfo.courseprice;
    ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:nil title:@"购买节数" destinClassName:@"ZMCalendarViewController"];
    item03.style = ZMSettingItemStyleCountNum;
    ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:nil title:@"优惠" destinClassName:@"ZMCountTableViewController"];
    item04.rightTitle = @"￥150";
    ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:nil title:@"总价" destinClassName:@"ZMMyCollectListController"];
    item05.rightTitle = @"￥150";
    self.dataSource = @[item01,item02,item03,item04,item05];
    [self.tableView reloadData];
    [self requst];
    // Do any additional setup after loading the view.
}

- (void)requst {
    [MBProgressHUD showActivityMessageInView:nil];
    ZMGetCourseInfoRequest *request = [[ZMGetCourseInfoRequest alloc] init];
    request.tid =  self.coachDetailModel.userinfo.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"加载成功"];
        self.infoArray = [NSArray modelArrayWithClass:[ZMContinueLessonModel class] json:request.responseObject[@"data"]];
        
//        self.detailModel = [ZMCoachDetailModel modelWithJSON:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    
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
        
        NSDictionary *dict = [self.coachDetailModel.userinfo modelToJSONObject];
        ZMMemberModel *model = [ZMMemberModel modelWithJSON:dict];
        cell.model = model;
        return cell;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        ZMLessonTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMLessonTypeCell"];
        if (!cell) {
            cell = [[ZMLessonTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMLessonTypeCell"];
        }
        if (indexPath.row == 1) {
//            NSArray *tagStrings = self.infoArray arr
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
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
