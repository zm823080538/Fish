//
//  ZMPreferentialActivityController.m
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "ZMPreferentialActivityController.h"
#import <Masonry.h>
#import "ZMNewList.h"
#import <UIImageView+YYWebImage.h>
@interface ZMPreferentialActivityController ()

@end

@implementation ZMPreferentialActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; self.tableView.tableFooterView = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    self.tableView.rowHeight = 160;
}

- (void)rightBarItemClick {
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    UIImageView *imageView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        imageView = [[UIImageView alloc] init];
        [cell addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
    ZMNewListItem *item = self.list[indexPath.row];
    [imageView setImageURL:[NSURL URLWithString:item.image]];
    return cell;
}
@end
