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
@interface FPDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, weak, readonly, nullable) UITableView *tableView;
- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView;

@property (nonatomic, weak, readonly, nullable) UICollectionView *collectionView;
- (nullable instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView;

/// The tableview or collction view data metric.
@property (nonatomic, strong, nonnull) FPGlobalDataMetric *globalDataMetric;

- (nullable FPDelegate *)delegate;

/// TCDataSource subclass UICollectionViewDataSource flow layout require SupplementaryView, simple return this method.
- (nonnull UICollectionReusableView *)viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath;

@end

