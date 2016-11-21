//
//  AddRestaurantViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/21.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "AddRestaurantViewController.h"

@interface AddRestaurantViewController () {
    UINavigationBar *_navigationBar;
}

@end

@implementation AddRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitleView];
}

- (void)initTitleView {
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    UINavigationItem *leftItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModelView:)];
    leftItem.leftBarButtonItem = leftBarButtonItem;
    [_navigationBar pushNavigationItem:leftItem animated:NO];
    [self.view addSubview:_navigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"print something");
}

- (void)dismissModelView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
