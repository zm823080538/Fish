//
//  ZMExerciseResultListController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMExerciseResultListController.h"
#import "ZMExerciseResultCell.h"
#import "ZMWebViewController.h"

@interface ZMExerciseResultListController ()

@end

@implementation ZMExerciseResultListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 140;
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMExerciseResultCell *exerciseResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMExerciseResultCell class])];;
    if (!exerciseResultCell) {
        exerciseResultCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMExerciseResultCell class]) owner:nil options:nil].firstObject;
    }
    exerciseResultCell.item = self.arrayList.list[indexPath.row];
    return exerciseResultCell;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMWebViewController *webVC = [[ZMWebViewController alloc] init];
    ZMNewListItem *item = self.arrayList.list[indexPath.row];
    webVC.item = item;
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
