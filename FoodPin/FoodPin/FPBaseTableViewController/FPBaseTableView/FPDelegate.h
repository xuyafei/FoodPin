#import <UIKit/UIKit.h>

@class FPDataSource;
@class FPGlobalDataMetric;

@interface FPDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, weak, readonly, nullable)  UITableView *tableView;
- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView;

- (nonnull FPDataSource *)dataSource;
@property (nonatomic, assign, nonnull) FPGlobalDataMetric *globalDataMetric;


#pragma mark - UITableViewDelegate helper methods

/// TCDelegate subclass UITableViewDelegate require section cell height, simple return this method.
- (CGFloat)heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath;

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

