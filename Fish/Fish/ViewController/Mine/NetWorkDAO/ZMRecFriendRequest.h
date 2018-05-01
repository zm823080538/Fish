//
//  ZMRecFriendRequest.h
//  Fish
//
//  Created by zhaoming on 27/04/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface ZMRecFriendRequest : YTKBaseRequest
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *friendsname;
@property (nonatomic, copy) NSString *friendsmoblie;
@end
