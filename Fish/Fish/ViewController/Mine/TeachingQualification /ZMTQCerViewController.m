//
//  ZMTQCerViewController.m
//  Fish
//
//  Created by sunny on 2018/5/12.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMTQCerViewController.h"
#import "ZMPersonalModel.h"
#import "PersonalInfoCell.h"
#import "LTHMonthYearPickerView.h"
@interface ZMTQCerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;
@property (nonatomic, strong) UITextField * dateTextField;
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataSource;
@property (nonatomic, strong) PersonalInfoCell *dateCell;


@end

@implementation ZMTQCerViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资质证书";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self configDatePicker];
    [self loadData];
}

- (void)save {
    
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
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc]  initWithImage:nil title:@"从业时间设置" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:@"暂无从业时间"];
    self.dataSource = @[item01];
    [self.tableView reloadData];
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
    if (indexPath.row == 0) {
        [self.dateTextField becomeFirstResponder];
    }
}


- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    NSString *dateStr = [NSString stringWithFormat: @"%@ - %@", year, month];
    self.dateCell.rightLabel.text = dateStr;
    ZMPersonalModel  *item = self.dataSource[0];
    item.subTitle = dateStr;
}

#pragma mark -- DatePicker Delegate
- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    [self.dateTextField resignFirstResponder];
}

- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
    [self.dateTextField resignFirstResponder];
}

@end
