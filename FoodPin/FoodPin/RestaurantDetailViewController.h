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
#import "FPTableViewBaseItem.h"

@interface RestaurantDetailViewController : UIViewController

@property(nonatomic, weak)   UIImageView *headView;
@property(nonatomic, strong) FoodPinPresentAnimation *presentAnimation;
@property(nonatomic, strong) FPTableViewBaseItem *baseItem;

@end
