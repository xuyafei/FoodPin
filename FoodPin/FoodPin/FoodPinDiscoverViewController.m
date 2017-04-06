//
//  FoodPinDiscoverViewController.m
//  FoodPin
//
//  Created by polycom on 2017/4/1.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinDiscoverViewController.h"
#import "DiscoverDetailViewController.h"
#import "DiscoverController.h"

@interface FoodPinDiscoverViewController ()

@property (strong, nonatomic) DiscoverController *discoverController;

@end

@implementation FoodPinDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Discover";
    [self configurationDiscoverView];
    [self fetchDiscoverFoodData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configurationDiscoverView {
    __weak typeof(self) weakWelf = self;
    self.discoverController = [DiscoverController inistanceWithPresenter:[DiscoverPresenter presentWithUserId:100]];
    [self.discoverController setDidSelectedRowHandler:^(CKRecord *draft) {
        __strong typeof(self) strongSelf = weakWelf;
        DiscoverDetailViewController *discoverDetailViewController = [[DiscoverDetailViewController alloc] init];
        [strongSelf.navigationController pushViewController:discoverDetailViewController animated:YES];
    }];
    
    self.discoverController.discoverTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeigth);
    [self.view addSubview:self.discoverController.discoverTableView];
}

- (void)fetchDiscoverFoodData {
    [self.discoverController fetchDataWithCompletionHander:nil];
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
