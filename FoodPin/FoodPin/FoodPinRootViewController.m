//
//  FoodPinRootViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/23.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "FoodPinRootViewController.h"
#import "RestaurantViewController.h"
#import "RestaurantAboutViewController.h"
#import "RestaurantDiscoverViewController.h"
#import "FoodPinDiscoverViewController.h"
#import "DiscoverDetailViewController.h"

@interface FoodPinRootViewController ()

@end

@implementation FoodPinRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationControllers];
}

- (void)initNavigationControllers {
    RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] init];
    RestaurantAboutViewController *restaurantAboutViewController = [[RestaurantAboutViewController alloc] init];
    FoodPinDiscoverViewController *discoverViewController = [[FoodPinDiscoverViewController alloc] init];
    //DiscoverDetailViewController *discoverDetailController = [[DiscoverDetailViewController alloc] init];
    
    self.favoritesNav = [[UINavigationController alloc] initWithRootViewController:restaurantViewController];
    self.discoverNav = [[UINavigationController alloc] initWithRootViewController:discoverViewController];
    self.aboutNav = [[UINavigationController alloc] initWithRootViewController:restaurantAboutViewController];
    
    NSArray *tabController  = @[self.favoritesNav, self.discoverNav, self.aboutNav];
    [self setViewControllers:tabController];
    
    UITabBarItem *favoriteItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *discoverItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *aboutItem = [self.tabBar.items objectAtIndex:2];
    
    [favoriteItem setTitle:@"Favorites"];
    [favoriteItem setImage:[[UIImage imageNamed:@"favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [favoriteItem setSelectedImage:[[UIImage imageNamed:@"favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [discoverItem setTitle:@"Discover"];
    [discoverItem setImage:[[UIImage imageNamed:@"discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [discoverItem setSelectedImage:[[UIImage imageNamed:@"discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [aboutItem setTitle:@"About"];
    [aboutItem setImage:[[UIImage imageNamed:@"about"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [aboutItem setSelectedImage:[[UIImage imageNamed:@"about"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
