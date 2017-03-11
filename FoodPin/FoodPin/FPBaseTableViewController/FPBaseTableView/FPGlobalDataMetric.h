//
//  FPGlobalDataMetric.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPSectionDataMetric;
@interface FPGlobalDataMetric : NSObject
/// NSArray parameter must contains all instance kinda `TCSectionDataMetric`.
- (nullable instancetype)initWithSectionDataMetrics:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics;
/// Return empty instance
+ (nullable instancetype)empty;

#pragma mark - Retrieve

/// The count of sections
- (NSInteger)numberOfSections;

/// Each section items count
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/// The data from specific section
- (nullable NSArray *)dataInSection:(NSInteger)section;

/// The data which should configure for the indexPath
- (nullable id)dataForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// Return the data indexPath in UITableview/UICollection
- (nullable NSIndexPath *)indexPathOfData:(nonnull id)data;

/// Return the all section data metrics
/// **Note**: Prepared for swift convert.
- (nullable NSArray<FPSectionDataMetric *> *)allSectionDataMetrics __attribute__((deprecated("use `sectionDataMetrics:` instead.")));

/// Return the all section data metrics
- (nullable NSArray<FPSectionDataMetric *> *)sectionDataMetrics;

/// All data.
- (nullable NSArray *)allData;

/// Private: Section index titles.
- (nullable NSArray<NSString *> *)sectionIndexTitles;

#pragma mark - Modify

/// Append single `TCSectionDataMetric` to last for current section.
- (void)append:(nonnull FPSectionDataMetric *)sectionDataMetric;

/// Add new `TCSectionDataMetric` to last for current section
- (void)appendSectionDataMetric:(nonnull FPSectionDataMetric *)sectionDataMetric __attribute__((deprecated("use `append:` instead.")));

/// Append multiple `TCSectionDataMetric` collection to last for current section.
- (void)appendContentsOf:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics;

/// Append single `TCSectionDataMetric` for current setion at specific index.
- (void)insert:(nonnull FPSectionDataMetric *)sectionDataMetric atIndex:(NSInteger)index;

/// Append multiple `TCSectionDataMetric` for current setion at specific index.
- (void)insertContentsOf:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics atIndex:(NSInteger)index;;

/// Add new `TCSectionDataMetric` for current setion at specific index
- (void)insertSectionDataMetric:(nonnull FPSectionDataMetric *)sectionDataMetric atIndex:(NSInteger)index __attribute__((deprecated("use `insert:atIndex:` instead.")));

/// Append single data to last section data metric.
- (void)appendLastSection:(nonnull id )data;

/// Append multiple data to last section data metric.
- (void)appendLastSectionContentsOf:(nonnull NSArray *)data;

/// Append new data to last section data metric
- (void)appendLastSectionData:(nonnull NSArray *)data __attribute__((deprecated("use `appendLastSectionContentsOf:` instead.")));

/// Append single data to specific section data metric.
- (void)append:(nullable id)data inSection:(NSInteger)section;

/// Append multiple data to specific section data metric.
- (void)appendContentsOf:(nullable NSArray *)data inSection:(NSInteger)section;

/// Append new data to specific section data metric
- (void)appendData:(nonnull NSArray *)data inSection:(NSInteger)section __attribute__((deprecated("use `appendContentsOf:inSection:` instead.")));

/// Insert single data to specific section & item data metric.
- (void)insert:(nonnull id)data atIndexPath:(nonnull NSIndexPath *)indexPath;

/// Insert multiple data to specific section & item data metric.
- (void)insertContentsOf:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath;

/// Insert specific item new data to specific section data metric
- (void)insertData:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath __attribute__((deprecated("use `insertContentsOf:atIndexPath` instead.")));

/// Replace single data to specific section data metric.
- (void)replaceWith:(nonnull id)data atIndexPath:(nonnull NSIndexPath *)indexPath;

/// Replace multiple data to specific section data metric.
- (void)replaceWithContentsOf:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath;

/// Replace specific item new data to specific section data metric
- (void)replaceData:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath __attribute__((deprecated("use `replaceContentsOf:atIndexPath:` instead.")));

/// Remove the first section data metric.
- (nullable FPSectionDataMetric *)removeFirst;

/// Remove the last section data metric.
- (nullable FPSectionDataMetric *)removeLast;

/// Remove specific section data metric.
- (nullable FPSectionDataMetric *)removeAtIndex:(NSInteger)index;

/// Remove specific data for indexPath.
- (nullable id)removeAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// Remove all data.
- (nullable NSArray *)removeAll;

/// Remove the last section data metric
- (nullable FPSectionDataMetric *)removeLastSectionDataMetric __attribute__((deprecated("use `removeLast` instead.")));

/// Remove specific section data metric
- (nullable FPSectionDataMetric *)removeSectionDataMetricAtIndex:(NSInteger)index __attribute__((deprecated("use `removeAtIndex:` instead.")));

/// Remove specific data for indexPath
- (nullable id)removeDataAtIndexPath:(nonnull NSIndexPath *)indexPath __attribute__((deprecated("use `removeAtIndexPath:` instead.")));

/// Exchange data.
- (void)exchageAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath withIndexPath:(nonnull NSIndexPath *)destinationIndexPath;

/// Move data.
- (void)moveAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath;

#pragma mark - Cache Size & Height

- (void)invalidateCachedCellHeightForIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)invalidateCachedCellSizeForIndexPath:(nonnull NSIndexPath *)indexPath;
@end
