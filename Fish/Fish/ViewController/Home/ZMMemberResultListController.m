//
//  ZMMemberResultListController.m
//  Fish
//
//  Created by sunny on 2018/5/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMemberResultListController.h"
#import "ZMMemberResultItemTableCell.h"

@interface ZMMemberResultListController ()

@end

@implementation ZMMemberResultListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 287;
    //    [self loadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMMemberResultItemTableCell *memberResultItemCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMMemberResultItemTableCell class])];
    if (!memberResultItemCell) {
        memberResultItemCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMMemberResultItemTableCell class]) owner:nil options:nil].firstObject;
    }
    return memberResultItemCell;
    
}
@end
