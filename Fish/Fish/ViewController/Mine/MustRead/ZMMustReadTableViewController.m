//
//  ZMMustReadTableViewController.m
//  Fish
//
//  Created by sunny on 2018/5/20.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMMustReadTableViewController.h"
#import "ZMPersonalModel.h"
#import "ZMWebViewController.h"
@interface ZMMustReadTableViewController ()

@end

@implementation ZMMustReadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZMPersonalModel   *item01 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"服务职责" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    ZMPersonalModel   *item02 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"教练需知" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];

    ZMPersonalModel   *item03 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"服务流程" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    ZMPersonalModel   *item04 = [[ZMPersonalModel   alloc] initWithImage:nil title:@"评论机制" destinClassName:@"" style:PersonalInfoCellStyleLabelArrow subTitle:nil];
    self.dataSource = @[item01,item02,item03,item04];
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZMPersonalModel  *item = self.dataSource[indexPath.row];
    [cell setPersonalModel:item];
    cell.style = item.style;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    教练必读-教练须知 - /h5/news/detail?id=xuzhi
//    教练必读-岗位职责 /h5/news/detail?id=zhize
//    教练必读-服务流程 - /h5/news/detail?id=liucheng
//    教练必读-评价机制 - /h5/news/detail?id=jizhi
    ZMPersonalModel *model = self.dataSource[indexPath.row];
    ZMWebViewController *webVC = [[ZMWebViewController alloc] init];
    webVC.isMustRead = YES;
    webVC.view.backgroundColor = [UIColor whiteColor];
    webVC.title = model.title;
    NSString *urlString;
    if (indexPath.row == 0) {
        urlString = @"https://www.bjwork.xyz/h5/news/detail?id=zhize";
    } else if (indexPath.row == 1) {
        urlString = @"https://www.bjwork.xyz/h5/news/detail?id=xuzhi";
    } else if (indexPath.row == 2) {
        urlString = @"https://www.bjwork.xyz/h5/news/detail?id=liucheng";
    } else {
        urlString = @"https://www.bjwork.xyz/h5/news/detail?id=jizhi";
    }
    webVC.urlString = urlString;
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
