//
//  ZMRecFriendViewController.m
//  Fish
//
//  Created by sunny on 2018/4/26.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRecFriendViewController.h"
#import "ZMInputTextField.h"
#import "ZMRecFriendRequest.h"
#import "ZMAccountManager.h"

@interface ZMRecFriendViewController ()
@property (nonatomic, strong) ZMInputTextField *nameTextField;
@property (nonatomic, strong) ZMInputTextField *phoneTextField;
@end

@implementation ZMRecFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.title = @"推荐好友信息";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    for (int i = 0; i < 2; i ++) {
        ZMInputTextField *inputTextField = [[ZMInputTextField alloc] initWithFrame:CGRectMake(0, 20 + 64 + 54 * i, SCREEN_WIDTH, 54)];
        inputTextField.backgroundColor = [UIColor whiteColor];
        inputTextField.textField.textAlignment = NSTextAlignmentRight;
        if (i == 0) {
            inputTextField.leftLabelText = @"推荐人姓名";
            inputTextField.textField.placeholder = @"请输入推荐人姓名";
            self.nameTextField = inputTextField;
        } else {
            inputTextField.leftLabelText = @"推荐人手机号";
            inputTextField.textField.placeholder = @"请输入推荐人手机号";
            self.phoneTextField = inputTextField;
        }
        [self.view addSubview:inputTextField];
    }
}

- (void)rightBarItemClick {
    ZMRecFriendRequest *recFriendRequest = [[ZMRecFriendRequest alloc] init];
    recFriendRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    recFriendRequest.friendsname = self.nameTextField.textField.text;
    recFriendRequest.friendsmoblie = self.phoneTextField.textField.text;
    [recFriendRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
