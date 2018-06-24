//
//  ZMPublishViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMPublishViewController.h"
#import "ZMHomeSectionView.h"
#import "UITextView+MGPlaceholder.h"
#import "SKTagView.h"
@interface ZMPublishViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) NSArray * cTypes;



@end

@implementation ZMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.cTypes = @[@"增肌", @"减脂" , @"塑形", @"康复", @"拉伸", @"其他"];
    self.sectionTitles = @[@"类型", @"详细描述", @"意向购买节数"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZMHomeSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZMHomeSectionView"];
    if (!sectionView) {
        sectionView = [[ZMHomeSectionView alloc] initWithReuseIdentifier:@"ZMHomeSectionView"];
    }
    sectionView.title = self.sectionTitles[section];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        SKTagView *tagView = [[SKTagView alloc] init];
        for (NSString *tagString in self.cTypes) {
            SKTag *tag = [[SKTag alloc] initWithText:tagString];
            tag.textColor = ThemeColor;
            tag.borderColor = ThemeColor;
            tag.borderWidth = 1;
            tag.cornerRadius = 3;
            [tagView addTag:tag];
        }
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UITextView *textView = [[UITextView alloc] init];
        [cell addSubview:textView];
        textView.placeholder = @"请输入描述文字";
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).insets(UIEdgeInsetsMake(14, 14, 14, 14));
        }];
    } else {
        
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 50;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
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
