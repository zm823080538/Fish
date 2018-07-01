//
//  ZMLessonTypeCell.m
//  Fish
//
//  Created by sunny on 2018/6/23.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonTypeCell.h"


@interface ZMLessonTypeCell ()
@property (nonatomic) UILabel *nameLabel;


@end

@implementation ZMLessonTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self conifgUI];
        _selectIndex = -1;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.nameLabel.text = title;
}

- (void)setTagList:(NSArray *)tagList {
    _tagList = tagList;
    [self.tagView removeAllTags];
    for (NSString *tagString in tagList) {
        SKTag *tag = [[SKTag alloc] initWithText:tagString];
        if (self.lessonType == LessonTypeXiaoLei) {
            tag.bgColor = ThemeColor;
            
        } else {
            
        }
        tag.padding = UIEdgeInsetsMake(8, 17, 8, 17);
        tag.borderColor = ThemeColor;
        tag.borderWidth = 1;
        tag.cornerRadius = 3;
        [self.tagView addTag:tag];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    self.tagView.selectIndex = selectIndex;
}

- (void)setLessonType:(LessonType)lessonType {
   
}


- (void)conifgUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.tagView];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.top.mas_equalTo(15);
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(25);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).mas_equalTo(-21);
        make.bottom.equalTo(self.contentView).mas_offset(-5);
    }];
    [self.contentView setClipsToBounds:YES];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = ThemeColor;
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

- (SKTagView *)tagView {
    if (!_tagView) {
        _tagView = [[SKTagView alloc] init];
        _tagView.lineSpacing = 20;
        _tagView.interitemSpacing = 42;
    }
    return _tagView;
}
@end
