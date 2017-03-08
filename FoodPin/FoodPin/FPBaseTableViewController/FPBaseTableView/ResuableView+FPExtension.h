//
//  ResuableView+FPExtension.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UICollectionReusableView (FPXLayoutSizeFittingSize)
- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize;
@end

@interface UICollectionViewCell (FPLayoutSizeFittingSize)
- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize;
@end

@interface UITableViewCell (FPLayoutSizeFittingSize)
- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize;
@end

@interface UITableViewHeaderFooterView (FPLayoutSizeFittingSize)
- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize;
@end



@interface UITableView (FPComputeLayoutSize)
- (CGFloat)fp_heightForReusableCellByIdentifier:(nonnull NSString *)identifier dataConfigurationHandler:(nonnull void (^)(UITableViewCell * _Nonnull cell))dataConfigurationHandler;
- (CGFloat)fp_heightForReusableHeaderFooterViewByIdentifier:(nonnull NSString *)identifier dataConfigurationHandler:(nonnull void (^)(UITableViewHeaderFooterView * _Nonnull reusableHeaderFooterView))dataConfigurationHandler;
@end

@interface UICollectionView (FPComputeLayoutSize)
- (CGSize)fp_sizeForReusableViewByClass:(nonnull Class)cls preferredLayoutSizeFittingSize:(CGSize)fittingSize dataConfigurationHandler:(nonnull void (^)(UICollectionReusableView * _Nonnull reusableView))dataConfigurationHandler;
@end
