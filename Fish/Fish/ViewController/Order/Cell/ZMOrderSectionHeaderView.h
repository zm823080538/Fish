//
//  ZMOrderSectionHeaderView.h
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMHisOrderModel.h"
@interface ZMOrderSectionHeaderView : UIView
@property (nonatomic, strong) RACSubject * handleSubject;
@property (nonatomic, strong) HistoryList * historyList;

@end
