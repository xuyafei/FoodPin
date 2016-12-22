//
//  WalkthroughContentViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/22.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "WalkthroughContentViewController.h"
#import "WalkthroughPageViewController.h"
#import "Masonry.h"

@interface WalkthroughContentViewController () {
    UILabel *_headingLabel;
    UILabel *_contentLabel;
    UIImageView *_contentImageView;
    UIButton *_forwardButton;
    UIPageControl *_pageControl;
}

@end

@implementation WalkthroughContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initLayoutSubView];
}

- (void)initLayoutSubView {
    _headingLabel = [[UILabel alloc] init];
    _headingLabel.font = [UIFont systemFontOfSize:30.0];
    _headingLabel.textColor = [UIColor whiteColor];
    _headingLabel.textAlignment = NSTextAlignmentCenter;
    _headingLabel.text = self.heading;
    [self.view addSubview:_headingLabel];
    
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.image = [UIImage imageNamed:self.imageFile];
    [self.view addSubview:_contentImageView];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15.0];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 2;
    _contentLabel.text = self.content;
    [self.view addSubview:_contentLabel];
    
    _forwardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _forwardButton.backgroundColor = [UIColor clearColor];
    NSString *buttonTitleString;
    if(self.index == 0 || self.index == 1) {
        buttonTitleString = @"NEXT";
    } else {
        buttonTitleString = @"DONE";
    }
    [_forwardButton setTitle:buttonTitleString forState:UIControlStateNormal];
    [_forwardButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_forwardButton addTarget:self action:@selector(clickNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forwardButton];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = self.index;
    [self.view addSubview:_pageControl];

    [_headingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headingLabel.mas_bottom).offset(14);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(540);
        make.height.mas_equalTo(418);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentImageView.mas_bottom).offset(18);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(282);
        make.height.mas_equalTo(64);
    }];
    
    [_forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(29);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(10);
    }];
}

- (void)clickNext:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(setButtonIndex:)]) {
        [self.delegate setButtonIndex:self.index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
