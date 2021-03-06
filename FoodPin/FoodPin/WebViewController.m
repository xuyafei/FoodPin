//
//  WebViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/24.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () {
    UIWebView *_aboutWebView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAboutWebview];
    [self loadWebview];
}

- (void)initAboutWebview {
    _aboutWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    [self.view addSubview:_aboutWebView];
}

- (void)loadWebview {
    NSURL *aboutUrl = [NSURL URLWithString:@"http://www.appcoda.com/contact"];
    NSURLRequest *request = [NSURLRequest requestWithURL:aboutUrl];
    [_aboutWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
