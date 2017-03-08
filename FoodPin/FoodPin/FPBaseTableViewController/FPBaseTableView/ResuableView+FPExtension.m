//
//  ResuableView+FPExtension.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "ResuableView+FPExtension.h"
#import "FPHelper.h"
#import <objc/runtime.h>

BOOL FPTableViewSupportsConstraintsProperty();
BOOL FPCollectionViewSupportsConstraintsProperty();

#pragma mark - UICollectionReusableView

@implementation UICollectionReusableView (FPLayoutSizeFittingSize)

// This is kind of a hack because cells don't have an intrinsic content size or any other way to constrain them to a size. As a result, labels that _should_ wrap at the bounds of a cell, don't. So by adding width and height constraints to the cell temporarily, we can make the labels wrap and the layout compute correctly.
- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize {
    CGRect frame = self.frame;
    frame.size = fittingSize;
    self.frame = frame;
    
    NSArray *constraints = @[[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fittingSize.width],
                             [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:UILayoutFittingExpandedSize.height]];
    [self addConstraints:constraints];
    [self updateConstraints];
    CGSize size = [self systemLayoutSizeFittingSize:fittingSize];
    [self removeConstraints:constraints];
    
    frame.size = size;
    self.frame = frame;
    
    return size;
}

@end

#pragma mark - UICollectionViewCell

@implementation UICollectionViewCell (FPLayoutSizeFittingSize)

- (CGSize)fp_preferredLayoutSizeFittingSize:(CGSize)fittingSize {
    CGRect frame = self.frame;
    frame.size = fittingSize;
    self.frame = frame;
    
    CGSize size;
    if (FPCollectionViewSupportsConstraintsProperty()) {
        [self layoutSubviews];
        size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    } else {
        NSArray *constraints = @[
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fittingSize.width],
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:UILayoutFittingExpandedSize.height]];
        
        [self addConstraints:constraints];
        [self updateConstraints];
        size = [self systemLayoutSizeFittingSize:fittingSize];
        [self removeConstraints:constraints];
    }
    
    // Only consider the height for cells, because the contentView isn't anchored correctly sometimes.
    fittingSize.height = size.height;
    frame.size = fittingSize;
    self.frame = frame;
    
    return fittingSize;
}

@end


#pragma mark - UITableViewCell

@implementation UITableViewCell (FPLayoutSizeFittingSize)

/// **Note**: You should indicate the `preferredMaxLayoutWidth` by this way:
/// **Note**: You should indicate the `preferredMaxLayoutWidth` by this way:
/// ```Swift
/// override func layoutSubviews() {
///    super.layoutSubviews()
///    contentView.setNeedsLayout()
///    contentView.layoutIfNeeded()
///    nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(nameLabel.bounds)
/// }
/// ```
- (CGSize)tc_preferredLayoutSizeFittingSize:(CGSize)fittingSize {
    CGRect frame = self.frame;
    frame.size = fittingSize;
    self.frame = frame;
    
    CGSize size;
    if (FPCollectionViewSupportsConstraintsProperty()) {
        [self layoutSubviews];
        size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    } else {
        NSArray *constraints = @[
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fittingSize.width],
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:UILayoutFittingExpandedSize.height]];
        
        [self addConstraints:constraints];
        [self updateConstraints];
        size = [self systemLayoutSizeFittingSize:fittingSize];
        [self removeConstraints:constraints];
    }
    
    // Only consider the height for cells, because the contentView isn't anchored correctly sometimes.
    size.width = fittingSize.width;
    frame.size = size;
    self.frame = frame;
    
    return size;
}

@end

#pragma mark - UITableViewHeaderFooterView

@implementation UITableViewHeaderFooterView (TCLayoutSizeFittingSize)

- (CGSize)tc_preferredLayoutSizeFittingSize:(CGSize)fittingSize {
    CGRect frame = self.frame;
    frame.size = fittingSize;
    self.frame = frame;
    
    CGSize size;
    if (FPCollectionViewSupportsConstraintsProperty()) {
        [self layoutSubviews];
        // Apple's implement like folow, somehow, it doesn't work.
        // size = systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    } else {
        NSArray *constraints = @[
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fittingSize.width],
                                 [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:UILayoutFittingExpandedSize.height]];
        
        [self addConstraints:constraints];
        [self updateConstraints];
        size = [self systemLayoutSizeFittingSize:fittingSize];
        [self removeConstraints:constraints];
    }
    
    // Only consider the height for cells, because the contentView isn't anchored correctly sometimes.
    fittingSize.height = size.height;
    frame.size = fittingSize;
    self.frame = frame;
    
    return fittingSize;
}

@end

#pragma mark - Helpers

static inline BOOL _supportsConstraintsProperty() {
    static BOOL constraintsSupported;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *versionString = [[UIDevice currentDevice] systemVersion];
        constraintsSupported = ([versionString integerValue] > 7);
    });
    
    return constraintsSupported;
}

BOOL FPTableViewSupportsConstraintsProperty() {
    return _supportsConstraintsProperty();
}


BOOL FPCollectionViewSupportsConstraintsProperty() {
    return _supportsConstraintsProperty();
}


#pragma mark - UITableView TCComputeLayoutSize

@implementation UITableView (FPComputeLayoutSize)

- (CGFloat)fp_heightForReusableCellByIdentifier:(nonnull NSString *)identifier dataConfigurationHandler:(nonnull void (^)(UITableViewCell * _Nonnull cell))dataConfigurationHandler {
    UITableViewCell *reusableCell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!reusableCell) {
        [NSException raise:@"FatalError" format:@"Cell must be registered to tableView for identifier: %@", identifier];
    }
    
    [reusableCell prepareForReuse];
    dataConfigurationHandler(reusableCell);
    
    CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.bounds), UILayoutFittingExpandedSize.height);
    return [reusableCell tc_preferredLayoutSizeFittingSize:fittingSize].height + 1.0f / [UIScreen mainScreen].scale;
}

- (CGFloat)fp_heightForReusableHeaderFooterViewByIdentifier:(nonnull NSString *)identifier dataConfigurationHandler:(nonnull void (^)(UITableViewHeaderFooterView * _Nonnull reusableHeaderFooterView))dataConfigurationHandler {
    UITableViewHeaderFooterView *reusableHeaderFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!reusableHeaderFooterView) {
        [NSException raise:@"FatalError" format:@"HeaderFooterView must be registered to tableView for identifier: %@", identifier];
    }
    
    [reusableHeaderFooterView prepareForReuse];
    dataConfigurationHandler(reusableHeaderFooterView);
    
    CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.bounds), UILayoutFittingExpandedSize.height);
    return [reusableHeaderFooterView tc_preferredLayoutSizeFittingSize:fittingSize].height + 1.0f / [UIScreen mainScreen].scale;
}

@end


#pragma mark -

@implementation UICollectionView (FPComputeLayoutSize)

- (CGSize)fp_sizeForReusableViewByClass:(nonnull Class)cls preferredLayoutSizeFittingSize:(CGSize)fittingSize dataConfigurationHandler:(nonnull void (^)(UICollectionReusableView * _Nonnull reusableView))dataConfigurationHandler {
    NSMutableDictionary<NSString *, UICollectionReusableView *> *reusableViews = [self.fp_reusableViews mutableCopy];
    if (!reusableViews) {
        reusableViews = [NSMutableDictionary new];
    }
    
    NSString *key = NSStringFromClass(cls);
    UICollectionReusableView *reusableView = [reusableViews objectForKey:key];
    if (!reusableView) {
        reusableView = [[cls alloc] initWithFrame:CGRectZero];
        [reusableViews setObject:reusableView forKey:key];
        [self fp_setReusableViews:reusableViews];
    }
    
    [reusableView prepareForReuse];
    dataConfigurationHandler(reusableView);
    
    return [reusableView fp_preferredLayoutSizeFittingSize:fittingSize];
}

static const void *ReusableViewsAccocaitionKey = @"reusableViews";
- (NSDictionary<NSString *, UICollectionReusableView *> *)fp_reusableViews {
    return objc_getAssociatedObject(self, &ReusableViewsAccocaitionKey);
}

- (void)fp_setReusableViews:(NSDictionary<NSString *, UICollectionReusableView *> *)reusableViews {
    objc_setAssociatedObject(self, &ReusableViewsAccocaitionKey, reusableViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
