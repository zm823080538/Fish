//
//  ZMLessTimeSettingCell.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessTimeSettingCell.h"

@interface ZMLessTimeSettingCell ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ZMLessTimeSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZMServiceTimeModel *)model {
    if (model.starthour.integerValue > 12) {
        self.label1.text = @"下午";
    } else {
        self.label1.text = @"上午";
    }
    if (model.endhour.integerValue > 12) {
        self.label4.text = @"下午";
    } else {
        self.label4.text = @"上午";
    }
    self.label2.text = model.starttime;
    self.label3.text = model.endtime;
    NSMutableString *muString = @"".mutableCopy;
    if (model.day1) {
        [muString appendString:@"星期一、"];
    } else if (model.day2) {
        [muString appendString:@"星期二、"];
    } else if (model.day3) {
        [muString appendString:@"星期三、"];
    } else if (model.day4) {
        [muString appendString:@"星期四、"];
    } else if (model.day5) {
        [muString appendString:@"星期五、"];
    } else if (model.day6) {
        [muString appendString:@"星期六、"];
    } else if (model.day7) {
        [muString appendString:@"星期日、"];
    }
    [muString deleteCharactersInRange:NSMakeRange(muString.length - 1, 1)];
    self.dateLabel.text = muString;
}

@end
