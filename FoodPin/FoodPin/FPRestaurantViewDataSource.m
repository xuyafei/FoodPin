//
//  FPRestaurantViewDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/27.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPRestaurantViewDataSource.h"
#import "RestaurantTableViewCell.h"

@implementation FPRestaurantViewDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(FPTableViewBaseItem *)object {
    return [RestaurantTableViewCell class];
}

@end
