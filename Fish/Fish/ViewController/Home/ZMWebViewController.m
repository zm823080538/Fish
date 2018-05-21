//
//  ZMWebViewController.m
//  Fish
//
//  Created by sunny on 2018/5/21.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "ZMWebViewController.h"
#import <WebKit/WebKit.h>

@interface ZMWebViewController ()
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation ZMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[WKWebViewConfiguration new]];
    [self.view addSubview:self.wkWebView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.wkWebView loadRequest:request];
}


@end
