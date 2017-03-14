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
