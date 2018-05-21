//
//  TeachQAViewController.m
//  Fish
//
//  Created by sunny on 2018/4/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "TeachQAViewController.h"
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"
#import "ZMTQCerViewController.h"
#import "ZMExciseLanguageController.h"
#import "ZMExercisePhotosViewController.h"
#import "LTHMonthYearPickerView.h"

@interface TeachQAViewController ()   <UITableViewDelegate, UITableViewDataSource,LTHMonthYearPickerViewDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) PersonalInfoCell *dateCell;
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;
@property (nonatomic, strong) UITextField * dateTextField;








@end

@implementation TeachQAViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教学资质";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
    [self configDatePicker];
}

- (void)configDatePicker {
    self.dateTextField = [[UITextField alloc] init];
    [self.view addSubview:self.dateTextField];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy / MM"];
    NSDate *minDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 2000,1]];
    _monthYearPicker = [[LTHMonthYearPickerView alloc] initWithDate: [NSDate date]
                                                        shortMonths: NO
                                                     numberedMonths: NO
                                                         andToolbar: YES
                                                            minDate: minDate
                                                         andMaxDate: [NSDate date]];
    self.dateTextField.inputView = _monthYearPicker;
    
    _monthYearPicker.delegate = self;
//    NSDate *maxDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 2115,3]];
   
}


- (void)loadData {
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"从业时间" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:@"暂无从业时间"];
    
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"擅长领域" destinClassName:@"ZMGoodAtFieldViewController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"成功案例" destinClassName:@"ZMSuccessDemoCollectionViewController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"资质证书" destinClassName:@"ZMTQCerViewController" style:PersonalInfoCellStyleLabelArrow subTitle:@"待审核"];
    
    ZMPersonalModel   *item05 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"健身格言" destinClassName:@"ZMExciseLanguageController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    ZMPersonalModel   *item06 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"形象照" destinClassName:@"ZMExercisePhotosViewController" style:PersonalInfoCellStyleArrow subTitle:nil];
    ZMPersonalModel   *item07 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"申请晋升" destinClassName:@"" style:PersonalInfoCellStyleArrow subTitle:nil];
    ZMPersonalModel   *item08 = [[ZMPersonalModel   alloc] initWithImage:@"" title:@"简历口述" destinClassName:@"ZMExciseLanguageController" style:PersonalInfoCellStyleArrow subTitle:nil];
    
    self.dataSource = @[item01,item02,item03,item04,item05,item06,item07,item08];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.datePicker resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        self.dateCell = cell;
    }
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        ZMPersonalModel  *item = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        [self.dateTextField becomeFirstResponder];
    } else {
        Class class = NSClassFromString(item.destinClassName);
        UIViewController *vc = [class new];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    NSString *dateStr = [NSString stringWithFormat: @"%@ - %@", year, month];
    self.dateCell.rightLabel.text = dateStr;
    ZMPersonalModel  *item = self.dataSource[0];
    item.subTitle = dateStr;
}

- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    [self.dateTextField resignFirstResponder];
}

- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
    [self.dateTextField resignFirstResponder];
}




@end
