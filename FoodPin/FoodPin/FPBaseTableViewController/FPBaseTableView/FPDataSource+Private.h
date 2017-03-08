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

/// TCDelegate subclass UITableViewDelegate require header view height, simple return this method
- (CGFloat)_heightForHeaderInSection:(NSInteger)section;
/// TCDelegate subclass UITableViewDelegate require footer view, simple return this method
- (nullable UIView *)_viewForHeaderInSection:(NSInteger)section;

/// TCDelegate subclass UITableViewDelegate require footer view height, simple return this method
- (CGFloat)_heightForFooterInSection:(NSInteger)section;
/// TCDelegate subclass UITableViewDelegate require footer view, simple return this method
- (nullable UIView *)_viewForFooterInSection:(NSInteger)section;


#pragma mark - UICollectionViewDelegate helper methods

- (CGSize)_sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath preferredLayoutSizeFittingSize:(CGSize)fittingSize cellType:(nonnull Class)type;
- (CGSize)_sizeForSupplementaryViewAtIndexPath:(nonnull NSIndexPath *)indexPath preferredLayoutSizeFittingSize:(CGSize)fittingSize cellType:(nonnull Class)type ofKind:(nonnull NSString *)kind;

@end
