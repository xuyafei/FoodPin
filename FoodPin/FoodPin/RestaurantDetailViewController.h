//
//  RestaurantDetailViewController.h
//  FoodPin
//
//  Created by xuyafei on 16/11/16.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "FoodPinPresentAnimation.h"

@interface RestaurantDetailViewController : UIViewController

@property(nonatomic, strong) Restaurant *restaurant;
@property(nonatomic, weak)   UIImageView *headView;
@property(nonatomic, strong) FoodPinPresentAnimation *presentAnimation;

@end
