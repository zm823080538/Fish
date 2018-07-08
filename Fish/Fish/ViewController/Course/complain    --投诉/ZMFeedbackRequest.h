//
//  ZMFeedbackRequest.h
//  Fish
//
//  Created by sunny on 2018/7/8.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMFeedbackRequest : YTKRequest
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *type;
@end
