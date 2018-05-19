//
//  ZMCalendarViewController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCalendarViewController.h"
#import <JTCalendar/JTCalendar.h>
@interface ZMCalendarViewController () <JTCalendarDelegate>
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation ZMCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
