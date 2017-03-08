//
//  FPSectionDataMetric.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPSectionDataMetric : NSObject

#pragma mark - Initializer

/// Initializer.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData;

/// TableView only.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData indexTitle:(nonnull NSString *)indexTitle;

/// UITableView only.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData titleForHeader:(nonnull NSString *)titleForHeader titleForFooter:(nonnull NSString *)titleForFooter;

/// UITableView only.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData titleForHeader:(nonnull NSString *)titleForHeader titleForFooter:(nonnull NSString *)titleForFooter indexTitle:(nonnull NSString *)indexTitle;

/// UITableView only, Data means which delegate method request for custom viewForHeader/viewForFooter needs.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData dataForHeader:(nonnull id)dataForHeader dataForFooter:(nonnull id)dataForFooter;

/// UITableView only, Data means which delegate method request for custom viewForHeader/viewForFooter needs.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData dataForHeader:(nonnull id)dataForHeader dataForFooter:(nonnull id)dataForFooter indexTitle:(nonnull NSString *)indexTitle;

/// UICollectionView only.
- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData dataForSupplementaryHeader:(nonnull NSArray *)dataForSupplementaryHeader dataForSupplementaryFooter:(nonnull NSArray *)dataForSupplementaryFooter;

/// Return empty instance.
+ (nullable instancetype)empty;


#pragma mark - Retrieve

/// Section data count.
- (NSInteger)numberOfItems;

/// Return specific data.
- (nullable id)dataAtIndex:(NSInteger)index;

/// All data
- (nonnull NSArray *)itemsData;


/// UITableView only, the section header title.
- (nullable NSString *)titleForHeader;

/// UITableView only, the section footer title.
- (nullable NSString *)titleForFooter;

/// UITableView only, the section header data.
- (nullable id)dataForHeader;

/// UITableView only, the section footer data.
- (nullable id)dataForFooter;

/// UITableView index title.
- (nullable NSString *)indexTitle;


/// UICollectionView only, return specific supplementary header element data
- (nullable id)dataForSupplementaryHeaderAtIndex:(NSInteger)index;

/// UICollectionView only, return specific supplementary footer element data
- (nullable id)dataForSupplementaryFooterAtIndex:(NSInteger)index;


#pragma mark - Modify

/// Append single data for current section data metric.
- (void)append:(nonnull id)data;

/// Append new data for current section data metric.
- (void)appendContentsOf:(nonnull NSArray *)data;

/// Add new data for current section data metric
- (void)addItemsDataFromArray:(nonnull NSArray *)data __attribute__((deprecated("use `appendContentsOf:` instead.")));

/// Append single data for current setion data metric at specific index.
- (void)insert:(nonnull id)data atIndex:(NSInteger)index;

/// Append new data for current setion data metric at specific index.
- (void)insertContentsOf:(nonnull NSArray *)data atIndex:(NSInteger)index;

/// Add new data for current setion data metric at specific index
- (void)insertItemsDataFromArray:(nonnull NSArray *)data atIndex:(NSInteger)index __attribute__((deprecated("use `insertContentsOf:atIndex:` instead.")));

/// Replace single new data for current setion data metric at specific index.
- (void)replaceWith:(nonnull id)data atIndex:(NSInteger)index;

/// Replace single new data for current setion data metric at specific index.
- (void)replaceWithNewData:(nonnull id)data atIndex:(NSInteger)index __attribute__((deprecated("use `replaceWith:atIndex:` instead.")));

/// Replace multiple new data for current setion data metric at specific index.
- (void)replaceWithContentsOf:(nonnull NSArray *)data atIndex:(NSInteger)index;

/// Replace multiple new data for current setion data metric at specific index.
- (void)replaceWithNewDataArray:(nonnull NSArray *)data atIndex:(NSInteger)index __attribute__((deprecated("use `replaceWithContentsOf:atIndex:` instead.")));

/// Remove first data.
- (nonnull id)removeFirst;

/// Remove last data.
- (nonnull id)removeLast;

/// Remove specific data at index
- (nullable id)removeAtIndex:(NSInteger)index;

/// Remove specific data at index
- (nullable id)removeDataForItemAtIndex:(NSInteger)index __attribute__((deprecated("use `removeAtIndex:` instead.")));

/// Remove all data.
- (nullable NSArray *)removeAll;

/// Exchange data.
- (void)exchangeElementAtIndex:(NSInteger)index withElementAtIndex:(NSInteger)otherIndex;

/// Exchange data
- (void)exchangeDataAtIndex:(NSInteger)sourceIndex withDataAtIndex:(NSInteger)destinationIndex __attribute__((deprecated("use `exchangeElementAtIndex:withElementAtIndex` instead.")));

/// Move data.
- (void)moveElementAtIndex:(NSInteger)index toIndex:(NSInteger)otherIndex;


#pragma mark - Cache Size & Height

- (void)invalidateCachedCellHeightForIndex:(NSInteger)index;
- (void)invalidateCachedCellSizeForIndex:(NSInteger)index;
- (void)invalidateCachedHeightForHeader;
- (void)invalidateCachedHeightForFooter;
- (void)invalidateCachedSizeForHeader;
- (void)invalidateCachedSizeForFooter;

@end
