//
//  ZMExerciseMaximViewController.m
//  Fish
//
//  Created by sunny on 2018/5/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMExerciseMaximViewController.h"
#import "UIColor+Hex.h"
#import <ReactiveObjC.h>
#import "UITextView+MGPlaceholder.h"

@interface ZMExerciseMaximViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;

@end

@implementation ZMExerciseMaximViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentTextView.placeholderColor = [UIColor colorWithHexString:@"#BABABA"];
    self.commentTextView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 45);
    int  maxLength = 50;
    @weakify(self)
    RAC(self.commentNumLabel,text) = [self.commentTextView.rac_textSignal  map:^id(NSString *value) {
        @strongify(self)
        if (value.length > maxLength) {
            value = [value substringToIndex:maxLength];
            self.commentTextView.text = value;
        }
        self.commentNumLabel.textColor = (value.length == maxLength) ? [UIColor redColor] : [UIColor colorWithHexString:@"#999999"];
        return [NSString stringWithFormat:@"%ld/50",value.length];
    }];
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
