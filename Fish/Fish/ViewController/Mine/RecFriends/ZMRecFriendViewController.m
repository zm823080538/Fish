//
//  ZMRecFriendViewController.m
//  Fish
//
//  Created by zhaoming on 2018/6/2.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMRecFriendViewController.h"
#import "ZMRecFriendCell.h"
#import "ZMRecFriendRequest.h"
#import "ZMRecFriendModel.h"

@interface ZMRecFriendViewController () <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource>
@property (nonatomic, strong) ZMRecFriendModel *recFriendModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ZMRecFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[ZMAccountManager shareManager].loginUser.img] placeholder:PlaceholderImage];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 75;
    self.tableView.emptyDataSetSource = self;
    [self request];
}
- (IBAction)paste {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.codeLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [MBProgressHUD showTipMessageInView:@"复制失败"];
        
    }else
    {
        [MBProgressHUD showTipMessageInView:@"已复制"];
        
    }

}

- (void)request {
    [MBProgressHUD showActivityMessageInView:nil];
    ZMRecFriendRequest *request = [[ZMRecFriendRequest alloc] init];
    request.id = [ZMAccountManager shareManager].loginUser.id;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] integerValue] == 0) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccessMessage:@"加载成功"];
            
            self.recFriendModel = [ZMRecFriendModel modelWithJSON:request.responseObject[@"data"]];
            [self updateUI];
            
        } else {
            [MBProgressHUD showErrorMessage:request.responseObject[@"msg"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:@"网编异常，请稍后再试"];
    }];
}

- (void)updateUI {
    self.codeLabel.text = self.recFriendModel.invitecode;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",self.recFriendModel.invitemoney];
    [self.tableView reloadData];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"zanwushuju"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无内容";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName:UIColorFromRGB(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recFriendModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMRecFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMRecFriendCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZMRecFriendCell class]) owner:nil options:nil].firstObject;
    }
    ZMAccount *account = self.recFriendModel.list[indexPath.row];
    cell.friendModel = account;
    return cell;
}


@end
