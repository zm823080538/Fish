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
#import "ZMStudentSaveRequest.h"
@interface ZMContinueLessonVC () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger _cTypeIndex;
    CGFloat _youhui; //优惠
    CGFloat _total; //总价
    NSUInteger _number; //数量
    NSString *_address; //地址
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSArray * infoArray;
@property (nonatomic, strong) NSMutableArray *selectTypes; //选中的小类




@end

@implementation ZMContinueLessonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _cTypeIndex = 0;
    _number = 1;
    self.selectTypes = @[].mutableCopy;
    self.title = @"购买私教课";
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 150;
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
    commitButton.backgroundColor = ThemeColor;
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(commitButton.mas_top);
    }];
    

    [self requst];
    // Do any additional setup after loading the view.
}

- (void)commit {
     ZMContinueLessonModel *selectModel = self.infoArray[_cTypeIndex];
    if (!selectModel) {
        [MBProgressHUD showErrorMessage:@"请选择大课类型"];
        return;
    }
    NSMutableString *muString = [NSMutableString string];
    
    [self.selectTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = obj.integerValue;
        List *list = selectModel.list[index];
        [muString appendFormat:@"%@", [NSString stringWithFormat:@"%@,",list.id]];
    }];
    if (muString.length > 0) {
        [muString deleteCharactersInRange:NSMakeRange(muString.length - 1, 1)];
    } else {
        [MBProgressHUD showErrorMessage:@"请选择小课类型"];
        return;
    }
    ZMStudentSaveRequest *request = [[ZMStudentSaveRequest alloc] init];
    request.tid = self.coachDetailModel.userinfo.id;
    request.uid = [ZMAccountManager shareManager].loginUser.id;
    request.ctype = selectModel.id;
    request.coursetypeids = muString;
    request.csum = [NSString stringWithFormat:@"%ld",_number];
    request.address = _address;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"申请成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

- (void)requst {
    [MBProgressHUD showActivityMessageInView:nil];
    ZMGetCourseInfoRequest *request = [[ZMGetCourseInfoRequest alloc] init];
    request.tid =  self.coachDetailModel.userinfo.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"加载成功"];
        [MBProgressHUD hideHUD];
        self.infoArray = [NSArray modelArrayWithClass:[ZMContinueLessonModel class] json:request.responseObject[@"data"]];
        [self updateUI];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)updateUI {
    ZMSettingItem  *item01 = [[ZMSettingItem  alloc] initWithImage:@"address_normal" title:@"地址" destinClassName:@"TeachQAViewController"];
    item01.style = ZMSettingItemStyleLabelArrow;
    item01.rightTitle = self.coachDetailModel.userinfo.address;
    _address = self.coachDetailModel.userinfo.address;
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:nil title:@"课程单价" destinClassName:@"ZMMemberApplyViewController"];
    item02.rightTitle = [NSString stringWithFormat:@"￥%@",self.coachDetailModel.userinfo.courseprice];
    ZMSettingItem  *item03 = [[ZMSettingItem  alloc] initWithImage:nil title:@"购买节数" destinClassName:@"ZMCalendarViewController"];
    item03.style = ZMSettingItemStyleCountNum;
    ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:nil title:@"优惠" destinClassName:@"ZMCountTableViewController"];
    item04.rightTitle = @"￥150";
    ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:nil title:@"总价" destinClassName:@"ZMMyCollectListController"];
    item05.rightTitle = @"￥150";
    self.dataSource = @[item01,item02,item03,item04,item05].mutableCopy;
    [self.tableView reloadData];
}

- (void)updateDetailInfo {
    ZMContinueLessonModel *selectModel = self.infoArray[_cTypeIndex];
    ZMSettingItem  *item02 = [[ZMSettingItem  alloc] initWithImage:nil title:@"课程单价" destinClassName:@"ZMMemberApplyViewController"];
    item02.rightTitle = [NSString stringWithFormat:@"￥%@",selectModel.price];
    
    ZMSettingItem  *item04 = [[ZMSettingItem  alloc] initWithImage:nil title:@"优惠" destinClassName:@"ZMCountTableViewController"];
    item04.title = [NSString stringWithFormat:@"优惠(%@)",selectModel.onsalelabel];
    if ([selectModel.onsaletype isEqualToString:@"1"]) {  //打折优惠
        _youhui = (1.0 - [selectModel.onsaledata floatValue]) * [selectModel.price floatValue];
        NSString *onsalePrice = [NSString stringWithFormat:@"%.2lf",_youhui * _number];
        item04.rightTitle = onsalePrice;
    } else if ([selectModel.onsaletype isEqualToString:@"2"]){ //满减优惠
        for (Onsaledataforapp *onSale in selectModel.onsaledataforapp) {
            if (selectModel.price.floatValue >= onSale.total.floatValue) {
                item04.rightTitle = [NSString stringWithFormat:@"-%.2lf",onSale.money.floatValue * _number];
                _youhui = onSale.money.floatValue * _number;
                break;
            }
        }
    } else { //无优惠
        _youhui = 0;
        item04.rightTitle = @"0";
    }
    
    _total = selectModel.price.floatValue * _number - _youhui;
    ZMSettingItem  *item05 = [[ZMSettingItem  alloc] initWithImage:nil title:@"总价" destinClassName:@"ZMMyCollectListController"];
    item05.rightTitle = [NSString stringWithFormat:@"￥%.2lf",_total];
    
    [self.dataSource replaceObjectAtIndex:1 withObject:item02];
    [self.dataSource replaceObjectAtIndex:3 withObject:item04];
    [self.dataSource replaceObjectAtIndex:4 withObject:item05];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMNearMememberCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMNearMememberCell" owner:nil options:nil][1];
        }
        
        NSDictionary *dict = [self.coachDetailModel.userinfo modelToJSONObject];
        ZMMemberModel *model = [ZMMemberModel modelWithJSON:dict];
        cell.model = model;
        return cell;
    } else if (indexPath.row == 1) {
        ZMLessonTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMLessonTypeCell"];
        if (!cell) {
            cell = [[ZMLessonTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMLessonTypeCell"];
        }
        
            NSMutableArray *tagStrings = @[].mutableCopy;
            [self.infoArray enumerateObjectsUsingBlock:^(ZMContinueLessonModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tagStrings addObject:obj.name];
            }];
            cell.tagList = tagStrings;
            cell.title = @"课程类型";
            __weak typeof(cell) weakCell = cell;
            cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
                _cTypeIndex = index;
                weakCell.selectIndex = index;
                [self updateDetailInfo];
                [self.selectTypes removeAllObjects];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0],[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            };
        cell.tagView.selectIndex = 0;
        
       
        return cell;
    } else if (indexPath.row == 2) {
        ZMLessonTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMLessonTypeCell1"];
        if (!cell) {
            cell = [[ZMLessonTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZMLessonTypeCell1"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        NSMutableArray *tagStrings = @[].mutableCopy;
        [self.infoArray enumerateObjectsUsingBlock:^(ZMContinueLessonModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == _cTypeIndex) {
                [obj.list enumerateObjectsUsingBlock:^(List * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [tagStrings addObject:obj.name];
                }];
            }
        }];
        cell.tagList = tagStrings;
        cell.title = @"课程小类";
        cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
            if ([self.selectTypes containsObject:@(index)]) {
                [self.selectTypes removeObject:@(index)];
            } else {
                [self.selectTypes addObject:@(index)];
            }
        };
        return cell;
    }
    else {
        static NSString *ID = @"ZMMineTableViewCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ZMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        ZMSettingItem *item = self.dataSource[indexPath.row - 3];
        if ([item.title isEqualToString:@"优惠"] || [item.title isEqualToString:@"地址"]) {
            item.rightTitle = [NSString stringWithFormat:@"%@",item.rightTitle];
            cell.rightLabel.textColor = ThemeColor;
        } else {
            cell.rightLabel.textColor = ThemeRedColor;
        }
        [cell setModel:item];
        cell.numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            _number = number;
            [self updateDetailInfo];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
