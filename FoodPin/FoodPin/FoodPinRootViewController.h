//
//  FoodPinRootViewController.h
//  FoodPin
//
//  Created by xuyafei on 16/11/23.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodPinRootViewController : UITabBarController
@property(nonatomic, strong)UINavigationController *favoritesNav;
@property(nonatomic, strong)UINavigationController *discoverNav;
@property(nonatomic, strong)UINavigationController *aboutNav;
@end
