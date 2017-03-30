//
//  FPDiscoverDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/30.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPDiscoverDataSource.h"
#import "DiscoverTableViewCell.h"
#import "FPDiscoverViewItem.h"

@implementation FPDiscoverDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(FPTableViewBaseItem *)object {
    return [DiscoverTableViewCell class];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPDiscoverViewItem *object = (FPDiscoverViewItem*)[self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    DiscoverTableViewCell* cell = (DiscoverTableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //[cell setObject:object];
    
    return cell;
}

@end
