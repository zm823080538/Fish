//
//  ZMEvaluationRequest.m
//  Fish
//
//  Created by sunny on 2018/7/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMEvaluationRequest.h"

@implementation ZMEvaluationRequest
- (NSString *)requestUrl {
    return @"/api/course/appraiseSave";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"courseid": _courseid,
             @"userid": _userid,
             @"tid": _tid,
             @"score": _score,
             @"keyword": _keyword,
             @"praisedesc":_praisedesc,
             };
}
@end
