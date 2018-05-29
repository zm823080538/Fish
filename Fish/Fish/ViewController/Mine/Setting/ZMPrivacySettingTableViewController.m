//
//  ZMPrivacySettingTableViewController.m
//  Fish
//
//  Created by zhaoming on 2018/5/29.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPrivacySettingTableViewController.h"

@interface ZMPrivacySettingTableViewController ()

@end

@implementation ZMPrivacySettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"允许被搜索";
    UISwitch *swit = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    cell.accessoryView = swit;
    [swit addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (void)switchChange:(UISwitch *)swit {
    swit.selected = !swit.selected;
    if (swit.selected) {
        
    }
}




@end
