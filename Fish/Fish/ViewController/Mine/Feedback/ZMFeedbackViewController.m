//
//  ZMFeedbackViewController.m
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMFeedbackViewController.h"
#import "MGSearchFeedbackCell.h"
#import <ReactiveObjC.h>

@interface ZMFeedbackViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectFeedbackList;
@property (nonatomic, strong) RACSubject *selectSignal;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ZMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"功能异常：功能故障或不可用",@"产品建议：用的不爽，我有建议",@"其他问题"];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MGSearchFeedbackCell" bundle:nil] forCellReuseIdentifier:@"MGSearchFeedbackCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSearchFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MGSearchFeedbackCell" forIndexPath:indexPath];
    cell.checkButton.userInteractionEnabled = NO;
    cell.titleLabel.text = self.dataSource[indexPath.row];
    BOOL containCurrentIndex = [self.selectFeedbackList containsObject:@(indexPath.row)];
    cell.checkButton.selected = containCurrentIndex ?: NO;
    [cell setLineViewHidden:((self.dataSource.count - 1) == indexPath.row) ? YES : NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MGSearchFeedbackCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkButton.selected = !cell.checkButton.selected;
    if (cell.checkButton.selected) {
        [self.selectFeedbackList addObject:@(indexPath.row)];
    } else {
        [self.selectFeedbackList removeObject:@(indexPath.row)];
    }
    [self.selectSignal sendNext:@(indexPath.row)];
}


@end
