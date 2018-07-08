//
//  ZMCourseAddressController.m
//  Fish
//
//  Created by sunny on 2018/6/19.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMCourseAddressController.h"
#import <MAMapKit/MAMapKit.h>
@interface ZMCourseAddressController ()
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@end

@implementation ZMCourseAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    // Do any additional setup after loading the view from its nib.
}

- (void)save {
    NSDictionary *addressInfo = @{@"address":self.addressTextField.text};
    [self.subject sendNext:addressInfo];
}

- (IBAction)cancel {
}

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [[RACSubject alloc] init];
        
    }
    return _subject;
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
