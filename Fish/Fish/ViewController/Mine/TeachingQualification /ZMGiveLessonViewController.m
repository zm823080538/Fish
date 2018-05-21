//
//  ZMGiveLessonViewController.m
//  Fish
//
//  Created by sunny on 2018/5/13.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMGiveLessonViewController.h"
#import "ZMInputTextField.h"
@interface ZMGiveLessonViewController ()

@end

@implementation ZMGiveLessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.title = @"课程提醒设置";
    ZMInputTextField *inputTextField = [[ZMInputTextField alloc] initWithFrame:CGRectMake(0, 20 + 64 + 54, SCREEN_WIDTH, 54)];
    inputTextField.backgroundColor = [UIColor whiteColor];
    inputTextField.textField.textAlignment = NSTextAlignmentRight;
    inputTextField.leftLabelText = @"推荐人姓名";
    inputTextField.textField.placeholder = @"请输入推荐人姓名";
    [self.view addSubview:inputTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
