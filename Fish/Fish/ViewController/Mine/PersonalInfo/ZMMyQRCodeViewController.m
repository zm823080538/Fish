//
//  ZMMyQRCodeViewController.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMyQRCodeViewController.h"

@interface ZMMyQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@end

@implementation ZMMyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[ZMAccountManager shareManager].loginUser.img] placeholder:PlaceholderImage];
    self.titleLabel.text = [ZMAccountManager shareManager].loginUser.nickname;
    self.subTitleLabel.text = [NSString stringWithFormat:@"ID : %@",[ZMAccountManager shareManager].loginUser.no];
//    self.QRImageView setImageWithURL:[NSURL URLWithString:<#(nonnull NSString *)#>] placeholder:<#(nullable UIImage *)#>
}
- (IBAction)share {
    
}

@end
