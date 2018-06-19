//
//  ZMCourseAppointController.m
//  Fish
//
//  Created by sunny on 2018/6/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseAppointController.h"
#import "ZMNearMememberCell.h"
#import "ZMMineTableViewCell.h"
#import "ZMCourseAddressController.h"
@interface ZMCourseAppointController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation ZMCourseAppointController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约课程";
    self.view.backgroundColor = [UIColor whiteColor];
    ZMMineModel  *item01 = [[ZMMineModel  alloc] initWithImage:@"result" title:@"课程类型" destinClassName:@"TeachQAViewController"];
    item01.rightTitle = @"审核中";
    ZMMineModel  *item02 = [[ZMMineModel  alloc] initWithImage:@"member_addUser" title:@"预约世界" destinClassName:@"ZMOrderViewController"];
    ZMMineModel  *item03 = [[ZMMineModel  alloc] initWithImage:@"order" title:@"地点" destinClassName:@"ZMCalendarViewController"];
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
        ZMMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineTableViewCell"];
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
    if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        ZMCourseAddressController *addressVC = [ZMCourseAddressController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}


@end
