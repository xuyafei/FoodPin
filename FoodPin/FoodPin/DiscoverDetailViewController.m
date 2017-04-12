//
//  DiscoverDetailViewController.m
//  FoodPin
//
//  Created by polycom on 2017/4/6.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverDetailViewController.h"
#import "DiscoverDetailController.h"

@interface DiscoverDetailViewController ()

@property (nonatomic, strong) DiscoverDetailController *discoverDetailController;
@property (nonatomic, strong) UITableView *discoverDetailTableView;

@end

@implementation DiscoverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self configDiscoverDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configDiscoverDetailView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    
    self.discoverDetailController = [DiscoverDetailController initWithPresenter];
    self.discoverDetailController.discoverDetailTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigth);
    [self.view addSubview:self.discoverDetailController.discoverDetailTableView];
}


@end
