//
//  AppDelegate.m
//  FoodPin
//
//  Created by xuyafei on 16/11/14.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "AppDelegate.h"
#import "TempViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.restaurantViewController = [[RestaurantViewController alloc] init];
    self.restaurantViewController.title = @"FoodPin";
    //self.navController = [[UINavigationController alloc] initWithRootViewController:self.restaurantViewController];
    self.foodRootViewController = [[FoodPinRootViewController alloc] init];
    //TempViewController *tempView = [[TempViewController alloc] init];;
    //self.window.rootViewController = tempView;
    self.window.rootViewController = self.foodRootViewController;
    
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBarTintColor:RGB(242.0, 116.0, 119.0, 1.0)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Avenir-Light" size:24.0], NSFontAttributeName, nil]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UITabBar appearance] setTintColor:RGB(244.0, 136.0, 139.0, 1.0)];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabitem-selected"]];
     
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
