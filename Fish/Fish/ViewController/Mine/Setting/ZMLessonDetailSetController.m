//
//  ZMLessonDetailSetController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonDetailSetController.h"

@interface ZMLessonDetailSetController ()

@end

@implementation ZMLessonDetailSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 331;
    } else {
        return 58;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}



@end
