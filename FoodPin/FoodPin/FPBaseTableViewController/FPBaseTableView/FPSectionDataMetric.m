//
//  FPSectionDataMetric.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPSectionDataMetric.h"
#import "FPSectionDataMetric+Private.h"
#import "FPHelper.h"


@interface FPSectionDataMetric ()
@property (nonatomic, strong, readwrite, nonnull) NSMutableArray *itemsData;
@property (nonatomic, copy, nonnull) NSString *indexTitle;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *cachedHeightForCell;
@property (nonatomic, strong) NSMutableArray<NSValue *> *cachedSizeForCell;

@end

@implementation FPSectionDataMetric

#pragma mark - Initializer

- (nullable instancetype)init {
    [NSException raise:@"Ues designed initializer instead" format:@""];
    return nil;
}

- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _itemsData = [itemsData mutableCopy];
    return self;
}

- (nullable instancetype)initWithItemsData:(nonnull NSArray *)itemsData indexTitle:(nonnull NSString *)indexTitle {
    self = [self initWithItemsData:itemsData];
    
    _indexTitle = indexTitle;
    
    return self;
}

+ (nullable instancetype)empty {
    return [[[self class] alloc] initWithItemsData:@[]];
}

- (NSMutableArray<NSNumber *> *)cachedHeightForCell {
    if (!_cachedHeightForCell) {
        NSInteger count = self.numberOfItems;
        _cachedHeightForCell = [[NSMutableArray alloc] initWithCapacity:count];
        for (int index = 0; index < count; index++) {
            [_cachedHeightForCell addObject:@(UITableViewAutomaticDimension)];
        }
    }
    
    return _cachedHeightForCell;
}


- (NSMutableArray<NSValue *> *)cachedSizeForCell {
    if (!_cachedSizeForCell) {
        NSInteger count = self.numberOfItems;
        _cachedSizeForCell = [[NSMutableArray alloc] initWithCapacity:count];
        for (int index = 0; index < count; index++) {
            [_cachedSizeForCell addObject:[NSValue valueWithCGSize:CGSizeZero]];
        }
    }
    
    return _cachedSizeForCell;
}

#pragma mark - Retrieve

- (NSInteger)numberOfItems {
    return _itemsData.count;
}

- (nonnull NSArray *)itemsData {
    return _itemsData;
}

- (nullable id)dataAtIndex:(NSInteger)index {
    if (self.numberOfItems <= index) {
        return nil;
    }
    
    return self.itemsData[index];
}


- (nullable NSString *)indexTitle {
    return _indexTitle;
}

#pragma mark - Modify

- (void)append:(nonnull id)data {
    [_itemsData addObject:data];
    [self.cachedHeightForCell addObject:@(UITableViewAutomaticDimension)];
    [self.cachedSizeForCell addObject:[NSValue valueWithCGSize:CGSizeZero]];
}

- (void)appendContentsOf:(nonnull NSArray *)data {
    [_itemsData addObjectsFromArray:data];
    
    for (int index = 0; index < data.count; index++) {
        [self.cachedHeightForCell addObject:@(UITableViewAutomaticDimension)];
        [self.cachedSizeForCell addObject:[NSValue valueWithCGSize:CGSizeZero]];
    }
}

- (void)addItemsDataFromArray:(NSArray *)data {
    [self appendContentsOf:data];
}

- (void)insert:(nonnull id)data atIndex:(NSInteger)index {
    [self insertContentsOf:@[data] atIndex:index];
}

- (void)insertContentsOf:(nonnull NSArray *)data atIndex:(NSInteger)index {
    validateInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, data.count)];
    [_itemsData insertObjects:data atIndexes:indexSet];
    
    NSMutableArray *height = [NSMutableArray new];
    NSMutableArray *size = [NSMutableArray new];
    for (NSUInteger index = 0; index < data.count; index++) {
        [height addObject:@(UITableViewAutomaticDimension)];
        [size addObject:[NSValue valueWithCGSize:CGSizeZero]];
    }
    
    [self.cachedHeightForCell insertObjects:height atIndexes:indexSet];
    [self.cachedSizeForCell insertObjects:size atIndexes:indexSet];
}

- (void)insertItemsDataFromArray:(NSArray *)data atIndex:(NSInteger)index {
    [self insertContentsOf:data atIndex:index];
}

- (void)replaceWith:(nonnull id)data atIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    [_itemsData replaceObjectAtIndex:index withObject:data];
}

- (void)replaceWithNewData:(id)data atIndex:(NSInteger)index {
    [self replaceWith:data atIndex:index];
}

- (void)replaceWithContentsOf:(nonnull NSArray *)data atIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, data.count)];
    [_itemsData replaceObjectsAtIndexes:indexSet withObjects:data];
    
    NSMutableArray *height = [NSMutableArray new];
    NSMutableArray *size = [NSMutableArray new];
    for (NSUInteger index = 0; index < data.count; index++) {
        [height addObject:@(UITableViewAutomaticDimension)];
        [size addObject:[NSValue valueWithCGSize:CGSizeZero]];
    }
    [self.cachedHeightForCell replaceObjectsAtIndexes:indexSet withObjects:height];
    [self.cachedSizeForCell replaceObjectsAtIndexes:indexSet withObjects:size];
}

- (void)replaceWithNewDataArray:(NSArray *)data atIndex:(NSInteger)index {
    [self replaceWithContentsOf:data atIndex:index];
}

- (nonnull id)removeFirst {
    if ([self.itemsData count] <= 0) {
        return nil;
    }
    
    id first = self.itemsData.firstObject;
    [_itemsData removeObjectAtIndex:0];
    
    [self.cachedHeightForCell removeObjectAtIndex:0];
    [self.cachedSizeForCell removeObjectAtIndex:0];
    
    return first;
}

- (nonnull id)removeLast {
    id last = self.itemsData.lastObject;
    [_itemsData removeLastObject];
    
    [self.cachedHeightForCell removeLastObject];
    [self.cachedSizeForCell removeLastObject];
    
    return last;
}

- (nullable id)removeAtIndex:(NSInteger)index {
    if (self.numberOfItems <= index) {
        return nil;
    }
    
    id removed = [self.itemsData objectAtIndex:index];
    [_itemsData removeObjectAtIndex:index];
    
    [self.cachedHeightForCell removeObjectAtIndex:index];
    [self.cachedSizeForCell removeObjectAtIndex:index];
    
    return removed;
}

- (nullable id)removeDataForItemAtIndex:(NSInteger)index {
    return [self removeAtIndex:index];
}

- (nullable NSArray *)removeAll {
    NSArray *removed = [[NSArray alloc] initWithArray:self.itemsData];
    [_itemsData removeAllObjects];
    
    [self.cachedHeightForCell removeAllObjects];
    [self.cachedSizeForCell removeAllObjects];
    
    return removed;
}

- (void)exchangeElementAtIndex:(NSInteger)index withElementAtIndex:(NSInteger)otherIndex {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    [_itemsData exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
    
    [self.cachedHeightForCell exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
    [self.cachedSizeForCell exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
}

- (void)exchangeDataAtIndex:(NSInteger)sourceIndex withDataAtIndex:(NSInteger)destinationIndex {
    [self exchangeElementAtIndex:sourceIndex withElementAtIndex:destinationIndex];
}

- (void)moveElementAtIndex:(NSInteger)index toIndex:(NSInteger)otherIndex {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    if (index == otherIndex) {
        return;
    }
    
    id moved = [self.itemsData objectAtIndex:index];
    [_itemsData removeObjectAtIndex:index];
    [_itemsData insertObject:moved atIndex:otherIndex];
    
    NSNumber *height = [self.cachedHeightForCell objectAtIndex:index];
    [self.cachedHeightForCell removeObjectAtIndex:index];
    [self.cachedHeightForCell insertObject:height atIndex:otherIndex];
    
    NSValue *size = [self.cachedSizeForCell objectAtIndex:index];
    [self.cachedSizeForCell removeObjectAtIndex:index];
    [self.cachedSizeForCell insertObject:size atIndex:otherIndex];
}

#pragma mark - Cache Height

- (void)cacheHeight:(CGFloat)height forIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    self.cachedHeightForCell[index] = @(height);
}
- (CGFloat)cachedHeightForIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
#if defined(__LP64__) && __LP64__
    return [self.cachedHeightForCell[index] doubleValue];
#else
    return [self.cachedHeightForCell[index] floatValue];
#endif
}

- (void)cacheSize:(CGSize)size forIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    self.cachedSizeForCell[index] = [NSValue valueWithCGSize:size];
}

- (CGSize)cachedSizeForIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    return [self.cachedSizeForCell[index] CGSizeValue];
}

- (void)invalidateCachedCellHeightForIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    self.cachedHeightForCell[index] = @(UITableViewAutomaticDimension);
}

- (void)invalidateCachedCellSizeForIndex:(NSInteger)index {
    validateNoneInsertElementArgumentIndex(self.itemsData, index, __FILE__, __LINE__, __FUNCTION__);
    self.cachedSizeForCell[index] = [NSValue valueWithCGSize:CGSizeZero];
}

#pragma mark - Description

- (NSString *)description {
    return [self _description_];
}

- (NSString *)debugDescription {
    return [self _description_];
}

- (NSString *)_description_ {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:@"items: (\n"];
    for (id item in self.itemsData) {
        [desc appendFormat:@"%@\n", item];
    }
    [desc appendFormat:@")\nitems count :%@, \n", @(self.itemsData.count)];
    
    return [NSString stringWithString:desc];
}

@end
