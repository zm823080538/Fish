//
//  ZMAppointSuccVC.m
//  Fish
//
//  Created by sunny on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMAppointSuccVC.h"

@interface ZMAppointSuccVC ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *returnHome;

@end

@implementation ZMAppointSuccVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.layer.borderWidth = 1;
    self.backButton.layer.borderColor = ThemeColor.CGColor;
}
- (IBAction)buttonClick:(UIButton *)sender {
}


@end
