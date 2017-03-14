//
//  FPDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPDataSource.h"
#import "FPDelegate.h"
#import "FPDelegate+Private.h"
#import "FPGlobalDataMetric.h"
#import "FPGlobalDataMetric+Private.h"
#import "FPDataSourceProtocol.h"
#import "FPSectionDataMetric.h"
#import "FPHelper.h"
#import "FPDefaultSupplementaryView.h"
#import "NSObject+FPIdentifier.h"
#import "ResuableView+FPExtension.h"

@interface FPDataSource ()

@property (nonatomic, weak, readwrite) UITableView *tableView;

@property (nonatomic, weak, nullable) id<FPDataSourceable> sourceable;
@property (nonatomic, weak, nullable, readwrite) id<FPImageLazyLoadable> lazyLoadable;

@property (nonatomic, weak, nullable) id<FPTableViewEditable> editable;

@end

@implementation FPDataSource

#pragma mark - Initializer

- (nullable instancetype)init {
    [NSException raise:@"Use `initWithTableView:` or `initWithCollectionView:` instead." format:@""];
    return nil;
}

- (nullable instancetype)__init__ {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if ([self conformsToProtocol:@protocol(FPDataSourceable)]) {
        self.sourceable = (id<FPDataSourceable>)self;
    } else {
        [NSException raise:@"Must conforms protocol `TCDataSourceable`." format:@""];
    }
    
    return self;
}

- (nullable instancetype)initWithTableView:(nonnull UITableView *)tableView {
    NSAssert(tableView, NSLocalizedString(@"Tableview can not be nil", nil));
    
    self = [self __init__];
    _tableView = tableView;
    [self registerTableViewReusableView];
    if ([self conformsToProtocol:@protocol(FPTableViewEditable)]) {
        self.editable = (id<FPTableViewEditable>)self;
    }
    
    return self;
}

- (void)registerTableViewReusableView {
    [self.sourceable registerReusableCell];
}

#pragma mark - Accessor

- (nullable FPDelegate *)delegate {
    if (self.tableView) {
        return (FPDelegate *)self.tableView.delegate;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

#pragma mark - TCDataSourceable

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.globalDataMetric numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.globalDataMetric numberOfItemsInSection:section];
}

/// http://stackoverflow.com/questions/25826383/when-to-use-dequeuereusablecellwithidentifier-vs-dequeuereusablecellwithidentifi
/// The most important difference is that the forIndexPath: version asserts (crashes) if you didn't register a class or nib for the identifier. The older (non-forIndexPath:) version returns nil in that case.
/// You register a class for an identifier by sending registerClass:forCellReuseIdentifier: to the table view. You register a nib for an identifier by sending registerNib:forCellReuseIdentifier: to the table view.
/// If you create your table view and your cell prototypes in a storyboard, the storyboard loader takes care of registering the cell prototypes that you defined in the storyboard.
/// Session 200 - What's New in Cocoa Touch from WWDC 2012 discusses the (then-new) forIndexPath: version starting around 8m30s. It says that “you will always get an initialized cell” (without mentioning that it will crash if you didn't register a class or nib).
/// The video also says that “it will be the right size for that index path”. Presumably this means that it will set the cell's size before returning it, by looking at the table view's own width and calling your delegate's tableView:heightForRowAtIndexPath: method (if defined). This is why it needs the index path.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.sourceable reusableCellIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [NSException raise:@"Must conforms protocol `TCDataSourceable`." format:@""];
    }
    [cell prepareForReuse];
    
    id data = [self.globalDataMetric dataForItemAtIndexPath:indexPath];
    if (data && !self.delegate.scrollingToTop) {
        [self.sourceable loadData:data forReusableCell:cell];
        
        if ([self conformsToProtocol:@protocol(FPImageLazyLoadable)]) {
            CGRect targetRect = self.delegate.targetRect.CGRectValue;
            if (CGRectIntersectsRect(targetRect, cell.frame)) {
                id lazyLoadable = (id<FPImageLazyLoadable>)self;
                [lazyLoadable lazyLoadImagesData:data forReusableCell:cell];
            }
        }
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}
#pragma mark - Section Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.globalDataMetric sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[self.globalDataMetric sectionIndexTitles] indexOfObjectIdenticalTo:title];
}


#pragma mark - TCTableViewEditable

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    id editable = self.editable;
    if (!editable) {
        return NO;
    }
    
    return [editable canEditElementAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id editable = self.editable;
    if (!editable) {
        return;
    }
    
    id data = [self.globalDataMetric dataForItemAtIndexPath:indexPath];
    if (!data) {
        return;
    }
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.globalDataMetric removeAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (UITableViewCellEditingStyleInsert == editingStyle) {
        // Duplicate last content item, in case reload data error, should not use it.
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.item + 1 inSection:indexPath.section];
        [self.globalDataMetric insert:data atIndexPath:newIndexPath];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [editable commitEditingStyle:editingStyle forData:data];
}

- (CGFloat)_heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self.globalDataMetric cachedHeightForIndexPath:indexPath];
    if (height != UITableViewAutomaticDimension) {
        return height;
    }
    
    id data = [self.globalDataMetric dataForItemAtIndexPath:indexPath];
    if (!data) {
        return UITableViewAutomaticDimension;
    }
    
    NSString *identifier = [self.sourceable reusableCellIdentifierForIndexPath:indexPath];
    __weak typeof(self) weak_self = self;
    height = [self.tableView fp_heightForReusableCellByIdentifier:identifier dataConfigurationHandler:^(UITableViewCell * _Nonnull cell) {
        __strong typeof(weak_self) strong_self = weak_self;
        [strong_self.sourceable loadData:data forReusableCell:cell];
    }];
    [self.globalDataMetric cacheHeight:height forIndexPath:indexPath];
    
    return height;
}

@end

