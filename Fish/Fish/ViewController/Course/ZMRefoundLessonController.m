//
//  ZMRefoundLessonController.m
//  Fish
//
//  Created by sunny on 2018/6/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRefoundLessonController.h"
#import "ZMBaseActionSheetView.h"
//#import "<#header#>"
@interface ZMRefoundLessonController () <UITableViewDelegate, UITableViewDataSource>{
    ZMBaseActionSheetView *_actionSheetView;
    NSInteger _selectIndex;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *IDNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UILabel *lessonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refoundMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;

@property (weak, nonatomic) IBOutlet UITableView *reasonListView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (nonatomic, strong) NSArray *dataSource;


// 退课原因弹出框
@end

@implementation ZMRefoundLessonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要退课";
    _selectIndex = -1;
    self.dataSource = @[@"地址变更/太远了",@"不想上了",@"教练不负责",@"其他原因"];
}

- (IBAction)selectReasonClick:(UIButton *)sender {
    self.alertView = [[NSBundle mainBundle] loadNibNamed:@"ZMRefoundReasonView" owner:self options:nil].firstObject;
    _actionSheetView = [ZMBaseActionSheetView alertWithContainerView:self.alertView type:ZMAlertViewTypeActionSheet];
    [_actionSheetView show];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_selectIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = ThemeColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectIndex = indexPath.row;
    [self.reasonListView reloadData];
}

- (IBAction)commit {
   
}

- (IBAction)chooseReasonClick:(id)sender {    
    if (_selectIndex == -1) {
        [MBProgressHUD showErrorMessage:@"请选择退课原因"];
        return;
    }
    [_actionSheetView hidden];
    [self.reasonButton setTitle:self.dataSource[_selectIndex] forState:UIControlStateNormal];
}

- (IBAction)closeAlert:(id)sender {
    [_actionSheetView hidden];
}

@end
