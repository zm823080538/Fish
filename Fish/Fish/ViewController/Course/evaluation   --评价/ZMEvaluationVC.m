//
//  ZMEvaluationVC.m
//  Fish
//
//  Created by sunny on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMEvaluationVC.h"
#import "SKTagView.h"
#import "SKTagButton.h"
#import "WSStarRatingView.h"
@interface ZMEvaluationVC () <StarRatingViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet SKTagView *tagView;
@property (weak, nonatomic) IBOutlet WSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;

@end

@implementation ZMEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.tagView.lineSpacing = 18;
    self.tagView.interitemSpacing = 13;
    self.starView.delegate = self;
    
    self.tagView.padding = UIEdgeInsetsMake(10, 0, 10, 0);
    NSArray *array = @[@"达到预期", @"教练有过迟到", @"任职认真", @"非正常接触"];
    for (NSString *string in array) {
        SKTag *tag = [SKTag tagWithText:string];
        tag.borderColor = ThemeColor;
        tag.textColor = ThemeColor;
        tag.font = [UIFont systemFontOfSize:11];
        tag.borderWidth = 1;
        tag.padding = UIEdgeInsetsMake(10, 15, 10, 15);
        [self.tagView addTag:tag];
    }
    int  maxLength = 200;
    @weakify(self)
    RAC(self.commentNumLabel,text) = [self.commentTextView.rac_textSignal  map:^id(NSString *value) {
        @strongify(self)
        if (value.length > maxLength) {
            value = [value substringToIndex:maxLength];
            self.commentTextView.text = value;
        }
        self.commentNumLabel.textColor = (value.length == maxLength) ? [UIColor redColor] : UIColorFromRGB(0x999999);
        return [NSString stringWithFormat:@"%ld/200",value.length];
    }];
}

- (void)starRatingView:(WSStarRatingView *)view score:(float)score {
    NSLog(@"----%@",[NSString stringWithFormat:@"%0.1f分",score * 5 ]);
}

- (IBAction)evaluationClick:(UIButton *)sender {
}
- (IBAction)satisfiedclick:(UIButton *)sender {
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
