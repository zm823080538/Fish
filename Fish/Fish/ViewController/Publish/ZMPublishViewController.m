//
//  ZMPublishViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPublishViewController.h"
#import "ZMHomeSectionView.h"
#import "ZMSettingCell.h"
#import "UITextView+MGPlaceholder.h"
#import "SKTagView.h"
#import "ZMPersonalModel.h"
#import "ZMBaseActionSheetView.h"
@interface ZMPublishViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) NSArray * cTypes;
@property (nonatomic, strong) NSArray * details;



@end

@implementation ZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];    
    self.cTypes = @[@"增肌", @"减脂" , @"塑形", @"康复", @"拉伸", @"其他"];
    self.sectionTitles = @[@"类型", @"详细描述", @"意向购买节数"];
    ZMPersonalModel *model = [[ZMPersonalModel alloc] initWithImage:nil title:@"购买节数" destinClassName:nil style:PersonalInfoCellStyleArrow subTitle:@"10"];
    ZMPersonalModel *model1 = [[ZMPersonalModel alloc] initWithImage:nil title:@"地址" destinClassName:nil style:PersonalInfoCellStyleArrow subTitle:@"成都市双流区"];
    self.details = @[model,model1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMHomeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZMHomeSectionView"];
    sectionView.arrowButton.hidden = YES;
    if (!sectionView) {
        sectionView = [[ZMHomeSectionView alloc] initWithReuseIdentifier:@"ZMHomeSectionView"];
    }
    sectionView.title = self.sectionTitles[section];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 150;
    if (indexPath.section == 1) return 100;
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) return 1;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        SKTagView *tagView = [[SKTagView alloc] init];
        tagView.padding = UIEdgeInsetsMake(10, 20, 10, 20);
        tagView.lineSpacing = 20;
        tagView.interitemSpacing = 42;
        for (NSString *tagString in self.cTypes) {
            SKTag *tag = [[SKTag alloc] initWithText:tagString];
            tag.padding = UIEdgeInsetsMake(8, 17, 8, 17);
            tag.textColor = ThemeColor;
            tag.borderColor = ThemeColor;
            tag.borderWidth = 1;
            tag.cornerRadius = 3;
            [tagView addTag:tag];
        }
        [cell addSubview:tagView];
        [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
        }
        UITextView *textView = [[UITextView alloc] init];
        [cell addSubview:textView];
        textView.placeholder = @"请输入描述文字";
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).insets(UIEdgeInsetsMake(14, 14, 14, 14));
        }];
        return cell;
    } else {
        static NSString *ID = @"ZMMineTableViewCell";
        ZMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ZMMineTableViewCell" owner:nil options:nil].firstObject;
        }
        ZMSettingItem  *item = self.details[indexPath.row];
        [cell setModel:item];
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 50;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
