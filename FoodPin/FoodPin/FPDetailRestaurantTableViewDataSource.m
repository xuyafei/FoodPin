//
//  FPDetailRestaurantTableViewDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/29.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPDetailRestaurantTableViewDataSource.h"
#import "RestaurantDetailTableViewCell.h"
#import "FPDetailTableViewItem.h"

@implementation FPDetailRestaurantTableViewDataSource


- (Class)tableView:(UITableView *)tableView cellClassForObject:(FPTableViewBaseItem *)object {
    return [RestaurantDetailTableViewCell class];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPDetailTableViewItem *object = (FPDetailTableViewItem*)[self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    RestaurantDetailTableViewCell* cell = (RestaurantDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setObject:object];
    
    return cell;
}

@end
