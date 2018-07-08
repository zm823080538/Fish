//
//  ZMStudentSave1Request.h
//  Fish
//
//  Created by sunny on 2018/7/8.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMStudentSave1Request : YTKRequest
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *tryflag;
@end
