//
//  ZMComplainVC.m
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMComplainVC.h"
#import "ZMPickPhotoCollectionView.h"
@interface ZMComplainVC ()
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;
@property (weak, nonatomic) IBOutlet ZMPickPhotoCollectionView *pickView;

@end

@implementation ZMComplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)finish:(id)sender {
    [MBProgressHUD showSuccessMessage:@"投诉成功"];
    [self.navigationController popViewControllerAnimated:YES];
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
