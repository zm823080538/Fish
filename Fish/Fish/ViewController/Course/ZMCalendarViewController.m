//
//  ZMCalendarViewController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCalendarViewController.h"
#import <FSCalendar.h>
#import <NSObject+YYModel.h>
#import "ZMNearMememberCell.h"
#import "ZMAccountManager.h"
#import "ZMCourseListRequest.h"
#import "ZMCourseDetailViewController.h"

@interface ZMCalendarViewController()<UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) FSCalendar *calendar;
@property (nonatomic, strong) UITableView * tableView;

@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSArray * datesWithEvent;



- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;

@end

@implementation ZMCalendarViewController

//- (void)dealloc
//{
//    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
//    NSLog(@"%s",__FUNCTION__);
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的课程表";
        self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F3);
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.datesWithEvent = @[@"2018-05-03",
                            @"2018-05-06",
                            @"2018-05-12",
                            @"2018-05-25"];
        CGFloat height = 300;
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        calendar.dataSource = self;
        calendar.delegate = self;
        calendar.backgroundColor = [UIColor whiteColor];
        calendar.appearance.headerMinimumDissolvedAlpha = 0;
        calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
        [self.view addSubview:calendar];
        self.calendar = calendar;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendar.frame), self.view.width, self.view.height - CGRectGetMaxY(self.calendar.frame)) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 64;
        [self.view addSubview:self.tableView];
        self.tableView.tableFooterView = [UIView new];
        
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        previousButton.frame = CGRectMake(0, 5, 95, 34);
        previousButton.backgroundColor = [UIColor whiteColor];
        previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:previousButton];
        self.previousButton = previousButton;
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 5, 95, 34);
        nextButton.backgroundColor = [UIColor whiteColor];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nextButton];
        self.nextButton = nextButton;
        
        [self.calendar selectDate:[NSDate date] scrollToDate:YES];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    ZMCourseListRequest *request = [[ZMCourseListRequest alloc] init];
    //        1关注2黑名单3已接单
    NSString *status = @"1";
    request.tid = [ZMAccountManager shareManager].loginUser.id;
    request.status = status;
    request.starttime = [self.dateFormatter stringFromDate:date];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.dataSource = [NSArray modelArrayWithClass:[ZMCourseListItem class] json:request.responseObject[@"data"][@"list"]];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return 1;
    }
    return 0;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
    label.backgroundColor = UIColorFromRGB(0xF3F3F3);
    label.text = @"    课程";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = UIColorFromRGB(0x4A576A);
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 57;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMNearMememberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMNearMememberCell class])];
    if (!cell ) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMNearMememberCell class]) owner:nil options:nil].firstObject;
    }
    cell.item = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ZMCourseDetailViewController *courseDetailVC = [[ZMCourseDetailViewController alloc] init];
    courseDetailVC.course = self.dataSource[indexPath.row];
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
    
}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}


@end
