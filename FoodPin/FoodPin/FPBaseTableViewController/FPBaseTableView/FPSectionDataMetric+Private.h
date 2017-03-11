//
//  FPSectionDataMetric+Private.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPSectionDataMetric.h"

@interface FPSectionDataMetric ()

- (void)cacheHeight:(CGFloat)height forIndex:(NSInteger)index;
- (CGFloat)cachedHeightForIndex:(NSInteger)index;

- (void)cacheSize:(CGSize)size forIndex:(NSInteger)index;
- (CGSize)cachedSizeForIndex:(NSInteger)index;

@end
