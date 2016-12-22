//
//  AppDelegate.h
//  FoodPin
//
//  Created by xuyafei on 16/11/14.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantViewController.h"
#import "FoodPinRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RestaurantViewController *restaurantViewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) FoodPinRootViewController *foodRootViewController;

@end

