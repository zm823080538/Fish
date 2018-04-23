//
//  ZMUpLoadRequest.h
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "YTKBaseRequest.h"
#import <UIKit/UIKit.h>
@interface ZMUpLoadRequest : YTKBaseRequest
- (id)initWithImage:(UIImage *)image;
- (NSString *)responseImageId;
@end
