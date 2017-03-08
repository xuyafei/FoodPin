//
//  FPGlobalDataMetric+Private.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPGlobalDataMetric.h"

@interface FPGlobalDataMetric ()

- (void)cacheHeight:(CGFloat)height forIndexPath:(nonnull NSIndexPath *)indexPath;
- (CGFloat)cachedHeightForIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)cacheSize:(CGSize)size forIndexPath:(nonnull NSIndexPath *)indexPath;
- (CGSize)cachedSizeForIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)cacheHeight:(CGFloat)height forHeaderInSection:(NSInteger)section;
- (CGFloat)cachedHeightForHeaderInSection:(NSInteger)section;

- (void)cacheSize:(CGSize)size forHeaderInSection:(NSInteger)section;
- (CGSize)cachedSizeForHeaderInSection:(NSInteger)section;

- (void)cacheHeight:(CGFloat)height forFooterInSection:(NSInteger)section;
- (CGFloat)cachedHeightForFooterInSection:(NSInteger)section;

- (void)cacheSize:(CGSize)size forFooterInSection:(NSInteger)section;
- (CGSize)cachedSizeForFooterInSection:(NSInteger)section;

@end

