//
//  ZMEvaluationRequest.h
//  Fish
//
//  Created by sunny on 2018/7/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMEvaluationRequest : YTKRequest
@property (nonatomic, copy) NSString * courseid;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * tid;
@property (nonatomic, copy) NSString * score;
@property (nonatomic, copy) NSString * keyword;
@property (nonatomic, copy) NSString * praisedesc;

@end
