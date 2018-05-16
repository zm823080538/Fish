//
//  ZMLessonTimeSettingController.m
//  Fish
//
//  Created by sunny on 2018/5/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMLessonTimeSettingController.h"
#import "ZMLessTimeSettingCell.h"
#import "ZMLessonDetailSetController.h"
@interface ZMLessonTimeSettingController ()

@end

@implementation ZMLessonTimeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
  
}

- (void)add {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ZMLessTimeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZMLessTimeSettingCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMLessonDetailSetController *lessonDetailSetVC = [[ZMLessonDetailSetController alloc] init];
    [self.navigationController pushViewController:lessonDetailSetVC animated:YES];
}


@end
