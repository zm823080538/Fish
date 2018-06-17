//
//  ZMHomeSectionView.h
//  Fish
//
//  Created by zhaoming on 05/05/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMHomeSectionView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^arrowClick)(void);
@end
