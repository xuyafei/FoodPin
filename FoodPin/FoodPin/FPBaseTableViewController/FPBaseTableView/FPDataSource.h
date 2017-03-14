//
//  FPDataSource.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPDataSourceProtocol.h"

@class FPGlobalDataMetric;
@class FPDelegate;
@interface FPDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak, readonly, nullable) UITableView *tableView;
- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView;
@property (nonatomic, strong, nonnull) FPGlobalDataMetric *globalDataMetric;

- (nullable FPDelegate *)delegate;

@end

