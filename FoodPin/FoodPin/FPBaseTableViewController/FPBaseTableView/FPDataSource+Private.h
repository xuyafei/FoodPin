//
//  FPDataSource+Private.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPDataSource.h"

@protocol FPImageLazyLoadable;

@interface FPDataSource ()

@property (nonatomic, weak, readonly, nullable) id<FPImageLazyLoadable> lazyLoadable;

#pragma mark - UITableViewDelegate helper methods

/// TCDelegate subclass UITableViewDelegate require row height, simple return this method
- (CGFloat)_heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;


@end
