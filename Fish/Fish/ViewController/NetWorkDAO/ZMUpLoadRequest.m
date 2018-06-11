//
//  ZMUpLoadRequest.m
//  Fish
//
//  Created by sunny on 2018/4/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMUpLoadRequest.h"
#import <AFURLRequestSerialization.h>
@implementation ZMUpLoadRequest {
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"/api/upload";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"file";
        NSString *formKey = @"test.jpeg";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:name fileName:formKey mimeType:type];
    };
}

- (NSString *)imageUrlString {
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"data"];
}

@end
