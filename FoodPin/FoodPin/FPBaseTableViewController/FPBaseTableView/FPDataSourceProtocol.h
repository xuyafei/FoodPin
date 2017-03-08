//
//  FPDataSourceProtocol.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FPSectionDataMetric;

#pragma mark TCDataSourceable

@protocol FPDataSourceable <NSObject>

/// Regiseter the cell class for reuse
- (void)registerReusableCell;

/// return the cell reuse identifier for indexpath
- (nonnull NSString *)reusableCellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;

/// load data for specific cell
- (void)loadData:(nonnull id)data forReusableCell:(nonnull id)cell;

@end


#pragma mark TCTableViewHeaderFooterViewibility

@protocol FPTableViewHeaderFooterViewibility <NSObject>

/// UITableView only, register the reuse header or footer view
- (void)registerReusableHeaderFooterView;

/// UITableView only, return the HeaderFooterView header reuse identifier for section
- (nullable NSString *)reusableHeaderViewIdentifierInSection:(NSInteger)section;
/// UITableView only, load data for specific UITableViewHeaderFooterView header
- (void)loadData:(nonnull id)data forReusableHeaderView:(nonnull UITableViewHeaderFooterView *)headerView;

/// UITableView only, return the HeaderFooterView footer reuse identifier for section
- (nullable NSString *)reusableFooterViewIdentifierInSection:(NSInteger)section;
/// UITableView only, load data for specific UITableViewHeaderFooterView footer
- (void)loadData:(nonnull id)data forReusableFooterView:(nonnull UITableViewHeaderFooterView *)footerView;

@end


#pragma mark TCCollectionSupplementaryViewibility

@protocol FPCollectionSupplementaryViewibility <NSObject>

/// UICollectionView only, regiseter the supplementary class for reuse
- (void)registerReusableSupplementaryView;

/// UICollectionView only, return the supplementary header view reuse identifier for indexPath.
- (nullable NSString *)reusableSupplementaryHeaderViewIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;
/// UICollectionView only, load data for flow layout specific supplementary header view.
- (void)loadData:(nonnull id)data forReusableSupplementaryHeaderView:(nonnull UICollectionReusableView *)reusableView;

/// UICollectionView only, return the supplementary footer view reuse identifier for indexPath.
- (nullable NSString *)reusableSupplementaryFooterViewIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;
/// UICollectionView only, load data for flow layout specific supplementary footer view.
- (void)loadData:(nonnull id)data forReusableSupplementaryFooterView:(nonnull UICollectionReusableView *)reusableView;

@end


#pragma mark TCTableViewEditable

@protocol FPTableViewEditable <NSObject>

/// Can edit the specific item
- (BOOL)canEditElementAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// commit editing data behavior
- (void)commitEditingStyle:(UITableViewCellEditingStyle)style forData:(nonnull id)data;
@end


#pragma mark TCTableViewCollectionViewMovable

@protocol FPTableViewCollectionViewMovable <NSObject>

/// Can move the specific item
- (BOOL)canMoveElementAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// Move data position.
- (void)moveElementAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath;

@end


#pragma mark TCImageLazyLoadable

@protocol FPImageLazyLoadable <NSObject>

/// Lazy load images.
- (void)lazyLoadImagesData:(nonnull id)data forReusableCell:(nullable id)cell;

@end
