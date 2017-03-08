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

@property (nonatomic, assign, readwrite) CGFloat cachedHeightForHeader;
@property (nonatomic, assign, readwrite) CGFloat cachedHeightForFooter;

@property (nonatomic, assign, readwrite) CGSize cachedSizeForHeader;
@property (nonatomic, assign, readwrite) CGSize cachedSizeForFooter;


@end
