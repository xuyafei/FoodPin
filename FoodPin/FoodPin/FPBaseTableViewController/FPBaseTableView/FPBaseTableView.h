//
//  FPBaseTableView.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPTableViewDataSource.h"

@class FPTableViewSectionObject;
@protocol FPTableViewDelegate <UITableViewDelegate>

@optional

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (UIView *)headerViewForSectionObject:(FPTableViewSectionObject *)sectionObject atSection:(NSInteger)section;

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FPBaseTableView : UITableView <UITableViewDelegate>

@property (nonatomic, weak) id<FPTableViewDataSource> fpDataSource;
@property (nonatomic, weak) id<FPTableViewDelegate> fpDelegate;

@end
