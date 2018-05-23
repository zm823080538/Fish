//
//  ZMCollectRequest.h
//  Fish
//
//  Created by sunny on 2018/5/22.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKRequest.h"

@interface ZMCollectRequest : YTKRequest
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * action;

@end
