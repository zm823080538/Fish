



//
//  RCDataManager.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RCDataManager.h"
#import "AppDelegate.h"
#import "ZMGetUserInfoRequest.h"
@implementation RCDataManager
{
        NSMutableArray *dataSoure;
}

- (instancetype)init{
    if (self = [super init]) {
        [RCIM sharedRCIM].userInfoDataSource = self;
    }
    return self;
}

+ (RCDataManager *)shareManager{
    static RCDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
/**
 *  从服务器同步好友列表
 */
//-(void)syncFriendList:(void (^)(NSMutableArray* friends,BOOL isSuccess))completion
//{
//    dataSoure = [[NSMutableArray alloc]init];
//
//    for (NSInteger i = 1; i<7; i++) {
//        if(i==1){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"文明" portrait:@"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100" QQ:@"740747055" sex:@"男"];
//            [dataSoure addObject:aUserInfo];
//        }else if (i==2) {
//          RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"张全蛋" portrait:@"http://weixin.ihk.cn/ihkwx_upload/fodder/20151210/1449727755947.jpg" QQ:@"张全蛋的QQ信息" sex:@"男"];
//            [dataSoure addObject:aUserInfo];
//        }else if(i==3){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"怕瓦落地" portrait:@"http://pic.ihk.cn/head/base/ihk/2014/04/30/213816839.jpg" QQ:@"帕瓦落地的QQ信息" sex:@"男"];
//            [dataSoure addObject:aUserInfo];
//
//        }else if(i==4){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"凤姐" portrait:@"http://weixin.ihk.cn/ihkwx_upload/fodder/20151218/1450420944608.jpg" QQ:@"凤姐的QQ信息" sex:@"女"];
//            [dataSoure addObject:aUserInfo];
//
//        }else if(i==5){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"猴塞雷" portrait:@"http://pic.ihk.cn/head/80_93/ihk/2015/05/20/104331022.jpg" QQ:@"猴塞雷的QQ信息" sex:@"男"];
//            [dataSoure addObject:aUserInfo];
//
//        }else if(i==6){
//            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"犀利哥" portrait:@"" QQ:@"犀利哥的QQ信息" sex:@"男"];
//            [dataSoure addObject:aUserInfo];
//
//        }
//
//
//    }
//
//    [AppDelegate shareAppDelegate].friendsArray = dataSoure;
//    completion(dataSoure,YES);
//
//}
/**
 *  从服务器同步群组列表
 */
#pragma mark
#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString*)userId completion:(void (^)(RCUserInfo*))completion
{
    ZMGetUserInfoRequest *request = [[ZMGetUserInfoRequest alloc] init];
    request.id = userId;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZMAccount *account = [ZMAccount modelWithJSON:request.responseObject[@"data"]];
                RCUserInfo *myselfInfo = [[RCUserInfo alloc]initWithUserId:account.id name:account.nickname portrait:account.img];
                completion(myselfInfo);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    


    
   
}

@end

