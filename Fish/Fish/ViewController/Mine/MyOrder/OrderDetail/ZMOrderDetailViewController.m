//
//  ZMOrderDetailViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/15.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderDetailViewController.h"
#import <ReactiveObjC.h>
#import "ZMOrderAddressCell.h"
#import "ZMOrderTableViewCell.h"
@interface ZMOrderDetailViewController ()

@end

@implementation ZMOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 49;
    } else if (indexPath.section == 1) {
        return indexPath.row ? 50 : 140;
    } else {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 4;
    if (section == 2) return 5;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *ID = @"ZMOrderAddressCell";
        ZMOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderAddressCell" owner:nil options:nil].firstObject;
        }
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *ID = @"ZMOrderTableViewCell";
            ZMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"ZMOrderTableViewCell" owner:nil options:nil].lastObject;
            }
            return cell;
        } else {
            
        }
    } else {
        
    }
    return nil;
    
}



@end
