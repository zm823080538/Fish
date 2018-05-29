//
//  ZMLessonDetailSetController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonDetailSetController.h"
#import "ZMLessonDaySettingController.h"
#import <PGDatePicker.h>
#import "ZMServicetimeSaveRequest.h"

@interface ZMLessonDetailSetController () <PGDatePickerDelegate>
@property (nonatomic, strong) UITextField * dateTextField;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *data;



@end

@implementation ZMLessonDetailSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增服务时间";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.tableView.sectionHeaderHeight = 10;
    NSString *item01SubTitle = @"请设置";
    NSString *item02SubTitle = @"请设置";
    NSString *item03SubTitle = @"请设置";
    if (self.model) {
        item01SubTitle = self.model.starttime;
        item02SubTitle = self.model.endtime;
        item03SubTitle = self.model.endtime;
        NSMutableString *muString = @"".mutableCopy;
        if (self.model.day1) {
            [muString appendString:@"星期一|"];
        } else if (self.model.day2) {
            [muString appendString:@"星期二|"];
        } else if (self.model.day3) {
            [muString appendString:@"星期三|"];
        } else if (self.model.day4) {
            [muString appendString:@"星期四|"];
        } else if (self.model.day5) {
            [muString appendString:@"星期五|"];
        } else if (self.model.day6) {
            [muString appendString:@"星期六|"];
        } else if (self.model.day7) {
            [muString appendString:@"星期日|"];
        }
        [muString deleteCharactersInRange:NSMakeRange(muString.length - 1, 1)];
        item03SubTitle = muString;
    }
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc] initWithImage:@"order" title:@"开始时间" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:item01SubTitle];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:@"order" title:@"结束时间" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:item02SubTitle];
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:@"order" title:@"星期" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:item03SubTitle];
    self.dataSource = @[item01,item02,item03].mutableCopy;
    [self.tableView reloadData];
}

- (void)save {
    ZMServicetimeSaveRequest *saveRequest = [[ZMServicetimeSaveRequest alloc] init];
    if (self.model) {
        saveRequest.id = self.model.id;
    }
    
    ZMPersonalModel *model = self.dataSource[0];
    saveRequest.starttime = model.subTitle;
    
    ZMPersonalModel *model1 = self.dataSource[1];
    saveRequest.endtime = model1.subTitle;
    
    ZMPersonalModel *model2 = self.dataSource[2];
    if ([model2.subTitle containsString:@"星期一"]) {
        saveRequest.day1 = @"1";
    }
    if ([model2.subTitle containsString:@"星期二"]) {
        saveRequest.day2 = @"1";
    }
    if ([model2.subTitle containsString:@"星期三"]) {
        saveRequest.day3 = @"1";
    }
    if ([model2.subTitle containsString:@"星期四"]) {
        saveRequest.day4 = @"1";
    }
    if ([model2.subTitle containsString:@"星期五"]) {
        saveRequest.day5 = @"1";
    }
    if ([model2.subTitle containsString:@"星期六"]) {
        saveRequest.day6 = @"1";
    }
    if ([model2.subTitle containsString:@"星期日"]) {
        saveRequest.day7 = @"1";
    }
    saveRequest.tid = [ZMAccountManager shareManager].loginUser.id;
    
    [saveRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showSuccessMessage:@"保存成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshServiceTimeListNotification" object:nil];
         [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        _selectIndex = indexPath.row;
        PGDatePicker *datePicker = [[PGDatePicker alloc]init];
        datePicker.delegate = self;
        [datePicker show];
        datePicker.datePickerMode = PGDatePickerModeTime;
    } else {
        PersonalInfoCell *cell = (PersonalInfoCell *)[self.tableView cellForRowAtIndexPath:indexPath];
      ZMLessonDaySettingController *vc = [[ZMLessonDaySettingController alloc] init];
        vc.block = ^(NSArray *array) {
            cell.rightLabel.text = [array componentsJoinedByString:@"|"];
            ZMPersonalModel *model = self.dataSource[2];
            model.subTitle = cell.rightLabel.text;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma PGDatePickerDelegate

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if (_selectIndex == 0) {
        PersonalInfoCell *cell = (PersonalInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *minute = [NSString stringWithFormat:@"%ld",dateComponents.minute];
        if (dateComponents.minute < 10) {
            minute = [NSString stringWithFormat:@"0%ld",dateComponents.minute];
        }
        cell.rightLabel.text = [NSString stringWithFormat:@"%ld:%@",dateComponents.hour,minute];
        ZMPersonalModel *model = self.dataSource[0];
        model.subTitle = cell.rightLabel.text;
    } else if (_selectIndex == 1) {
        PersonalInfoCell *cell = (PersonalInfoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        NSString *minute = [NSString stringWithFormat:@"%ld",dateComponents.minute];
        if (dateComponents.minute < 10) {
            minute = [NSString stringWithFormat:@"0%ld",dateComponents.minute];
        }
        cell.rightLabel.text = [NSString stringWithFormat:@"%ld:%@",dateComponents.hour,minute];
        ZMPersonalModel *model = self.dataSource[1];
        model.subTitle = cell.rightLabel.text;
    }
    NSLog(@"dateComponents = %@", dateComponents);
    
}






@end
