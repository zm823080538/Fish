//
//  ZMRefoundLessonRequest.h
//  Fish
//
//  Created by sunny on 2018/7/11.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMRefoundLessonRequest : YTKRequest
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * refundtype;
@property (nonatomic, copy) NSString * refunddetail;
@end
