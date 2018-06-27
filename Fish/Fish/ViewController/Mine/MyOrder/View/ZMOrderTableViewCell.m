//
//  ZMOrderTableViewCell.m
//  Fish
//
//  Created by zhaoming on 2018/6/14.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderTableViewCell.h"

@interface ZMOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *userAgeButton;
@property (weak, nonatomic) IBOutlet UILabel *lessonTotalPriceLabel;


@end

@implementation ZMOrderTableViewCell

- (IBAction)refoundBtnClick {
    [self.subject sendNext:nil];
    NSLog(@"refound");
}

- (IBAction)click:(id)sender {
}

@end
