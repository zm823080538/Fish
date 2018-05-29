//
//  ZMUpLoadRequest.h
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <YTKRequest.h>
#import <UIKit/UIKit.h>
@interface ZMUpLoadRequest : YTKRequest
- (id)initWithImage:(UIImage *)image;
- (NSString *)imageUrlString;
@end
