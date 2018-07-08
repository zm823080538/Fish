//
//  ZMOrderTableViewCell.h
//  Fish
//
//  Created by zhaoming on 2018/6/14.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrderDetailModel.h"
@interface ZMOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *refoundClick;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn1;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn2;
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) ZMOrderDetailModel *detailModel;

@end
