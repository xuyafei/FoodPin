//
//  WebViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/24.
//  Copyright © 2016年 永康范. All rights reserved.
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
    _aboutWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
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
