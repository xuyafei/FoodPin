//
//  RestaurantSearchResultViewController.h
//  FoodPin
//
//  Created by polycom on 2017/2/22.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantSearchResultViewController : UIViewController
@property (nonatomic, weak) UITableView *searchResultTableView;
@property (nonatomic, strong) NSMutableArray *searchResultRestaurants;
@end
