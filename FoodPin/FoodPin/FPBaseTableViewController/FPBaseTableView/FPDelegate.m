//
//  FPDelegate.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPDelegate.h"
#import "FPDataSource.h"
#import "FPDataSource+Private.h"
#import "FPGlobalDataMetric.h"
#import "FPDataSourceProtocol.h"

@interface FPDelegate ()
@property (nonatomic, weak, readwrite) UITableView *tableView;

@property (nonatomic, assign) BOOL scrollingToTop;
@property (nonatomic, strong, readwrite, nullable) NSValue *targetRect;
@end

@implementation FPDelegate

#pragma mark - Initializer

- (nullable instancetype)init {
    [NSException raise:@"Use `initWithTableView:` or `initWithCollectionView:` instead." format:@""];
    return nil;
}

- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView {
    NSAssert(tableView, NSLocalizedString(@"Tableview can not be nil", nil));
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _tableView = tableView;
    
    return self;
}

#pragma mark - Accessor

- (nonnull FPDataSource *)dataSource {
   return (FPDataSource *)self.tableView.dataSource;
}

- (nonnull FPGlobalDataMetric *)globalDataMetric {
    return self.dataSource.globalDataMetric;
}

- (void)setGlobalDataMetric:(nonnull FPGlobalDataMetric *)globalDataMetric {
    self.dataSource.globalDataMetric = globalDataMetric;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.targetRect = nil;
    [self loadImagesForVisibleElements];
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGRect rect = CGRectMake((*targetContentOffset).x, (*targetContentOffset).y, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
    self.targetRect = [NSValue valueWithCGRect:rect];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.targetRect = nil;
    [self loadImagesForVisibleElements];
}

- (void)loadImagesForVisibleElements {
    id lazyLoadable = self.dataSource.lazyLoadable;
    if (!lazyLoadable) {
        return;
    }
    NSArray *visibleIndexPaths = self.tableView.indexPathsForVisibleRows;
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        id cell =  [self.tableView cellForRowAtIndexPath:indexPath];
        id data = [self.dataSource.globalDataMetric dataForItemAtIndexPath:indexPath];
        if (cell && data) {
            [lazyLoadable lazyLoadImagesData:data forReusableCell:cell];
        }
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    self.scrollingToTop = YES;
    return YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.scrollingToTop = NO;
    [self loadContent];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    self.scrollingToTop = NO;
    [self loadContent];
}

- (void)loadContent {
    if (self.scrollingToTop) {
        return;
    }
    
   [self loadContentForTableView];
}

- (void)loadContentForTableView {
    if (self.tableView.indexPathsForVisibleRows.count <= 0) {
        return;
    }
    [self.tableView reloadData];
}




#pragma mark - UITableViewDelegate helper methods

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource _heightForRowAtIndexPath:indexPath];
}


@end
