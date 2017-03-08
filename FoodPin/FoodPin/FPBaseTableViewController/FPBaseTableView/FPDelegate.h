#import <UIKit/UIKit.h>

@class FPDataSource;
@class FPGlobalDataMetric;

@interface FPDelegate : NSObject <UITableViewDelegate, UICollectionViewDelegate>

@property (nonatomic, weak, readonly, nullable)  UITableView *tableView;
- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView;

@property (nonatomic, weak, readonly, nullable) UICollectionView *collectionView;
- (nullable instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView;

- (nonnull FPDataSource *)dataSource;
@property (nonatomic, assign, nonnull) FPGlobalDataMetric *globalDataMetric;


#pragma mark - UITableViewDelegate helper methods

/// TCDelegate subclass UITableViewDelegate require section cell height, simple return this method.
- (CGFloat)heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath;

/// TCDelegate subclass UITableViewDelegate require section header view height, simple return this method.
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
/// TCDelegate subclass UITableViewDelegate require section header view, simple return this method.
- (nullable UIView *)viewForHeaderInSection:(NSInteger)section;


/// TCDelegate subclass UITableViewDelegate require section footer view height, simple return this method.
- (CGFloat)heightForFooterInSection:(NSInteger)section;
/// TCDelegate subclass UITableViewDelegate require section footer view, simple return this method.
- (nullable UIView *)viewForFooterInSection:(NSInteger)section;


#pragma mark - UICollectionViewDelegate helper methods

/// TCDelegate subclass UICollectionViewDelegate flow layout require cell size, simple return this method.
- (CGSize)sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath preferredLayoutSizeFittingSize:(CGSize)fittingSize cellType:(nonnull Class)type;
/// TCDelegate subclass UICollectionViewDelegate flow layout require SupplementaryView size, simple return this method.
- (CGSize)sizeForSupplementaryViewAtIndexPath:(nonnull NSIndexPath *)indexPath preferredLayoutSizeFittingSize:(CGSize)fittingSize cellType:(nonnull Class)type ofKind:(nonnull NSString *)kind;


#pragma mark - UIScrollViewDelegate

NS_ASSUME_NONNULL_BEGIN

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;

NS_ASSUME_NONNULL_END


@end

