//
//  ChooseRoleViewController.m
//  Fish
//
//  Created by sunny on 2018/4/9.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ChooseRoleViewController.h"

@interface ChooseRoleViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@end

@implementation ChooseRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.backgroundView.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:0.95];    // Do any additional setup after loading the view from its nib.
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
