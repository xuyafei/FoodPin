//
//  FPTableViewDataSource.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FPTableViewBaseItem;

@protocol FPTableViewDataSource <UITableViewDataSource>

@optional

- (FPTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView *)tableView cellClassForObject:(FPTableViewBaseItem *)object;

@end


@interface FPTableViewDataSource : NSObject<FPTableViewDataSource>

@property (nonatomic, copy) NSMutableArray *sections;

- (void)clearAllItems;
- (void)appenItem:(FPTableViewBaseItem *)item;

@end
