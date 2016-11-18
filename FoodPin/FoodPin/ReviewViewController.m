//
//  ReviewViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/18.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "ReviewViewController.h"
#import "Masonry.h"

@interface ReviewViewController () {
    UIImageView *_backgroundImageView;
    UIButton *_closeButton;
}

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViews];
}

- (void)layoutSubViews {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _backgroundImageView.image = [UIImage imageNamed:@"barrafina"];
    [self.view addSubview:_backgroundImageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [_backgroundImageView addSubview:blurEffectView];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.layer.cornerRadius = 15;
    [_closeButton setBackgroundImage:[[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_closeButton setTintColor:[UIColor whiteColor]];
    [_closeButton addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(25);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)clickClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"delloc for ReviewViewController");
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
