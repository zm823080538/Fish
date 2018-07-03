//
//  ZMWebViewController.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMWebViewController.h"
#import <WebKit/WebKit.h>
#import "ZMCollectRequest.h"
#import "ZMBodyRecordListVC.h"

@interface ZMWebViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation ZMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    if ([self.title isEqualToString:@"身体数据"]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bjwork.xyz/h5/bodydata/detail"]];

        [self.wkWebView loadRequest:request];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(bodyRecord)];
    } else {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.item.linkurl]];
    [self.wkWebView loadRequest:request];
    if (self.isMustRead) {
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"收藏" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitle:@"已收藏" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    button.selected = self.item.favorite.boolValue;
    }  
}

- (void)bodyRecord {
    ZMBodyRecordListVC *vc = [ZMBodyRecordListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[WKWebViewConfiguration new]];
    }
    return _wkWebView;
}

- (void)setUrlString:(NSString *)urlString {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.wkWebView loadRequest:request];
}

- (void)buttonClick:(UIButton *)sender {
    ZMCollectRequest *collectRequest = [[ZMCollectRequest alloc] init];
    collectRequest.id = self.item.id;
    collectRequest.userid = [ZMAccountManager shareManager].loginUser.id;
    collectRequest.action = self.item.favorite;
    [collectRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        sender.selected = !sender.selected;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}


@end
