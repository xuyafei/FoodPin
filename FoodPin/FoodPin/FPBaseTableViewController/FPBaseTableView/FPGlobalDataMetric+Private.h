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

@end

