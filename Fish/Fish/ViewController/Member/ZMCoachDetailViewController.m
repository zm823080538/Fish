//
//  ZMCoachDetailViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCoachDetailViewController.h"
#import <FSCalendar.h>
#import "ZMLessonTimeCell.h"
@interface ZMCoachDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet FSCalendar *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZMCoachDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)fouse:(UIButton *)sender {
}
- (IBAction)praviteChat:(UIButton *)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMLessonTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMLessonTimeCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

@end
