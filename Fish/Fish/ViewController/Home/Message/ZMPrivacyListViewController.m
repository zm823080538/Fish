//
//  ZMPrivacyListViewController.m
//  Fish
//
//  Created by sunny on 2018/5/17.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPrivacyListViewController.h"

@interface ZMPrivacyListViewController ()

@end

@implementation ZMPrivacyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayConversationTypes:@[
                                        @(ConversationType_PRIVATE)
                                        ]];
    self.conversationListTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    RCConversationViewController *chatVC = [[RCConversationViewController alloc] init];
    chatVC.conversationType = ConversationType_PRIVATE;
    //如果是单聊，不显示发送方昵称
    chatVC.targetId = model.targetId;
    chatVC.title = model.conversationTitle;
    [self.navigationController pushViewController:chatVC animated:YES];
}

@end
