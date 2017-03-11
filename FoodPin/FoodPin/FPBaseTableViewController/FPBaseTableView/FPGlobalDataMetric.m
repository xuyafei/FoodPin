//
//  FPGlobalDataMetric.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPGlobalDataMetric.h"
#import "FPSectionDataMetric.h"
#import "FPSectionDataMetric+Private.h"
#import "FPHelper.h"


@interface FPGlobalDataMetric ()
@property (nonatomic, strong) NSMutableArray<FPSectionDataMetric *> *sectionDataMetrics;
@end

@implementation FPGlobalDataMetric

#pragma mark - Initializer

- (instancetype)init {
    NSAssert(NO, NSLocalizedString(@"Ues `initWithSectionDataMetrics:` instead", nil));
    return nil;
}

- (nullable instancetype)initWithSectionDataMetrics:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _sectionDataMetrics = [NSMutableArray new];
    [_sectionDataMetrics addObjectsFromArray:sectionDataMetrics];
    
    return self;
}

+ (nullable instancetype)empty {
    return [[[self class] alloc] initWithSectionDataMetrics:@[]];
}

#pragma mark - Retrieve

- (NSInteger)numberOfSections {
    return self.sectionDataMetrics.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [[self.sectionDataMetrics objectAtIndex:section] numberOfItems];
}

- (nullable NSArray<FPSectionDataMetric *> *)allSectionDataMetrics {
    return self.sectionDataMetrics;
}

- (nullable NSArray<FPSectionDataMetric *> *)sectionDataMetrics {
    return _sectionDataMetrics;
}

- (nullable NSArray *)dataInSection:(NSInteger)section {
    FPSectionDataMetric *sectionDataMetric = [self.sectionDataMetrics objectAtIndex:section];
    return [sectionDataMetric itemsData];
}

- (nullable id)dataForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if ([self.sectionDataMetrics count] <= section) {
        return nil;
    }
    
    return [[self.sectionDataMetrics objectAtIndex:section] dataAtIndex:indexPath.item];
}

- (nullable NSIndexPath *)indexPathOfData:(nonnull id)data {
    __block NSIndexPath *indexPath = nil;
    [self.sectionDataMetrics enumerateObjectsUsingBlock:^(FPSectionDataMetric *sectionDataMetric, NSUInteger idx, BOOL *stop) {
        NSArray *items = [sectionDataMetric itemsData];
        if ([items containsObject:data]) {
            NSInteger row = [items indexOfObjectIdenticalTo:data];
            indexPath = [NSIndexPath indexPathForItem:row inSection:idx];
            *stop = YES;
        }
    }];
    
    return indexPath;
}

- (nullable NSArray *)allData {
    NSMutableArray *allData = [NSMutableArray new];
    for (FPSectionDataMetric *sectionDataMetric in self.sectionDataMetrics) {
        [allData addObjectsFromArray:sectionDataMetric.itemsData];
    }
    
    return allData;
}



- (NSInteger)indexOfHeaderData:(nonnull id)data {
    NSArray *headerData = [self.sectionDataMetrics valueForKey:@"dataForHeader"];
    if ([headerData containsObject:data]) {
        return [headerData indexOfObjectIdenticalTo:data];
    }
    
    return -1;
}

- (NSInteger)indexOfFooterData:(nonnull id)data {
    NSArray *footerData = [self.sectionDataMetrics valueForKey:@"dataForFooter"];
    if ([footerData containsObject:data]) {
        return [footerData indexOfObjectIdenticalTo:data];
    }
    
    return -1;
}

- (nullable NSArray<NSString *> *)sectionIndexTitles {
    NSMutableArray *indexTitles = [NSMutableArray new];
    for (FPSectionDataMetric *sectionDataMetric in self.sectionDataMetrics) {
        NSString *indexTitle = sectionDataMetric.indexTitle;
        if (indexTitle) {
            [indexTitles addObject:indexTitle];
        }
    }
    
    if (indexTitles.count <= 0) {
        return nil;
    }
    
    return indexTitles;
}

#pragma mark - Modify

- (void)append:(nonnull FPSectionDataMetric *)sectionDataMetric {
    [_sectionDataMetrics addObject:sectionDataMetric];
}

- (void)appendSectionDataMetric:(FPSectionDataMetric *)sectionDataMetric {
    [self append:sectionDataMetric];
}

- (void)appendContentsOf:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics {
    [_sectionDataMetrics addObjectsFromArray:sectionDataMetrics];
}

- (void)insert:(nonnull FPSectionDataMetric *)sectionDataMetric atIndex:(NSInteger)index {
    [self insertContentsOf:@[sectionDataMetric] atIndex:index];
}

- (void)insertContentsOf:(nonnull NSArray<FPSectionDataMetric *> *)sectionDataMetrics atIndex:(NSInteger)index {
    validateInsertElementArgumentIndex(_sectionDataMetrics, index, __FILE__, __LINE__, __FUNCTION__);
    [_sectionDataMetrics insertObjects:sectionDataMetrics atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, sectionDataMetrics.count)]];
}

- (void)insertSectionDataMetric:(FPSectionDataMetric *)sectionDataMetric atIndex:(NSInteger)index {
    [self insert:sectionDataMetric atIndex:index];
}

- (void)appendLastSection:(nonnull id )data {
    [_sectionDataMetrics.lastObject append:data];
}

- (void)appendLastSectionContentsOf:(nonnull NSArray *)data {
    [_sectionDataMetrics.lastObject appendContentsOf:data];
}

- (void)appendLastSectionData:(nonnull NSArray *)data {
    [self appendLastSectionContentsOf:data];
}

- (void)append:(nullable id)data inSection:(NSInteger)section {
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] append:data];
}

- (void)appendContentsOf:(nullable NSArray *)data inSection:(NSInteger)section {
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] appendContentsOf:data];
}

- (void)appendData:(NSArray *)data inSection:(NSInteger)section {
    [self appendContentsOf:data inSection:section];
}

- (void)insert:(nonnull id)data atIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] insert:data atIndex:indexPath.item];
}

- (void)insertContentsOf:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] insertContentsOf:data atIndex:indexPath.item];
}

- (void)insertData:(NSArray *)data atIndexPath:(NSIndexPath *)indexPath {
    [self insertContentsOf:data atIndexPath:indexPath];
}

- (void)replaceWith:(nonnull id)data atIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] replaceWith:data atIndex:indexPath.item];
}

- (void)replaceWithContentsOf:(nonnull NSArray *)data atIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] replaceWithContentsOf:data atIndex:indexPath.item];
}

- (void)replaceData:(NSArray *)data atIndexPath:(NSIndexPath *)indexPath {
    [self replaceWithContentsOf:data atIndexPath:indexPath];
}

- (nullable FPSectionDataMetric *)removeFirst {
    if (self.sectionDataMetrics.count <= 0) {
        return nil;
    }
    
    FPSectionDataMetric *first = self.sectionDataMetrics.firstObject;
    [_sectionDataMetrics removeObjectAtIndex:0];
    return first;
}

- (nullable FPSectionDataMetric *)removeLast {
    if (self.sectionDataMetrics.count <= 0) {
        return nil;
    }
    
    FPSectionDataMetric *last = self.sectionDataMetrics.lastObject;
    [_sectionDataMetrics removeLastObject];
    
    return last;
}

- (nullable FPSectionDataMetric *)removeAtIndex:(NSInteger)index {
    if (self.sectionDataMetrics.count <= index) {
        return nil;
    }
    
    FPSectionDataMetric *removed = [self.sectionDataMetrics objectAtIndex:index];
    [_sectionDataMetrics removeObjectAtIndex:index];
    
    return removed;
}

- (nullable id)removeAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (self.sectionDataMetrics.count <= section) {
        return nil;
    }
    
    return [self.sectionDataMetrics[section] removeAtIndex:indexPath.item];
}

- (nullable NSArray *)removeAll {
    NSArray *all = [[NSArray alloc] initWithArray:self.sectionDataMetrics];
    [_sectionDataMetrics removeAllObjects];
    
    return all;
}

- (nullable FPSectionDataMetric *)removeLastSectionDataMetric {
    return [self removeLast];
}

- (nullable FPSectionDataMetric *)removeSectionDataMetricAtIndex:(NSInteger)index {
    return [self removeAtIndex:index];
}

- (nullable id)removeDataAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self removeAtIndexPath:indexPath];
}

- (void)exchageAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath withIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    NSInteger sourceSection = sourceIndexPath.section;
    NSInteger sourceItem = sourceIndexPath.item;
    NSInteger destinationSection = destinationIndexPath.section;
    NSInteger destinationItem = destinationIndexPath.item;
    
    if (sourceSection == destinationSection) {
        [self.sectionDataMetrics[sourceSection] exchangeElementAtIndex:sourceItem withElementAtIndex:destinationItem];
    }
    else {
        // Take out the source data.
        id sourceData = [self.sectionDataMetrics[sourceSection] removeAtIndex:sourceItem];
        id destinationData = [self.sectionDataMetrics[destinationSection] removeAtIndex:destinationItem];
        if (sourceData && destinationData) {
            [self.sectionDataMetrics[destinationSection] insert:sourceData atIndex:destinationItem];
            [self.sectionDataMetrics[sourceSection] insert:destinationData atIndex:sourceItem];
        }
        else {
            [NSException raise:@"FatalError: take out data faild." format:@""];
        }
    }
}

- (void)moveAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    NSInteger sourceSection = sourceIndexPath.section;
    NSInteger sourceItem = sourceIndexPath.item;
    NSInteger destinationSection = destinationIndexPath.section;
    NSInteger destinationItem = destinationIndexPath.item;
    
    if (sourceSection == destinationSection) {
        [self.sectionDataMetrics[sourceSection] moveElementAtIndex:sourceItem toIndex:destinationItem];
    }
    else {
        // Take out the source data.
        id sourceData = [self.sectionDataMetrics[sourceSection] removeAtIndex:sourceItem];
        if (sourceData) {
            // Insert to desitination position.
            [self.sectionDataMetrics[destinationSection] insert:sourceData atIndex:destinationItem];
        } else {
            [NSException raise:@"FatalError: take out data faild." format:@""];
        }
    }
}


#pragma mark - Cache Size & Height

- (void)cacheHeight:(CGFloat)height forIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] cacheHeight:height forIndex:indexPath.item];
}

- (CGFloat)cachedHeightForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    return [self.sectionDataMetrics[section] cachedHeightForIndex:indexPath.item];
}

- (void)cacheSize:(CGSize)size forIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] cacheSize:size forIndex:indexPath.item];
}

- (CGSize)cachedSizeForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    return [self.sectionDataMetrics[section] cachedSizeForIndex:indexPath.item];
}


- (void)invalidateCachedCellHeightForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] invalidateCachedCellHeightForIndex:indexPath.item];
}

- (void)invalidateCachedCellSizeForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    validateNoneInsertElementArgumentIndex(self.sectionDataMetrics, section, __FILE__, __LINE__, __FUNCTION__);
    [self.sectionDataMetrics[section] invalidateCachedCellSizeForIndex:indexPath.item];
}

#pragma mark - Description

- (NSString *)description {
    return [self _description_];
}

- (NSString *)debugDescription {
    return [self _description_];
}

- (NSString *)_description_ {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:@"sectionDataMetrics: (\n"];
    for (id item in _sectionDataMetrics) {
        [desc appendFormat:@"%@\n", item];
    }
    [desc appendFormat:@")\nsection count :%@", @(_sectionDataMetrics.count)];
    [desc appendFormat:@"\naddress :%p", self];
    return [NSString stringWithString:desc];
}

@end
