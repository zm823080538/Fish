//
//  ZMOrderCell.m
//  Fish
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMOrderCell.h"

@interface ZMOrderCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation ZMOrderCell

- (void)setOrderList:(Orderlist *)orderList {
    self.leftLabel.text = orderList.createDate;
    self.centerLabel.text = [NSString stringWithFormat:@"(%@/%@)",orderList.cuse,orderList.csum];
    self.rightLabel.text = [NSString stringWithFormat:@"%@元",orderList.cprice];
}

@end
